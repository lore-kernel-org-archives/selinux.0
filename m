Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A50C432BE
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B52760F25
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhHEO0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbhHEO0e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5963CC061765
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id oz16so9904225ejc.7
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fQo2JuN/v1ZMy4eJwLPPPk9ndNqTJaJm6Cj+Fv85WHE=;
        b=jeDDQoFGX2rXxVDz4UP14T9422XBeakXLWCrIZjRPJ/lPcuHJQ2KqgwDuI1E6WY3ZR
         g9kh7jUmVXxNx91q6Fdr3GL3XksbJBl56Cs+SZyAWa2rDOjDx9wRWW7f9ZX0nrKx1X2g
         bzaTYVyWGD6ebKUxui8wQidXEoqzanFt0blHPTsRJILH+y0AhNW7nGp6My8r5N2c31O8
         at/Aaohy0jRZ6ke4RJALgQjOQ3Aa6lV+Sf6at4m/NJz+pU4P0l8XbZtdM2MWfjo9dgN+
         dHteIPbBElgPBbYMV9KMPMd8mxQO6DEVdmOvCaqP53PIuwG9eZvvIkx5k3QrjNMFVEpB
         BlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQo2JuN/v1ZMy4eJwLPPPk9ndNqTJaJm6Cj+Fv85WHE=;
        b=X1cyJWW0Op8y2UKNAx+cfsx6SaNEr2SFqfvpCPql/214yJYImZHZP7UTxxpsd6B/AF
         I127p4k1ffb5l1IwEg8pVEBQ1HjPwm+t8FspOxSSijn4+g0ODdTMaXBvt+d54yGzw/sM
         Ji9xg+JBzHHYrpljGywwMlzrCe7EXqsXMZZnetRrJ+B46ng3aBdRgjccYARbwBLAXqwP
         dkhQ06KbRUsgNwtyU7v52D8lzMHnYyb3nJtbwLVTQxFb/6u5NwmVZg4KWZ5ySiXnXRZK
         Q47yrXVWpr3Sk6zOdqe6uZRoBmn2hX5be96vW/IMEgd3MlLZnT4gaZJdwm7RwZfWmJhr
         cfUg==
X-Gm-Message-State: AOAM532onFyeAhDlt86/XFdo/29EszAxS1sC94YOXnV7/Uq6L9rXeO2K
        g1tZCocEKS0MFMcvSGGii3HBzJMT/jc=
X-Google-Smtp-Source: ABdhPJyjpQLt22GrN/XDu6dHiKrsbjMtnkWglBxOPA4QdQW4tRMoW+rCkPM0RDi5WDZpv9eqWbK0mA==
X-Received: by 2002:a17:906:3019:: with SMTP id 25mr5131111ejz.91.1628173577437;
        Thu, 05 Aug 2021 07:26:17 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 4/7] core: add support for MAC checks on unit install operations
Date:   Thu,  5 Aug 2021 16:24:42 +0200
Message-Id: <20210805142445.61725-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

shared:

Add a MAC callback call to unit_file_* functions to check unit
operations, like enable or disable.  The MAC callback is supplied with
the unit name as first argument.  The second argument is a blob used by
the back-end MAC specific check.  If no check should be performed, pass
NULL pointers.

core:

Implement a generic MAC callback for sd-bus and register it for D-Bus
exposed methods.

systemctl:

Adopt to the new callback by passing NULL.  No callback check is needed
when called on the client side, cause regular kernel MAC checks (like
write or unlink) on the unit file will be performed.
---
 src/core/dbus-callbackdata.h             |   5 ++
 src/core/dbus-manager.c                  |  39 ++++++---
 src/core/manager.c                       |   2 +-
 src/shared/install.c                     | 100 +++++++++++++++++++----
 src/shared/install.h                     |  42 +++++++---
 src/systemctl/systemctl-add-dependency.c |   2 +-
 src/systemctl/systemctl-enable.c         |  16 ++--
 src/systemctl/systemctl-is-enabled.c     |   2 +-
 src/systemctl/systemctl-preset-all.c     |   2 +-
 src/test/test-install-root.c             |  88 ++++++++++----------
 src/test/test-install.c                  |  38 ++++-----
 11 files changed, 225 insertions(+), 111 deletions(-)
 create mode 100644 src/core/dbus-callbackdata.h

diff --git a/src/core/dbus-callbackdata.h b/src/core/dbus-callbackdata.h
new file mode 100644
index 0000000000..7dedb680c0
--- /dev/null
+++ b/src/core/dbus-callbackdata.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#pragma once
+
+typedef struct MacUnitCallbackUserdata {
+} MacUnitCallbackUserdata;
diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index 1f2ac8152c..eec358cb6b 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -11,6 +11,7 @@
 #include "bus-common-errors.h"
 #include "bus-get-properties.h"
 #include "bus-log-control-api.h"
+#include "dbus-callbackdata.h"
 #include "data-fd-util.h"
 #include "dbus-cgroup.h"
 #include "dbus-execute.h"
@@ -2184,10 +2185,19 @@ fail:
         return r;
 }
 
+static int mac_unit_callback_check(const char *unit_name, void *userdata) {
+        MacUnitCallbackUserdata *ud = userdata;
+
+        assert(unit_name);
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
 
@@ -2196,6 +2206,7 @@ static int method_enable_unit_files_generic(
         size_t n_changes = 0;
         UnitFileFlags flags;
         int r;
+        MacUnitCallbackUserdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2228,7 +2239,7 @@ static int method_enable_unit_files_generic(
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = call(m->unit_file_scope, flags, NULL, l, &changes, &n_changes);
+        r = call(m->unit_file_scope, flags, NULL, l, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2251,8 +2262,8 @@ static int method_link_unit_files(sd_bus_message *message, void *userdata, sd_bu
         return method_enable_unit_files_generic(message, userdata, unit_file_link, false, error);
 }
 
-static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char **files, UnitFileChange **changes, size_t *n_changes) {
-        return unit_file_preset(scope, flags, root_dir, files, UNIT_FILE_PRESET_FULL, changes, n_changes);
+static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char **files, UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata) {
+        return unit_file_preset(scope, flags, root_dir, files, UNIT_FILE_PRESET_FULL, changes, n_changes, mac_check, userdata);
 }
 
 static int method_preset_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
@@ -2273,6 +2284,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
         int runtime, force, r;
         UnitFileFlags flags;
         const char *mode;
+        MacUnitCallbackUserdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2301,7 +2313,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = unit_file_preset(m->unit_file_scope, flags, NULL, l, preset_mode, &changes, &n_changes);
+        r = unit_file_preset(m->unit_file_scope, flags, NULL, l, preset_mode, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2311,7 +2323,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
 static int method_disable_unit_files_generic(
                 sd_bus_message *message,
                 Manager *m,
-                int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes),
+                int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
                 sd_bus_error *error) {
 
         _cleanup_strv_free_ char **l = NULL;
@@ -2319,6 +2331,7 @@ static int method_disable_unit_files_generic(
         UnitFileFlags flags;
         size_t n_changes = 0;
         int r;
+        MacUnitCallbackUserdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2352,7 +2365,7 @@ static int method_disable_unit_files_generic(
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = call(m->unit_file_scope, flags, NULL, l, &changes, &n_changes);
+        r = call(m->unit_file_scope, flags, NULL, l, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2377,6 +2390,7 @@ static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_
         size_t n_changes = 0;
         Manager *m = userdata;
         int r;
+        MacUnitCallbackUserdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2391,7 +2405,7 @@ static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = unit_file_revert(m->unit_file_scope, NULL, l, &changes, &n_changes);
+        r = unit_file_revert(m->unit_file_scope, NULL, l, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2437,6 +2451,7 @@ static int method_preset_all_unit_files(sd_bus_message *message, void *userdata,
         const char *mode;
         UnitFileFlags flags;
         int force, runtime, r;
+        MacUnitCallbackUserdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2465,7 +2480,7 @@ static int method_preset_all_unit_files(sd_bus_message *message, void *userdata,
         if (r == 0)
                 return 1; /* No authorization for now, but the async polkit stuff will call us again when it has it */
 
-        r = unit_file_preset_all(m->unit_file_scope, flags, NULL, preset_mode, &changes, &n_changes);
+        r = unit_file_preset_all(m->unit_file_scope, flags, NULL, preset_mode, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2481,6 +2496,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         char *target, *type;
         UnitDependency dep;
         UnitFileFlags flags;
+        MacUnitCallbackUserdata mcud = {};
 
         assert(message);
         assert(m);
@@ -2505,7 +2521,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         if (dep < 0)
                 return -EINVAL;
 
-        r = unit_file_add_dependency(m->unit_file_scope, flags, NULL, l, target, dep, &changes, &n_changes);
+        r = unit_file_add_dependency(m->unit_file_scope, flags, NULL, l, target, dep, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return install_error(error, r, changes, n_changes);
 
@@ -2520,6 +2536,7 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         const char *name;
         char **p;
         int runtime, r;
+        MacUnitCallbackUserdata mcud = {};
 
         r = sd_bus_message_read(message, "sb", &name, &runtime);
         if (r < 0)
@@ -2537,7 +2554,7 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         flags = UNIT_FILE_DRY_RUN |
                 (runtime ? UNIT_FILE_RUNTIME : 0);
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes, mac_unit_callback_check, &mcud);
         if (r < 0)
                 return log_error_errno(r, "Failed to get file links for %s: %m", name);
 
diff --git a/src/core/manager.c b/src/core/manager.c
index 24dfe9fc06..952bc57036 100644
--- a/src/core/manager.c
+++ b/src/core/manager.c
@@ -1691,7 +1691,7 @@ static void manager_preset_all(Manager *m) {
                 return;
 
         /* If this is the first boot, and we are in the host system, then preset everything */
-        r = unit_file_preset_all(UNIT_FILE_SYSTEM, 0, NULL, UNIT_FILE_PRESET_ENABLE_ONLY, NULL, 0);
+        r = unit_file_preset_all(UNIT_FILE_SYSTEM, 0, NULL, UNIT_FILE_PRESET_ENABLE_ONLY, NULL, 0, NULL, NULL);
         if (r < 0)
                 log_full_errno(r == -EEXIST ? LOG_NOTICE : LOG_WARNING, r,
                                "Failed to populate /etc with preset unit settings, ignoring: %m");
diff --git a/src/shared/install.c b/src/shared/install.c
index a348f0c572..f1e603fecf 100644
--- a/src/shared/install.c
+++ b/src/shared/install.c
@@ -2158,13 +2158,26 @@ static int install_context_mark_for_removal(
         return 0;
 }
 
+static int do_mac_check(
+                mac_callback_t mac_check,
+                const char *unit_name,
+                void *userdata) {
+
+        if (!mac_check)
+                return 0;
+
+        return mac_check(unit_name, userdata);
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
@@ -2192,6 +2205,10 @@ int unit_file_mask(
                         continue;
                 }
 
+                q = do_mac_check(mac_check, *i, userdata);
+                if (q < 0)
+                        return q;
+
                 path = path_make_absolute(*i, config_path);
                 if (!path)
                         return -ENOMEM;
@@ -2210,7 +2227,9 @@ int unit_file_unmask(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_set_free_free_ Set *remove_symlinks_to = NULL;
@@ -2240,6 +2259,10 @@ int unit_file_unmask(
                 if (!unit_name_is_valid(*i, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, *i, userdata);
+                if (r < 0)
+                        return r;
+
                 path = path_make_absolute(*i, config_path);
                 if (!path)
                         return -ENOMEM;
@@ -2304,7 +2327,9 @@ int unit_file_link(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_strv_free_ char **todo = NULL;
@@ -2336,6 +2361,10 @@ int unit_file_link(
                 if (!unit_name_is_valid(fn, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, fn, userdata);
+                if (r < 0)
+                        return r;
+
                 full = path_join(paths.root_dir, *i);
                 if (!full)
                         return -ENOMEM;
@@ -2404,7 +2433,9 @@ int unit_file_revert(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_set_free_free_ Set *remove_symlinks_to = NULL;
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
@@ -2435,6 +2466,10 @@ int unit_file_revert(
                 if (!unit_name_is_valid(*i, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, *i, userdata);
+                if (r < 0)
+                        return r;
+
                 STRV_FOREACH(p, paths.search_path) {
                         _cleanup_free_ char *path = NULL, *dropin = NULL;
                         struct stat st;
@@ -2561,7 +2596,9 @@ int unit_file_add_dependency(
                 const char *target,
                 UnitDependency dep,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_(install_context_done) InstallContext c = {};
@@ -2595,6 +2632,10 @@ int unit_file_add_dependency(
 
         assert(target_info->type == UNIT_FILE_TYPE_REGULAR);
 
+        r = do_mac_check(mac_check, target_info->name, userdata);
+        if (r < 0)
+                return r;
+
         STRV_FOREACH(f, files) {
                 char ***l;
 
@@ -2605,6 +2646,10 @@ int unit_file_add_dependency(
 
                 assert(i->type == UNIT_FILE_TYPE_REGULAR);
 
+                r = do_mac_check(mac_check, i->name, userdata);
+                if (r < 0)
+                        return r;
+
                 /* We didn't actually load anything from the unit
                  * file, but instead just add in our new symlink to
                  * create. */
@@ -2630,7 +2675,9 @@ int unit_file_enable(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_(install_context_done) InstallContext c = {};
@@ -2657,6 +2704,10 @@ int unit_file_enable(
                         return r;
 
                 assert(i->type == UNIT_FILE_TYPE_REGULAR);
+
+                r = do_mac_check(mac_check, i->name, userdata);
+                if (r < 0)
+                        return r;
         }
 
         /* This will return the number of symlink rules that were
@@ -2673,7 +2724,9 @@ int unit_file_disable(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
         _cleanup_(install_context_done) InstallContext c = {};
@@ -2697,6 +2750,10 @@ int unit_file_disable(
                 if (!unit_name_is_valid(*i, UNIT_NAME_ANY))
                         return -EINVAL;
 
+                r = do_mac_check(mac_check, *i, userdata);
+                if (r < 0)
+                        return r;
+
                 r = install_info_add(&c, *i, NULL, paths.root_dir, /* auxiliary= */ false, NULL);
                 if (r < 0)
                         return r;
@@ -2715,7 +2772,9 @@ int unit_file_reenable(
                 const char *root_dir,
                 char **files,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         char **n;
         int r;
@@ -2728,12 +2787,12 @@ int unit_file_reenable(
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
@@ -3248,7 +3307,9 @@ static int preset_prepare_one(
                 const char *name,
                 const UnitFilePresets *presets,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(install_context_done) InstallContext tmp = {};
         _cleanup_strv_free_ char **instance_name_list = NULL;
@@ -3262,6 +3323,11 @@ static int preset_prepare_one(
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
@@ -3301,7 +3367,9 @@ int unit_file_preset(
                 char **files,
                 UnitFilePresetMode mode,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(install_context_done) InstallContext plus = {}, minus = {};
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
@@ -3327,7 +3395,7 @@ int unit_file_preset(
                 return r;
 
         STRV_FOREACH(i, files) {
-                r = preset_prepare_one(scope, &plus, &minus, &paths, *i, &presets, changes, n_changes);
+                r = preset_prepare_one(scope, &plus, &minus, &paths, *i, &presets, changes, n_changes, mac_check, userdata);
                 if (r < 0)
                         return r;
         }
@@ -3341,7 +3409,9 @@ int unit_file_preset_all(
                 const char *root_dir,
                 UnitFilePresetMode mode,
                 UnitFileChange **changes,
-                size_t *n_changes) {
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata) {
 
         _cleanup_(install_context_done) InstallContext plus = {}, minus = {};
         _cleanup_(lookup_paths_free) LookupPaths paths = {};
@@ -3386,7 +3456,7 @@ int unit_file_preset_all(
                         if (!IN_SET(de->d_type, DT_LNK, DT_REG))
                                 continue;
 
-                        r = preset_prepare_one(scope, &plus, &minus, &paths, de->d_name, &presets, changes, n_changes);
+                        r = preset_prepare_one(scope, &plus, &minus, &paths, de->d_name, &presets, changes, n_changes, mac_check, userdata);
                         if (r < 0 &&
                             !IN_SET(r, -EEXIST, -ERFKILL, -EADDRNOTAVAIL, -EIDRM, -EUCLEAN, -ELOOP, -ENOENT))
                                 /* Ignore generated/transient/missing/invalid units when applying preset, propagate other errors.
diff --git a/src/shared/install.h b/src/shared/install.h
index cdc5435035..96896f0548 100644
--- a/src/shared/install.h
+++ b/src/shared/install.h
@@ -93,27 +93,35 @@ struct UnitFileInstallInfo {
         bool auxiliary;
 };
 
+typedef int (*mac_callback_t)(const char *unit_name, void *userdata);
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
@@ -121,41 +129,53 @@ int unit_file_preset(
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
@@ -175,7 +195,9 @@ int unit_file_add_dependency(
                 const char *target,
                 UnitDependency dep,
                 UnitFileChange **changes,
-                size_t *n_changes);
+                size_t *n_changes,
+                mac_callback_t mac_check,
+                void *userdata);
 
 int unit_file_lookup_state(
                 UnitFileScope scope,
diff --git a/src/systemctl/systemctl-add-dependency.c b/src/systemctl/systemctl-add-dependency.c
index ba385ea2a2..90b6c28aa0 100644
--- a/src/systemctl/systemctl-add-dependency.c
+++ b/src/systemctl/systemctl-add-dependency.c
@@ -37,7 +37,7 @@ int add_dependency(int argc, char *argv[], void *userdata) {
                 assert_not_reached();
 
         if (install_client_side()) {
-                r = unit_file_add_dependency(arg_scope, unit_file_flags_from_args(), arg_root, names, target, dep, &changes, &n_changes);
+                r = unit_file_add_dependency(arg_scope, unit_file_flags_from_args(), arg_root, names, target, dep, &changes, &n_changes, NULL, NULL);
                 unit_file_dump_changes(r, "add dependency on", changes, n_changes, arg_quiet);
 
                 if (r > 0)
diff --git a/src/systemctl/systemctl-enable.c b/src/systemctl/systemctl-enable.c
index dcbe2c7302..5cfdcd73ca 100644
--- a/src/systemctl/systemctl-enable.c
+++ b/src/systemctl/systemctl-enable.c
@@ -106,23 +106,23 @@ int enable_unit(int argc, char *argv[], void *userdata) {
 
                 flags = unit_file_flags_from_args();
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
+                        r = unit_file_link(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else if (streq(verb, "preset")) {
-                        r = unit_file_preset(arg_scope, flags, arg_root, names, arg_preset_mode, &changes, &n_changes);
+                        r = unit_file_preset(arg_scope, flags, arg_root, names, arg_preset_mode, &changes, &n_changes, NULL, NULL);
                 } else if (streq(verb, "mask"))
-                        r = unit_file_mask(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_mask(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else if (streq(verb, "unmask"))
-                        r = unit_file_unmask(arg_scope, flags, arg_root, names, &changes, &n_changes);
+                        r = unit_file_unmask(arg_scope, flags, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else if (streq(verb, "revert"))
-                        r = unit_file_revert(arg_scope, arg_root, names, &changes, &n_changes);
+                        r = unit_file_revert(arg_scope, arg_root, names, &changes, &n_changes, NULL, NULL);
                 else
                         assert_not_reached();
 
diff --git a/src/systemctl/systemctl-is-enabled.c b/src/systemctl/systemctl-is-enabled.c
index e33dffaf29..08e1e03619 100644
--- a/src/systemctl/systemctl-is-enabled.c
+++ b/src/systemctl/systemctl-is-enabled.c
@@ -18,7 +18,7 @@ static int show_installation_targets_client_side(const char *name) {
         flags = UNIT_FILE_DRY_RUN |
                 (arg_runtime ? UNIT_FILE_RUNTIME : 0);
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, flags, NULL, p, &changes, &n_changes, NULL, NULL);
         if (r < 0)
                 return log_error_errno(r, "Failed to get file links for %s: %m", name);
 
diff --git a/src/systemctl/systemctl-preset-all.c b/src/systemctl/systemctl-preset-all.c
index b5eb199f4a..c325606b43 100644
--- a/src/systemctl/systemctl-preset-all.c
+++ b/src/systemctl/systemctl-preset-all.c
@@ -13,7 +13,7 @@ int preset_all(int argc, char *argv[], void *userdata) {
         int r;
 
         if (install_client_side()) {
-                r = unit_file_preset_all(arg_scope, unit_file_flags_from_args(), arg_root, arg_preset_mode, &changes, &n_changes);
+                r = unit_file_preset_all(arg_scope, unit_file_flags_from_args(), arg_root, arg_preset_mode, &changes, &n_changes, NULL, NULL);
                 unit_file_dump_changes(r, "preset", changes, n_changes, arg_quiet);
 
                 if (r > 0)
diff --git a/src/test/test-install-root.c b/src/test/test-install-root.c
index 30494f7fa1..e7b0cc3d6e 100644
--- a/src/test/test-install-root.c
+++ b/src/test/test-install-root.c
@@ -54,7 +54,7 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", NULL) >= 0);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_ALIAS);
 
-        assert_se(unit_file_mask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_mask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/dev/null"));
@@ -70,11 +70,11 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_MASKED);
 
         /* Enabling a masked unit should fail! */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) == -ERFKILL);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) == -ERFKILL);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_unmask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_unmask(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/a.service");
@@ -82,7 +82,7 @@ static void test_basic_mask_and_enable(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/a.service"));
@@ -97,12 +97,12 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_ALIAS);
 
         /* Enabling it again should succeed but be a NOP */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("a.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/a.service");
@@ -116,13 +116,13 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "d.service", &state) >= 0 && state == UNIT_FILE_ALIAS);
 
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
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/a.service"));
@@ -138,7 +138,7 @@ static void test_basic_mask_and_enable(const char *root) {
 
         /* Let's try to reenable */
 
-        assert_se(unit_file_reenable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("b.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_reenable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("b.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/a.service");
@@ -180,7 +180,7 @@ static void test_basic_mask_and_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "f.service", NULL) >= 0);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "f.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("f.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("f.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/f.service"));
@@ -248,7 +248,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked3.service", &state) >= 0 && state == UNIT_FILE_LINKED);
 
         /* First, let's link the unit into the search path */
-        assert_se(unit_file_link(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_link(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/opt/linked.service"));
@@ -260,7 +260,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", &state) >= 0 && state == UNIT_FILE_LINKED);
 
         /* Let's unlink it from the search path again */
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/linked.service");
@@ -271,7 +271,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", NULL) == -ENOENT);
 
         /* Now, let's not just link it, but also enable it */
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("/opt/linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/linked.service");
         q = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/linked.service");
@@ -293,7 +293,7 @@ static void test_linked_units(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
 
         /* And let's unlink it again */
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/linked.service");
         q = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/linked.service");
@@ -313,7 +313,7 @@ static void test_linked_units(const char *root) {
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "linked.service", NULL) == -ENOENT);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked2.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked2.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/linked2.service");
         q = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/linked2.service");
@@ -332,7 +332,7 @@ static void test_linked_units(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked3.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("linked3.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(startswith(changes[0].path, root));
@@ -395,7 +395,7 @@ static void test_add_dependency(const char *root) {
         p = strjoina(root, "/usr/lib/systemd/system/add-dependency-test-service.service");
         assert_se(symlink("real-add-dependency-test-service.service", p) >= 0);
 
-        assert_se(unit_file_add_dependency(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("add-dependency-test-service.service"), "add-dependency-test-target.target", UNIT_WANTS, &changes, &n_changes) >= 0);
+        assert_se(unit_file_add_dependency(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("add-dependency-test-service.service"), "add-dependency-test-target.target", UNIT_WANTS, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/real-add-dependency-test-service.service"));
@@ -436,7 +436,7 @@ static void test_template_enable(const char *root) {
 
         log_info("== %s with template@.service enabled ==", __func__);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/template@.service"));
@@ -452,7 +452,7 @@ static void test_template_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@def.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@foo.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -468,7 +468,7 @@ static void test_template_enable(const char *root) {
 
         log_info("== %s with template@foo.service enabled ==", __func__);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/template@.service"));
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/template@foo.service");
@@ -483,7 +483,7 @@ static void test_template_enable(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@def.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "template-symlink@foo.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template@foo.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -501,7 +501,7 @@ static void test_template_enable(const char *root) {
 
         log_info("== %s with template-symlink@quux.service enabled ==", __func__);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template-symlink@quux.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("template-symlink@quux.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/template@.service"));
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/template@quux.service");
@@ -546,7 +546,7 @@ static void test_indirect(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectb.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectc.service", &state) >= 0 && state == UNIT_FILE_ALIAS);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/indirectb.service"));
@@ -559,7 +559,7 @@ static void test_indirect(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectb.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "indirectc.service", &state) >= 0 && state == UNIT_FILE_ALIAS);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("indirectc.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/indirectb.service");
@@ -598,7 +598,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/preset-yes.service"));
@@ -610,7 +610,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-yes.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/preset-yes.service");
@@ -621,7 +621,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-no.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("preset-no.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
@@ -629,7 +629,7 @@ static void test_preset_and_list(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-yes.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "preset-no.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
 
         assert_se(n_changes > 0);
 
@@ -693,7 +693,7 @@ static void test_revert(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "xx.service", &state) >= 0 && state == UNIT_FILE_STATIC);
 
         /* Initially there's nothing to revert */
-        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
@@ -702,7 +702,7 @@ static void test_revert(const char *root) {
         assert_se(write_string_file(p, "# Empty override\n", WRITE_STRING_FILE_CREATE) >= 0);
 
         /* Revert the override file */
-        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -714,7 +714,7 @@ static void test_revert(const char *root) {
         assert_se(write_string_file(p, "# Empty dropin\n", WRITE_STRING_FILE_CREATE) >= 0);
 
         /* Revert the dropin file */
-        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_revert(UNIT_FILE_SYSTEM, root, STRV_MAKE("xx.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         assert_se(streq(changes[0].path, p));
@@ -754,7 +754,7 @@ static void test_preset_order(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-1.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-2.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-1.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-1.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/prefix-1.service"));
@@ -766,7 +766,7 @@ static void test_preset_order(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-1.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-2.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-2.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("prefix-2.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 0);
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "prefix-1.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
@@ -866,7 +866,7 @@ static void test_with_dropin(const char *root) {
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-4b.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(changes[1].type_or_errno == UNIT_FILE_SYMLINK);
@@ -879,7 +879,7 @@ static void test_with_dropin(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-2.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
@@ -893,7 +893,7 @@ static void test_with_dropin(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-3.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
@@ -907,7 +907,7 @@ static void test_with_dropin(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-4a.service"), &changes, &n_changes) == 2);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-4a.service"), &changes, &n_changes, NULL, NULL) == 2);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-3.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
@@ -978,7 +978,7 @@ static void test_with_dropin_template(const char *root) {
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "with-dropin-3@.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1@instance-1.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-1@instance-1.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(changes[1].type_or_errno == UNIT_FILE_SYMLINK);
@@ -991,7 +991,7 @@ static void test_with_dropin_template(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-1.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-1.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 2);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(changes[1].type_or_errno == UNIT_FILE_SYMLINK);
@@ -1004,7 +1004,7 @@ static void test_with_dropin_template(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-2.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-2@instance-2.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/with-dropin-2@.service"));
@@ -1013,7 +1013,7 @@ static void test_with_dropin_template(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3@.service"), &changes, &n_changes) == 1);
+        assert_se(unit_file_enable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("with-dropin-3@.service"), &changes, &n_changes, NULL, NULL) == 1);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
         assert_se(streq(changes[0].source, "/usr/lib/systemd/system/with-dropin-3@.service"));
@@ -1053,7 +1053,7 @@ static void test_preset_multiple_instances(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bar0.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
         /* Preset a single instantiated unit specified in the list */
-        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bar0.service", &state) >= 0 && state == UNIT_FILE_ENABLED);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_SYMLINK);
@@ -1062,7 +1062,7 @@ static void test_preset_multiple_instances(const char *root) {
         unit_file_changes_free(changes, n_changes);
         changes = NULL; n_changes = 0;
 
-        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), &changes, &n_changes) >= 0);
+        assert_se(unit_file_disable(UNIT_FILE_SYSTEM, 0, root, STRV_MAKE("foo@bar0.service"), &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes == 1);
         assert_se(changes[0].type_or_errno == UNIT_FILE_UNLINK);
         p = strjoina(root, SYSTEM_CONFIG_UNIT_DIR"/multi-user.target.wants/foo@bar0.service");
@@ -1075,7 +1075,7 @@ static void test_preset_multiple_instances(const char *root) {
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bar1.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@bartest.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
 
-        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes) >= 0);
+        assert_se(unit_file_preset_all(UNIT_FILE_SYSTEM, 0, root, UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL) >= 0);
         assert_se(n_changes > 0);
 
         assert_se(unit_file_get_state(UNIT_FILE_SYSTEM, root, "foo@def.service", &state) >= 0 && state == UNIT_FILE_DISABLED);
diff --git a/src/test/test-install.c b/src/test/test-install.c
index 7a0beb2d24..523aaf8220 100644
--- a/src/test/test-install.c
+++ b/src/test/test-install.c
@@ -52,12 +52,12 @@ int main(int argc, char* argv[]) {
 
         log_info("/*** enable **/");
 
-        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         log_info("/*** enable2 **/");
 
-        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -71,7 +71,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -85,10 +85,10 @@ int main(int argc, char* argv[]) {
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
@@ -102,10 +102,10 @@ int main(int argc, char* argv[]) {
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
@@ -119,7 +119,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_mask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -133,10 +133,10 @@ int main(int argc, char* argv[]) {
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
@@ -150,7 +150,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes);
+        r = unit_file_unmask(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -164,7 +164,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_enable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -178,7 +178,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -191,7 +191,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -205,7 +205,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -218,7 +218,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_link(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -232,7 +232,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_reenable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes);
+        r = unit_file_reenable(UNIT_FILE_SYSTEM, 0, NULL, (char**) files2, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -246,7 +246,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes);
+        r = unit_file_disable(UNIT_FILE_SYSTEM, 0, NULL, STRV_MAKE(basename(files2[0])), &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
@@ -258,7 +258,7 @@ int main(int argc, char* argv[]) {
         changes = NULL;
         n_changes = 0;
 
-        r = unit_file_preset(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, UNIT_FILE_PRESET_FULL, &changes, &n_changes);
+        r = unit_file_preset(UNIT_FILE_SYSTEM, 0, NULL, (char**) files, UNIT_FILE_PRESET_FULL, &changes, &n_changes, NULL, NULL);
         assert_se(r >= 0);
 
         dump_changes(changes, n_changes);
-- 
2.32.0

