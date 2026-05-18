<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>فاتورة رقم {{ $invoice->id }}</title>
    <style>
        body { font-family: 'Arial', sans-serif; padding: 20px; }
        .header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .details { margin-bottom: 20px; }
        .details table { width: 100%; border-collapse: collapse; }
        .details th, .details td { padding: 10px; border: 1px solid #ddd; text-align: right; }
        .total { font-weight: bold; font-size: 1.2em; color: #d32f2f; margin-top: 20px; }
        .footer { margin-top: 50px; text-align: center; font-size: 0.9em; color: #777; }
        @media print {
            .no-print { display: none; }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>فاتورة استهلاك الماء</h1>
        <p>رقم الفاتورة: {{ $invoice->id }}</p>
    </div>

    <div class="details">
        <h3>معلومات المشترك:</h3>
        <p>الاسم: {{ $invoice->subscriber->name }}</p>
        <p>رقم العداد: {{ $invoice->subscriber->meter_number }}</p>
    </div>

    <div class="details">
        <h3>تفاصيل الاستهلاك (شهر {{ $invoice->reading->month }}):</h3>
        <table>
            <thead>
                <tr>
                    <th>المؤشر القديم</th>
                    <th>المؤشر الجديد</th>
                    <th>الاستهلاك (م3)</th>
                    <th>سعر م3</th>
                    <th>المبلغ</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>{{ $invoice->reading->old_index }}</td>
                    <td>{{ $invoice->reading->new_index }}</td>
                    <td>{{ $invoice->reading->consumption }}</td>
                    <td>{{ $invoice->reading->price_per_m3 }} MAD</td>
                    <td>{{ $invoice->amount }} MAD</td>
                </tr>
            </tbody>
        </table>
    </div>

    @if($invoice->penalty > 0)
    <p>الذعيرة: {{ $invoice->penalty }} MAD</p>
    @endif

    <div class="total">
        المجموع الواجب أداؤه: {{ $invoice->total }} MAD
    </div>

    <div class="footer">
        شكراً لاشتراككم. يرجى أداء الفاتورة في أقرب وقت.
    </div>

    <div class="no-print" style="margin-top: 20px; text-align: center;">
        <button onclick="window.print()" style="padding: 10px 20px; cursor: pointer;">طبع الفاتورة</button>
    </div>
</body>
</html>
