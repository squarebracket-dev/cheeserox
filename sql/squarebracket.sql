-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2024 at 07:04 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `opensb-v1.3-dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `invite_keys`
--

CREATE TABLE `invite_keys` (
  `id` int(11) NOT NULL,
  `invite_key` varchar(64) NOT NULL,
  `generated_by` int(11) NOT NULL,
  `claimed_by` int(11) DEFAULT NULL,
  `generated_time` int(11) NOT NULL,
  `claimed_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` varchar(45) NOT NULL DEFAULT '0.0.0.0',
  `reason` varchar(255) NOT NULL DEFAULT '<em>No reason specified</em>',
  `time` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `post` text NOT NULL,
  `author` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `is_site_news` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journal_comments`
--

CREATE TABLE `journal_comments` (
  `comment_id` int(11) NOT NULL,
  `id` text NOT NULL,
  `reply_to` bigint(20) NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  `author` bigint(20) NOT NULL,
  `date` bigint(20) NOT NULL,
  `deleted` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suggestions`
--

CREATE TABLE `suggestions` (
  `id` int(11) NOT NULL,
  `author` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

CREATE TABLE `uploads` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Incrementing ID for internal purposes.',
  `video_id` varchar(11) NOT NULL COMMENT 'Random alphanumeric video ID which will be visible.',
  `title` varchar(128) NOT NULL COMMENT 'Video title',
  `description` text DEFAULT NULL COMMENT 'Video description',
  `author` bigint(20) UNSIGNED NOT NULL COMMENT 'User ID of the video author',
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Unix timestamp for the time the video was uploaded',
  `most_recent_view` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `original_site` varchar(64) DEFAULT NULL,
  `original_time` bigint(20) UNSIGNED DEFAULT NULL,
  `views` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Video views',
  `flags` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '8 bools to determine certain video properties',
  `category_id` int(11) DEFAULT 0 COMMENT 'Category ID for the video',
  `videofile` text DEFAULT NULL COMMENT 'Path to the video file(?)',
  `videolength` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Length of the video in seconds',
  `tags` text DEFAULT NULL COMMENT 'Video tags, serialized in JSON',
  `post_type` int(11) NOT NULL DEFAULT 0 COMMENT 'The type of the post, 0 is a video, 1 is a legacy video, 2 is art, and 3 is music.',
  `rating` enum('general','questionable','mature') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_comments`
--

CREATE TABLE `upload_comments` (
  `comment_id` bigint(20) NOT NULL,
  `id` text NOT NULL COMMENT 'ID to video or user.',
  `reply_to` bigint(20) NOT NULL DEFAULT 0,
  `comment` text NOT NULL COMMENT 'The comment itself, formatted in Markdown.',
  `author` bigint(20) NOT NULL COMMENT 'Numerical ID of comment author.',
  `date` bigint(20) NOT NULL COMMENT 'UNIX timestamp when the comment was posted.',
  `deleted` tinyint(4) NOT NULL COMMENT 'States that the comment is deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_deleted`
--

CREATE TABLE `upload_deleted` (
  `autoint` int(11) NOT NULL,
  `id` varchar(11) NOT NULL,
  `uploaded_time` bigint(20) NOT NULL,
  `deleted_time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_ratings`
--

CREATE TABLE `upload_ratings` (
  `user` bigint(20) UNSIGNED NOT NULL COMMENT 'User that does the rating.',
  `video` bigint(20) UNSIGNED NOT NULL COMMENT 'Video that is being rated.',
  `rating` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 for like, 0 for dislike.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_tag_index`
--

CREATE TABLE `upload_tag_index` (
  `video_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_tag_meta`
--

CREATE TABLE `upload_tag_meta` (
  `tag_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `latestUse` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_takedowns`
--

CREATE TABLE `upload_takedowns` (
  `id` int(11) NOT NULL,
  `submission` text NOT NULL,
  `time` int(11) NOT NULL,
  `reason` text NOT NULL,
  `sender` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload_views`
--

CREATE TABLE `upload_views` (
  `video_id` text NOT NULL,
  `user` text NOT NULL,
  `timestamp` int(11) NOT NULL,
  `type` enum('guest','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL COMMENT ' 	Incrementing ID for internal purposes.',
  `name` varchar(128) NOT NULL COMMENT 'Username, chosen by the user',
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL COMMENT 'Password, hashed in bcrypt.',
  `admin_password` varchar(128) DEFAULT NULL,
  `token` varchar(128) NOT NULL COMMENT 'User token for cookie authentication.',
  `joined` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'User''s join date',
  `lastview` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Timestamp of last view',
  `birthdate` date DEFAULT NULL,
  `featured_submission` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `title` text NOT NULL COMMENT 'Display Name',
  `about` text DEFAULT NULL COMMENT 'User''s description',
  `customcolor` varchar(7) DEFAULT '#523bb8' COMMENT 'The color that the user has set for their profile',
  `profile_layout` tinyint(4) NOT NULL,
  `language` varchar(10) NOT NULL DEFAULT 'en-US' COMMENT 'Language (Defaults to English)',
  `avatar` tinyint(1) NOT NULL DEFAULT 0,
  `ip` varchar(48) DEFAULT '999.999.999.999',
  `u_flags` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '8 bools to determine certain user properties',
  `powerlevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0 - banned. 1 - normal user. 2 - moderator. 3 - administrator',
  `group_id` int(11) NOT NULL DEFAULT 3,
  `comfortable_rating` enum('general','questionable','mature') NOT NULL,
  `blacklisted_tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`blacklisted_tags`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_bans`
--

CREATE TABLE `user_bans` (
  `autoint` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `reason` text NOT NULL,
  `time` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_favorites`
--

CREATE TABLE `user_favorites` (
  `user_id` int(11) NOT NULL,
  `video_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_follows`
--

CREATE TABLE `user_follows` (
  `id` int(11) NOT NULL COMMENT 'ID of the user that wants to subscribe to a user.',
  `user` int(11) NOT NULL COMMENT 'The user that the user wants to subscribe to.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `recipient` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `related_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_old_names`
--

CREATE TABLE `user_old_names` (
  `autoint` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `old_name` varchar(128) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_password_resets`
--

CREATE TABLE `user_password_resets` (
  `id` varchar(64) NOT NULL,
  `user` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profile_comments`
--

CREATE TABLE `user_profile_comments` (
  `comment_id` int(11) NOT NULL,
  `id` text NOT NULL,
  `reply_to` bigint(20) NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  `author` bigint(20) NOT NULL,
  `date` bigint(20) NOT NULL,
  `deleted` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_staff_notes`
--

CREATE TABLE `user_staff_notes` (
  `autoint` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `note` text NOT NULL,
  `author` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `invite_keys`
--
ALTER TABLE `invite_keys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journal_comments`
--
ALTER TABLE `journal_comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `suggestions`
--
ALTER TABLE `suggestions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `upload_comments`
--
ALTER TABLE `upload_comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `upload_deleted`
--
ALTER TABLE `upload_deleted`
  ADD PRIMARY KEY (`autoint`);

--
-- Indexes for table `upload_tag_meta`
--
ALTER TABLE `upload_tag_meta`
  ADD PRIMARY KEY (`tag_id`);

--
-- Indexes for table `upload_takedowns`
--
ALTER TABLE `upload_takedowns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_bans`
--
ALTER TABLE `user_bans`
  ADD PRIMARY KEY (`autoint`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_old_names`
--
ALTER TABLE `user_old_names`
  ADD PRIMARY KEY (`autoint`);

--
-- Indexes for table `user_profile_comments`
--
ALTER TABLE `user_profile_comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `user_staff_notes`
--
ALTER TABLE `user_staff_notes`
  ADD PRIMARY KEY (`autoint`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invite_keys`
--
ALTER TABLE `invite_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journal_comments`
--
ALTER TABLE `journal_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suggestions`
--
ALTER TABLE `suggestions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Incrementing ID for internal purposes.';

--
-- AUTO_INCREMENT for table `upload_comments`
--
ALTER TABLE `upload_comments`
  MODIFY `comment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `upload_deleted`
--
ALTER TABLE `upload_deleted`
  MODIFY `autoint` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `upload_tag_meta`
--
ALTER TABLE `upload_tag_meta`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `upload_takedowns`
--
ALTER TABLE `upload_takedowns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT ' 	Incrementing ID for internal purposes.';

--
-- AUTO_INCREMENT for table `user_bans`
--
ALTER TABLE `user_bans`
  MODIFY `autoint` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_old_names`
--
ALTER TABLE `user_old_names`
  MODIFY `autoint` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profile_comments`
--
ALTER TABLE `user_profile_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_staff_notes`
--
ALTER TABLE `user_staff_notes`
  MODIFY `autoint` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
