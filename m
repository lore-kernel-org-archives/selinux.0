Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE99C4320A
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A3B60F25
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbhHEO0j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbhHEO0e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E9C0613D5
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zb12so5107044ejb.5
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7qgJ7pdqliDiehSbQmC0drifkF24wEf1rc4rvaeCJGo=;
        b=kDD//a9+BtR8B8D47Ch78TeklBTSPI+o0d5UE/nw0gcNvwL1i9yp06KhhRW5aGtFEq
         ID7MQVSQqI+dUqA8yatOFGLPDSnDpZBvP0GFi/9fjcyF8uHtHI5o61vhAAl5yBcfKV4O
         DzhbimwMDMtDDiZJYflC2Z05uc1n7LqX1J8nt+3ifoOFba1vBGaiOLmtMQi2tTAyfQ13
         q5mIaCIevjP8yobXjfj+ohAuPJo1F2nGXsqiCTe9VBTfD2PJjvEgSQb2UeJP0YAvBihl
         Zfj/Ci99jnmwPKkw9RE3sZQS58BqC2awI0Or9RXFvutq1TLNFIIl16tcNnxyx8B9Xdxp
         Z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qgJ7pdqliDiehSbQmC0drifkF24wEf1rc4rvaeCJGo=;
        b=F0mCGevEXliXa32dY4E8ZAWsB6lnkcYe383CcCY15D+fH/nlqP2fq5uL6NmFdyGEXM
         JP8s4uhfRPGrRKvhSUTD3x1M2iS9OT3J6yLownLrWeJl2UB6SovtuB/NQtk5fpmoov7J
         aa+gmqyldHXxHEwr8a+YVxUqdJWCauqNFXb4bDFlDrLx6EE0L4GXihb78Q2casHBolpZ
         OdZWmKXgWQj8w4rcxCCHbOC65/9IZ8lwnV9ev8tASJjl0RNBVu8yvsa/kSHnmgeGjgsI
         0OwxOuJzvO2LRF8tzipCA5991dvkkJKzuJ+fHIoDDVri/uE1rYqpmETqAkPysDoWHrN+
         WQaQ==
X-Gm-Message-State: AOAM532hgyQpxV8fNo+6utv4++VlffajixqhRrXfFLCFtZ/ZxjdBJbad
        B7mGxt4i36BzeV7KBdnrrv0aVikTjwM=
X-Google-Smtp-Source: ABdhPJyApJ3IOKOgBIzrKXPybT5L28mrXyiLN1Fu+XzEZyLByhsfDEhCrLBfXxKrxtlYCW02MrZZ8A==
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr5185497ejc.354.1628173578016;
        Thu, 05 Aug 2021 07:26:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:17 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 5/7] core: implement the sd-bus generic callback for SELinux
Date:   Thu,  5 Aug 2021 16:24:43 +0200
Message-Id: <20210805142445.61725-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 src/core/dbus-callbackdata.h | 10 ++++++
 src/core/dbus-manager.c      | 45 +++++++++++++++++----------
 src/core/manager.c           |  7 +++++
 src/core/manager.h           |  1 +
 src/core/selinux-access.c    | 53 ++++++++++++++++++++++++++++++-
 src/core/selinux-access.h    |  7 +++++
 src/shared/install.c         | 60 ++++++++++++++++++++++++++++++++++++
 src/shared/install.h         |  2 ++
 8 files changed, 168 insertions(+), 17 deletions(-)

diff --git a/src/core/dbus-callbackdata.h b/src/core/dbus-callbackdata.h
index 7dedb680c0..400c3bc481 100644
--- a/src/core/dbus-callbackdata.h
+++ b/src/core/dbus-callbackdata.h
@@ -1,5 +1,15 @@
 /* SPDX-License-Identifier: LGPL-2.1-or-later */
 #pragma once
 
+#include "sd-bus.h"
+
+#include "manager.h"
+
 typedef struct MacUnitCallbackUserdata {
+        Manager *manager;
+        sd_bus_message *message;
+        sd_bus_error *error;
+        const char *func;
+
+        const char *selinux_permission;
 } MacUnitCallbackUserdata;
diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index eec358cb6b..66cc276f8f 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -2187,10 +2187,15 @@ fail:
 
 static int mac_unit_callback_check(const char *unit_name, void *userdata) {
         MacUnitCallbackUserdata *ud = userdata;
+        int r;
 
         assert(unit_name);
         assert(ud);
 
+        r = mac_selinux_unit_callback_check(unit_name, ud);
+        if (r < 0)
+                return r;
+
         return 0;
 }
 
@@ -2199,6 +2204,8 @@ static int method_enable_unit_files_generic(
                 Manager *m,
                 int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
                 bool carries_install_info,
+                const char *mac_selinux_permission,
+                const char *func,
                 sd_bus_error *error) {
 
         _cleanup_strv_free_ char **l = NULL;
@@ -2206,7 +2213,7 @@ static int method_enable_unit_files_generic(
         size_t n_changes = 0;
         UnitFileFlags flags;
         int r;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = { m, message, error, func, mac_selinux_permission };
 
         assert(message);
         assert(m);
@@ -2247,19 +2254,19 @@ static int method_enable_unit_files_generic(
 }
 
 static int method_enable_unit_files_with_flags(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_enable, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_enable, true, "enable", __func__, error);
 }
 
 static int method_enable_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_enable, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_enable, true, "enable", __func__, error);
 }
 
 static int method_reenable_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_reenable, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_reenable, true, "enable", __func__, error);
 }
 
 static int method_link_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_link, false, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_link, false, "enable", __func__, error);
 }
 
 static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char **files, UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata) {
@@ -2267,11 +2274,11 @@ static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flag
 }
 
 static int method_preset_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_preset_without_mode, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_preset_without_mode, true, "reload", __func__, error);
 }
 
 static int method_mask_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_mask, false, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_mask, false, "disable", __func__, error);
 }
 
 static int method_preset_unit_files_with_mode(sd_bus_message *message, void *userdata, sd_bus_error *error) {
@@ -2284,7 +2291,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
         int runtime, force, r;
         UnitFileFlags flags;
         const char *mode;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = { m, message, error, __func__, "reload" };
 
         assert(message);
         assert(m);
@@ -2324,6 +2331,8 @@ static int method_disable_unit_files_generic(
                 sd_bus_message *message,
                 Manager *m,
                 int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
+                const char *mac_selinux_permissions,
+                const char *func,
                 sd_bus_error *error) {
 
         _cleanup_strv_free_ char **l = NULL;
@@ -2331,7 +2340,7 @@ static int method_disable_unit_files_generic(
         UnitFileFlags flags;
         size_t n_changes = 0;
         int r;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = { m, message, error, func, mac_selinux_permissions };
 
         assert(message);
         assert(m);
@@ -2373,15 +2382,15 @@ static int method_disable_unit_files_generic(
 }
 
 static int method_disable_unit_files_with_flags(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_disable_unit_files_generic(message, userdata, unit_file_disable, error);
+        return method_disable_unit_files_generic(message, userdata, unit_file_disable, "disable", __func__, error);
 }
 
 static int method_disable_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_disable_unit_files_generic(message, userdata, unit_file_disable, error);
+        return method_disable_unit_files_generic(message, userdata, unit_file_disable, "disable", __func__, error);
 }
 
 static int method_unmask_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_disable_unit_files_generic(message, userdata, unit_file_unmask, error);
+        return method_disable_unit_files_generic(message, userdata, unit_file_unmask, "enable", __func__, error);
 }
 
 static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
@@ -2390,7 +2399,7 @@ static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_
         size_t n_changes = 0;
         Manager *m = userdata;
         int r;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = {  m, message, error, __func__, "reload" };
 
         assert(message);
         assert(m);
@@ -2451,7 +2460,7 @@ static int method_preset_all_unit_files(sd_bus_message *message, void *userdata,
         const char *mode;
         UnitFileFlags flags;
         int force, runtime, r;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = { m, message, error, __func__, "reload" };
 
         assert(message);
         assert(m);
@@ -2496,7 +2505,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         char *target, *type;
         UnitDependency dep;
         UnitFileFlags flags;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = { m, message, error, __func__, "reload" };
 
         assert(message);
         assert(m);
@@ -2529,6 +2538,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
 }
 
 static int method_get_unit_file_links(sd_bus_message *message, void *userdata, sd_bus_error *error) {
+        Manager *m = userdata;
         _cleanup_(sd_bus_message_unrefp) sd_bus_message *reply = NULL;
         UnitFileChange *changes = NULL;
         size_t n_changes = 0, i;
@@ -2536,7 +2546,10 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         const char *name;
         char **p;
         int runtime, r;
-        MacUnitCallbackUserdata mcud = {};
+        MacUnitCallbackUserdata mcud = { m, message, error, __func__, "status" };
+
+        assert(message);
+        assert(m);
 
         r = sd_bus_message_read(message, "sb", &name, &runtime);
         if (r < 0)
diff --git a/src/core/manager.c b/src/core/manager.c
index 952bc57036..f9bd2636fa 100644
--- a/src/core/manager.c
+++ b/src/core/manager.c
@@ -1977,6 +1977,13 @@ Unit *manager_get_unit(Manager *m, const char *name) {
         return hashmap_get(m->units, name);
 }
 
+const char *manager_lookup_unit_label_path(Manager *m, const char *name) {
+        assert(m);
+        assert(name);
+
+        return hashmap_get(m->unit_id_map, name);
+}
+
 static int manager_dispatch_target_deps_queue(Manager *m) {
         Unit *u;
         int r = 0;
diff --git a/src/core/manager.h b/src/core/manager.h
index 284ea42a9d..42a345c9a7 100644
--- a/src/core/manager.h
+++ b/src/core/manager.h
@@ -474,6 +474,7 @@ int manager_startup(Manager *m, FILE *serialization, FDSet *fds);
 
 Job *manager_get_job(Manager *m, uint32_t id);
 Unit *manager_get_unit(Manager *m, const char *name);
+const char *manager_lookup_unit_label_path(Manager *m, const char *name);
 
 int manager_get_job_from_dbus_path(Manager *m, const char *s, Job **_j);
 
diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index 180fe22773..82a0feffb4 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -16,11 +16,14 @@
 #include "alloc-util.h"
 #include "audit-fd.h"
 #include "bus-util.h"
+#include "dbus-callbackdata.h"
 #include "errno-util.h"
 #include "format-util.h"
+#include "install.h"
 #include "log.h"
 #include "path-util.h"
 #include "selinux-util.h"
+#include "stat-util.h"
 #include "stdio-util.h"
 #include "strv.h"
 #include "util.h"
@@ -284,6 +287,47 @@ int _mac_selinux_generic_access_check(
         return enforce ? r : 0;
 }
 
+int mac_selinux_unit_callback_check(
+        const char *unit_name,
+        const MacUnitCallbackUserdata *userdata) {
+
+        const Unit *u;
+        const char *path = NULL;
+        _cleanup_free_ char *path_lookup = NULL;
+
+        assert(unit_name);
+        assert(userdata);
+        assert(userdata->manager);
+        assert(userdata->message);
+        assert(userdata->error);
+        assert(userdata->func);
+
+        if (!mac_selinux_use())
+                return 0;
+
+        if (!userdata->selinux_permission)
+                return 0;
+
+        u = manager_get_unit(userdata->manager, unit_name);
+        if (u)
+                path = unit_label_path(u);
+
+        /* maybe the unit is not loaded, e.g. a disabled user session unit */
+        if (!path)
+                path = manager_lookup_unit_label_path(userdata->manager, unit_name);
+
+        /* try to search for a unit path and do not base the check on a masked path, e.g. /dev/null */
+        if (!path || null_or_empty_path(path) > 0)
+                (void) unit_file_label_path(userdata->manager->unit_file_scope, NULL, unit_name, &path_lookup);
+
+        return _mac_selinux_generic_access_check(
+                userdata->message,
+                path_lookup ?: path,
+                userdata->selinux_permission,
+                userdata->error,
+                userdata->func);
+}
+
 #else /* HAVE_SELINUX */
 
 int _mac_selinux_generic_access_check(
@@ -296,4 +340,11 @@ int _mac_selinux_generic_access_check(
         return 0;
 }
 
-#endif /* HAVE_SELINUX */
+int mac_selinux_unit_callback_check(
+                const char *unit_name,
+                const MacUnitCallbackUserdata *userdata) {
+
+        return 0;
+}
+
+#endif
diff --git a/src/core/selinux-access.h b/src/core/selinux-access.h
index 8a5582997a..65eb643462 100644
--- a/src/core/selinux-access.h
+++ b/src/core/selinux-access.h
@@ -5,6 +5,9 @@
 
 #include "manager.h"
 
+/* forward declaration */
+typedef struct MacUnitCallbackUserdata MacUnitCallbackUserdata;
+
 int _mac_selinux_generic_access_check(sd_bus_message *message,
                                       const char *path,
                                       const char *permission,
@@ -16,3 +19,7 @@ int _mac_selinux_generic_access_check(sd_bus_message *message,
 
 #define mac_selinux_unit_access_check(unit, message, permission, error) \
         _mac_selinux_generic_access_check((message), unit_label_path(unit), (permission), (error), __func__)
+
+int mac_selinux_unit_callback_check(
+                const char *unit_name,
+                const MacUnitCallbackUserdata *userdata);
diff --git a/src/shared/install.c b/src/shared/install.c
index f1e603fecf..0eab706724 100644
--- a/src/shared/install.c
+++ b/src/shared/install.c
@@ -3559,6 +3559,66 @@ int unit_file_get_list(
         return 0;
 }
 
+int unit_file_label_path(
+        UnitFileScope scope,
+        const char *root_dir,
+        const char *name,
+        char **ret_path) {
+
+        _cleanup_(lookup_paths_free) LookupPaths paths = {};
+        char **dirname;
+        int r;
+
+        assert(scope >= 0);
+        assert(scope < _UNIT_FILE_SCOPE_MAX);
+        assert(name);
+        assert_return(unit_name_is_valid(name, UNIT_NAME_ANY), -EINVAL);
+        assert(ret_path);
+
+        r = lookup_paths_init(&paths, scope, 0, root_dir);
+        if (r < 0)
+                return r;
+
+        STRV_FOREACH(dirname, paths.search_path) {
+                _cleanup_closedir_ DIR *d = NULL;
+                const struct dirent *de;
+
+                d = opendir(*dirname);
+                if (!d) {
+                        if (errno == ENOENT)
+                                continue;
+                        if (IN_SET(errno, ENOTDIR, EACCES)) {
+                                log_debug_errno(errno, "Failed to open \"%s\": %m", *dirname);
+                                continue;
+                        }
+
+                        return -errno;
+                }
+
+                FOREACH_DIRENT(de, d, return -errno) {
+                        _cleanup_free_ char *p = NULL;
+
+                        if (!IN_SET(de->d_type, DT_LNK, DT_REG))
+                                continue;
+
+                        if (!streq(de->d_name, name))
+                                continue;
+
+                        p = path_join(*dirname, de->d_name);
+                        if (!p)
+                                return -ENOMEM;
+
+                        if (null_or_empty_path(p))
+                                continue;
+
+                        *ret_path = TAKE_PTR(p);
+                        return 0;
+                }
+        }
+
+        return -ENOENT;
+}
+
 static const char* const unit_file_state_table[_UNIT_FILE_STATE_MAX] = {
         [UNIT_FILE_ENABLED]         = "enabled",
         [UNIT_FILE_ENABLED_RUNTIME] = "enabled-runtime",
diff --git a/src/shared/install.h b/src/shared/install.h
index 96896f0548..e03422c65a 100644
--- a/src/shared/install.h
+++ b/src/shared/install.h
@@ -208,6 +208,8 @@ int unit_file_lookup_state(
 int unit_file_get_state(UnitFileScope scope, const char *root_dir, const char *filename, UnitFileState *ret);
 int unit_file_exists(UnitFileScope scope, const LookupPaths *paths, const char *name);
 
+int unit_file_label_path(UnitFileScope scope, const char *root_dir, const char *name, char **ret_path);
+
 int unit_file_get_list(UnitFileScope scope, const char *root_dir, Hashmap *h, char **states, char **patterns);
 Hashmap* unit_file_list_free(Hashmap *h);
 
-- 
2.32.0

