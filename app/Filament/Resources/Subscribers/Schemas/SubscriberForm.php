<?php

namespace App\Filament\Resources\Subscribers\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class SubscriberForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('name')
                    ->label('الاسم الكامل')
                    ->required(),
                TextInput::make('meter_number')
                    ->label('رقم العداد')
                    ->required(),
                TextInput::make('cin')
                    ->label('رقم البطاقة الوطنية')
                    ->default(null),
                TextInput::make('phone')
                    ->label('الهاتف')
                    ->tel()
                    ->default(null),
                DatePicker::make('date_subscription')
                    ->label('تاريخ الاشتراك')
                    ->required(),
                Select::make('status')
                    ->label('الحالة')
                    ->options(['Actif' => 'نشط', 'Suspendu' => 'متوقف'])
                    ->default('Actif')
                    ->required(),
            ]);
    }
}
