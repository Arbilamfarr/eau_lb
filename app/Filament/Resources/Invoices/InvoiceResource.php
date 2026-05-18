<?php

namespace App\Filament\Resources\Invoices;

use App\Filament\Resources\Invoices\Pages\ManageInvoices;
use App\Models\Invoice;
use BackedEnum;
use Filament\Actions\Action;
use Filament\Actions\EditAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Columns\TextColumn;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class InvoiceResource extends Resource
{
    protected static ?string $model = Invoice::class;

    protected static ?string $navigationLabel = 'الفواتير';
    protected static ?string $pluralLabel = 'الفواتير';
    protected static ?string $singularLabel = 'فاتورة';

    protected static string|BackedEnum|null $navigationIcon = 'heroicon-o-document-text';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('subscriber_id')
                    ->label('المشترك')
                    ->relationship('subscriber', 'name')
                    ->searchable()
                    ->preload()
                    ->required(),
                Select::make('reading_id')
                    ->label('القراءة')
                    ->relationship('reading', 'month')
                    ->required(),
                TextInput::make('amount')
                    ->label('المبلغ')
                    ->numeric()
                    ->required(),
                TextInput::make('penalty')
                    ->label('الذعيرة')
                    ->numeric()
                    ->default(0),
                TextInput::make('total')
                    ->label('المجموع الواجب أداؤه')
                    ->numeric()
                    ->required(),
                Select::make('status')
                    ->label('الحالة')
                    ->options([
                        'Payée' => 'مؤداة',
                        'Non payée' => 'غير مؤداة',
                        'En retard' => 'متأخرة',
                    ])
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('subscriber.name')
                    ->label('المشترك')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('reading.month')
                    ->label('الشهر')
                    ->sortable(),
                TextColumn::make('total')
                    ->label('المجموع')
                    ->money('MAD')
                    ->sortable(),
                TextColumn::make('status')
                    ->label('الحالة')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'Payée' => 'success',
                        'Non payée' => 'warning',
                        'En retard' => 'danger',
                        default => 'gray',
                    })
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'Payée' => 'مؤداة',
                        'Non payée' => 'غير مؤداة',
                        'En retard' => 'متأخرة',
                        default => $state,
                    }),
                TextColumn::make('created_at')
                    ->label('تاريخ الفاتورة')
                    ->date()
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
                            fn (\Illuminate\Database\Eloquent\Builder $query, $date): \Illuminate\Database\Eloquent\Builder => $query->whereHas('reading', fn ($q) => $q->where('month', \Illuminate\Support\Carbon::parse($date)->format('Y-m'))),
                        );
                    }),
            ])
            ->recordActions([
                Action::make('print')
                    ->label('طبع')
                    ->icon('heroicon-o-printer')
                    ->url(fn (Invoice $record): string => route('invoice.print', $record))
                    ->openUrlInNewTab(),
                Action::make('sms')
                    ->label('رسالة SMS')
                    ->icon('heroicon-o-chat-bubble-left')
                    ->color('info')
                    ->url(fn (Invoice $record): string => "sms:" . ($record->subscriber->phone ?? "") . "?body=" . urlencode("مرحباً " . $record->subscriber->name . "، فاتورتكم لشهر " . $record->reading->month . " جاهزة بمبلغ " . $record->total . " درهم."))
                    ->openUrlInNewTab(),
                Action::make('whatsapp')
                    ->label('WhatsApp')
                    ->icon('heroicon-o-chat-bubble-bottom-center-text')
                    ->color('success')
                    ->url(fn (Invoice $record): string => "https://wa.me/" . preg_replace('/[^0-9]/', '', $record->subscriber->phone ?? "") . "?text=" . urlencode("مرحباً " . $record->subscriber->name . "، فاتورتكم لشهر " . $record->reading->month . " جاهزة بمبلغ " . $record->total . " درهم."))
                    ->openUrlInNewTab(),
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
            'index' => ManageInvoices::route('/'),
        ];
    }
}
