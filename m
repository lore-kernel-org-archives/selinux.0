Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD7C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKIURI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIURI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 15:17:08 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169671DDF0
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 12:17:07 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so49869971ejb.13
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLrJXNies1OMkhS7mkXVpGV5r+jrAqkJ7FvNdmw/a2I=;
        b=FX8ai4Ypp4mgWjkG7Xz2LDvqmYbQpXmpRIo1n5HTQq96s1Cg3TTpD+dFcPW79sc9pz
         eBvYIMZN7RjXP7XaBXsqc3FNYQzumpo4xYBsBKEdpouRqRqQUSvTPYhdpyzKdJzQ9ZQE
         uq/1Ovn1zKsS4OxD3+llIYx8kTAqj0qzfJaNQT/dKlQBEyJlJNomOzl30oi4EQI3M76I
         NcKp0KeMSsvkurTvyZ8InWQwW/rhaLKe6HT//WqKMIEWRmdgNC66WxMCQm6ni8VGl0Ug
         eyilCUuuedhppGYRyCMAjsdy1VC2m+yHiV4liz2b+V6rUYVCPXRwdqU9G3pFDXLCVSm+
         dKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLrJXNies1OMkhS7mkXVpGV5r+jrAqkJ7FvNdmw/a2I=;
        b=GC2Dnhx3zPuSZBVMgib9i1PMfwk3Q/svJETVAUoma/7ng1Ahk367VhLYbrpDvfVtJw
         o7AxusepJwRGWb6gvMSQ2dltnq73L4s3LiqDCeoWE8M4aJYfeWLJvogp2pJOiVcbYOH8
         GCibP+cSOdfwgJFiCjLn3cMEo/r2KFLmlO0HA/wZbEPR4xSdHzlJG0WXquUMeThEuB38
         d3L+kdy71G2hN0jfmXzsKgNDcTZJm5mDhjVwcTsidHoNeKz/1z5AZqStHb27huuiRzwr
         WxNyQgOM0EeYRM17V6JeyrqC9ueVrsmt86UN9+3q2FZM+cHC6U7vgHqAvFcIatXouRhH
         ERYg==
X-Gm-Message-State: ANoB5pkikuN6MV1rTO++wdecjar5O2ZSB8CHDq997yIqevrbUDFwPL1W
        o2NbTQCG9/D2kDrrk/p1GtEl+H6Up0g=
X-Google-Smtp-Source: AMsMyM6QGh9oNRrmp6hTY6Fw07QhMm+0Ke9Den/oMMIAw3LyW29I7XtaDjJ8YSeev2NHFLFxtK496A==
X-Received: by 2002:a17:907:7b8a:b0:7ae:3957:f4e1 with SMTP id ne10-20020a1709077b8a00b007ae3957f4e1mr26371953ejc.720.1668025025575;
        Wed, 09 Nov 2022 12:17:05 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7d751000000b00458898fe90asm7442068eds.5.2022.11.09.12.17.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:17:05 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: drop set but not used internal variable
Date:   Wed,  9 Nov 2022 21:17:01 +0100
Message-Id: <20221109201701.64203-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The internal variable avc_netlink_trouble is only assigned but never
read from.
Unused since the initial commit 13cd4c896068 ("initial import from svn
trunk revision 2950").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_internal.c | 2 --
 libselinux/src/avc_internal.h | 3 ---
 libselinux/src/sestatus.c     | 1 -
 3 files changed, 6 deletions(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 71a1357b..ffc663e5 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -51,7 +51,6 @@ char avc_prefix[AVC_PREFIX_SIZE] = "uavc";
 int avc_running = 0;
 int avc_enforcing = 1;
 int avc_setenforce = 0;
-int avc_netlink_trouble = 0;
 
 /* process setenforce events for netlink and sestatus */
 int avc_process_setenforce(int enforcing)
@@ -295,7 +294,6 @@ void avc_netlink_loop(void)
 
 	close(fd);
 	fd = -1;
-	avc_netlink_trouble = 1;
 	avc_log(SELINUX_ERROR,
 		"%s:  netlink thread: errors encountered, terminating\n",
 		avc_prefix);
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index a9a4aa0b..54f0ce28 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -180,7 +180,4 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 			 security_class_t tclass, access_vector_t perms,
 			 uint32_t seqno, uint32_t enable) ;
 
-/* netlink kernel message code */
-extern int avc_netlink_trouble ;
-
 #endif				/* _SELINUX_AVC_INTERNAL_H_ */
diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 89c1f621..fbe64301 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -343,7 +343,6 @@ error:
 		if (avc_using_threads)
 		{
 			fallback_netlink_thread = avc_create_thread(&avc_netlink_loop);
-			avc_netlink_trouble = 0;
 		}
 
 		fallback_sequence = 0;
-- 
2.38.1

