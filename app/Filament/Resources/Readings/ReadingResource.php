<?php

namespace App\Filament\Resources\Readings;

use App\Filament\Resources\Readings\Pages\CreateReading;
use App\Filament\Resources\Readings\Pages\EditReading;
use App\Filament\Resources\Readings\Pages\ListReadings;
use App\Filament\Resources\Readings\Schemas\ReadingForm;
use App\Filament\Resources\Readings\Tables\ReadingsTable;
use App\Models\Reading;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class ReadingResource extends Resource
{
    protected static ?string $model = Reading::class;

    protected static ?string $navigationLabel = 'تسجيل القراءات';
    protected static ?string $pluralLabel = 'تسجيلات القراءات';
    protected static ?string $singularLabel = 'تسجيل قراءة';

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-pencil-square';

    public static function form(Schema $schema): Schema
    {
        return ReadingForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return ReadingsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListReadings::route('/'),
            'create' => CreateReading::route('/create'),
            'edit' => EditReading::route('/{record}/edit'),
        ];
    }
}
