Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D65C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06417227BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Bhchrh4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLRO2Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36964 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfLRO2Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so1817148edb.4
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YW+I59w6+Obs2r/1pYJmdSGP5U2Xt6oQOgwt5MnVaho=;
        b=Bhchrh4pDNCLIYSQ+0a50vXF0G3fX4RGZK+LmNn6gJpngpP0DBGt95vjHkdpmyFZ2w
         6/yU6XnyiSFMicz8UME5BRdAHtKuIs4iI+Tfs6y6mBPCqmEGIeDKOVV5vRCFjd0aoDhU
         mEghoJQFjxPa1KcB2ukBLyGDRm5wcJ+qbmbR7rayGaM4CyqcFcG13zH0P9Ux7opiYnit
         4nR/T8WlYO7EEM1DKGanbRJmJMLvyFgSRq4X2zL2CH06qQ34PFwXZqCyYdScxc4kdE7D
         RcZFV8eJ9WTLUTl8ir2EExXKaGf2XEBA7tq0YxojpsOTbvwJe4wSMz4gpOliyGAwrmXv
         ZdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YW+I59w6+Obs2r/1pYJmdSGP5U2Xt6oQOgwt5MnVaho=;
        b=BJ6fEz+Y6ikGNFJ7NdV9rDcEvw8s7yTacFoaFjIJsFHIiLPOtQ3SPO2UTVLy3VRBQK
         s5yBz+JJdZwuy8Laosq7sye5BQ853P8zmIQ8ud0JUfeitL4w4XCkswagdoyHOR9AcMJi
         JBdzL7HLl9tW7XIFiwWfzDhSzjca3a2aMLXNflw6CNapEhbkQXtx8FxJJAyz5oM4vahK
         9XcvwjiYD6WuuWm3FjoorhJ1eha2t4HlgsM9bkX6/3mjPf0GCGnxieU2JpIDHWP2rPua
         qE69eDUMSYfUQkKtWI3f2NcLDMT0IqTj12N+6VrbYoqnCOOJdla8ilo045RBz91rDZ48
         CTWA==
X-Gm-Message-State: APjAAAXkXna/RWv3NJy85zZFoGJk3E5MMD5phew+PQuWRdSCVGFQejxu
        Dhqtr00hp0guZ3y0xAUEiB3sUIHC
X-Google-Smtp-Source: APXvYqz/8FQDYuoTmY4Nm7PfWsYDRf3PbejFtnWgxNk2YELe+4R0hSBlm9FCV9hYK5TZ67YJbGVmNA==
X-Received: by 2002:a05:6402:542:: with SMTP id i2mr2613650edx.190.1576679301782;
        Wed, 18 Dec 2019 06:28:21 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:21 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 7/8] core: implement the sd-bus generic callback for SELinux
Date:   Wed, 18 Dec 2019 15:28:07 +0100
Message-Id: <20191218142808.30433-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Also keep the SELinux class `service` in `mac_selinux_generic_access_check()` in the case no path is given.
Previously this could mainly happen on a mask unit, which is fixed now.
Changing the class, but keeping the permission, is unpleasant as the class `system` must otherwise define always all permissions of `service` and a unit operation resulting in a system class-based check is odd.
The fallback target context remains the process context of systemd-pid1.
---
 src/core/dbus-manager.c   | 37 +++++++++++++++++++++-------------
 src/core/manager.c        |  7 +++++++
 src/core/manager.h        |  1 +
 src/core/selinux-access.c | 42 ++++++++++++++++++++++++++++++++++-----
 src/core/selinux-access.h | 28 +++++++++++++++++++++++---
 src/core/unit.c           |  4 +++-
 src/core/unit.h           |  2 +-
 7 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index b866fd58b6..14085ba1a1 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -2063,14 +2063,20 @@ fail:
 }
 
 struct mac_callback_userdata {
+        struct mac_selinux_callback_userdata selinux;
 };
 
 static int mac_callback_check(const char *name, void *userdata) {
         struct mac_callback_userdata *ud = userdata;
+        int r;
 
         assert(name);
         assert(ud);
 
+        r = mac_selinux_callback_check(name, &(ud->selinux));
+        if (r < 0)
+                return r;
+
         return 0;
 }
 
@@ -2079,6 +2085,7 @@ static int method_enable_unit_files_generic(
                 Manager *m,
                 int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
                 bool carries_install_info,
+                const char *mac_selinux_verb,
                 sd_bus_error *error) {
 
         _cleanup_strv_free_ char **l = NULL;
@@ -2086,7 +2093,7 @@ static int method_enable_unit_files_generic(
         size_t n_changes = 0;
         UnitFileFlags flags;
         int runtime, force, r;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, mac_selinux_verb } };
 
         assert(message);
         assert(m);
@@ -2115,15 +2122,15 @@ static int method_enable_unit_files_generic(
 }
 
 static int method_enable_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_enable, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_enable, true, MAC_SELINUX_UNIT_PERM_ENABLE, error);
 }
 
 static int method_reenable_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_reenable, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_reenable, true, MAC_SELINUX_UNIT_PERM_REENABLE, error);
 }
 
 static int method_link_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_link, false, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_link, false, MAC_SELINUX_UNIT_PERM_LINK, error);
 }
 
 static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char **files, UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata) {
@@ -2131,11 +2138,11 @@ static int unit_file_preset_without_mode(UnitFileScope scope, UnitFileFlags flag
 }
 
 static int method_preset_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_preset_without_mode, true, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_preset_without_mode, true, MAC_SELINUX_UNIT_PERM_PRESET, error);
 }
 
 static int method_mask_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_enable_unit_files_generic(message, userdata, unit_file_mask, false, error);
+        return method_enable_unit_files_generic(message, userdata, unit_file_mask, false, MAC_SELINUX_UNIT_PERM_MASK, error);
 }
 
 static int method_preset_unit_files_with_mode(sd_bus_message *message, void *userdata, sd_bus_error *error) {
@@ -2148,7 +2155,7 @@ static int method_preset_unit_files_with_mode(sd_bus_message *message, void *use
         int runtime, force, r;
         UnitFileFlags flags;
         const char *mode;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, MAC_SELINUX_UNIT_PERM_PRESET } };
 
         assert(message);
         assert(m);
@@ -2188,13 +2195,14 @@ static int method_disable_unit_files_generic(
                 sd_bus_message *message,
                 Manager *m,
                 int (*call)(UnitFileScope scope, UnitFileFlags flags, const char *root_dir, char *files[], UnitFileChange **changes, size_t *n_changes, mac_callback_t mac_check, void *userdata),
+                const char *mac_selinux_verb,
                 sd_bus_error *error) {
 
         _cleanup_strv_free_ char **l = NULL;
         UnitFileChange *changes = NULL;
         size_t n_changes = 0;
         int r, runtime;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, mac_selinux_verb } };
 
         assert(message);
         assert(m);
@@ -2221,11 +2229,11 @@ static int method_disable_unit_files_generic(
 }
 
 static int method_disable_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_disable_unit_files_generic(message, userdata, unit_file_disable, error);
+        return method_disable_unit_files_generic(message, userdata, unit_file_disable, MAC_SELINUX_UNIT_PERM_DISABLE, error);
 }
 
 static int method_unmask_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
-        return method_disable_unit_files_generic(message, userdata, unit_file_unmask, error);
+        return method_disable_unit_files_generic(message, userdata, unit_file_unmask, MAC_SELINUX_UNIT_PERM_UNMASK, error);
 }
 
 static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_bus_error *error) {
@@ -2234,7 +2242,7 @@ static int method_revert_unit_files(sd_bus_message *message, void *userdata, sd_
         size_t n_changes = 0;
         Manager *m = userdata;
         int r;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, MAC_SELINUX_UNIT_PERM_REVERT } };
 
         assert(message);
         assert(m);
@@ -2295,7 +2303,7 @@ static int method_preset_all_unit_files(sd_bus_message *message, void *userdata,
         const char *mode;
         UnitFileFlags flags;
         int force, runtime, r;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, MAC_SELINUX_UNIT_PERM_PRESET } };
 
         assert(message);
         assert(m);
@@ -2340,7 +2348,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         char *target, *type;
         UnitDependency dep;
         UnitFileFlags flags;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, MAC_SELINUX_UNIT_PERM_ADDDEPENDENCY } };
 
         assert(message);
         assert(m);
@@ -2377,6 +2385,7 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
 }
 
 static int method_get_unit_file_links(sd_bus_message *message, void *userdata, sd_bus_error *error) {
+        Manager *m = userdata;
         _cleanup_(sd_bus_message_unrefp) sd_bus_message *reply = NULL;
         UnitFileChange *changes = NULL;
         size_t n_changes = 0, i;
@@ -2384,7 +2393,7 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         const char *name;
         char **p;
         int runtime, r;
-        struct mac_callback_userdata mcud = {};
+        struct mac_callback_userdata mcud = { .selinux = { m, message, error, MAC_SELINUX_UNIT_PERM_STATUS } };
 
         r = mac_selinux_access_check(message, "status", error);
         if (r < 0)
diff --git a/src/core/manager.c b/src/core/manager.c
index 0b6ef09924..0f69ba12fd 100644
--- a/src/core/manager.c
+++ b/src/core/manager.c
@@ -1868,6 +1868,13 @@ Unit *manager_get_unit(Manager *m, const char *name) {
         return hashmap_get(m->units, name);
 }
 
+const char *manager_get_unitpath(Manager *m, const char *name) {
+        assert(m);
+        assert(name);
+
+        return hashmap_get(m->unit_id_map, name);
+}
+
 static int manager_dispatch_target_deps_queue(Manager *m) {
         Unit *u;
         unsigned k;
diff --git a/src/core/manager.h b/src/core/manager.h
index fb1a29d88c..acd3762744 100644
--- a/src/core/manager.h
+++ b/src/core/manager.h
@@ -452,6 +452,7 @@ int manager_startup(Manager *m, FILE *serialization, FDSet *fds);
 
 Job *manager_get_job(Manager *m, uint32_t id);
 Unit *manager_get_unit(Manager *m, const char *name);
+const char *manager_get_unitpath(Manager *m, const char *name);
 
 int manager_get_job_from_dbus_path(Manager *m, const char *s, Job **_j);
 
diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index 4500e4452f..d3b89c1d7a 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -168,6 +168,33 @@ static int access_init(sd_bus_error *error) {
         return 1;
 }
 
+int mac_selinux_callback_check(
+                const char *name,
+                struct mac_selinux_callback_userdata *userdata) {
+        const Unit *u;
+        const char *path = NULL;
+
+        assert(name);
+        assert(userdata);
+        assert(userdata->m);
+        assert(userdata->message);
+        assert(userdata->error);
+        assert(userdata->permission);
+
+        if (!mac_selinux_use())
+                return 0;
+
+        u = manager_get_unit(userdata->m, name);
+        if (u)
+                path = unit_label_path(u);
+
+        /* maybe the unit is not loaded, e.g. a disabled user session unit */
+        if (!path)
+                path = manager_get_unitpath(userdata->m, name);
+
+        return mac_selinux_generic_access_check(userdata->message, path, MAC_SELINUX_CLASS_UNIT, userdata->permission, userdata->error);
+}
+
 /*
    This function communicates with the kernel to check whether or not it should
    allow the access.
@@ -177,11 +204,12 @@ static int access_init(sd_bus_error *error) {
 int mac_selinux_generic_access_check(
                 sd_bus_message *message,
                 const char *path,
+                const char *tclass,
                 const char *permission,
                 sd_bus_error *error) {
 
         _cleanup_(sd_bus_creds_unrefp) sd_bus_creds *creds = NULL;
-        const char *tclass = NULL, *scon = NULL;
+        const char *scon = NULL;
         struct audit_info audit_info = {};
         _cleanup_free_ char *cl = NULL;
         char *fcon = NULL;
@@ -227,8 +255,6 @@ int mac_selinux_generic_access_check(
                         r = sd_bus_error_setf(error, SD_BUS_ERROR_ACCESS_DENIED, "Failed to get file context on %s.", path);
                         goto finish;
                 }
-
-                tclass = "service";
         } else {
                 r = getcon_raw(&fcon);
                 if (r < 0) {
@@ -236,8 +262,6 @@ int mac_selinux_generic_access_check(
                         r = sd_bus_error_setf(error, SD_BUS_ERROR_ACCESS_DENIED, "Failed to get current context.");
                         goto finish;
                 }
-
-                tclass = "system";
         }
 
         sd_bus_creds_get_cmdline(creds, &cmdline);
@@ -269,10 +293,18 @@ finish:
 int mac_selinux_generic_access_check(
                 sd_bus_message *message,
                 const char *path,
+                const char *tclass,
                 const char *permission,
                 sd_bus_error *error) {
 
         return 0;
 }
 
+int mac_selinux_callback_check(
+                const char *name,
+                struct mac_selinux_callback_userdata *userdata) {
+
+        return 0;
+}
+
 #endif
diff --git a/src/core/selinux-access.h b/src/core/selinux-access.h
index 1e75930f57..cfdeded59b 100644
--- a/src/core/selinux-access.h
+++ b/src/core/selinux-access.h
@@ -6,15 +6,37 @@
 #include "bus-util.h"
 #include "manager.h"
 
-int mac_selinux_generic_access_check(sd_bus_message *message, const char *path, const char *permission, sd_bus_error *error);
+#define MAC_SELINUX_CLASS_SYSTEM            "system"
+#define MAC_SELINUX_CLASS_UNIT              "service"
+
+#define MAC_SELINUX_UNIT_PERM_ADDDEPENDENCY "modify"
+#define MAC_SELINUX_UNIT_PERM_DISABLE       "disable"
+#define MAC_SELINUX_UNIT_PERM_ENABLE        "enable"
+#define MAC_SELINUX_UNIT_PERM_LINK          "enable"
+#define MAC_SELINUX_UNIT_PERM_MASK          "disable"
+#define MAC_SELINUX_UNIT_PERM_PRESET        "modify"
+#define MAC_SELINUX_UNIT_PERM_REENABLE      "enable"
+#define MAC_SELINUX_UNIT_PERM_REVERT        "modify"
+#define MAC_SELINUX_UNIT_PERM_STATUS        "status"
+#define MAC_SELINUX_UNIT_PERM_UNMASK        "enable"
+
+struct mac_selinux_callback_userdata {
+        Manager *m;
+        sd_bus_message *message;
+        sd_bus_error *error;
+        const char *permission;
+};
+int mac_selinux_callback_check(const char *name, struct mac_selinux_callback_userdata *userdata);
+
+int mac_selinux_generic_access_check(sd_bus_message *message, const char *path, const char *tclass, const char *permission, sd_bus_error *error);
 
 #if HAVE_SELINUX
 
 #define mac_selinux_access_check(message, permission, error) \
-        mac_selinux_generic_access_check((message), NULL, (permission), (error))
+        mac_selinux_generic_access_check((message), NULL, MAC_SELINUX_CLASS_SYSTEM, (permission), (error))
 
 #define mac_selinux_unit_access_check(unit, message, permission, error) \
-        mac_selinux_generic_access_check((message), unit_label_path(unit), (permission), (error))
+        mac_selinux_generic_access_check((message), unit_label_path(unit), MAC_SELINUX_CLASS_UNIT, (permission), (error))
 
 #else
 
diff --git a/src/core/unit.c b/src/core/unit.c
index f9b299c8a4..1d5c702020 100644
--- a/src/core/unit.c
+++ b/src/core/unit.c
@@ -5703,9 +5703,11 @@ bool unit_needs_console(Unit *u) {
         return exec_context_may_touch_console(ec);
 }
 
-const char *unit_label_path(Unit *u) {
+const char *unit_label_path(const Unit *u) {
         const char *p;
 
+        assert(u);
+
         /* Returns the file system path to use for MAC access decisions, i.e. the file to read the SELinux label off
          * when validating access checks. */
 
diff --git a/src/core/unit.h b/src/core/unit.h
index 5dac251d74..821c7b3c84 100644
--- a/src/core/unit.h
+++ b/src/core/unit.h
@@ -839,7 +839,7 @@ int unit_warn_leftover_processes(Unit *u);
 
 bool unit_needs_console(Unit *u);
 
-const char *unit_label_path(Unit *u);
+const char *unit_label_path(const Unit *u);
 
 int unit_pid_attachable(Unit *unit, pid_t pid, sd_bus_error *error);
 
-- 
2.24.1

