<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
    protected $guarded = [];

    public function subscriber()
    {
        return $this->belongsTo(Subscriber::class);
    }

    public function reading()
    {
        return $this->belongsTo(Reading::class);
    }

    public function payments()
    {
        return $this->hasMany(Payment::class);
    }
}
