Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61309C54FD0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A412082E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM9u1JrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgDTPqN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgDTPqM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6163DC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so734731pfd.4
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3TwQUklf9Fn7jFTh/RI/uyTKJIg58Qu3phgEeCNtRs=;
        b=KM9u1JrVBZGNFliK+ud3/qCv8TPNV9XnGpPqCMNzQTdtpY+ENfZCgPVtFyjT2u3n92
         B/pzcL/Q/DhVMVdOuTtizedwfx1yoiBam/4IIJUpDywLVsIm+lO+udhTTwB3xQn3Xme2
         O8iEuNmaW3/wRmi2MUls+qUzDrJxodgTBgHrAAroPWmKXB1iFjO87rL2ArG9D5zmYGHN
         ovltwHoTT2LT3ZGEvk4x7X+v8L+r3UbgOjrJz5wL1pmAP0+wToBnJraRKpCrXk6lv5Zw
         eBcqjfJSIGzX+X2oux2mHC+pkh2BKRcR+XBNcbQ8VIMQLl8DJSMRdgp4/uOUe7msp51T
         hfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B3TwQUklf9Fn7jFTh/RI/uyTKJIg58Qu3phgEeCNtRs=;
        b=lfY7CrcreiNJjbWLOodTPF/rOiDEOpeMgfhp7HpAqnl3IsLK+b6FxUrzLt/DizzN/E
         K6At/2nZ6uqoqEkxGzytpwjP3y2g8lglB0xy+xXGOLWlQTuG8BlvNaf+R+Z5ZUG6C4yt
         P27rWyPxXxmstwFKWDyNEvbuavnPR7lKZvkhDHUhWU3Gv+bVX2uCrAhIILIPhWbsf+xO
         9/+c9WTlIVyGANAkOloU/vu1BxKfVSAa8d8AAq+hPnOhOMzZ7g+YasAmkMyE1ZRqDXji
         5QAyTgWwjcV3dOBfxP0e2gkqz3fbRzTipYOkxlwEQcS5xHRyWkZ2F/43MET7uh/Uga1v
         dOiw==
X-Gm-Message-State: AGi0PuaofOEUfMdMYV/g1C3z8cVTTIZAN+3OqQYDfb5OwUaoOHcsJUyn
        Zx2zg0fMAsgGPPsr8sPKROY=
X-Google-Smtp-Source: APiQypKpsRrPrjmMDsk/gR9jnRbq6Mqrc59MupsuITRbasecne2aJAT+pK/dMSmztatyS4A7HNNFEQ==
X-Received: by 2002:a63:1c50:: with SMTP id c16mr16909467pgm.255.1587397571875;
        Mon, 20 Apr 2020 08:46:11 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:11 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 13/19] avc: create internal avc_init interface
Date:   Mon, 20 Apr 2020 10:45:31 -0500
Message-Id: <20200420154537.30879-14-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
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

