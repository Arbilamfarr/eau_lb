<?php

namespace App\Filament\Widgets;

use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class Overview extends StatsOverviewWidget
{
    protected static ?string $heading = 'نظرة عامة على الإحصائيات';

    protected function getStats(): array
    {
        return [
            Stat::make('إجمالي المشتركين', \App\Models\Subscriber::count())
                ->description('إجمالي عدد المشتركين النشطين')
                ->descriptionIcon('heroicon-m-users')
                ->color('success'),
            Stat::make('إجمالي الاستهلاك', \App\Models\Reading::sum('consumption') . ' m³')
                ->description('إجمالي حجم المياه المستهلكة')
                ->descriptionIcon('heroicon-m-chart-bar')
                ->color('info'),
            Stat::make('المبالغ غير المؤداة', \App\Models\Invoice::where('status', '!=', 'Payée')->sum('total') . ' MAD')
                ->description('إجمالي الفواتير غير المؤداة')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('danger'),
        ];
    }
}
