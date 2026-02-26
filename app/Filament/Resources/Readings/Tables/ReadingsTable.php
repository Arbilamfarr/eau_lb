<?php

namespace App\Filament\Resources\Readings\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class ReadingsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('subscriber.name')
                    ->label('المشترك')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('month')
                    ->label('الشهر')
                    ->searchable(),
                TextColumn::make('old_index')
                    ->label('المؤشر القديم')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('new_index')
                    ->label('المؤشر الجديد')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('consumption')
                    ->label('الاستهلاك')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('price_per_m3')
                    ->label('سعر م3')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('total')
                    ->label('المجموع')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('created_at')
                    ->label('تاريخ التسجيل')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->recordActions([
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
