<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('readings', function (Blueprint $table) {
            if (!Schema::hasColumn('readings', 'subscription_fee')) {
                $table->decimal('subscription_fee', 10, 2)->default(5.00)->after('price_per_m3');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('readings', function (Blueprint $table) {
            if (Schema::hasColumn('readings', 'subscription_fee')) {
                $table->dropColumn('subscription_fee');
            }
        });
    }
};
