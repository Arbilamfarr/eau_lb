<?php

namespace App\Filament\Widgets;

use App\Models\Reading;
use Filament\Widgets\ChartWidget;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Support\Carbon;

class ConsumptionChart extends ChartWidget
{
    use InteractsWithPageFilters;

    protected ?string $heading = 'الاستهلاك الشهري';
    protected ?string $maxHeight = '300px';

    protected function getData(): array
    {
        $year = Carbon::now()->year;
        $data = [];
        $labels = [];

        for ($m = 1; $m <= 12; $m++) {
            $monthStr = Carbon::create($year, $m, 1)->format('Y-m');
            $labels[] = Carbon::create($year, $m, 1)->translatedFormat('F');
            $data[] = Reading::where('month', $monthStr)->sum('consumption');
        }

        return [
            'datasets' => [
                [
                    'label' => 'الاستهلاك (m³)',
                    'data' => $data,
                    'backgroundColor' => '#3b82f6',
                    'borderColor' => '#3b82f6',
                ],
            ],
            'labels' => $labels,
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }
}
