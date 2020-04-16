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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A5DC352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAB9214AF
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwkCsiUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406241AbgDPPof (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442510AbgDPPoc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FDCC061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a22so1522216pjk.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThytxPAXFKfJwqL1E34wdemZ6YzRL2kXegLVFr+oRIk=;
        b=jwkCsiUlganqK8GCKG+pL9/jRBE6K1xbyHxTlyMK27hhx+3PCtBgayKEMufmTuPF1q
         XtDIL/RZK/yrb7HRG5h/LUwO/lEInIzLvtNM0IAID4LYKM7kqblYY1KWSngs9Vo7jJhL
         lO4TKvCSO2yTRi1J1toesy0+JW4/u4pPmxIOlAfdJxmfzxCEbEuHHBAaIZ3bzf+PmdC2
         dbxY0HBhtPv33GZBNTP4fQ05wXWrFc+Aa0KabqaKH2l0WeOftJpJtuEIyEFfItA72vD0
         i3tMeIWSZgKbUq4nsM3NtQUosxRPK5U5E+i94FpL4j069bpzJYluNYa2wZ0QlumtvPLF
         MuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ThytxPAXFKfJwqL1E34wdemZ6YzRL2kXegLVFr+oRIk=;
        b=Aa5DOPPATYzSCi+TKJMpelJCELU5jIF42T5MmkEdwtNDwRTZmwdMl+HQ7j/bUnVzWe
         ScOhxeHWkc97k1akDDjDe7GbnNq1SoaCiDdr4cUsBpJWrGVwUcqyIdljJv0xBaKUDCQz
         lz19xz29UhQKeyPx1xEt324IpI/c9qOfoNMJbOhXz7ySgWa3SvvsxNwNUC6TAK4QeOX8
         70XZAyUYC5R5bR/TvM05zhAbASYwjkVq/o7o1J7GiZcDjYJfKPrUSruDV9D//OjjU45y
         e0FVoqH9b43aQnS52JaMsIN2hfruY+6Tv/h+1s2QW6PMxPofTs48gychiNKztBqSxqYn
         xwDA==
X-Gm-Message-State: AGi0PubuKP1S15+5hAzdohapMprmXiKQiqgdBAASRXdJPl256FgFg9jL
        UU7loFAEPspI2UMm8cmsDdxAmE+t1Hs=
X-Google-Smtp-Source: APiQypJSHAodTtdRDwSAGialKRZmTOBVJDFbtlvvag+pFRUl4GWOU7O7bdgP3EHEBF5+H3goqFsnwg==
X-Received: by 2002:a17:90b:190c:: with SMTP id mp12mr6014816pjb.109.1587051871825;
        Thu, 16 Apr 2020 08:44:31 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:31 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 15/18] matchpathcon: create internal matchpathcon interface
Date:   Thu, 16 Apr 2020 10:43:49 -0500
Message-Id: <20200416154352.21619-16-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Now that matchpathcon is marked deprecated, create an
matchpathcon2 interface for internal users.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/matchpathcon.c          | 8 ++++++--
 libselinux/src/matchpathcon_internal.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 8515c88c2bb8..88539e627f5d 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -433,7 +433,11 @@ out:
 	return rc;
 }
 
-int matchpathcon(const char *path, mode_t mode, char ** con)
+int matchpathcon(const char *path, mode_t mode, char ** con) {
+	return matchpathcon2(path, mode, con);
+}
+
+int matchpathcon2(const char *path, mode_t mode, char ** con)
 {
 	char stackpath[PATH_MAX + 1];
 	char *p = NULL;
@@ -456,7 +460,7 @@ int matchpathcon(const char *path, mode_t mode, char ** con)
 
 int matchpathcon_index(const char *name, mode_t mode, char ** con)
 {
-	int i = matchpathcon(name, mode, con);
+	int i = matchpathcon2(name, mode, con);
 
 	if (i < 0)
 		return -1;
diff --git a/libselinux/src/matchpathcon_internal.h b/libselinux/src/matchpathcon_internal.h
index 3affa687327f..c63bcecfec89 100644
--- a/libselinux/src/matchpathcon_internal.h
+++ b/libselinux/src/matchpathcon_internal.h
@@ -3,4 +3,6 @@
 
 void matchpathcon_fini2(void);
 
+int matchpathcon2(const char *path, mode_t mode, char ** con);
+
 #endif
-- 
2.17.1

