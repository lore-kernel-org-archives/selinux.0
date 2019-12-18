Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16FAC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7515A218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ChKULLYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfLRO2W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39832 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLRO2W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id t17so1807032eds.6
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZEw2sXonyv6TNXpOuySc6XGWcnvavk1bddl5By/m+L4=;
        b=ChKULLYTbjgtsIE0nO3mnV/UYHwoRNwH8HDxiNUhrGsthkMXs7E0jGYRIzkiytREZd
         67aEwc8rNJXj+QprSYcL/Khq1ALs74etKB+pPOfeoiB7rR5YqOihidLaz4RDfFEqnxZd
         QZXKHvg5jVUgpzfXNnF9kLLlcjMFrgKDqWE4PDwRm2y3TqNvvJBNlMALxHI0YZkJT9k6
         XJ5KnZUexk9vgKfu+wIGsMLNJrgee7nLHP/vD7FTSWK+mfC1Lk/0XNem2N7ISkHcikFo
         sVLA2P9SATsM8nfeVJFVhglaA4srpO08bFU57QV34waPP9ept0b26FpOtEiPHuSDQ1YU
         EUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEw2sXonyv6TNXpOuySc6XGWcnvavk1bddl5By/m+L4=;
        b=XRjMXxsU4F9IX0jX9+cAlEBeKLeWK5JUXOmj7E5Ki0z18ddFLiAJr8mNl37iBuu5DQ
         0PwQegg3BEkgbcL0FdiD5qXIuC2obQS1ER++gykk1o99pHKhOkzmq6x6pS/7+lz5Sdf8
         CNJdMZwy6cj1I4bp3OA60d//qNQkY6YFQOU4FNNNxWGDhdi6IWleZ5u6c4jQcDQpP31B
         xN8dULBkIK7OEa8GJItf4v/Yjomy+Fevarye+2g5gj6lv8J5J1/Qq6gJj8F9sl/ZSMmU
         2/xsIzSeF6xrAUg5M5tIsnQBtZDK2M4BEae3HjOrJW1One1GZzEUYFi39lZPeNlMeAvg
         UzpQ==
X-Gm-Message-State: APjAAAUIW9CNVuscE6W4TuGkClzZhs+uOpOShZLW7/C3Y7bE/77N1JKl
        MPjW0/RmYvZsRq90yGBbVwql9Y7/
X-Google-Smtp-Source: APXvYqyT8Gdhnk4IgDTvPgFy8mkP8X1mneWTB2btgDyxNOQKeCAREnnxRKVWYBr5e2rOTiCrEzhpgA==
X-Received: by 2002:a50:f70c:: with SMTP id g12mr2655206edn.142.1576679299099;
        Wed, 18 Dec 2019 06:28:19 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:18 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/8] core: bookkeeping withdrawal path of masked units
Date:   Wed, 18 Dec 2019 15:28:03 +0100
Message-Id: <20191218142808.30433-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it possible to retrieve the MAC target context for an operation on a masked unit beforehand the execution.

E.g. if unit foo is installed at `/lib/systemd/system/foo.service` with label `foo_unit_t`, but masked via a symlink `/etc/systemd/system/foo.service` -> `/dev/null`,
this storing enables to check the unmask operation on the desired context `foo_unit_t`.
---
 src/analyze/analyze.c     | 11 ++++++++-
 src/core/load-fragment.c  | 10 ++++++++
 src/core/manager.c        |  1 +
 src/core/manager.h        |  1 +
 src/core/unit.c           |  9 +++++--
 src/core/unit.h           |  1 +
 src/shared/unit-file.c    | 52 +++++++++++++++++++++++++++++----------
 src/shared/unit-file.h    |  1 +
 src/systemctl/systemctl.c |  2 +-
 src/test/test-unit-file.c |  8 ++++--
 10 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/src/analyze/analyze.c b/src/analyze/analyze.c
index 991e61de7e..8510603185 100644
--- a/src/analyze/analyze.c
+++ b/src/analyze/analyze.c
@@ -1558,6 +1558,7 @@ static bool strv_fnmatch_strv_or_empty(char* const* patterns, char **strv, int f
 static int do_unit_files(int argc, char *argv[], void *userdata) {
         _cleanup_(lookup_paths_free) LookupPaths lp = {};
         _cleanup_hashmap_free_ Hashmap *unit_ids = NULL;
+        _cleanup_hashmap_free_ Hashmap *unit_withdrawals = NULL;
         _cleanup_hashmap_free_ Hashmap *unit_names = NULL;
         char **patterns = strv_skip(argv, 1);
         Iterator i;
@@ -1569,7 +1570,7 @@ static int do_unit_files(int argc, char *argv[], void *userdata) {
         if (r < 0)
                 return log_error_errno(r, "lookup_paths_init() failed: %m");
 
-        r = unit_file_build_name_map(&lp, NULL, &unit_ids, &unit_names, NULL);
+        r = unit_file_build_name_map(&lp, NULL, &unit_ids, &unit_withdrawals, &unit_names, NULL);
         if (r < 0)
                 return log_error_errno(r, "unit_file_build_name_map() failed: %m");
 
@@ -1581,6 +1582,14 @@ static int do_unit_files(int argc, char *argv[], void *userdata) {
                 printf("ids: %s → %s\n", k, dst);
         }
 
+        HASHMAP_FOREACH_KEY(dst, k, unit_withdrawals, i) {
+                if (!strv_fnmatch_or_empty(patterns, k, FNM_NOESCAPE) &&
+                    !strv_fnmatch_or_empty(patterns, dst, FNM_NOESCAPE))
+                        continue;
+
+                printf("withdrawals: %s → %s\n", k, dst);
+        }
+
         HASHMAP_FOREACH_KEY(v, k, unit_names, i) {
                 if (!strv_fnmatch_or_empty(patterns, k, FNM_NOESCAPE) &&
                     !strv_fnmatch_strv_or_empty(patterns, v, FNM_NOESCAPE))
diff --git a/src/core/load-fragment.c b/src/core/load-fragment.c
index 1679e047dd..338bf84996 100644
--- a/src/core/load-fragment.c
+++ b/src/core/load-fragment.c
@@ -4670,6 +4670,7 @@ int unit_load_fragment(Unit *u) {
         r = unit_file_build_name_map(&u->manager->lookup_paths,
                                      &u->manager->unit_cache_mtime,
                                      &u->manager->unit_id_map,
+                                     &u->manager->unit_withdrawal_map,
                                      &u->manager->unit_name_map,
                                      &u->manager->unit_path_cache);
         if (r < 0)
@@ -4702,8 +4703,17 @@ int unit_load_fragment(Unit *u) {
                         return r;
 
                 if (null_or_empty(&st)) {
+                        const char *wpath;
+
                         u->load_state = UNIT_MASKED;
                         u->fragment_mtime = 0;
+
+                        wpath = hashmap_get(u->manager->unit_withdrawal_map, u->id);
+                        if (wpath) {
+                                r = free_and_strdup(&u->withdrawal_path, wpath);
+                                if (r < 0)
+                                        return r;
+                        }
                 } else {
                         u->load_state = UNIT_LOADED;
                         u->fragment_mtime = timespec_load(&st.st_mtim);
diff --git a/src/core/manager.c b/src/core/manager.c
index 13a6b49a8f..7d8015e211 100644
--- a/src/core/manager.c
+++ b/src/core/manager.c
@@ -691,6 +691,7 @@ static int manager_setup_prefix(Manager *m) {
 
 static void manager_free_unit_name_maps(Manager *m) {
         m->unit_id_map = hashmap_free(m->unit_id_map);
+        m->unit_withdrawal_map = hashmap_free(m->unit_withdrawal_map);
         m->unit_name_map = hashmap_free(m->unit_name_map);
         m->unit_path_cache = set_free_free(m->unit_path_cache);
         m->unit_cache_mtime =  0;
diff --git a/src/core/manager.h b/src/core/manager.h
index 51df7f8cd9..fb1a29d88c 100644
--- a/src/core/manager.h
+++ b/src/core/manager.h
@@ -224,6 +224,7 @@ struct Manager {
         UnitFileScope unit_file_scope;
         LookupPaths lookup_paths;
         Hashmap *unit_id_map;
+        Hashmap *unit_withdrawal_map;
         Hashmap *unit_name_map;
         Set *unit_path_cache;
         usec_t unit_cache_mtime;
diff --git a/src/core/unit.c b/src/core/unit.c
index c406bb7ab2..f9b299c8a4 100644
--- a/src/core/unit.c
+++ b/src/core/unit.c
@@ -708,6 +708,7 @@ void unit_free(Unit *u) {
         strv_free(u->documentation);
         free(u->fragment_path);
         free(u->source_path);
+        free(u->withdrawal_path);
         strv_free(u->dropin_paths);
         free(u->instance);
 
@@ -1252,6 +1253,9 @@ void unit_dump(Unit *u, FILE *f, const char *prefix) {
         if (u->source_path)
                 fprintf(f, "%s\tSource Path: %s\n", prefix, u->source_path);
 
+        if (u->withdrawal_path)
+                fprintf(f, "%s\tWithdrawal Path: %s\n", prefix, u->withdrawal_path);
+
         STRV_FOREACH(j, u->dropin_paths)
                 fprintf(f, "%s\tDropIn Path: %s\n", prefix, *j);
 
@@ -5709,9 +5713,10 @@ const char *unit_label_path(Unit *u) {
         if (!p)
                 return NULL;
 
-        /* If a unit is masked, then don't read the SELinux label of /dev/null, as that really makes no sense */
+        /* If a unit is masked, then don't read the SELinux label of /dev/null, as that really makes no sense.
+         * Instead try withdrawal path (which can be NULL) */
         if (path_equal(p, "/dev/null"))
-                return NULL;
+                return u->withdrawal_path;
 
         return p;
 }
diff --git a/src/core/unit.h b/src/core/unit.h
index c5d8170c92..5dac251d74 100644
--- a/src/core/unit.h
+++ b/src/core/unit.h
@@ -130,6 +130,7 @@ typedef struct Unit {
 
         char *fragment_path; /* if loaded from a config file this is the primary path to it */
         char *source_path; /* if converted, the source file */
+        char *withdrawal_path; /* if masked, path to withdrawal unit file (if existent) */
         char **dropin_paths;
 
         usec_t fragment_mtime;
diff --git a/src/shared/unit-file.c b/src/shared/unit-file.c
index 28cd3c8600..2bf302650e 100644
--- a/src/shared/unit-file.c
+++ b/src/shared/unit-file.c
@@ -195,20 +195,23 @@ int unit_file_build_name_map(
                 const LookupPaths *lp,
                 usec_t *cache_mtime,
                 Hashmap **ret_unit_ids_map,
+                Hashmap **ret_unit_withdrawal_map,
                 Hashmap **ret_unit_names_map,
                 Set **ret_path_cache) {
 
-        /* Build two mappings: any name → main unit (i.e. the end result of symlink resolution), unit name →
-         * all aliases (i.e. the entry for a given key is a a list of all names which point to this key). The
-         * key is included in the value iff we saw a file or symlink with that name. In other words, if we
-         * have a key, but it is not present in the value for itself, there was an alias pointing to it, but
-         * the unit itself is not loadable.
+        /* Build three mappings:
+         *   - any name → main unit (i.e. the end result of symlink resolution)
+         *   - any name → withdrawal unit file path (in case the unit is maksed)
+         *   - unit name → all aliases (i.e. the entry for a given key is a a list of all names which point to this key).
+         *     The key is included in the value iff we saw a file or symlink with that name. In other words, if we
+         *     have a key, but it is not present in the value for itself, there was an alias pointing to it, but
+         *     the unit itself is not loadable.
          *
          * At the same, build a cache of paths where to find units.
          */
 
-        _cleanup_hashmap_free_ Hashmap *ids = NULL, *names = NULL;
-        _cleanup_set_free_free_ Set *paths = NULL;
+        _cleanup_hashmap_free_ Hashmap *ids = NULL, *withdrawals = NULL, *names = NULL;
+        _cleanup_set_free_free_ Set *paths = NULL, *masked_ids = NULL;
         char **dir;
         int r;
         usec_t mtime = 0;
@@ -224,6 +227,10 @@ int unit_file_build_name_map(
                         return log_oom();
         }
 
+        masked_ids = set_new(&string_hash_ops);
+        if (!masked_ids)
+                return log_oom();
+
         STRV_FOREACH(dir, (char**) lp->search_path) {
                 struct dirent *de;
                 _cleanup_closedir_ DIR *d = NULL;
@@ -248,6 +255,7 @@ int unit_file_build_name_map(
                         _cleanup_free_ char *_filename_free = NULL, *simplified = NULL;
                         const char *suffix, *dst = NULL;
                         bool valid_unit_name;
+                        bool revisit_masked;
 
                         valid_unit_name = unit_name_is_valid(de->d_name, UNIT_NAME_ANY);
 
@@ -276,8 +284,8 @@ int unit_file_build_name_map(
 
                         /* search_path is ordered by priority (highest first). If the name is already mapped
                          * to something (incl. itself), it means that we have already seen it, and we should
-                         * ignore it here. */
-                        if (hashmap_contains(ids, de->d_name))
+                         * ignore it here. Except the unit is masked, then try to get the withdrawal path */
+                        if ((revisit_masked = hashmap_contains(ids, de->d_name)) && !set_contains(masked_ids, de->d_name))
                                 continue;
 
                         dirent_ensure_type(d, de);
@@ -349,10 +357,27 @@ int unit_file_build_name_map(
                                 log_debug("%s: normal unit file: %s", __func__, dst);
                         }
 
-                        r = hashmap_put_strdup(&ids, de->d_name, dst);
-                        if (r < 0)
-                                return log_warning_errno(r, "Failed to add entry to hashmap (%s→%s): %m",
-                                                         de->d_name, dst);
+                        if (revisit_masked) {
+                                if (!path_equal(dst, "/dev/null")) {
+                                        r = hashmap_put_strdup(&withdrawals, de->d_name, dst);
+                                        if (r < 0)
+                                                return log_warning_errno(r, "Failed to add entry to hashmap (%s→%s): %m",
+                                                                        de->d_name, dst);
+
+                                        set_remove(masked_ids, de->d_name);
+                                }
+                        } else {
+                                r = hashmap_put_strdup(&ids, de->d_name, dst);
+                                if (r < 0)
+                                        return log_warning_errno(r, "Failed to add entry to hashmap (%s→%s): %m",
+                                                                de->d_name, dst);
+
+                                if (path_equal(dst, "/dev/null")) {
+                                        r = set_put_strdup(masked_ids, de->d_name);
+                                        if (r < 0)
+                                                return log_oom();
+                                }
+                        }
                 }
         }
 
@@ -383,6 +408,7 @@ int unit_file_build_name_map(
         if (cache_mtime)
                 *cache_mtime = mtime;
         *ret_unit_ids_map = TAKE_PTR(ids);
+        *ret_unit_withdrawal_map = TAKE_PTR(withdrawals);
         *ret_unit_names_map = TAKE_PTR(names);
         if (ret_path_cache)
                 *ret_path_cache = TAKE_PTR(paths);
diff --git a/src/shared/unit-file.h b/src/shared/unit-file.h
index 98ba677f3f..e116487e65 100644
--- a/src/shared/unit-file.h
+++ b/src/shared/unit-file.h
@@ -45,6 +45,7 @@ int unit_file_build_name_map(
                 const LookupPaths *lp,
                 usec_t *ret_time,
                 Hashmap **ret_unit_ids_map,
+                Hashmap **ret_unit_withdrawal_map,
                 Hashmap **ret_unit_names_map,
                 Set **ret_path_cache);
 
diff --git a/src/systemctl/systemctl.c b/src/systemctl/systemctl.c
index 20e0d453d2..497cca2ff8 100644
--- a/src/systemctl/systemctl.c
+++ b/src/systemctl/systemctl.c
@@ -2660,7 +2660,7 @@ static int unit_find_paths(
                 _cleanup_set_free_free_ Set *names = NULL;
 
                 if (!cached_name_map) {
-                        r = unit_file_build_name_map(lp, NULL, &cached_id_map, &cached_name_map, NULL);
+                        r = unit_file_build_name_map(lp, NULL, &cached_id_map, NULL, &cached_name_map, NULL);
                         if (r < 0)
                                 return r;
                 }
diff --git a/src/test/test-unit-file.c b/src/test/test-unit-file.c
index 6021164739..0671b75074 100644
--- a/src/test/test-unit-file.c
+++ b/src/test/test-unit-file.c
@@ -29,6 +29,7 @@ static void test_unit_validate_alias_symlink_and_warn(void) {
 static void test_unit_file_build_name_map(char **ids) {
         _cleanup_(lookup_paths_free) LookupPaths lp = {};
         _cleanup_hashmap_free_ Hashmap *unit_ids = NULL;
+        _cleanup_hashmap_free_ Hashmap *unit_withdrawals = NULL;
         _cleanup_hashmap_free_ Hashmap *unit_names = NULL;
         Iterator i;
         const char *k, *dst;
@@ -38,11 +39,14 @@ static void test_unit_file_build_name_map(char **ids) {
 
         assert_se(lookup_paths_init(&lp, UNIT_FILE_SYSTEM, 0, NULL) >= 0);
 
-        assert_se(unit_file_build_name_map(&lp, &mtime, &unit_ids, &unit_names, NULL) == 1);
+        assert_se(unit_file_build_name_map(&lp, &mtime, &unit_ids, &unit_withdrawals, &unit_names, NULL) == 1);
 
         HASHMAP_FOREACH_KEY(dst, k, unit_ids, i)
                 log_info("ids: %s → %s", k, dst);
 
+        HASHMAP_FOREACH_KEY(dst, k, unit_withdrawals, i)
+                log_info("withdrawals: %s → %s", k, dst);
+
         HASHMAP_FOREACH_KEY(v, k, unit_names, i) {
                 _cleanup_free_ char *j = strv_join(v, ", ");
                 log_info("aliases: %s ← %s", k, j);
@@ -51,7 +55,7 @@ static void test_unit_file_build_name_map(char **ids) {
         char buf[FORMAT_TIMESTAMP_MAX];
         log_debug("Last modification time: %s", format_timestamp(buf, sizeof buf, mtime));
 
-        r = unit_file_build_name_map(&lp, &mtime, &unit_ids, &unit_names, NULL);
+        r = unit_file_build_name_map(&lp, &mtime, &unit_ids, &unit_withdrawals, &unit_names, NULL);
         assert_se(IN_SET(r, 0, 1));
         if (r == 0)
                 log_debug("Cache rebuild skipped based on mtime.");
-- 
2.24.1

