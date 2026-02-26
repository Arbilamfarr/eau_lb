<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reading extends Model
{
    protected $guarded = [];

    protected static function booted()
    {
        static::saved(function ($reading) {
            $reading->invoice()->updateOrCreate(
                ['reading_id' => $reading->id],
                [
                    'subscriber_id' => $reading->subscriber_id,
                    'amount' => $reading->total,
                    'penalty' => 0,
                    'total' => $reading->total,
                    'status' => 'Non payée',
                ]
            );
        });
    }

    public function subscriber()
    {
        return $this->belongsTo(Subscriber::class);
    }

    public function invoice()
    {
        return $this->hasOne(Invoice::class);
    }
}
