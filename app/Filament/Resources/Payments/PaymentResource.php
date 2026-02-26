<?php

namespace App\Filament\Resources\Payments;

use App\Filament\Resources\Payments\Pages\ManagePayments;
use App\Models\Payment;
use BackedEnum;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Columns\TextColumn;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class PaymentResource extends Resource
{
    protected static ?string $model = Payment::class;

    protected static ?string $navigationLabel = 'عطليات الأداء';
    protected static ?string $pluralLabel = 'عمليات الأداء';
    protected static ?string $singularLabel = 'عملية أداء';

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-credit-card';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('invoice_id')
                    ->label('الفاتورة')
                    ->relationship('invoice', 'id')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('amount')
                    ->label('المبلغ المؤدى')
                    ->numeric()
                    ->required(),
                DatePicker::make('payment_date')
                    ->label('تاريخ الأداء')
                    ->default(now())
                    ->required(),
                Select::make('method')
                    ->label('طريقة الأداء')
                    ->options([
                        'Espèces' => 'نقدا',
                        'Virement' => 'تحويل بنكي',
                    ])
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('invoice.subscriber.name')
                    ->label('المشترك')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('invoice.id')
                    ->label('رقم الفاتورة')
                    ->searchable(),
                TextColumn::make('amount')
                    ->label('المبلغ')
                    ->money('MAD')
                    ->sortable(),
                TextColumn::make('payment_date')
                    ->label('التاريخ')
                    ->date()
                    ->sortable(),
                TextColumn::make('method')
                    ->label('الطريقة')
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'Espèces' => 'نقدا',
                        'Virement' => 'تحويل بنكي',
                        default => $state,
                    }),
            ])
            ->filters([
                //
            ])
            ->recordActions([
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ManagePayments::route('/'),
        ];
    }
}
