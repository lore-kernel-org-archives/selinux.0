Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12658C00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHHRen (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHRel (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:34:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0692DBC82
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:34:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so17872566ejc.7
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=mvE7miV0rZOKCXG+j+WsmIDnz4Fmn44tA0PfnpSsc04=;
        b=HaAM1UL+mUkYT6SHvxHnxd3TvOIq3N6KIctlyCB/SIE+24xG5slw+Dv7fTsKMGXp+9
         gUoUIQMXAr24S1vUlPtQaTP47gio0H7a65jC/Sy/2a3yGPdEiLlfXNMv5losbueLIEP8
         KlvSg3JhYlFokpmueZL3G8JzLUBjcmLc3J4RXt+tBtCRPFbQkWL5JLbYH+Y9PFJi8DL8
         pC7QZSj9Zep0zvg33/SxwBv5HP1JCOcMivMKOcYQnkb0EFUmiv5bpR/d34vk3IWMuNez
         rQncIcdiFAAcstWbfkJQFSP6m3LZUZPQUg+duTq4e+B2KSGQS1wjExJOXu3YR9qQon/O
         hZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=mvE7miV0rZOKCXG+j+WsmIDnz4Fmn44tA0PfnpSsc04=;
        b=eaAFS3riRiUb15uHBmwbVJklFJYMNHPpKNEX1YdPSSuwK28Tg9srYWzPi4SD2S2plD
         v8Lw2xICWmENl6O+ew/KpviOFc1XwWvUnrNvaqmqWOT1fjfO5zQnX8rQtqWMkGy3xM/z
         6T97PkWhhSEM6l1KvzWnNvlPBTTwho24bGgLNbxuwdIKJs2a24MrE55/YPBwBYldwn+q
         UawIIF6RBQWVtgmpPYmaENSixvnX5982FMMav0OcCKTRMWoHGjGiYc0KxK4ChnKfGPm0
         D8O7Kpe+5oGjQLldYJomzQwqL1bxZdNLrSJk2Uz0TvJA7yvm/YbhPY5WGK0sPyMt3pXP
         yaYQ==
X-Gm-Message-State: ACgBeo3B0TH+RmKVpvgGKCmM51IK9rt7p4YBXHgRVn2IUtc4lWX+qygD
        EC1BHCQ8HAr44m49zldv6s/spxKjfHU=
X-Google-Smtp-Source: AA6agR71WFxjEzlJ5L/LaIfSeozZ20mL5Sx/NNI0/KZYzv39I8v6fGHq8nC4aSW/2dGF47SISH4h9w==
X-Received: by 2002:a17:907:a068:b0:731:366a:6005 with SMTP id ia8-20020a170907a06800b00731366a6005mr7390927ejc.344.1659980076520;
        Mon, 08 Aug 2022 10:34:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id l1-20020a170906078100b00730ba005b39sm87205ejc.132.2022.08.08.10.34.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:34:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: avoid newline in avc message
Date:   Mon,  8 Aug 2022 19:34:29 +0200
Message-Id: <20220808173429.16318-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not add a final newline to the avc log message as it will be treated
as a part of the tclass field in final audit record:

    {
        "AUDIT_FIELD_EXE" : "/usr/bin/dbus-broker",
        "_UID" : "104",
        "_AUDIT_SESSION" : "4294967295",
        "_TRANSPORT" : "audit",
        "__REALTIME_TIMESTAMP" : "1659975331468531",
        "_AUDIT_TYPE" : "1107",
        "AUDIT_FIELD_SCONTEXT" : "system_u:system_r:systemd_t:s0",
        "_AUDIT_LOGINUID" : "4294967295",
        "_SELINUX_CONTEXT" : "system_u:system_r:system_dbusd_t:s0-s0:c0.c1023",
        "AUDIT_FIELD_SAUID" : "104",
        "MESSAGE" : "USER_AVC pid=1538 uid=104 auid=4294967295 ses=4294967295 subj=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 msg='avc:  granted  { send_msg } for  scontext=system_u:system_r:systemd_t:s0 tcontext=system_u:system_r:systemd_logind_t:s0 tclass=dbus\n exe=\"/usr/bin/dbus-broker\" sauid=104 hostname=? addr=? terminal=?'",
        "AUDIT_FIELD_TCONTEXT" : "system_u:system_r:systemd_logind_t:s0",
        "_SOURCE_REALTIME_TIMESTAMP" : "1659975331462000",
        "__MONOTONIC_TIMESTAMP" : "207995768",
        "AUDIT_FIELD_TCLASS" : "dbus\n",
        "AUDIT_FIELD_TERMINAL" : "?",
        "_PID" : "1538",
        "SYSLOG_FACILITY" : "4",
        "_BOOT_ID" : "3921464b65f64fb4a7c037dee97cd6ad",
        "SYSLOG_IDENTIFIER" : "audit",
        "_MACHINE_ID" : "5d78c28f10d54c0fb7b6fd1acc6af8ff",
        "_AUDIT_TYPE_NAME" : "USER_AVC",
        "__CURSOR" : "s=84589ce96ff8400189fc515ff892674a;i=c38e;b=3921464b65f64fb4a7c037dee97cd6ad;m=c65c378;t=5e5bd1ff7d4f3;x=c22e610fc9b00b10",
        "AUDIT_FIELD_ADDR" : "?",
        "AUDIT_FIELD_HOSTNAME" : "?",
        "_AUDIT_ID" : "1075",
        "_HOSTNAME" : "debianBullseye"
    }

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 7493e4b2..8d5983a2 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -725,7 +725,6 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
 	if (denied)
 		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
 
-	log_append(avc_audit_buf, "\n");
 	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
 
 	avc_release_lock(avc_log_lock);
-- 
2.36.1

