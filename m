Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE76C2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF2421927
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brds3kwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406042AbgDPPoN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395396AbgDPPoJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59BC061A10
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so1526022pjb.3
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mK6rHo6KUM5WsO4Xh6SckGgAQp4XOee8g5xpZh7S2Rc=;
        b=Brds3kwBvgn1TfryKTNlivbbjlCnUehPsE/vGya1m8xvqllxkbEELAKci4+FYbrQ6L
         aqXE0H7xazSxkvHoauim8eOTM74vx3WbqjYc2Usl/Qq4FLQ7ssV8DUkQCt/izw0wOPSX
         Xnu/QP4JkOxTM78W+hj+Wwqq18Nb5WypPee6E9GzHGRdMe80+27f2ktoXqHmDFry0FQP
         mjAkhA+uxaIFQPfq6sJ1UtFDES7EhP/Mzeg3gOR7nhyo7BAWBFC6rZxkU6LDZkRW5iQE
         IekktJgtd7u5FB49TuUIIqGZM9sBb7b+E1Ge1RgCGpGmXhp0umokFudlcqVE1uT/sbi4
         jZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mK6rHo6KUM5WsO4Xh6SckGgAQp4XOee8g5xpZh7S2Rc=;
        b=abz7fOkwRcWFAJs0eQC08o7oFoEAO265/G/+sYk4q9SvDqUcbbWsWuIWioNyuARq4l
         rh6AgQE3V/Pp/G5P6m3RNiTEizdYeocZgyGCIftPgYXJDKM6zhlXiAXh25Z1LecnvnLm
         Wrj3thgcvD+clWCQLX2bpbe7lb327SlHuXenD3AwD1lielYyeHMIkj09ufL+wsbtTDKe
         10lX3hV93bv525azG2NfqovM8znLguZZHH8GRm9kjPvf4XgUoy2XbwfRkRkIzIvtQ7Mq
         BjNI0MEhjY4zP44Wzh+1hrZEPC88RgBj1+U1hIUxhz7aSUPSndt9sOyz70mQWy0ZtIYG
         c9MQ==
X-Gm-Message-State: AGi0PuaCxuJsUPUSUZgro6msYTFrwJBTVXOlqS802ENCghyng+VqPrVN
        fAIkjSY+tgqKD+/jVRv44Gw=
X-Google-Smtp-Source: APiQypLsgi+IZ59ulfiIG/qK8upSEc2X7G/7ZbOSB2P2RoIWQ5MfPR2KXhibSI2xZN8NS2JrjaNh9g==
X-Received: by 2002:a17:90b:3714:: with SMTP id mg20mr5813931pjb.127.1587051848466;
        Thu, 16 Apr 2020 08:44:08 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:08 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 01/18] security_load_booleans: update return comment
Date:   Thu, 16 Apr 2020 10:43:35 -0500
Message-Id: <20200416154352.21619-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The code returns -1 not 0, correct it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 6a512b383325..948ca0689a07 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -323,7 +323,7 @@ extern int security_set_boolean_list(size_t boolcnt,
 				     SELboolean * boollist, int permanent);
 
 /* Load policy boolean settings. Deprecated as local policy booleans no
- * longer supported. Will always return 0.
+ * longer supported. Will always return -1.
  */
 extern int security_load_booleans(char *path);
 
-- 
2.17.1

