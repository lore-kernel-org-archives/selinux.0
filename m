Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3CEC2D0C3
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633F9218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nz8yXoI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLRO2Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46699 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfLRO2Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so1782738edi.13
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j5AMi00ikqquEUsGSw0RdDNar4ei548oAVjXgUD8JZE=;
        b=Nz8yXoI71e+3jo3GrcLzz7JZognPSFmCQtrb+qLvVeeRWI9tfWUy/uzsr3YaGk62w5
         KsrXe5S9eRyBhWs672WTSVpfiKDsMB9G1Ov5CpIWGAcf9INNlNp421H2Vw/YDZhRTbAY
         htsDkm+EvJvYCXoJUdSrGjBlP6pGz9PR+lSY+IOTQR1y47dQD7JbcO5lRvySHM7bDjoJ
         WJI6dQnBA6QgB1xZqVGkBmw8h4cbqIfJGaeosC/cM3mGdh3X9B6nw2HwdRciZ08GUzpI
         KTBV9oIiG2SkMX4A0aQ7JcZiNzpa3iugVSHybjYICwtFV74KGVNY507t3RUWK9TUxOAo
         9ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5AMi00ikqquEUsGSw0RdDNar4ei548oAVjXgUD8JZE=;
        b=QD28zEm+J8dpIPL/YnV6ylfukNLqxiH78KZWsqnP6t2z5g6Uqv/MigMaUFL51ozgTJ
         1pYec1+kmqIbIDau5CZJPzTP/I4JfMdmwNI8mJFbRl/nCoX7zxSb71czC3dUsYDnKVSP
         u3xPSGHBtHuMsHdaiGx+F8LGKmqOe8H30EhxfjZwdFmHvVtNW3a1wq1Tv/XOr4K16qzQ
         y2ByPnz9TNeEiLtZDwcvvW7kudpyjAclY1kCwGppcudzvdie2LrpEftXpgj/1/0VV4Jy
         lkcaM2oiQtJ8tgzNtKhe371jcTAPYudjVzOIIu8HeQWVE/8EhZtGEzO4i9VgJceHcyrv
         IaLA==
X-Gm-Message-State: APjAAAV+s7MYOyw2gkeJpqv7q4cvSffE+3Iake4edeP1LAOgB59h/eSD
        HPcGWkZXgdHjuymUcHgAP/GSDg9p
X-Google-Smtp-Source: APXvYqywJGYcD1nT2Y1Y5r6/DdmpM2v91ZiZEdZZ6VqbtNqavmozuoLQJQaudBujmV45uayWZb45sQ==
X-Received: by 2002:a05:6402:2052:: with SMTP id bc18mr2644404edb.161.1576679302358;
        Wed, 18 Dec 2019 06:28:22 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:21 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 8/8] core: add notes to D-Bus interfaces about adding SELinux checks
Date:   Wed, 18 Dec 2019 15:28:08 +0100
Message-Id: <20191218142808.30433-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 src/core/dbus-automount.c | 3 +++
 src/core/dbus-cgroup.c    | 3 +++
 src/core/dbus-device.c    | 3 +++
 src/core/dbus-execute.c   | 3 +++
 src/core/dbus-job.c       | 3 +++
 src/core/dbus-kill.c      | 3 +++
 src/core/dbus-manager.c   | 3 +++
 src/core/dbus-mount.c     | 3 +++
 src/core/dbus-path.c      | 3 +++
 src/core/dbus-scope.c     | 3 +++
 src/core/dbus-service.c   | 3 +++
 src/core/dbus-slice.c     | 3 +++
 src/core/dbus-socket.c    | 3 +++
 src/core/dbus-swap.c      | 3 +++
 src/core/dbus-target.c    | 3 +++
 src/core/dbus-timer.c     | 3 +++
 src/core/dbus-unit.c      | 6 ++++++
 17 files changed, 54 insertions(+)

diff --git a/src/core/dbus-automount.c b/src/core/dbus-automount.c
index bd6e6a9dde..129ef98df1 100644
--- a/src/core/dbus-automount.c
+++ b/src/core/dbus-automount.c
@@ -8,6 +8,9 @@
 
 static BUS_DEFINE_PROPERTY_GET_ENUM(property_get_result, automount_result, AutomountResult);
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_automount_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Where", "s", NULL, offsetof(Automount, where), SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-cgroup.c b/src/core/dbus-cgroup.c
index 27dc9e43c3..ad277e94c9 100644
--- a/src/core/dbus-cgroup.c
+++ b/src/core/dbus-cgroup.c
@@ -344,6 +344,9 @@ static int property_get_ip_address_access(
         return sd_bus_message_close_container(reply);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_cgroup_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Delegate", "b", bus_property_get_bool, offsetof(CGroupContext, delegate), 0),
diff --git a/src/core/dbus-device.c b/src/core/dbus-device.c
index 6cf7f58e02..c2566c274b 100644
--- a/src/core/dbus-device.c
+++ b/src/core/dbus-device.c
@@ -4,6 +4,9 @@
 #include "device.h"
 #include "unit.h"
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_device_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("SysFSPath", "s", NULL, offsetof(Device, sysfs), SD_BUS_VTABLE_PROPERTY_EMITS_CHANGE),
diff --git a/src/core/dbus-execute.c b/src/core/dbus-execute.c
index 1d0bc1ede3..67bc91c3c6 100644
--- a/src/core/dbus-execute.c
+++ b/src/core/dbus-execute.c
@@ -692,6 +692,9 @@ static int property_get_log_extra_fields(
         return sd_bus_message_close_container(reply);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_exec_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Environment", "as", NULL, offsetof(ExecContext, environment), SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-job.c b/src/core/dbus-job.c
index 7b0b093757..ca531570ba 100644
--- a/src/core/dbus-job.c
+++ b/src/core/dbus-job.c
@@ -119,6 +119,9 @@ int bus_job_method_get_waiting_jobs(sd_bus_message *message, void *userdata, sd_
         return sd_bus_send(NULL, reply, NULL);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_job_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_METHOD("Cancel", NULL, NULL, bus_job_method_cancel, SD_BUS_VTABLE_UNPRIVILEGED),
diff --git a/src/core/dbus-kill.c b/src/core/dbus-kill.c
index 30597e86f0..e7d0d2b16c 100644
--- a/src/core/dbus-kill.c
+++ b/src/core/dbus-kill.c
@@ -25,6 +25,9 @@ static int property_get_restart_kill_signal(
         return sd_bus_message_append_basic(reply, 'i', &s);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_kill_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("KillMode", "s", property_get_kill_mode, offsetof(KillContext, kill_mode), SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index 14085ba1a1..721ebeeaa8 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -2476,6 +2476,9 @@ static int method_abandon_scope(sd_bus_message *message, void *userdata, sd_bus_
         return bus_scope_method_abandon(message, u, error);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_manager_vtable[] = {
         SD_BUS_VTABLE_START(0),
 
diff --git a/src/core/dbus-mount.c b/src/core/dbus-mount.c
index b6d61627eb..1fface5532 100644
--- a/src/core/dbus-mount.c
+++ b/src/core/dbus-mount.c
@@ -39,6 +39,9 @@ static BUS_DEFINE_PROPERTY_GET(property_get_options, "s", Mount, mount_get_optio
 static BUS_DEFINE_PROPERTY_GET(property_get_type, "s", Mount, mount_get_fstype);
 static BUS_DEFINE_PROPERTY_GET_ENUM(property_get_result, mount_result, MountResult);
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_mount_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Where", "s", NULL, offsetof(Mount, where), SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-path.c b/src/core/dbus-path.c
index 1a97d62486..9f53c4bd1e 100644
--- a/src/core/dbus-path.c
+++ b/src/core/dbus-path.c
@@ -42,6 +42,9 @@ static int property_get_paths(
         return sd_bus_message_close_container(reply);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_path_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Unit", "s", bus_property_get_triggered_unit, 0, SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-scope.c b/src/core/dbus-scope.c
index 84d91dcfa3..740a09874d 100644
--- a/src/core/dbus-scope.c
+++ b/src/core/dbus-scope.c
@@ -42,6 +42,9 @@ int bus_scope_method_abandon(sd_bus_message *message, void *userdata, sd_bus_err
 
 static BUS_DEFINE_PROPERTY_GET_ENUM(property_get_result, scope_result, ScopeResult);
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_scope_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Controller", "s", NULL, offsetof(Scope, controller), SD_BUS_VTABLE_PROPERTY_EMITS_CHANGE),
diff --git a/src/core/dbus-service.c b/src/core/dbus-service.c
index 5cf9b21890..ef912577ab 100644
--- a/src/core/dbus-service.c
+++ b/src/core/dbus-service.c
@@ -91,6 +91,9 @@ static int property_get_exit_status_set(
         return sd_bus_message_close_container(reply);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_service_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Type", "s", property_get_type, offsetof(Service, type), SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-slice.c b/src/core/dbus-slice.c
index effd5fa5d7..db49933ae3 100644
--- a/src/core/dbus-slice.c
+++ b/src/core/dbus-slice.c
@@ -5,6 +5,9 @@
 #include "slice.h"
 #include "unit.h"
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_slice_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_VTABLE_END
diff --git a/src/core/dbus-socket.c b/src/core/dbus-socket.c
index 25d3d71391..15ba47091d 100644
--- a/src/core/dbus-socket.c
+++ b/src/core/dbus-socket.c
@@ -74,6 +74,9 @@ static int property_get_listen(
         return sd_bus_message_close_container(reply);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_socket_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("BindIPv6Only", "s", property_get_bind_ipv6_only, offsetof(Socket, bind_ipv6_only), SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-swap.c b/src/core/dbus-swap.c
index 353fa20132..de4a0b0e55 100644
--- a/src/core/dbus-swap.c
+++ b/src/core/dbus-swap.c
@@ -29,6 +29,9 @@ static BUS_DEFINE_PROPERTY_GET(property_get_priority, "i", Swap, swap_get_priori
 static BUS_DEFINE_PROPERTY_GET(property_get_options, "s", Swap, swap_get_options);
 static BUS_DEFINE_PROPERTY_GET_ENUM(property_get_result, swap_result, SwapResult);
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_swap_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("What", "s", NULL, offsetof(Swap, what), SD_BUS_VTABLE_PROPERTY_EMITS_CHANGE),
diff --git a/src/core/dbus-target.c b/src/core/dbus-target.c
index ba50113641..7c61f7d6fd 100644
--- a/src/core/dbus-target.c
+++ b/src/core/dbus-target.c
@@ -3,6 +3,9 @@
 #include "dbus-target.h"
 #include "unit.h"
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_target_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_VTABLE_END
diff --git a/src/core/dbus-timer.c b/src/core/dbus-timer.c
index 439c276fac..354336e4a3 100644
--- a/src/core/dbus-timer.c
+++ b/src/core/dbus-timer.c
@@ -118,6 +118,9 @@ static int property_get_next_elapse_monotonic(
                                                                  TIMER_MONOTONIC_CLOCK(t), CLOCK_MONOTONIC));
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_timer_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Unit", "s", bus_property_get_triggered_unit, 0, SD_BUS_VTABLE_PROPERTY_CONST),
diff --git a/src/core/dbus-unit.c b/src/core/dbus-unit.c
index 37b5decf52..184405d8be 100644
--- a/src/core/dbus-unit.c
+++ b/src/core/dbus-unit.c
@@ -764,6 +764,9 @@ static int property_get_refs(
         return sd_bus_message_close_container(reply);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_unit_vtable[] = {
         SD_BUS_VTABLE_START(0),
 
@@ -1350,6 +1353,9 @@ int bus_unit_method_attach_processes(sd_bus_message *message, void *userdata, sd
         return sd_bus_reply_method_return(message, NULL);
 }
 
+/* Note: when adding a SD_BUS_WRITABLE_PROPERTY or SD_BUS_METHOD add a TODO(selinux),
+ *       so the SELinux people can add a permission check.
+ */
 const sd_bus_vtable bus_unit_cgroup_vtable[] = {
         SD_BUS_VTABLE_START(0),
         SD_BUS_PROPERTY("Slice", "s", property_get_slice, 0, 0),
-- 
2.24.1

