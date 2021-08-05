Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DAC4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D8B60F25
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbhHEO0j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbhHEO0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023CC061798
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id e19so9882919ejs.9
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fVul56w0w/09wFHQU8+GgrAPFPp0mQE4tVBUTeDj6cI=;
        b=dPHSAdvJ0S3BARRLNNv6t7Dyq3FlxAfQy7uoznVMmSLodlYbT+S0oW0s7dVHB6rG/v
         9lPdSKAKGM4bv+hp49gUDhH3n+GfbmHhfjqId9RyA5Q9RBJ/JUWHcHMIcavJZOcSqD70
         2ekA93e1ln3YI02O0pUvBtQEfiXU4nEwA1kg8w7Fm+pzABI+96nnhfMZzApoOudVj4D2
         KY9g2kvpBHYpzo6pguhJQcM4Hp2ZHZMbk1hF4qZu3+J2KbcRDXumArf+CM79WHdwTW4X
         MvsSKTUUig6tzOdoeuNmn5xLicmn7eoIsCHuoFb8MLVj6FH85cMsdc1zsL49FdA4Ilx0
         HI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVul56w0w/09wFHQU8+GgrAPFPp0mQE4tVBUTeDj6cI=;
        b=ORX5mQyp9qjsyIShnZ6rZliIWmct0YZF5x1nlcC/k5mO2DQ6PygcVdM081z1Ytjyys
         emFMKvHUQjw5N0SHsCiAiTAhKupGh/jvp4Vgy/o/H0jNZPrrp6ANCu6CTlZb4JC1SBTS
         nRiM+KlIy7bDZx7A7jmaMBdlcLMFGUk+3ja4qGO1FaVCkMAKWobuo8NDJ/1IorgFnZ0q
         JkG4U+LWpo65LAIpHcTPBbRX2XPMOTrWShWDNzKsO8AiVpE7hQxYqfs4dt2pGXtEK0Ud
         Al11/P9SPmTh7lRrMLPNIE8Qzi/FCSz4ZG+YC7w1ZFcC9HFt14lJsTlkRNW3NYpATQu6
         QjMw==
X-Gm-Message-State: AOAM530RIGBZHdfq+/2rD2Lrrd82zDTwL53GHD2zDDpUe7i0QhrqKfxk
        Xl8qwfHtD4JoCrIDalKKhctwl+GtfKM=
X-Google-Smtp-Source: ABdhPJycbm3kuphUDTuVJ7lLhqReKEP98kEJmMKTI9vgEAvSHh7Ny2NaRKepoWMWHk5q4aBCHq7NWQ==
X-Received: by 2002:a17:906:840f:: with SMTP id n15mr5240629ejx.334.1628173578575;
        Thu, 05 Aug 2021 07:26:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 6/7] core: avoid bypasses in D-BUS SELinux filter
Date:   Thu,  5 Aug 2021 16:24:44 +0200
Message-Id: <20210805142445.61725-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not allow access if D-Bus credentials are unavailable.
Perform system check if job or unit not found.
---
 src/core/dbus.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/src/core/dbus.c b/src/core/dbus.c
index f876433c00..576dfa0b11 100644
--- a/src/core/dbus.c
+++ b/src/core/dbus.c
@@ -214,13 +214,12 @@ static int mac_selinux_filter(sd_bus_message *message, void *userdata, sd_bus_er
         Manager *m = userdata;
         const char *verb, *path;
         Unit *u = NULL;
-        Job *j;
         int r;
 
         assert(message);
 
         /* Our own method calls are all protected individually with
-         * selinux checks, but the built-in interfaces need to be
+         * SELinux checks, but the built-in interfaces need to be
          * protected too. */
 
         if (sd_bus_message_is_method_call(message, "org.freedesktop.DBus.Properties", "Set"))
@@ -235,42 +234,37 @@ static int mac_selinux_filter(sd_bus_message *message, void *userdata, sd_bus_er
 
         path = sd_bus_message_get_path(message);
 
-        if (object_path_startswith("/org/freedesktop/systemd1", path)) {
-                r = mac_selinux_access_check(message, verb, error);
-                if (r < 0)
-                        return r;
+        if (streq_ptr(path, "/org/freedesktop/systemd1"))
+                return mac_selinux_access_check(message, verb, error);
 
-                return 0;
-        }
-
-        if (streq_ptr(path, "/org/freedesktop/systemd1/unit/self")) {
+        if (object_path_startswith(path, "/org/freedesktop/systemd1/job")) {
+                Job *j;
+                r = manager_get_job_from_dbus_path(m, path, &j);
+                if (r >= 0)
+                        u = j->unit;
+        } else if (streq_ptr(path, "/org/freedesktop/systemd1/unit/self")) {
                 _cleanup_(sd_bus_creds_unrefp) sd_bus_creds *creds = NULL;
                 pid_t pid;
 
                 r = sd_bus_query_sender_creds(message, SD_BUS_CREDS_PID, &creds);
                 if (r < 0)
-                        return 0;
+                        return r;
 
                 r = sd_bus_creds_get_pid(creds, &pid);
                 if (r < 0)
-                        return 0;
+                        return r;
 
                 u = manager_get_unit_by_pid(m, pid);
-        } else {
-                r = manager_get_job_from_dbus_path(m, path, &j);
-                if (r >= 0)
-                        u = j->unit;
-                else
-                        manager_load_unit_from_dbus_path(m, path, NULL, &u);
-        }
-        if (!u)
-                return 0;
+        } else if (object_path_startswith(path, "/org/freedesktop/systemd1/unit")) {
+                manager_load_unit_from_dbus_path(m, path, NULL, &u);
+        } else
+                log_warning("Unexpected object path '%s' in SELinux D-Bus filter", path);
 
-        r = mac_selinux_unit_access_check(u, message, verb, error);
-        if (r < 0)
-                return r;
+        if (!u)
+                /* Fall back to main instance check, e.g. if job or unit not found. */
+                return mac_selinux_access_check(message, verb, error);
 
-        return 0;
+        return mac_selinux_unit_access_check(u, message, verb, error);
 }
 #endif
 
-- 
2.32.0

