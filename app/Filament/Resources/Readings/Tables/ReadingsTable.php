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
                TextColumn::make('subscription_fee')
                    ->label('انخراط')
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
                \Filament\Tables\Filters\Filter::make('month')
                    ->form([
                        \Filament\Forms\Components\TextInput::make('month')
                            ->label('الشهر')
                            ->type('month'),
                    ])
                    ->query(function (\Illuminate\Database\Eloquent\Builder $query, array $data): \Illuminate\Database\Eloquent\Builder {
                        return $query->when(
                            $data['month'],
                            fn (\Illuminate\Database\Eloquent\Builder $query, $date): \Illuminate\Database\Eloquent\Builder => $query->where('month', \Illuminate\Support\Carbon::parse($date)->format('Y-m')),
                        );
                    }),
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
