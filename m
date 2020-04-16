Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE7C2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB57520732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMPnGoCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439129AbgDPPoc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395459AbgDPPo3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE0C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a22so1522160pjk.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3TwQUklf9Fn7jFTh/RI/uyTKJIg58Qu3phgEeCNtRs=;
        b=JMPnGoCZhXdBPbg2cCPSGr3RwoqBYff1a0jAeGVJnM4yIcqzrbRLtu33rTMSwGHEBm
         UEoazlnetHUGrPkRPGcv/iiMLUiAHW7b+wUQDFPZzHm2ZsSjkJpM3D7zYQL8XNfKtsG0
         fSUYftw/5L/j6NZL0EjkOQ6WO9bH6fHALtbV3fdpYN9prB6IYdKEaXStSzRsX/UydPHu
         AqguFkX0nheagoYImi7RchSj5zhFvA1keGmmu4YU4OKo9y5t/C3ZCuniRr8BYSvyysH2
         HHXvmQJmix++AwoBlW+zCXDiFOSU989Z8rvy3GdMSkpzNLpqSgrRvPahwgdWPwFsU8R9
         vugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B3TwQUklf9Fn7jFTh/RI/uyTKJIg58Qu3phgEeCNtRs=;
        b=UXBUbNlN6FROZGFnDSjApWooqAuyNNbPU9ihL3H0yy/g2fzuoDwUR2ef6P3LaBivTC
         M0dUxWvDqZOjXhc9N+dHlRDbwozzQtiQR3ud9CuHR+YcxhDjMZVtJgPtwqRAIra2+IMH
         LH7iSIEd1viBWk/1Ta2fmJLT8RqPrKIivfc9nju/coAXv1pFQQ+Uol1kL145GCPqc43U
         Ogc/PehwgjDBA0gq5kitmOGxUT1Rj/9HHE+kBVZpKVlycXBfaROmRauRccARSO8gclJ9
         1NxVVKbOVmBYYmLSHeyH3CKTQs7tg4pyM7w25RutdJ/z50swRoVwt9nMtUAnOu+kS+gD
         aGBg==
X-Gm-Message-State: AGi0PuZdHGlQ1vnJQxLuW21O8FRPdlZY7g67IKM1OpiWZyMpITB8qUEd
        VSKFBrsjlOC7j4wSxL7MoOI=
X-Google-Smtp-Source: APiQypKMhCluJ2u5d+ouagaDuzJDowPRJU7Ag1m8Nmk2Eg2RIEZnCL8IUEkIKbol7bS0OcfFlV6G1w==
X-Received: by 2002:a17:90a:a796:: with SMTP id f22mr5877840pjq.134.1587051868663;
        Thu, 16 Apr 2020 08:44:28 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:28 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 13/18] avc: create internal avc_init interface
Date:   Thu, 16 Apr 2020 10:43:47 -0500
Message-Id: <20200416154352.21619-14-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Now that avc_init is marked deprecated, create an avc_init2 interface
for internal users.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/avc.c          | 11 ++++++++++-
 libselinux/src/avc_internal.h |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index ab10b0f9f1cb..505641406995 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -157,7 +157,7 @@ int avc_open(struct selinux_opt *opts, unsigned nopts)
 			break;
 		}
 
-	return avc_init("avc", NULL, NULL, NULL, NULL);
+	return avc_init2("avc", NULL, NULL, NULL, NULL);
 }
 
 int avc_init(const char *prefix,
@@ -165,6 +165,15 @@ int avc_init(const char *prefix,
 	     const struct avc_log_callback *log_cb,
 	     const struct avc_thread_callback *thread_cb,
 	     const struct avc_lock_callback *lock_cb)
+{
+	return avc_init2(prefix, mem_cb, log_cb, thread_cb, lock_cb);
+}
+
+int avc_init2(const char *prefix,
+	     const struct avc_memory_callback *mem_cb,
+	     const struct avc_log_callback *log_cb,
+	     const struct avc_thread_callback *thread_cb,
+	     const struct avc_lock_callback *lock_cb)
 {
 	struct avc_node *new;
 	int i, rc = 0;
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 3f8a6bb1cf84..c8d26a8ae254 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -173,4 +173,9 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 /* netlink kernel message code */
 extern int avc_netlink_trouble ;
 
+extern int avc_init2(const char *msgprefix,
+		    const struct avc_memory_callback *mem_callbacks,
+		    const struct avc_log_callback *log_callbacks,
+		    const struct avc_thread_callback *thread_callbacks,
+		    const struct avc_lock_callback *lock_callbacks);
 #endif				/* _SELINUX_AVC_INTERNAL_H_ */
-- 
2.17.1

