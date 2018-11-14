Return-Path: <SRS0=eYI8=NZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A580C43441
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB49214F1
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="REunIoPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB49214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725757AbeKOFwE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:52:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34036 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Nov 2018 00:52:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so28016749qkg.1
        for <selinux@vger.kernel.org>; Wed, 14 Nov 2018 11:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fs3H5FnEHhrLGnLMBsK1Mu3o0uopefTDsw0csIy0mEU=;
        b=REunIoPDILraOCpuIe6pMRX8LH0ipt2BwFnWrlKn6dmJ2wSzgPorJb6f/O4CxbV+Gw
         JaFt5QAR+ve85oGg71OZ/jLaeKroIJFdp98JIugUnkx1IhHYiDbfw9LHVF7Sffu+853A
         VBptW80gOa8r7q78mlje2JVtx015CX4R575uZgal84/Cs1Oz+eJewnt7TeVRM59pKmVY
         Qk/tt8I+67YK4ciq5vT1/raGfeSETmi0Hoj+pKhDqh578wZmAtfkFOBbQW5PlN6i9lKb
         7yvWdDQEkOOyuIpAHYjP3YamUyW7hVh8N8q5uz/4yCS0/WFfIPnYvjOixCwNas9aobiu
         7stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=fs3H5FnEHhrLGnLMBsK1Mu3o0uopefTDsw0csIy0mEU=;
        b=b01mGG9t+IitCM2ntBoWUKP0V2w7Ch3Zrs9nVamj7TEutuLeTzPpkdA5lYYVxaUTgV
         DmO401I8qFgRx8vV+5AStRUUgMEio+uf6IkBrZsF9xL5/hpIvJAir+58jssqcsFhXw6C
         7iHAgxb+3BYcfkwB7SqyoztwZzHB9bLPC8IszQaWLSHPnsyl20a4CUKaIS59rSdQAhmM
         wqkdgYmgutHI+vH1lnWHsbqy7eTLPJzQsEPLZMNaFedYC/VhCRcPMV43bD8CI0vza7Sx
         Nh+Wbh72Ls9xXtNJlm+vbP4Duhqv8W6tP5Ijd3K6AEi7vTVL0OoKBj+2NvvGj791Sp43
         8unQ==
X-Gm-Message-State: AGRZ1gKgGvytG/KUd8Diy2pF/a5snwzNN/mPb0XPimmbt3QeQmDaFn2v
        cOtgg/oFOCteWI9+cc81R28Mks0sSg==
X-Google-Smtp-Source: AJdET5cbrRqvEaebEAsiI89VI2cB3Um7z9LO68YQkypegPzQytGxNCdwHUZ01G+ufC6697N8OLnXLw==
X-Received: by 2002:ad4:410c:: with SMTP id i12mr3211617qvp.219.1542224848256;
        Wed, 14 Nov 2018 11:47:28 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id o2sm14215390qko.97.2018.11.14.11.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:47:27 -0800 (PST)
Subject: [PATCH] selinux: fix non-MLS handling in mls_context_to_sid()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 14 Nov 2018 14:47:25 -0500
Message-ID: <154222484559.17938.2684528385878670936.stgit@chester>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 95ffe194204a ("selinux: refactor mls_context_to_sid() and make
it stricter") inadvertently changed how we handle labels that did not
contain MLS information.  This patch restores the proper behavior in
mls_context_to_sid() and adds a comment explaining the proper
behavior to help ensure this doesn't happen again.

Fixes: 95ffe194204a ("selinux: refactor mls_context_to_sid() and make it stricter")
Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/mls.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 2fe459df3c85..b7efa2296969 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -245,9 +245,13 @@ int mls_context_to_sid(struct policydb *pol,
 	char *rangep[2];
 
 	if (!pol->mls_enabled) {
-		if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
-			return 0;
-		return -EINVAL;
+		/*
+		 * With no MLS, only return -EINVAL if there is a MLS field
+		 * and it did not come from an xattr.
+		 */
+		if (oldc && def_sid == SECSID_NULL)
+			return -EINVAL;
+		return 0;
 	}
 
 	/*

