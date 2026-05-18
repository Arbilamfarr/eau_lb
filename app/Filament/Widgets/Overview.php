<?php

namespace App\Filament\Widgets;

use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class Overview extends StatsOverviewWidget
{
    use \Filament\Widgets\Concerns\InteractsWithPageFilters;

    protected function getStats(): array
    {
        $month = $this->tableFilters['month'] ?? null;
        $totalPaid = \App\Models\Invoice::where('status', 'Payée')
            ->when($month, fn ($q) => $q->whereHas('reading', fn ($qr) => $qr->where('month', \Illuminate\Support\Carbon::parse($month)->format('Y-m'))))
            ->sum('total');

        $unpaid = \App\Models\Invoice::where('status', '!=', 'Payée')
            ->when($month, fn ($q) => $q->whereHas('reading', fn ($qr) => $qr->where('month', \Illuminate\Support\Carbon::parse($month)->format('Y-m'))))
            ->sum('total');

        return [
            Stat::make('إجمالي المشتركين', \App\Models\Subscriber::count())
                ->description('إجمالي عدد المشتركين النشطين')
                ->descriptionIcon('heroicon-m-users')
                ->color('success'),
            Stat::make('المبالغ المؤداة', number_format($totalPaid, 2) . ' MAD')
                ->description('إجمالي الفواتير المؤداة')
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('success'),
            Stat::make('المبالغ غير المؤداة', number_format($unpaid, 2) . ' MAD')
                ->description('إجمالي الفواتير غير المؤداة')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('danger'),
        ];
    }
}
