Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC18C38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4FA24955
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKBLv7Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHPmZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgEHPmY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:24 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79FC061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a15so639828qvt.9
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dSFmslcQXOudC58cMAMKTWJ6vLqNrwbIYJVeNa97/U=;
        b=AKBLv7BucSml8vS2Sb3/82zwEa+HL4VjDNnH9Uqx+A20xKuIZVn971r3VVajm5qSy1
         JQz5kNAP7j/JgKqmH6M5Lw2PR65ZMVa4MZ+EwkItyg16nFGwj7GL0BPgyEz1014LFVx/
         Z2AvRQ5W5qLWA+m9sEzLPS2OtUUOctdOBxF9tXDB5pGY7V/cUuRps8mTiv+k1wl8EW2a
         yx3vxfGQNgUg7Rnkc+H5RKZMDgwjh7gFqMV8vdIC6z5jM80BlVFQbcm12xIT2FavebQJ
         PYPEHTDgaF3d62hS1nJGIyBspREzu6S33qX0LoDPGOvSSJNYP6ufOt/26vUmWFbFtRPa
         ErkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dSFmslcQXOudC58cMAMKTWJ6vLqNrwbIYJVeNa97/U=;
        b=obdKyI2B1QS6/H4Rq9t0AVdCAjxgL0ouxKxIC4TcN8XMUXnw630ABxKBdeF85iJsWF
         oxK46l1slwinpTMBy5CmTd/UpmPSAIAkSNnrV9Fng7eOwfW4S3aMZjB31A00Jop1QUuC
         V7RYVT/1fVc4TxYrgWHwje4SYyKF17k2Uf4JjxVHl2mVJ1Qb4f5C1tYWqsY86YwYIf81
         K6LK3eMKRFM6nYF2XTBWFKIDAX51STnoeUbsnCfTUoJeDYdRCf0NQ8NN70yHQrK3RurL
         YEZY3iYibawomJ3x2Dpnb1mw3JYsOwnTYgE9h/Y34NbuFDR3qtiQdgFLfxF+ufryEqs8
         PiYg==
X-Gm-Message-State: AGi0PuYBucEPS2abEKu8++4jmNbNCiL1HFp23TJSnCrxiG6INu7mrCfW
        465smmLGmwWHCjDrybLa9arZ+t8o
X-Google-Smtp-Source: APiQypKGLaxN4dNwqREsuByEc8NSZOyME0ZAhrRx5hxO6IfgodGTiHgPuJD6rxqWB9RVGGUs1MjoEg==
X-Received: by 2002:a0c:b31b:: with SMTP id s27mr3489064qve.158.1588952543879;
        Fri, 08 May 2020 08:42:23 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:23 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 08/15] test_overlayfs.te: allow test_overlay_mounter_t to read user tmp files
Date:   Fri,  8 May 2020 11:41:31 -0400
Message-Id: <20200508154138.24217-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

During setup-overlay, a shell is run in test_overlay_mounter_t from
a "here document" i.e. an inline input.  This creates a temporary file
that is inherited by the shell and must be readable.  Allow it.
This is apparently being allowed somehow in the base Fedora policy
for all domains but not in Debian.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_overlayfs.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index 6f1756e..b29621e 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -52,6 +52,7 @@ corecmd_exec_bin(test_overlay_mounter_t)
 
 userdom_search_admin_dir(test_overlay_mounter_t)
 userdom_search_user_home_content(test_overlay_mounter_t)
+userdom_read_user_tmp_files(test_overlay_mounter_t)
 
 mount_exec(test_overlay_mounter_t)
 mount_rw_pid_files(test_overlay_mounter_t)
-- 
2.23.1

