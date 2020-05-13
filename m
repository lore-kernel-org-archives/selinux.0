Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC3C433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0FB205CB
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 18:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGlgeiA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgEMSqT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387462AbgEMSqS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 14:46:18 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B3C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 11:46:18 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ee19so400908qvb.11
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=ArXJ+7JaXqoHGSSyaadeXHmGqapORyMhmi6nPwisVgI=;
        b=IGlgeiA32uT+9caIjnkPQDorrrmr58NUcjBEyx27nXYt3rK3kUe3ffw35YZFJUKhul
         6jt3cPQrWct42OVDM4/pJBH8ixm9i/KkDgsabfcQmgbpP/DMDMZY7pSHTssayM/GXZPs
         me/JEald6eo1Ka+o/PKt8xkuSlNsZHOn/0K1/bt756bjUgfrDSIA1AhWFESFCQsfU3RQ
         KfgFaKfBFOvTnFrShaBz/UR4+DqanPUcwYrAx8svSyGeqh56atlrGLNMGQMew4ZG/RpF
         4AAvHV2hbpLqHGl/uoiv9hVsLcPRKbj1vNeAjI4fjuY2hzzAEi7n6THxw+n4ZvwT2956
         URfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=ArXJ+7JaXqoHGSSyaadeXHmGqapORyMhmi6nPwisVgI=;
        b=cHLDTT/hz2ec8SncZNehc92aywGdxrqnqfiXykCH0PGToPap8guacByHHePsH7IhbK
         3V+va5Y1Zsb37QkoU2dvafD+q9JrdFMuidF6AfQrxiIhO5AF271DZiIYcXWQG6TuOxwn
         3JaiCLykAukhbn1YT23bLE3RHUWRUNEtKJOohzHFLRanal032+rT9AEBQHDu0FT0gNXf
         D3+5YQSlr9ePFSpaqN+rZUSA9GtaM6RjoyDT4SS+1VH/iTH82st+drziQ9K5oxUA44+x
         wX6mNEMdjHnp4rv/iX4GKAK7mb3rcncyrdEqlSe3uRiRVH2J2wqLB3XJHos1Kwb+1p44
         5+Sw==
X-Gm-Message-State: AOAM531UnIAhuzbM2ZYGVO0GdqDpf4181HVdEOeqm99pee4Wvjtf8YtG
        En2RGJGps7MxfNznenCUlQiGLeze
X-Google-Smtp-Source: ABdhPJy8HXYxPR2UQEEG5j0c6laLKPcNBLA9Rsnne+kZZ6x+yMR2MFY8oooLM/xUVGkZMZey35KVwQ==
X-Received: by 2002:a0c:eb0e:: with SMTP id j14mr1016507qvp.230.1589395577798;
        Wed, 13 May 2020 11:46:17 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id t124sm572661qkf.99.2020.05.13.11.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 11:46:17 -0700 (PDT)
Message-ID: <5ebc4079.1c69fb81.c8782.38eb@mx.google.com>
X-Google-Original-Message-ID: <20200513184608.10360-1-EVOFORGE\sdsmall@a-gady2p56i3do.evoforge.org>
From:   Smalley <stephen.smalley.work@gmail.com>
X-Google-Original-From: Smalley <EVOFORGE\sdsmall@a-gady2p56i3do.evoforge.org>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: fsync before rename
Date:   Wed, 13 May 2020 14:46:08 -0400
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Prior to rename(2)'ing new files into place, fsync(2) them to ensure
the contents will be fully written prior to rename.  While we are here,
also fix checking of write(2) to detect short writes.  This code could
be more generally improved but keeping to the minimal changes required
to fix this bug.

Fixes: https://github.com/SELinuxProject/selinux/issues/237
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 859c0a22..3cac36d4 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -735,7 +735,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
 	}
 	umask(mask);
 	while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
-		if (write(out, buf, amount_read) < 0) {
+		if (write(out, buf, amount_read) != amount_read) {
 			errsv = errno;
 			retval = -1;
 		}
@@ -745,6 +745,10 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
 		retval = -1;
 	}
 	close(in);
+	if (fsync(out) < 0) {
+		errsv = errno;
+		retval = -1;
+	}
 	if (close(out) < 0) {
 		errsv = errno;
 		retval = -1;
-- 
2.23.3

