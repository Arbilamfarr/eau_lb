<?php

namespace App\Filament\Resources\Readings\Schemas;

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
                    ->required(),
                TextInput::make('month')
                    ->label('الشهر')
                    ->type('month')
                    ->placeholder('السنة-الشهر')
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
                    ->default(0)
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

        $consumption = max(0, $new - $old);
        $total = $consumption * $price;

        $set('consumption', $consumption);
        $set('total', $total);
    }
}
