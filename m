Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30190C3F68F
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A73218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fAw6fJVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLRO2W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46695 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfLRO2W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so1782645edi.13
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iG1omOY3j6TFAuPapv5lxoAoO3xz+LG69koppTI1Blk=;
        b=fAw6fJVDsKsF7exByHTRswaDvZYMsNYpyvTnkMwa0V4bbTGBx/GF0vNUc9ShF868js
         DgAKB4nmbZMwyCneTrRpHKhmR7Slnsa3Pnc1DgriGOlRf/bOE8BKVwbuFaJDRI+yR/9C
         zijsz+EvH62JwCfyQYWSpb472O1x4skamGiwQbZtxidLJhTquwpk4omip845wr8AtrN8
         sUYkw5FR/TlzwJ9+oBs3dWma0twt6qwefO6noQzE/LCkFTrAnRwJWayej7AMQ4DJdXfS
         E4cpN8JyKY2+Rp2Ws7FqDR6vvtgejmuB6W1j6VoLQ/m8hQiqSMHHC+6VJZXryQJrJ2K+
         pGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iG1omOY3j6TFAuPapv5lxoAoO3xz+LG69koppTI1Blk=;
        b=K4LoRTYvhUXl5lO+DAAu04Uvr2sXMuvZqRB9vRG2K0slCP9B5MXM+q04mMaDkynwrd
         q45Gzb2Zi2OqGckM1uJst156M960Z6F+s8RI/fDg/MEucnLdXyqLIzWpw2F576CQ4vQU
         IIM/H0gC+D26HUElHqDJnbaud0uTo+y6JMTC2TmMLigqXkf1I6lrQ4fC5MeWnwjKk41G
         qokkn00hLC2iH66Ry/SFWH3yZyvM7mGBBvvNPgljh+q1W2rC1B58ZeGLS2G4OJVHdHTs
         qc2jk9+JINLLyO7KnqfHt7/D2sK4DpyvKZ3T/fpQiKRjZeJRRr77nofh4t3bSXq7yYst
         57DQ==
X-Gm-Message-State: APjAAAXwtGBGUHRarBv5qkAVUT2lnXh/N/4O143czJrwalnUgiCImiCo
        raJ3fUxfssiH71oONprKBlOzfajy
X-Google-Smtp-Source: APXvYqwmKIS5Z12IArN2CDO/21d9Hx+3jBz+Xl+DFTqKKYCjvBuJGmDkPsW5j2Fg1RK/gsdgX4ZwFA==
X-Received: by 2002:a17:906:9248:: with SMTP id c8mr3065934ejx.37.1576679299718;
        Wed, 18 Dec 2019 06:28:19 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:19 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/8] core: add missing SELinux checks for dbus methods
Date:   Wed, 18 Dec 2019 15:28:04 +0100
Message-Id: <20191218142808.30433-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new SELinux permissions `modify` and `listdynusers` to the class `service`.
  - modfiy checks altering operations, like `systemctl log-level debug` or `systemctl add-wants foo bar`.
  - listdynusers checks obtaining dynamic users, which is very common on systems using nss-systemd.
    Add a new permission to avoid undermining the `status` permission.

Perform SELinux access checks for the following D-Bus exposed methods:

  D-Bus interface         | c function name                    | SELinux permission verb

  GetAfter / GetBefore    | bus_job_method_get_waiting_jobs    | status
  LogTarget               | property_set_log_target            | modify
  LogLevel                | property_set_log_level             | modify
  RuntimeWatchdocUSec     | property_set_runtime_watchdog      | modify
  ServiceWatchdogs        | bus_property_set_bool_wrapper      | modify
  GetUnit                 | method_get_unit                    | status
  GetUnitByPID            | method_get_unit_by_pid             | status
  GetUnitByControlGroup   | method_get_unit_by_control_group   | status
  LoadUnit                | method_load_unit                   | status
  ListUnitsByNames        | method_list_units_by_names         | status
  LookupDynamicUserByName | method_lookup_dynamic_user_by_name | listdynusers
  LookupDynamicUserByUID  | method_lookup_dynamic_user_by_uid  | listdynusers
  GetDynamicUsers         | method_get_dynamic_users           | listdynusers
  AddDependencyUnitFiles  | method_add_dependency_unit_files   | modify
  GetUnitFileLinks        | method_get_unit_file_links         | status
  Unref                   | bus_unit_method_unref              | modify
---
 src/core/dbus-job.c     |  4 ++
 src/core/dbus-manager.c | 89 ++++++++++++++++++++++++++++++++++++-----
 src/core/dbus-unit.c    |  4 ++
 3 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/src/core/dbus-job.c b/src/core/dbus-job.c
index a7d342257b..7b0b093757 100644
--- a/src/core/dbus-job.c
+++ b/src/core/dbus-job.c
@@ -71,6 +71,10 @@ int bus_job_method_get_waiting_jobs(sd_bus_message *message, void *userdata, sd_
         Job *j = userdata;
         int r, i, n;
 
+        r = mac_selinux_unit_access_check(j->unit, message, "status", error);
+        if (r < 0)
+                return r;
+
         if (strstr(sd_bus_message_get_member(message), "After"))
                 n = job_get_after(j, &list);
         else
diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index c751e84253..d2db6e4a61 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -121,6 +121,10 @@ static int property_set_log_target(
         assert(bus);
         assert(value);
 
+        r = mac_selinux_access_check(value, "modify", error);
+        if (r < 0)
+                return r;
+
         r = sd_bus_message_read(value, "s", &t);
         if (r < 0)
                 return r;
@@ -178,6 +182,10 @@ static int property_set_log_level(
         assert(bus);
         assert(value);
 
+        r = mac_selinux_access_check(value, "modify", error);
+        if (r < 0)
+                return r;
+
         r = sd_bus_message_read(value, "s", &t);
         if (r < 0)
                 return r;
@@ -282,6 +290,10 @@ static int property_set_runtime_watchdog(
 
         assert_cc(sizeof(usec_t) == sizeof(uint64_t));
 
+        r = mac_selinux_access_check(value, "modify", error);
+        if (r < 0)
+                return r;
+
         r = sd_bus_message_read(value, "t", t);
         if (r < 0)
                 return r;
@@ -289,6 +301,24 @@ static int property_set_runtime_watchdog(
         return watchdog_set_timeout(t);
 }
 
+static int bus_property_set_bool_wrapper(
+                sd_bus *bus,
+                const char *path,
+                const char *interface,
+                const char *property,
+                sd_bus_message *value,
+                void *userdata,
+                sd_bus_error *error) {
+
+        int r;
+
+        r = mac_selinux_access_check(value, "modify", error);
+        if (r < 0)
+                return r;
+
+        return bus_property_set_bool(bus, path, interface, property, value, userdata, error);
+}
+
 static int bus_get_unit_by_name(Manager *m, sd_bus_message *message, const char *name, Unit **ret_unit, sd_bus_error *error) {
         Unit *u;
         int r;
@@ -375,6 +405,10 @@ static int method_get_unit(sd_bus_message *message, void *userdata, sd_bus_error
         if (r < 0)
                 return r;
 
+        r = mac_selinux_unit_access_check(u, message, "status", error);
+        if (r < 0)
+                return r;
+
         return reply_unit_path(u, message, error);
 }
 
@@ -413,6 +447,10 @@ static int method_get_unit_by_pid(sd_bus_message *message, void *userdata, sd_bu
         if (!u)
                 return sd_bus_error_setf(error, BUS_ERROR_NO_UNIT_FOR_PID, "PID "PID_FMT" does not belong to any loaded unit.", pid);
 
+        r = mac_selinux_unit_access_check(u, message, "status", error);
+        if (r < 0)
+                return r;
+
         return reply_unit_path(u, message, error);
 }
 
@@ -488,6 +526,10 @@ static int method_get_unit_by_control_group(sd_bus_message *message, void *userd
         if (!u)
                 return sd_bus_error_setf(error, BUS_ERROR_NO_SUCH_UNIT, "Control group '%s' is not valid or not managed by this instance", cgroup);
 
+        r = mac_selinux_unit_access_check(u, message, "status", error);
+        if (r < 0)
+                return r;
+
         return reply_unit_path(u, message, error);
 }
 
@@ -510,6 +552,10 @@ static int method_load_unit(sd_bus_message *message, void *userdata, sd_bus_erro
         if (r < 0)
                 return r;
 
+        r = mac_selinux_unit_access_check(u, message, "status", error);
+        if (r < 0)
+                return r;
+
         return reply_unit_path(u, message, error);
 }
 
@@ -529,6 +575,7 @@ static int method_start_unit_generic(sd_bus_message *message, Manager *m, JobTyp
         if (r < 0)
                 return r;
 
+        /* bus_unit_method_start_generic() includes a mac_selinux check */
         return bus_unit_method_start_generic(message, u, job_type, reload_if_possible, error);
 }
 
@@ -703,6 +750,10 @@ static int method_list_units_by_names(sd_bus_message *message, void *userdata, s
         assert(message);
         assert(m);
 
+        r = mac_selinux_access_check(message, "status", error);
+        if (r < 0)
+                return r;
+
         r = sd_bus_message_read_strv(message, &units);
         if (r < 0)
                 return r;
@@ -1263,11 +1314,11 @@ static int method_reload(sd_bus_message *message, void *userdata, sd_bus_error *
         assert(message);
         assert(m);
 
-        r = verify_run_space("Refusing to reload", error);
+        r = mac_selinux_access_check(message, "reload", error);
         if (r < 0)
                 return r;
 
-        r = mac_selinux_access_check(message, "reload", error);
+        r = verify_run_space("Refusing to reload", error);
         if (r < 0)
                 return r;
 
@@ -1299,11 +1350,11 @@ static int method_reexecute(sd_bus_message *message, void *userdata, sd_bus_erro
         assert(message);
         assert(m);
 
-        r = verify_run_space("Refusing to reexecute", error);
+        r = mac_selinux_access_check(message, "reload", error);
         if (r < 0)
                 return r;
 
-        r = mac_selinux_access_check(message, "reload", error);
+        r = verify_run_space("Refusing to reexecute", error);
         if (r < 0)
                 return r;
 
@@ -1428,6 +1479,10 @@ static int method_switch_root(sd_bus_message *message, void *userdata, sd_bus_er
         assert(message);
         assert(m);
 
+        r = mac_selinux_access_check(message, "reboot", error);
+        if (r < 0)
+                return r;
+
         if (statvfs("/run/systemd", &svfs) < 0)
                 return sd_bus_error_set_errnof(error, errno, "Failed to statvfs(/run/systemd): %m");
 
@@ -1441,10 +1496,6 @@ static int method_switch_root(sd_bus_message *message, void *userdata, sd_bus_er
                             format_bytes(fb_need, sizeof(fb_need), RELOAD_DISK_SPACE_MIN));
         }
 
-        r = mac_selinux_access_check(message, "reboot", error);
-        if (r < 0)
-                return r;
-
         if (!MANAGER_IS_SYSTEM(m))
                 return sd_bus_error_setf(error, SD_BUS_ERROR_NOT_SUPPORTED, "Root switching is only supported by system manager.");
 
@@ -1636,6 +1687,10 @@ static int method_lookup_dynamic_user_by_name(sd_bus_message *message, void *use
         assert(message);
         assert(m);
 
+        r = mac_selinux_access_check(message, "listdynusers", error);
+        if (r < 0)
+                return r;
+
         r = sd_bus_message_read_basic(message, 's', &name);
         if (r < 0)
                 return r;
@@ -1663,6 +1718,10 @@ static int method_lookup_dynamic_user_by_uid(sd_bus_message *message, void *user
         assert(message);
         assert(m);
 
+        r = mac_selinux_access_check(message, "listdynusers", error);
+        if (r < 0)
+                return r;
+
         assert_cc(sizeof(uid) == sizeof(uint32_t));
         r = sd_bus_message_read_basic(message, 'u', &uid);
         if (r < 0)
@@ -1692,6 +1751,10 @@ static int method_get_dynamic_users(sd_bus_message *message, void *userdata, sd_
         assert(message);
         assert(m);
 
+        r = mac_selinux_access_check(message, "listdynusers", error);
+        if (r < 0)
+                return r;
+
         assert_cc(sizeof(uid_t) == sizeof(uint32_t));
 
         if (!MANAGER_IS_SYSTEM(m))
@@ -2264,6 +2327,10 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
         assert(message);
         assert(m);
 
+        r = mac_selinux_access_check(message, "modify", error);
+        if (r < 0)
+                return r;
+
         r = bus_verify_manage_unit_files_async(m, message, error);
         if (r < 0)
                 return r;
@@ -2300,6 +2367,10 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
         char **p;
         int runtime, r;
 
+        r = mac_selinux_access_check(message, "status", error);
+        if (r < 0)
+                return r;
+
         r = sd_bus_message_read(message, "sb", &name, &runtime);
         if (r < 0)
                 return r;
@@ -2422,7 +2493,7 @@ const sd_bus_vtable bus_manager_vtable[] = {
         /* The following item is an obsolete alias */
         SD_BUS_WRITABLE_PROPERTY("ShutdownWatchdogUSec", "t", bus_property_get_usec, bus_property_set_usec, offsetof(Manager, reboot_watchdog), SD_BUS_VTABLE_HIDDEN),
         SD_BUS_WRITABLE_PROPERTY("KExecWatchdogUSec", "t", bus_property_get_usec, bus_property_set_usec, offsetof(Manager, kexec_watchdog), 0),
-        SD_BUS_WRITABLE_PROPERTY("ServiceWatchdogs", "b", bus_property_get_bool, bus_property_set_bool, offsetof(Manager, service_watchdogs), 0),
+        SD_BUS_WRITABLE_PROPERTY("ServiceWatchdogs", "b", bus_property_get_bool, bus_property_set_bool_wrapper, offsetof(Manager, service_watchdogs), 0),
         SD_BUS_PROPERTY("ControlGroup", "s", NULL, offsetof(Manager, cgroup_root), 0),
         SD_BUS_PROPERTY("SystemState", "s", property_get_system_state, 0, 0),
         SD_BUS_PROPERTY("ExitCode", "y", bus_property_get_unsigned, offsetof(Manager, return_value), 0),
diff --git a/src/core/dbus-unit.c b/src/core/dbus-unit.c
index 9477c47140..f86efaac3a 100644
--- a/src/core/dbus-unit.c
+++ b/src/core/dbus-unit.c
@@ -645,6 +645,10 @@ int bus_unit_method_unref(sd_bus_message *message, void *userdata, sd_bus_error
         assert(message);
         assert(u);
 
+        r = mac_selinux_unit_access_check(u, message, "modify", error);
+        if (r < 0)
+                return r;
+
         r = bus_unit_track_remove_sender(u, message);
         if (r == -EUNATCH)
                 return sd_bus_error_setf(error, BUS_ERROR_NOT_REFERENCED, "Unit has not been referenced yet.");
-- 
2.24.1

