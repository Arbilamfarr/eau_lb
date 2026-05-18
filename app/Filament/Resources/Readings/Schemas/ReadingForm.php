<?php

namespace App\Filament\Resources\Readings\Schemas;

use App\Models\Reading;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class ReadingForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('subscriber_id')
                    ->label('المشترك')
                    ->relationship('subscriber', 'name')
                    ->searchable()
                    ->preload()
                    ->live()
                    ->afterStateUpdated(fn ($get, $set) => self::fetchOldIndex($get, $set))
                    ->required(),
                TextInput::make('month')
                    ->label('الشهر')
                    ->type('month')
                    ->placeholder('السنة-الشهر')
                    ->live()
                    ->afterStateUpdated(fn ($get, $set) => self::fetchOldIndex($get, $set))
                    ->helperText(fn ($get) => self::checkExistingReading($get))
                    ->required(),
                TextInput::make('old_index')
                    ->label('المؤشر القديم')
                    ->numeric()
                    ->default(0)
                    ->live()
                    ->afterStateUpdated(fn ($state, $get, $set) => self::calculate($get, $set))
                    ->required(),
                TextInput::make('new_index')
                    ->label('المؤشر الجديد')
                    ->numeric()
                    ->live()
                    ->afterStateUpdated(fn ($state, $get, $set) => self::calculate($get, $set))
                    ->minValue(fn ($get) => $get('old_index'))
                    ->validationMessages([
                        'min' => 'يجب أن يكون المؤشر الجديد أكبر من أو يساوي المؤشر القديم.',
                    ])
                    ->required(),
                TextInput::make('consumption')
                    ->label('الاستهلاك')
                    ->numeric()
                    ->readOnly()
                    ->required(),
                TextInput::make('price_per_m3')
                    ->label('سعر المتر المكعب')
                    ->numeric()
                    ->default(3)
                    ->live()
                    ->afterStateUpdated(fn ($state, $get, $set) => self::calculate($get, $set))
                    ->required(),
                TextInput::make('subscription_fee')
                    ->label('انخراط')
                    ->numeric()
                    ->default(5)
                    ->live()
                    ->afterStateUpdated(fn ($state, $get, $set) => self::calculate($get, $set))
                    ->required(),
                TextInput::make('total')
                    ->label('المجموع')
                    ->numeric()
                    ->readOnly()
                    ->required(),
            ]);
    }

    public static function calculate($get, $set): void
    {
        $old = (int) $get('old_index');
        $new = (int) $get('new_index');
        $price = (float) $get('price_per_m3');
        $subscription_fee = (float) $get('subscription_fee');

        $consumption = max(0, $new - $old);
        $total = ($consumption * $price) + $subscription_fee;

        $set('consumption', $consumption);
        $set('total', $total);
    }

    public static function fetchOldIndex($get, $set): void
    {
        $subscriberId = $get('subscriber_id');
        if (!$subscriberId) {
            return;
        }

        $query = Reading::where('subscriber_id', $subscriberId);

        $selectedMonth = $get('month');
        if ($selectedMonth) {
            // Get the latest reading before the selected month
            $query->where('month', '<', $selectedMonth);
        }

        $lastReading = $query->orderBy('month', 'desc')->first();

        if ($lastReading) {
            $set('old_index', $lastReading->new_index);
            self::calculate($get, $set);
        } else {
            $set('old_index', 0);
            self::calculate($get, $set);
        }
    }

    public static function checkExistingReading($get): ?string
    {
        $subscriberId = $get('subscriber_id');
        $month = $get('month');

        if (!$subscriberId || !$month) {
            return null;
        }

        $exists = Reading::where('subscriber_id', $subscriberId)
            ->where('month', $month)
            ->exists();

        if ($exists) {
            return '⚠️ تنبيه: قراءة هذا الشهر مسجلة بالفعل لهذا المشترك.';
        }

        return null;
    }
}
