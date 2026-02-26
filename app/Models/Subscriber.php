<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Subscriber extends Model
{
    protected $guarded = [];

    protected $casts = [
        'date_subscription' => 'date',
    ];

    public function readings()
    {
        return $this->hasMany(Reading::class);
    }

    public function invoices()
    {
        return $this->hasMany(Invoice::class);
    }
}
