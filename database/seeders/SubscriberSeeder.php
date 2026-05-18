<?php

namespace Database\Seeders;

use App\Models\Subscriber;
use Illuminate\Database\Seeder;

class SubscriberSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $subscribers = [
            ['meter_number' => '1', 'name' => 'لمخنتر براهيم'],
            ['meter_number' => '2', 'name' => 'البصري عبد الرحيم'],
            ['meter_number' => '3', 'name' => 'لمفرد بوشعيب'],
            ['meter_number' => '4', 'name' => 'الناجي خديجة'],
            ['meter_number' => '5', 'name' => 'أرنبي شفيق'],
            ['meter_number' => '6', 'name' => 'حليط عائشة'],
            ['meter_number' => '7', 'name' => 'حيدة حبيبة'],
            ['meter_number' => '8', 'name' => 'لمفرد امحمد'],
            ['meter_number' => '9', 'name' => 'لمفرد ميلودة'],
            ['meter_number' => '10', 'name' => 'لمفرد محمد'],
            ['meter_number' => '11', 'name' => 'لمفرد لمفرك'],
            ['meter_number' => '12', 'name' => 'لمغاري سعيد'],
            ['meter_number' => '13', 'name' => 'المسجد 1'],
            ['meter_number' => '14', 'name' => 'بن لمفرد عبد الله'],
            ['meter_number' => '15', 'name' => 'حيدة عائشة'],
            ['meter_number' => '16', 'name' => 'الراجي عبد الفتاح'],
            ['meter_number' => '17', 'name' => 'الراجي بوشعيب'],
            ['meter_number' => '18', 'name' => 'النابغة فاطنة'],
            ['meter_number' => '19', 'name' => 'جعواني مليكة'],
            ['meter_number' => '20', 'name' => 'حيدة امحمد'],
            ['meter_number' => '21', 'name' => 'المسجد2'],
            ['meter_number' => '22', 'name' => 'النابغة عبد اللطيف'],
            ['meter_number' => '23', 'name' => 'بريقات حميد'],
            ['meter_number' => '24', 'name' => 'بريقات حسنى'],
            ['meter_number' => '25', 'name' => 'مغتنم بوشعيب'],
            ['meter_number' => '26', 'name' => 'مغتنم ادريس'],
            ['meter_number' => '27', 'name' => 'النابغة عبد المجيد'],
            ['meter_number' => '28', 'name' => 'حافظي عبد السلام'],
            ['meter_number' => '29', 'name' => 'طاعة عبد القادر'],
            ['meter_number' => '30', 'name' => 'لمغاري أحمد'],
            ['meter_number' => '31', 'name' => 'لمغاري مصطفى'],
            ['meter_number' => '32', 'name' => 'لمغاري عبدالعاطي'],
            ['meter_number' => '33', 'name' => 'لمغاري فاطنة'],
            ['meter_number' => '34', 'name' => 'لمغاري بوشعيب'],
            ['meter_number' => '35', 'name' => 'لمغاري عبد العزيز'],
            ['meter_number' => '36', 'name' => 'النابغة عبد السلام'],
            ['meter_number' => '37', 'name' => 'النابغة محمد'],
            ['meter_number' => '38', 'name' => 'خصال عبد الكريم'],
            ['meter_number' => '39', 'name' => 'النابغة بوشعيب (البياض)'],
            ['meter_number' => '40', 'name' => 'بوعادل عبد الرحمان'],
            ['meter_number' => '41', 'name' => 'فتح الله عبد الغاني'],
            ['meter_number' => '42', 'name' => 'بوعادل مصطفى'],
            ['meter_number' => '43', 'name' => 'بريقات عائشة'],
            ['meter_number' => '44', 'name' => 'بريقات محمد'],
            ['meter_number' => '45', 'name' => 'راضي ماجدة'],
            ['meter_number' => '46', 'name' => 'لمغاري عبد الغاني'],
            ['meter_number' => '47', 'name' => 'لمفرد فتيحة'],
            ['meter_number' => '48', 'name' => 'زاهير لخليفة'],
            ['meter_number' => '49', 'name' => 'النابغة أحمد'],
            ['meter_number' => '50', 'name' => 'لمغاري امحمد'],
            ['meter_number' => '51', 'name' => 'باهي محمد'],
            ['meter_number' => '52', 'name' => 'لمغاري سي محمد'],
            ['meter_number' => '53', 'name' => 'الرخمي جوهرة'],
            ['meter_number' => '54', 'name' => 'لمغاري عبد الحق'],
            ['meter_number' => '55', 'name' => 'حيدة عبد اللطيف'],
            ['meter_number' => '56', 'name' => 'حيدة براهيم'],
            ['meter_number' => '57', 'name' => 'فتح الله عبد القادر'],
            ['meter_number' => '58', 'name' => 'لمخنتر بوشعيب'],
            ['meter_number' => '59', 'name' => 'غنبور مصطفى'],
            ['meter_number' => '60', 'name' => 'لكحل إبراهيم'],
            ['meter_number' => '61', 'name' => 'حيدة امحمد'],
            ['meter_number' => '62', 'name' => 'حيدة سعيد'],
            ['meter_number' => '63', 'name' => 'البيضاوي عصام'],
            ['meter_number' => '64', 'name' => 'حيدة محمد (لعسل)'],
            ['meter_number' => '65', 'name' => 'صبار عبد الرحمان'],
            ['meter_number' => '66', 'name' => 'لزعر عبد السلام'],
            ['meter_number' => '67', 'name' => 'أرنبي عبد الحق'],
            ['meter_number' => '68', 'name' => 'لمفرد عبد السلام'],
            ['meter_number' => '69', 'name' => 'لمخنتر التهامي'],
            ['meter_number' => '70', 'name' => 'لمخنتر يوسف'],
            ['meter_number' => '71', 'name' => 'مغتنم العربي'],
            ['meter_number' => '72', 'name' => 'لمفرد عبد العزيز'],
            ['meter_number' => '73', 'name' => 'غنبور عباس'],
            ['meter_number' => '74', 'name' => 'لمغاري رضوان'],
            ['meter_number' => '75', 'name' => 'مغتنم مباركة'],
            ['meter_number' => '76', 'name' => 'طاعة عبد الرحيم'],
            ['meter_number' => '77', 'name' => 'الراجي الطاهر'],
            ['meter_number' => '78', 'name' => 'مغتنم أيوب'],
            ['meter_number' => '79', 'name' => 'لمفرد أمينة'],
            ['meter_number' => '80', 'name' => 'اطراسي عبد العزيز'],
            ['meter_number' => '81', 'name' => 'زبيدة بريقات'],
            ['meter_number' => '82', 'name' => 'الراجي محمد'],
            ['meter_number' => '83', 'name' => 'الناجي حسن'],
            ['meter_number' => '84', 'name' => 'لمفرد امحمد'],
            ['meter_number' => '85', 'name' => 'حيدة عبد الرحيم'],
            ['meter_number' => '86', 'name' => 'لمغاري بوشعيب'],
            ['meter_number' => '87', 'name' => 'النابغة سي محمد'],
            ['meter_number' => '88', 'name' => 'أرنبي رشيد'],
            ['meter_number' => '89', 'name' => 'يوسف ولد ضراوي'],
        ];

        foreach ($subscribers as $data) {
            Subscriber::updateOrCreate(
                ['meter_number' => $data['meter_number']],
                [
                    'name' => $data['name'],
                    'cin' => 'TEMP-' . $data['meter_number'], // CIN est obligatoire et unique
                    'date_subscription' => now(),
                    'status' => 'Actif',
                ]
            );
        }
    }
}
