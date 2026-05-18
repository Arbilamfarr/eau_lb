-- Database dump for InfinityFree

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES ('lmsabh-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6', 'i:1;', '1772631479');
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES ('lmsabh-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer', 'i:1772631479;', '1772631479');

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscriber_id` bigint(20) unsigned NOT NULL,
  `reading_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `penalty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `status` enum('Payée','Non payée','En retard') NOT NULL DEFAULT 'Non payée',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_subscriber_id_foreign` (`subscriber_id`),
  KEY `invoices_reading_id_foreign` (`reading_id`),
  CONSTRAINT `invoices_reading_id_foreign` FOREIGN KEY (`reading_id`) REFERENCES `readings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_subscriber_id_foreign` FOREIGN KEY (`subscriber_id`) REFERENCES `subscribers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `invoices` (`id`, `subscriber_id`, `reading_id`, `amount`, `penalty`, `total`, `status`, `created_at`, `updated_at`) VALUES ('2', '88', '2', '35.00', '0.00', '35.00', 'Payée', '2026-03-04 13:47:21', '2026-03-04 14:07:49');
INSERT INTO `invoices` (`id`, `subscriber_id`, `reading_id`, `amount`, `penalty`, `total`, `status`, `created_at`, `updated_at`) VALUES ('3', '88', '3', '65.00', '0.00', '65.00', 'Payée', '2026-03-04 13:47:50', '2026-03-04 14:08:26');

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('1', '0001_01_01_000000_create_users_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('2', '0001_01_01_000001_create_cache_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('3', '0001_01_01_000002_create_jobs_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('4', '2026_02_26_171543_create_subscribers_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('5', '2026_02_26_171548_create_readings_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('6', '2026_02_26_171556_create_invoices_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('7', '2026_02_26_171602_create_payments_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('8', '2026_03_04_105526_add_subscription_fee_to_readings_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('9', '2026_03_04_134605_add_subscription_fee_to_readings_table_v2', '2');

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `method` enum('Espèces','Virement') NOT NULL DEFAULT 'Espèces',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_invoice_id_foreign` (`invoice_id`),
  CONSTRAINT `payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `readings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscriber_id` bigint(20) unsigned NOT NULL,
  `month` varchar(255) NOT NULL,
  `old_index` int(11) NOT NULL,
  `new_index` int(11) NOT NULL,
  `consumption` int(11) NOT NULL,
  `price_per_m3` decimal(10,2) NOT NULL,
  `subscription_fee` decimal(10,2) NOT NULL DEFAULT 5.00,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `readings_subscriber_id_foreign` (`subscriber_id`),
  CONSTRAINT `readings_subscriber_id_foreign` FOREIGN KEY (`subscriber_id`) REFERENCES `subscribers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `readings` (`id`, `subscriber_id`, `month`, `old_index`, `new_index`, `consumption`, `price_per_m3`, `subscription_fee`, `total`, `created_at`, `updated_at`) VALUES ('2', '88', '2026-03', '0', '10', '10', '3.00', '5.00', '35.00', '2026-03-04 13:47:21', '2026-03-04 13:47:21');
INSERT INTO `readings` (`id`, `subscriber_id`, `month`, `old_index`, `new_index`, `consumption`, `price_per_m3`, `subscription_fee`, `total`, `created_at`, `updated_at`) VALUES ('3', '88', '2026-04', '10', '30', '20', '3.00', '5.00', '65.00', '2026-03-04 13:47:50', '2026-03-04 13:48:09');

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('05dytvF7ou9XYufe0P9ZZHhlsUNOkF6CCWiOeg60', '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiR24weUpIa1hEQWJ0Y2pzenFSM21ObFFoUjlxVERwV29wR2NWcU1yRiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvcmVhZGluZ3MiO3M6NToicm91dGUiO3M6Mzk6ImZpbGFtZW50LmFkbWluLnJlc291cmNlcy5yZWFkaW5ncy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6ImVmYjEwYzhiMzMyMWEzOWQzYjEyYmUyMGQzOTRiYWVhZjg5MDk3YmI0NDBhMjQwYjA4YjcwNjEwYWYwY2RmZGMiO3M6NjoidGFibGVzIjthOjU6e3M6NDA6IjQ0NjM0MDQxMWVmMjE4MGFiNDA5MTEzNzMwOWEzNjUwX2NvbHVtbnMiO2E6Nzp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWUiO3M6NToibGFiZWwiO3M6MjM6Itin2YTYp9iz2YUg2KfZhNmD2KfZhdmEIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czozOiJjaW4iO3M6NToibGFiZWwiO3M6MjM6Itin2YTYsdmC2YUg2KfZhNmI2LfZhtmKIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6InBob25lIjtzOjU6ImxhYmVsIjtzOjEyOiLYp9mE2YfYp9iq2YEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEyOiJtZXRlcl9udW1iZXIiO3M6NToibGFiZWwiO3M6MTk6Itix2YLZhSDYp9mE2LnYr9in2K8iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjE3OiJkYXRlX3N1YnNjcmlwdGlvbiI7czo1OiJsYWJlbCI7czoyNzoi2KrYp9ix2YrYriDYp9mE2KfYtNiq2LHYp9mDIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9aTo1O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InN0YXR1cyI7czo1OiJsYWJlbCI7czoxMjoi2KfZhNit2KfZhNipIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiY3JlYXRlZF9hdCI7czo1OiJsYWJlbCI7czoyNToi2KrYp9ix2YrYriDYp9mE2KXZhti02KfYoSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjA7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjE7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtiOjE7fX1zOjQwOiI1M2U1ZGM3ZGFhMmQxYzE5NWMzMDNlYzI1NWUxZWEzNF9jb2x1bW5zIjthOjk6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxNToic3Vic2NyaWJlci5uYW1lIjtzOjU6ImxhYmVsIjtzOjE0OiLYp9mE2YXYtNiq2LHZgyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToibW9udGgiO3M6NToibGFiZWwiO3M6MTA6Itin2YTYtNmH2LEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjk6Im9sZF9pbmRleCI7czo1OiJsYWJlbCI7czoyNToi2KfZhNmF2KTYtNixINin2YTZgtiv2YrZhSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6OToibmV3X2luZGV4IjtzOjU6ImxhYmVsIjtzOjI1OiLYp9mE2YXYpNi02LEg2KfZhNis2K/ZitivIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMToiY29uc3VtcHRpb24iO3M6NToibGFiZWwiO3M6MTg6Itin2YTYp9iz2KrZh9mE2KfZgyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTI6InByaWNlX3Blcl9tMyI7czo1OiJsYWJlbCI7czoxMDoi2LPYudixINmFMyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTY6InN1YnNjcmlwdGlvbl9mZWUiO3M6NToibGFiZWwiO3M6MTI6Itin2YbYrtix2KfYtyI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjc7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToidG90YWwiO3M6NToibGFiZWwiO3M6MTQ6Itin2YTZhdis2YXZiNi5IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6ODthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiY3JlYXRlZF9hdCI7czo1OiJsYWJlbCI7czoyNToi2KrYp9ix2YrYriDYp9mE2KrYs9is2YrZhCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjA7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjE7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtiOjE7fX1zOjQwOiIxNzI5Zjk5ODkwYzAzYmVkOWZmZGQ1M2I0YTU3NzI2Y19jb2x1bW5zIjthOjQ6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoyMzoiaW52b2ljZS5zdWJzY3JpYmVyLm5hbWUiO3M6NToibGFiZWwiO3M6MTQ6Itin2YTZhdi02KrYsdmDIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiaW52b2ljZS5pZCI7czo1OiJsYWJlbCI7czoyMzoi2LHZgtmFINin2YTZgdin2KrZiNix2KkiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6ImFtb3VudCI7czo1OiJsYWJlbCI7czoxMjoi2KfZhNmF2KjZhNi6IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMjoicGF5bWVudF9kYXRlIjtzOjU6ImxhYmVsIjtzOjE0OiLYp9mE2KrYp9ix2YrYriI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiNjlmNjcxOTgyNjRlODBkZGE5YmRkMzhmY2FkMjk2YTRfY29sdW1ucyI7YTo1OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTU6InN1YnNjcmliZXIubmFtZSI7czo1OiJsYWJlbCI7czoxNDoi2KfZhNmF2LTYqtix2YMiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEzOiJyZWFkaW5nLm1vbnRoIjtzOjU6ImxhYmVsIjtzOjEwOiLYp9mE2LTZh9ixIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJ0b3RhbCI7czo1OiJsYWJlbCI7czoxNDoi2KfZhNmF2KzZhdmI2LkiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6InN0YXR1cyI7czo1OiJsYWJlbCI7czoxMjoi2KfZhNit2KfZhNipIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiY3JlYXRlZF9hdCI7czo1OiJsYWJlbCI7czoyNzoi2KrYp9ix2YrYriDYp9mE2YHYp9iq2YjYsdipIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9fXM6NDE6IjQ0NjM0MDQxMWVmMjE4MGFiNDA5MTEzNzMwOWEzNjUwX3Blcl9wYWdlIjtzOjI6IjUwIjt9czo4OiJmaWxhbWVudCI7YTowOnt9fQ==', '1772634557');

CREATE TABLE `subscribers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `cin` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `meter_number` varchar(255) NOT NULL,
  `date_subscription` date NOT NULL,
  `status` enum('Actif','Suspendu') NOT NULL DEFAULT 'Actif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_cin_unique` (`cin`),
  UNIQUE KEY `subscribers_meter_number_unique` (`meter_number`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('1', 'لمخنتر براهيم', 'TEMP-1', NULL, NULL, '1', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('2', 'البصري عبد الرحيم', 'TEMP-2', NULL, NULL, '2', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('3', 'لمفرد بوشعيب', 'TEMP-3', NULL, NULL, '3', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('4', 'الناجي خديجة', 'TEMP-4', NULL, NULL, '4', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('5', 'أرنبي شفيق', 'TEMP-5', NULL, NULL, '5', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('6', 'حليط عائشة', 'TEMP-6', NULL, NULL, '6', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('7', 'حيدة حبيبة', 'TEMP-7', NULL, NULL, '7', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('8', 'لمفرد امحمد', 'TEMP-8', NULL, NULL, '8', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('9', 'لمفرد ميلودة', 'TEMP-9', NULL, NULL, '9', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('10', 'لمفرد محمد', 'TEMP-10', NULL, NULL, '10', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('11', 'لمفرد لمفرك', 'TEMP-11', NULL, NULL, '11', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('12', 'لمغاري سعيد', 'TEMP-12', NULL, NULL, '12', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('13', 'المسجد 1', 'TEMP-13', NULL, NULL, '13', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('14', 'بن لمفرد عبد الله', 'TEMP-14', NULL, NULL, '14', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('15', 'حيدة عائشة', 'TEMP-15', NULL, NULL, '15', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('16', 'الراجي عبد الفتاح', 'TEMP-16', NULL, NULL, '16', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('17', 'الراجي بوشعيب', 'TEMP-17', NULL, NULL, '17', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('18', 'النابغة فاطنة', 'TEMP-18', NULL, NULL, '18', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('19', 'جعواني مليكة', 'TEMP-19', NULL, NULL, '19', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('20', 'حيدة امحمد', 'TEMP-20', NULL, NULL, '20', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('21', 'المسجد2', 'TEMP-21', NULL, NULL, '21', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('22', 'النابغة عبد اللطيف', 'TEMP-22', NULL, NULL, '22', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('23', 'بريقات حميد', 'TEMP-23', NULL, NULL, '23', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('24', 'بريقات حسنى', 'TEMP-24', NULL, NULL, '24', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('25', 'مغتنم بوشعيب', 'TEMP-25', NULL, NULL, '25', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('26', 'مغتنم ادريس', 'TEMP-26', NULL, NULL, '26', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('27', 'النابغة عبد المجيد', 'TEMP-27', NULL, NULL, '27', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('28', 'حافظي عبد السلام', 'TEMP-28', NULL, NULL, '28', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('29', 'طاعة عبد القادر', 'TEMP-29', NULL, NULL, '29', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('30', 'لمغاري أحمد', 'TEMP-30', NULL, NULL, '30', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('31', 'لمغاري مصطفى', 'TEMP-31', NULL, NULL, '31', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('32', 'لمغاري عبدالعاطي', 'TEMP-32', NULL, NULL, '32', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('33', 'لمغاري فاطنة', 'TEMP-33', NULL, NULL, '33', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('34', 'لمغاري بوشعيب', 'TEMP-34', NULL, NULL, '34', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('35', 'لمغاري عبد العزيز', 'TEMP-35', NULL, NULL, '35', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('36', 'النابغة عبد السلام', 'TEMP-36', NULL, NULL, '36', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('37', 'النابغة محمد', 'TEMP-37', NULL, NULL, '37', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('38', 'خصال عبد الكريم', 'TEMP-38', NULL, NULL, '38', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('39', 'النابغة بوشعيب (البياض)', 'TEMP-39', NULL, NULL, '39', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('40', 'بوعادل عبد الرحمان', 'TEMP-40', NULL, NULL, '40', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('41', 'فتح الله عبد الغاني', 'TEMP-41', NULL, NULL, '41', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('42', 'بوعادل مصطفى', 'TEMP-42', NULL, NULL, '42', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('43', 'بريقات عائشة', 'TEMP-43', NULL, NULL, '43', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('44', 'بريقات محمد', 'TEMP-44', NULL, NULL, '44', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('45', 'راضي ماجدة', 'TEMP-45', NULL, NULL, '45', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('46', 'لمغاري عبد الغاني', 'TEMP-46', NULL, NULL, '46', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('47', 'لمفرد فتيحة', 'TEMP-47', NULL, NULL, '47', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('48', 'زاهير لخليفة', 'TEMP-48', NULL, NULL, '48', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('49', 'النابغة أحمد', 'TEMP-49', NULL, NULL, '49', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('50', 'لمغاري امحمد', 'TEMP-50', NULL, NULL, '50', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('51', 'باهي محمد', 'TEMP-51', NULL, NULL, '51', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('52', 'لمغاري سي محمد', 'TEMP-52', NULL, NULL, '52', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('53', 'الرخمي جوهرة', 'TEMP-53', NULL, NULL, '53', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('54', 'لمغاري عبد الحق', 'TEMP-54', NULL, NULL, '54', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('55', 'حيدة عبد اللطيف', 'TEMP-55', NULL, NULL, '55', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('56', 'حيدة براهيم', 'TEMP-56', NULL, NULL, '56', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('57', 'فتح الله عبد القادر', 'TEMP-57', NULL, NULL, '57', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('58', 'لمخنتر بوشعيب', 'TEMP-58', NULL, NULL, '58', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('59', 'غنبور مصطفى', 'TEMP-59', NULL, NULL, '59', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('60', 'لكحل إبراهيم', 'TEMP-60', NULL, NULL, '60', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('61', 'حيدة امحمد', 'TEMP-61', NULL, NULL, '61', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('62', 'حيدة سعيد', 'TEMP-62', NULL, NULL, '62', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('63', 'البيضاوي عصام', 'TEMP-63', NULL, NULL, '63', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('64', 'حيدة محمد (لعسل)', 'TEMP-64', NULL, NULL, '64', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('65', 'صبار عبد الرحمان', 'TEMP-65', NULL, NULL, '65', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('66', 'لزعر عبد السلام', 'TEMP-66', NULL, NULL, '66', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('67', 'أرنبي عبد الحق', 'TEMP-67', NULL, NULL, '67', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('68', 'لمفرد عبد السلام', 'TEMP-68', NULL, NULL, '68', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('69', 'لمخنتر التهامي', 'TEMP-69', NULL, NULL, '69', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('70', 'لمخنتر يوسف', 'TEMP-70', NULL, NULL, '70', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('71', 'مغتنم العربي', 'TEMP-71', NULL, NULL, '71', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('72', 'لمفرد عبد العزيز', 'TEMP-72', NULL, NULL, '72', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('73', 'غنبور عباس', 'TEMP-73', NULL, NULL, '73', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('74', 'لمغاري رضوان', 'TEMP-74', NULL, NULL, '74', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('75', 'مغتنم مباركة', 'TEMP-75', NULL, NULL, '75', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('76', 'طاعة عبد الرحيم', 'TEMP-76', NULL, NULL, '76', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('77', 'الراجي الطاهر', 'TEMP-77', NULL, NULL, '77', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('78', 'مغتنم أيوب', 'TEMP-78', NULL, NULL, '78', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('79', 'لمفرد أمينة', 'TEMP-79', NULL, NULL, '79', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('80', 'اطراسي عبد العزيز', 'TEMP-80', NULL, NULL, '80', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('81', 'زبيدة بريقات', 'TEMP-81', NULL, NULL, '81', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('82', 'الراجي محمد', 'TEMP-82', NULL, NULL, '82', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('83', 'الناجي حسن', 'TEMP-83', NULL, NULL, '83', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('84', 'لمفرد امحمد', 'TEMP-84', NULL, NULL, '84', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('85', 'حيدة عبد الرحيم', 'TEMP-85', NULL, NULL, '85', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('86', 'لمغاري بوشعيب', 'TEMP-86', NULL, NULL, '86', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('87', 'النابغة سي محمد', 'TEMP-87', NULL, NULL, '87', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('88', 'أرنبي رشيد', 'TEMP-88', '212 618075613', NULL, '88', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 14:03:03');
INSERT INTO `subscribers` (`id`, `name`, `cin`, `phone`, `address`, `meter_number`, `date_subscription`, `status`, `created_at`, `updated_at`) VALUES ('89', 'يوسف ولد ضراوي', 'TEMP-89', NULL, NULL, '89', '2026-03-04', 'Actif', '2026-03-04 13:35:44', '2026-03-04 13:35:44');

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','agent') NOT NULL DEFAULT 'agent',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES ('1', 'Admin User', 'admin@example.com', NULL, '$2y$12$EXLqWXBZARZSv3.Hc68Yl.Bx3o8kYp8F6LQqgNGMHZ4lCjOcN3rIy', 'admin', 'FcEJwkPGGxEK8pRriEIP1C52XyUqUecbAQ9L6Zrg1jRiwDkwhhI79nmWi4QI', '2026-03-04 13:35:44', '2026-03-04 13:35:44');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES ('2', 'Agent User', 'agent@example.com', NULL, '$2y$12$ZIX1/NTy7MBMp.eWr1Iac.pvzpOF.EllAnl65B.ZP77cYwu/xaM4C', 'agent', NULL, '2026-03-04 13:35:44', '2026-03-04 13:35:44');

