Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EADC2D0CD
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37F6227BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PpDWpQBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLRO2W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41175 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfLRO2W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so1797649eds.8
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PFTPzHa5ExaoydZJfe5HzohXyfYSfBAPI74npCCCRV0=;
        b=PpDWpQBiremPO+6OJT9mNghnxETGAlDhsh92qZPwNKAnprdQ70u/+30v3nDt3ZqRL8
         pEqyK3/KcjbjoRZpMMkIr1XzMceA/U2xJF66bJPlFb2olhaR4sZOb4MOd/sUwA6aXhIm
         FGp1ZdR2csgWkOalbnU2A/PIIUkR7rz8tUFicPIHYR76U7wc08UjLAQ7rxTX6mgVHYDB
         4e9oZuo80/yDxS7G6DfaibFLW5HfcIkhaL4mCis9Yf2NfUN1GQe5MMPNX6IpL43S6g1p
         m+4hiTgXUuAbHF9EG4x4avTEuYsyNCzy/bt7L1cVHoYLOx01w9CGIiMbqktV45ctV7mm
         bP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFTPzHa5ExaoydZJfe5HzohXyfYSfBAPI74npCCCRV0=;
        b=NoHUvG4RMA6wUKRuhYhpktQLtJx7QT7bnJLQivQHIjuvNoR/IieYMujY/mke2oByL4
         vLu0E1XhfYihOlsi7UUAov/mKGqF5Z/wpOUQOlm3RnLJzsERk6XUtExdf2itrLb6z6Ym
         1IYMjMKivaCwae/3UXOMoV5Jm1dqHbG0nNJnvd9MgcoG6b6/usS8bPkkKkn9NTSxCIrS
         K7l48qE6Auj57cu7QoSZqRVDhCzbyV95ZfdMl9h7la0ELJGCkyT3h121Z9Gr6ApYaQLn
         XdM18ogo0lMCTCM6Q3SRdXExrSJWcV5tBU4vjApAz/OdXM8HEzD+sdCjcBqY8okd0XZh
         3yxg==
X-Gm-Message-State: APjAAAX0bBKSvqftotbQgVdH9wUzz63ezeUQrRKvnxyo2GC20oRWA7Fj
        HyIuMlku2PqPINTlL2Lo2szM1X9c
X-Google-Smtp-Source: APXvYqzR7ZUPUvEiO5MDBXKZI3CWHfTO+munupxjc2roDcJlyJOZljpGJosrH4Sf7P0Vjk5fWOtTGg==
X-Received: by 2002:a50:9f4d:: with SMTP id b71mr2640075edf.179.1576679300369;
        Wed, 18 Dec 2019 06:28:20 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:19 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 5/8] core: make SELinux access permissions more distinct
Date:   Wed, 18 Dec 2019 15:28:05 +0100
Message-Id: <20191218142808.30433-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make access permissions more distinct by using the new introduced permission `modify`:

  - method_set_environment           : reload -> modify
  - method_unset_environment         : reload -> modify
  - method_unset_and_set_environment : reload -> modify
  - method_set_exit_code             : exit   -> modify
  - bus_unit_method_set_properties   : start  -> modify
  - bus_unit_method_ref              : start  -> modify
---
 src/core/dbus-manager.c | 8 ++++----
 src/core/dbus-unit.c    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
index d2db6e4a61..cd66871d48 100644
--- a/src/core/dbus-manager.c
+++ b/src/core/dbus-manager.c
@@ -1561,7 +1561,7 @@ static int method_set_environment(sd_bus_message *message, void *userdata, sd_bu
         assert(message);
         assert(m);
 
-        r = mac_selinux_access_check(message, "reload", error);
+        r = mac_selinux_access_check(message, "modify", error);
         if (r < 0)
                 return r;
 
@@ -1592,7 +1592,7 @@ static int method_unset_environment(sd_bus_message *message, void *userdata, sd_
         assert(message);
         assert(m);
 
-        r = mac_selinux_access_check(message, "reload", error);
+        r = mac_selinux_access_check(message, "modify", error);
         if (r < 0)
                 return r;
 
@@ -1624,7 +1624,7 @@ static int method_unset_and_set_environment(sd_bus_message *message, void *userd
         assert(message);
         assert(m);
 
-        r = mac_selinux_access_check(message, "reload", error);
+        r = mac_selinux_access_check(message, "modify", error);
         if (r < 0)
                 return r;
 
@@ -1662,7 +1662,7 @@ static int method_set_exit_code(sd_bus_message *message, void *userdata, sd_bus_
         assert(message);
         assert(m);
 
-        r = mac_selinux_access_check(message, "exit", error);
+        r = mac_selinux_access_check(message, "modify", error);
         if (r < 0)
                 return r;
 
diff --git a/src/core/dbus-unit.c b/src/core/dbus-unit.c
index f86efaac3a..37b5decf52 100644
--- a/src/core/dbus-unit.c
+++ b/src/core/dbus-unit.c
@@ -579,7 +579,7 @@ int bus_unit_method_set_properties(sd_bus_message *message, void *userdata, sd_b
         assert(message);
         assert(u);
 
-        r = mac_selinux_unit_access_check(u, message, "start", error);
+        r = mac_selinux_unit_access_check(u, message, "modify", error);
         if (r < 0)
                 return r;
 
@@ -614,7 +614,7 @@ int bus_unit_method_ref(sd_bus_message *message, void *userdata, sd_bus_error *e
         assert(message);
         assert(u);
 
-        r = mac_selinux_unit_access_check(u, message, "start", error);
+        r = mac_selinux_unit_access_check(u, message, "modify", error);
         if (r < 0)
                 return r;
 
-- 
2.24.1

