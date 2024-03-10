<?php

namespace App\Console\Commands;

use App\Jobs\TestQueueJob;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

class TestCronQueueCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'test:cron-queue';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Test Cron';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        Log::debug('Cron Works');

        // TestQueueJob::dispatch()->delay(now()->addSeconds(5));
    }
}
