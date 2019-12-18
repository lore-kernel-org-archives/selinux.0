Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E05C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AC3227BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PvJAjUvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLRO21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44886 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfLRO21 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id bx28so1787697edb.11
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BgpG9cCwXuOqAeuyoqTvRecRdeycKOfK7REJNwr3eIo=;
        b=PvJAjUvtp6hsd5/v7qKExObuBzpEm0zv//l3c5OGo2qCO3NxZx1huTKngX3IlJZ26U
         lJbPNDVfd8Zr2P2+iuXBKoMfxl4egx8GBGbAlK6ntURtXauXvXcjELBOPzuj3lP1a645
         QXvTEOCJXXd14ky4zaY4MRCAVA8IobV8ueTe9co9RQ15yiN//2qYOrwqNv3RCnyQBrl9
         6GBfi0QLPV5G89v3qN5neamr9FknZpE0kq/fjrlMfJv882d2yJG2hJ+3hFWnTfsU4RWn
         oaLnLn1A4MU3mQXMaEYd0n2yxPhmhb//W8ot1C4MNBBdXYgeN+jAVb+rdvJJqDFMwo+y
         VUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgpG9cCwXuOqAeuyoqTvRecRdeycKOfK7REJNwr3eIo=;
        b=tq/al/+aBNtyqt/dVsvIR8NLvmSOPB6rVMHp4ysrBujPbA6pppOooapRTDl1i/ufqd
         T1YFXEJJxcjqagCTR+lVD86TtMVtEE+SuSvNKuGNlZ40VR1N1gaWW9z3p1iQBRSz71+P
         lDad5ESqRRCXa7kux3HB0XMAAddvFN0JQxc0eah3mC9xNsXcLCk65FfkWPjA4mus9IUw
         meni3MDLCsFLqlUsl5LaHIsK8B2YG0LIbuM3M1Zt7A2O7PRhnRhXByrWIu+tsqCp2dvK
         ddv7Qyy40GkcLXNd+HZO52ggDzQE8P2o+k1TpZZQRKwKur2Xu8T/1uwTvAeeSS6x/e4a
         Tqiw==
X-Gm-Message-State: APjAAAVqn9GbavcLCUutdyy0Ny4p3UmwEaKB1vlTxvBZ5+c9URmGBN7C
        KkUbxluGrlq46weS5ZliylSrxO/i
X-Google-Smtp-Source: APXvYqy6lwDSQogkxiDF2rQM6jPmUfNazfbqy7uzgBzSJYgWGL13CXXMFJPdyuG95AwSoNm3KBBINg==
X-Received: by 2002:aa7:d1d0:: with SMTP id g16mr2762495edp.56.1576679301091;
        Wed, 18 Dec 2019 06:28:21 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:20 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 6/8] core: add support for MAC checks on unit install operations
Date:   Wed, 18 Dec 2019 15:28:06 +0100
Message-Id: <20191218142808.30433-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

shared:
  Add a MAC callback call to unit_file_* functions to check unit operations, like enable, disable...
  The MAC callback is supplied with the unit name as first argument. The second argument is a blob used by the back-end MAC specific check.
  If no check should be performed, pass a NULL pointer.

core:
  Implement a generic MAC callback for sd-bus and register it for D-Bus exposed methods.

systemctl:
  Adopt to the new callback by passing NULL.
  No callback check is needed when called on the client side, cause regular MAC checks (like write, unlink...) on the installed unit file (in /lib/systemd/system) or temporary one (in /etc/systemd/system) will be performed.
---
 src/core/dbus-manager.c      |  41 ++++++++++----
 src/core/manager.c           |   2 +-
 src/shared/install.c         | 101 +++++++++++++++++++++++++++++------
 src/shared/install.h         |  42 +++++++++++----
 src/systemctl/systemctl.c    |  26 ++++-----
 src/test/test-install-root.c |  86 ++++++++++++++---------------
 src/test/test-install.c      |  38 ++++++-------
 7 files changed, 224 insertions(+), 112 deletions(-)

diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index cd66871d48..b866fd58b6 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -2062,10 +2062,22 @@ fail:
         return r;
 }
 
+struct mac_callback_userdata {
+};
+
+static int mac_callback_check(const char *name, void *userdata) {
+        struct mac_callback_userdata *ud = userdata;
+
+        assert(name);
+        assert(ud);
+
+        return 0;
+}
+
 static int method_enable_unit_files_generic(
                 sd_bus_message *message,
                 Manager *m,
-                int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes),
+                int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
                 bool carries_install_info,
                 sd_bus_error *error) {
 
@@ -2074,6 +2086,7 @@ static int method_enable_unit_files_generic(
         size_t n_changes = 0;
         UnitFileFlags flags;
         int runtime, force, r;
+        struct mac_callback_userdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2094,7 +2107,7 @@ static int method_enable_unit_files_generic(
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = call(m->unit_file_scope, flags, NULL, l, &changes, &n_changes);
+        r = call(m->unit_file_scope, flags, NULL, l, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2113,8 +2126,8 @@ static int method_link_unit_files(sd_bus_message *message, void *userdata, sd_bu
         return method_enable_unit_files_generic(message, userdata, unit_file_link, false, error);
 }
 
-static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char **files, UnitFileChange **changes, size_t *n_changes) {
-        return unit_file_preset(scope, flags, root_dir, files, UNIT_FILE_PRESET_FULL, changes, n_changes);
+static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char **files, UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata) {
+        return unit_file_preset(scope, flags, root_dir, files, UNIT_FILE_PRESET_FULL, changes, n_changes, mac_check, userdata);
 }
 
 static int method_preset_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
@@ -2135,6 +2148,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
         int runtime, force, r;
         UnitFileFlags flags;
         const char *mode;
+        struct mac_callback_userdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2163,7 +2177,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = unit_file_preset(m->unit_file_scope, flags, NULL, l, mm, &changes, &n_changes);
+        r = unit_file_preset(m->unit_file_scope, flags, NULL, l, mm, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2173,13 +2187,14 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
 static int method_disable_unit_files_generic(
                 sd_bus_message *message,
                 Manager *m,
-                int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes),
+                int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
                 sd_bus_error *error) {
 
         _cleanup_strv_free_ char **l = NULL;
         UnitFileChange *changes = NULL;
         size_t n_changes = 0;
         int r, runtime;
+        struct mac_callback_userdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2198,7 +2213,7 @@ static int method_disable_unit_files_generic(
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = call(m->unit_file_scope, runtime ? UNIT_FILE_RUNTIME : 0, NULL, l, &changes, &n_changes);
+        r = call(m->unit_file_scope, runtime ? UNIT_FILE_RUNTIME : 0, NULL, l, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2219,6 +2234,7 @@ static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_
         size_t n_changes = 0;
         Manager *m = userdata;
         int r;
+        struct mac_callback_userdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2233,7 +2249,7 @@ static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = unit_file_revert(m->unit_file_scope, NULL, l, &changes, &n_changes);
+        r = unit_file_revert(m->unit_file_scope, NULL, l, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2279,6 +2295,7 @@ static int method_preset_all_unit_files(sd_bus_message *message, void *userdata,
         const char *mode;
         UnitFileFlags flags;
         int force, runtime, r;
+        struct mac_callback_userdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2307,7 +2324,7 @@ static int method_preset_all_unit_files(sd_bus_message *message, void *userdata,
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = unit_file_preset_all(m->unit_file_scope, flags, NULL, mm, &changes, &n_changes);
+        r = unit_file_preset_all(m->unit_file_scope, flags, NULL, mm, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2323,6 +2340,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         char *target, *type;
         UnitDependency dep;
         UnitFileFlags flags;
+        struct mac_callback_userdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2351,7 +2369,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         if (dep < 0)
                 return -EINVAL;
 
-        r = unit_file_add_dependency(m->unit_file_scope, flags, NULL, l, target, dep, &changes, &n_changes);
+        r = unit_file_add_dependency(m->unit_file_scope, flags, NULL, l, target, dep, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2366,6 +2384,7 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         const char *name;
         char **p;
         int runtime, r;
+        struct mac_callback_userdata mcud = {};
 
         r = mac_selinux_access_check(message, "status", error);
         if (r < 0)
@@ -2387,7 +2406,7 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         flags = UNIT_FILE_DRY_RUN |
                 (runtime ? UNIT_FILE_RUNTIME : 0);
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes, mac_callback_check, &mcud);
         if (r < 0)
                 return log_error_errno(r, "Failed to get file links for %s: %m", name);
 
diff --git a/src/core/manager.c b/src/core/manager.c
index 7d8015e211..0b6ef09924 100644
--- a/src/core/manager.c
+++ b/src/core/manager.c
@@ -1569,7 +1569,7 @@ static void manager_preset_all(Manager *m) {
                 return;
 
         /* If this is the first boot, and we are in the host system, then preset everything */
-        r = unit_file_preset_all(UNIT_FILE_SYSTEM, 0, NULL, UNIT_FILE_PRESET_ENABLE_ONLY, NULL, 0);
+        r = unit_file_preset_all(UNIT_FILE_SYSTEM, 0, NULL, UNIT_FILE_PRESET_ENABLE_ONLY, NULL, 0, NULL, NULL);
         if (r < 0)
                 log_full_errno(r == -EEXIST ? LOG_NOTICE : LOG_WARNING, r,
                                "Failed to populate /etc with preset unit settings, ignoring: %m");
diff --git a/src/shared/install.c b/src/shared/install.c
index 0e673b3358..3a2d89b9f4 100644
--- a/src/shared/install.c
+++ b/src/shared/install.c
@@ -2010,13 +2010,26 @@ static int install_context_mark_for_removal(
         return 0;
 }
 
+static int do_mac_check(
+                mac_callback_t mac_check,
+                const char *name,
+                void *userdata) {
+
+        if (!mac_check)
+                return 0;
+
+        return mac_check(name, userdata);
+}
+
 int unit_file_mask(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         const char *config_path;
@@ -2044,6 +2057,10 @@ int unit_file_mask(
                         continue;
                 }
 
+                q = do_mac_check(mac_check, *i, userdata);
+                if (q < 0)
+                        return q;
+
                 path = path_make_absolute(*i, config_path);
                 if (!path)
                         return -ENOMEM;
@@ -2062,7 +2079,9 @@ int unit_file_unmask(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_set_free_free_ Set *remove_symlinks_to = NULL;
@@ -2092,6 +2111,10 @@ int unit_file_unmask(
                 if (!unit_name_is_valid(*i, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, *i, userdata);
+                if (r < 0)
+                        return r;
+
                 path = path_make_absolute(*i, config_path);
                 if (!path)
                         return -ENOMEM;
@@ -2156,7 +2179,9 @@ int unit_file_link(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_strv_free_ char **todo = NULL;
@@ -2188,6 +2213,10 @@ int unit_file_link(
                 if (!unit_name_is_valid(fn, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, fn, userdata);
+                if (r < 0)
+                        return r;
+
                 full = path_join(paths.root_dir, *i);
                 if (!full)
                         return -ENOMEM;
@@ -2256,7 +2285,9 @@ int unit_file_revert(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_set_free_free_ Set *remove_symlinks_to = NULL;
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
@@ -2287,6 +2318,10 @@ int unit_file_revert(
                 if (!unit_name_is_valid(*i, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, *i, userdata);
+                if (r < 0)
+                        return r;
+
                 STRV_FOREACH(p, paths.search_path) {
                         _cleanup_free_ char *path = NULL, *dropin = NULL;
                         struct stat st;
@@ -2413,7 +2448,9 @@ int unit_file_add_dependency(
                 const char *target,
                 UnitDependency dep,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_(install_context_done) InstallContext c = {};
@@ -2447,6 +2484,10 @@ int unit_file_add_dependency(
 
         assert(target_info->type == UNIT_FILE_TYPE_REGULAR);
 
+        r = do_mac_check(mac_check, target_info->name, userdata);
+        if (r < 0)
+                return r;
+
         STRV_FOREACH(f, files) {
                 char ***l;
 
@@ -2457,6 +2498,10 @@ int unit_file_add_dependency(
 
                 assert(i->type == UNIT_FILE_TYPE_REGULAR);
 
+                r = do_mac_check(mac_check, i->name, userdata);
+                if (r < 0)
+                        return r;
+
                 /* We didn't actually load anything from the unit
                  * file, but instead just add in our new symlink to
                  * create. */
@@ -2481,7 +2526,9 @@ int unit_file_enable(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_(install_context_done) InstallContext c = {};
@@ -2508,6 +2555,10 @@ int unit_file_enable(
                         return r;
 
                 assert(i->type == UNIT_FILE_TYPE_REGULAR);
+
+                r = do_mac_check(mac_check, i->name, userdata);
+                if (r < 0)
+                        return r;
         }
 
         /* This will return the number of symlink rules that were
@@ -2524,7 +2575,9 @@ int unit_file_disable(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_(install_context_done) InstallContext c = {};
@@ -2548,6 +2601,10 @@ int unit_file_disable(
                 if (!unit_name_is_valid(*i, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, *i, userdata);
+                if (r < 0)
+                        return r;
+
                 r = install_info_add(&c, *i, NULL, false, NULL);
                 if (r < 0)
                         return r;
@@ -2566,7 +2623,9 @@ int unit_file_reenable(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         char **n;
         int r;
@@ -2579,12 +2638,12 @@ int unit_file_reenable(
                 n[i] = basename(files[i]);
         n[i] = NULL;
 
-        r = unit_file_disable(scope, flags, root_dir, n, changes, n_changes);
+        r = unit_file_disable(scope, flags, root_dir, n, changes, n_changes, mac_check, userdata);
         if (r < 0)
                 return r;
 
         /* But the enable command with the full name */
-        return unit_file_enable(scope, flags, root_dir, files, changes, n_changes);
+        return unit_file_enable(scope, flags, root_dir, files, changes, n_changes, mac_check, userdata);
 }
 
 int unit_file_set_default(
@@ -3090,7 +3149,9 @@ static int preset_prepare_one(
                 const char *name,
                 Presets presets,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(install_context_done) InstallContext tmp = {};
         _cleanup_strv_free_ char **instance_name_list = NULL;
@@ -3104,6 +3165,11 @@ static int preset_prepare_one(
                                   &i, changes, n_changes);
         if (r < 0)
                 return r;
+
+        r = do_mac_check(mac_check, i->name, userdata);
+        if (r < 0)
+                return r;
+
         if (!streq(name, i->name)) {
                 log_debug("Skipping %s because it is an alias for %s.", name, i->name);
                 return 0;
@@ -3143,7 +3209,9 @@ int unit_file_preset(
                 char **files,
                 UnitFilePresetMode mode,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(install_context_done) InstallContext plus = {}, minus = {};
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
@@ -3169,7 +3237,8 @@ int unit_file_preset(
                 return r;
 
         STRV_FOREACH(i, files) {
-                r = preset_prepare_one(scope, &plus, &minus, &paths, *i, presets, changes, n_changes);
+
+                r = preset_prepare_one(scope, &plus, &minus, &paths, *i, presets, changes, n_changes, mac_check, userdata);
                 if (r < 0)
                         return r;
         }
@@ -3183,7 +3252,9 @@ int unit_file_preset_all(
                 const char *root_dir,
                 UnitFilePresetMode mode,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(install_context_done) InstallContext plus = {}, minus = {};
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
@@ -3231,7 +3302,7 @@ int unit_file_preset_all(
                                 continue;
 
                         /* we don't pass changes[] in, because we want to handle errors on our own */
-                        r = preset_prepare_one(scope, &plus, &minus, &paths, de->d_name, presets, NULL, 0);
+                        r = preset_prepare_one(scope, &plus, &minus, &paths, de->d_name, presets, NULL, 0, mac_check, userdata);
                         if (r == -ERFKILL)
                                 r = unit_file_changes_add(changes, n_changes,
                                                           UNIT_FILE_IS_MASKED, de->d_name, NULL);
diff --git a/src/shared/install.h b/src/shared/install.h
index b2ad9c4a71..4ad60c5dd8 100644
--- a/src/shared/install.h
+++ b/src/shared/install.h
@@ -87,27 +87,35 @@ struct UnitFileInstallInfo {
         bool auxiliary;
 };
 
+typedef int (*mac_callback_t)(const char *name, void *userdata);
+
 int unit_file_enable(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_disable(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_reenable(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_preset(
                 UnitFileScope scope,
                 UnitFileFlags flags,
@@ -115,41 +123,53 @@ int unit_file_preset(
                 char **files,
                 UnitFilePresetMode mode,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_preset_all(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 UnitFilePresetMode mode,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_mask(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_unmask(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_link(
                 UnitFileScope scope,
                 UnitFileFlags flags,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_revert(
                 UnitFileScope scope,
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 int unit_file_set_default(
                 UnitFileScope scope,
                 UnitFileFlags flags,
@@ -169,7 +189,9 @@ int unit_file_add_dependency(
                 const char *target,
                 UnitDependency dep,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 
 int unit_file_lookup_state(
                 UnitFileScope scope,
diff --git a/src/systemctl/systemctl.c b/src/systemctl/systemctl.c
index 497cca2ff8..1304ad1f25 100644
--- a/src/systemctl/systemctl.c
+++ b/src/systemctl/systemctl.c
@@ -6899,23 +6899,23 @@ static int enable_unit(int argc, char *argv[], void *userdata) {
 
                 flags = args_to_flags();
                 if (streq(verb, "enable")) {
-                        r = unit_file_enable(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_enable(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                         carries_install_info = r;
                 } else if (streq(verb, "disable"))
-                        r = unit_file_disable(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_disable(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else if (streq(verb, "reenable")) {
-                        r = unit_file_reenable(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_reenable(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                         carries_install_info = r;
                 } else if (streq(verb, "link"))
-                        r = unit_file_link(arg_scope, flags, arg_root, names, &changes, &n_changes);
-                else if (streq(verb, "preset")) {
-                        r = unit_file_preset(arg_scope, flags, arg_root, names, arg_preset_mode, &changes, &n_changes);
-                } else if (streq(verb, "mask"))
-                        r = unit_file_mask(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_link(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
+                else if (streq(verb, "preset"))
+                        r = unit_file_preset(arg_scope, flags, arg_root, names, arg_preset_mode, &changes, &n_changes, NULL, NULL);
+                else if (streq(verb, "mask"))
+                        r = unit_file_mask(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else if (streq(verb, "unmask"))
-                        r = unit_file_unmask(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_unmask(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else if (streq(verb, "revert"))
-                        r = unit_file_revert(arg_scope, arg_root, names, &changes, &n_changes);
+                        r = unit_file_revert(arg_scope, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else
                         assert_not_reached("Unknown verb");
 
@@ -7112,7 +7112,7 @@ static int add_dependency(int argc, char *argv[], void *userdata) {
                 assert_not_reached("Unknown verb");
 
         if (install_client_side()) {
-                r = unit_file_add_dependency(arg_scope, args_to_flags(), arg_root, names, target, dep, &changes, &n_changes);
+                r = unit_file_add_dependency(arg_scope, args_to_flags(), arg_root, names, target, dep, &changes, &n_changes, NULL, NULL);
                 unit_file_dump_changes(r, "add dependency on", changes, n_changes, arg_quiet);
 
                 if (r > 0)
@@ -7174,7 +7174,7 @@ static int preset_all(int argc, char *argv[], void *userdata) {
         int r;
 
         if (install_client_side()) {
-                r = unit_file_preset_all(arg_scope, args_to_flags(), arg_root, arg_preset_mode, &changes, &n_changes);
+                r = unit_file_preset_all(arg_scope, args_to_flags(), arg_root, arg_preset_mode, &changes, &n_changes, NULL, NULL);
                 unit_file_dump_changes(r, "preset", changes, n_changes, arg_quiet);
 
                 if (r > 0)
@@ -7234,7 +7234,7 @@ static int show_installation_targets_client_side(const char *name) {
         flags = UNIT_FILE_DRY_RUN |
                 (arg_runtime ? UNIT_FILE_RUNTIME : 0);
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes, NULL, NULL);
         if (r < 0)
                 return log_error_errno(r, "Failed to get file links for %s: %m", name);
 
diff --git a/src/test/test-install-root.c b/src/test/test-install-root.c
index 323e1124ba..7f8d534106 100644
--- a/src/test/test-install-root.c
+++ b/src/test/test-install-root.c
@@ -51,7 +51,7 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", NULL) >= 0);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_mask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_mask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/dev/null"));
@@ -67,11 +67,11 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_MASKED);
 
         /* Enabling a masked unit should fail! */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) == -ERFKILL);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) == -ERFKILL);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_unmask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_unmask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/a.service");
@@ -79,7 +79,7 @@ static void test_basic_mask_and_enable(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/a.service"));
@@ -94,12 +94,12 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
 
         /* Enabling it again should succeed but be a NOP */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/a.service");
@@ -113,13 +113,13 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
         /* Disabling a disabled unit must succeed but be a NOP */
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
         /* Let's enable this indirectly via a symlink */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("d.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("d.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/a.service"));
@@ -135,7 +135,7 @@ static void test_basic_mask_and_enable(const char *root) {
 
         /* Let's try to reenable */
 
-        assert_se(unit_file_reenable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("b.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_reenable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("b.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/a.service");
@@ -204,7 +204,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked3.service", &state) >= 0 && state == UNIT_FILE_LINKED);
 
         /* First, let's link the unit into the search path */
-        assert_se(unit_file_link(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_link(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/opt/linked.service"));
@@ -216,7 +216,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", &state) >= 0 && state == UNIT_FILE_LINKED);
 
         /* Let's unlink it from the search path again */
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/linked.service");
@@ -227,7 +227,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", NULL) == -ENOENT);
 
         /* Now, let's not just link it, but also enable it */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/linked.service");
         q = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/linked.service");
@@ -249,7 +249,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
 
         /* And let's unlink it again */
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/linked.service");
         q = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/linked.service");
@@ -269,7 +269,7 @@ static void test_linked_units(const char *root) {
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", NULL) == -ENOENT);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked2.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked2.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/linked2.service");
         q = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/linked2.service");
@@ -288,7 +288,7 @@ static void test_linked_units(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked3.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked3.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(startswith(changes[0].path, root));
@@ -351,7 +351,7 @@ static void test_add_dependency(const char *root) {
         p = strjoina(root, "/usr/lib/systemd/system/add-dependency-test-service.service");
         assert_se(symlink("real-add-dependency-test-service.service", p) >= 0);
 
-        assert_se(unit_file_add_dependency(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("add-dependency-test-service.service"), "add-dependency-test-target.target", UNIT_WANTS, &changes, &n_changes) >= 0);
+        assert_se(unit_file_add_dependency(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("add-dependency-test-service.service"), "add-dependency-test-target.target", UNIT_WANTS, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/real-add-dependency-test-service.service"));
@@ -392,7 +392,7 @@ static void test_template_enable(const char *root) {
 
         log_info("== %s with template@.service enabled ==", __func__);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/template@.service"));
@@ -408,7 +408,7 @@ static void test_template_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@def.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@foo.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -424,7 +424,7 @@ static void test_template_enable(const char *root) {
 
         log_info("== %s with template@foo.service enabled ==", __func__);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/template@.service"));
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/template@foo.service");
@@ -439,7 +439,7 @@ static void test_template_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@def.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@foo.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -457,7 +457,7 @@ static void test_template_enable(const char *root) {
 
         log_info("== %s with template-symlink@quux.service enabled ==", __func__);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template-symlink@quux.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template-symlink@quux.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/template@.service"));
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/template@quux.service");
@@ -502,7 +502,7 @@ static void test_indirect(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectb.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectc.service", &state) >= 0 && state == UNIT_FILE_INDIRECT);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/indirectb.service"));
@@ -515,7 +515,7 @@ static void test_indirect(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectb.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectc.service", &state) >= 0 && state == UNIT_FILE_INDIRECT);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/indirectb.service");
@@ -555,7 +555,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/preset-yes.service"));
@@ -567,7 +567,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/preset-yes.service");
@@ -578,7 +578,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-no.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-no.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
@@ -586,7 +586,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
 
         assert_se(n_changes > 0);
 
@@ -650,7 +650,7 @@ static void test_revert(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "xx.service", &state) >= 0 && state == UNIT_FILE_STATIC);
 
         /* Initially there's nothing to revert */
-        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
@@ -659,7 +659,7 @@ static void test_revert(const char *root) {
         assert_se(write_string_file(p, "# Empty override\n", WRITE_STRING_FILE_CREATE) >= 0);
 
         /* Revert the override file */
-        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -671,7 +671,7 @@ static void test_revert(const char *root) {
         assert_se(write_string_file(p, "# Empty dropin\n", WRITE_STRING_FILE_CREATE) >= 0);
 
         /* Revert the dropin file */
-        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -711,7 +711,7 @@ static void test_preset_order(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-1.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-2.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-1.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-1.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/prefix-1.service"));
@@ -723,7 +723,7 @@ static void test_preset_order(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-1.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-2.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-2.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-2.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-1.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
@@ -823,7 +823,7 @@ static void test_with_dropin(const char *root) {
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-4b.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(changes[1].type == UNIT_FILE_SYMLINK);
@@ -836,7 +836,7 @@ static void test_with_dropin(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-2.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
@@ -850,7 +850,7 @@ static void test_with_dropin(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-3.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
@@ -864,7 +864,7 @@ static void test_with_dropin(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-4a.service"), &changes, &n_changes) == 2);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-4a.service"), &changes, &n_changes, NULL, NULL) == 2);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-3.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
@@ -935,7 +935,7 @@ static void test_with_dropin_template(const char *root) {
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-3@.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1@instance-1.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1@instance-1.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(changes[1].type == UNIT_FILE_SYMLINK);
@@ -948,7 +948,7 @@ static void test_with_dropin_template(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-1.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-1.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(changes[1].type == UNIT_FILE_SYMLINK);
@@ -961,7 +961,7 @@ static void test_with_dropin_template(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-2.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-2.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/with-dropin-2@.service"));
@@ -970,7 +970,7 @@ static void test_with_dropin_template(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3@.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3@.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/with-dropin-3@.service"));
@@ -1010,7 +1010,7 @@ static void test_preset_multiple_instances(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bar0.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
         /* Preset a single instantiated unit specified in the list */
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bar0.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_SYMLINK);
@@ -1019,7 +1019,7 @@ static void test_preset_multiple_instances(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_PATH"/multi-user.target.wants/foo@bar0.service");
@@ -1032,7 +1032,7 @@ static void test_preset_multiple_instances(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bar1.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bartest.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes > 0);
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@def.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
diff --git a/src/test/test-install.c b/src/test/test-install.c
index 62daaccd62..5c09a428f0 100644
--- a/src/test/test-install.c
+++ b/src/test/test-install.c
@@ -53,12 +53,12 @@ int main(int argc, char* argv[]) {
 
         log_info("/*** enable **/");
 
-        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         log_info("/*** enable2 **/");
 
-        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -72,7 +72,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -86,10 +86,10 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
         log_info("/*** mask2 ***/");
-        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -103,10 +103,10 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
         log_info("/*** unmask2 ***/");
-        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -120,7 +120,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -134,10 +134,10 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
         log_info("/*** disable2 ***/");
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -151,7 +151,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -165,7 +165,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -179,7 +179,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -192,7 +192,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -206,7 +206,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -219,7 +219,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -233,7 +233,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_reenable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_reenable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -247,7 +247,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -259,7 +259,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_preset(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, UNIT_FILE_PRESET_FULL, &changes, &n_changes);
+        r = unit_file_preset(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
-- 
2.24.1

