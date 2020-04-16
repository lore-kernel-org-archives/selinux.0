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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152DC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B920732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCQ2t5Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395459AbgDPPod (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442475AbgDPPob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC08EC061A10
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i3so1830780pgk.1
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1To/FE2fo06GVscvLcra+k1YFjbs4QDa36op6rS+9Q=;
        b=uCQ2t5Fmg/2qCCETh/D2qdMGRo701M67dH+hPyNE0LtLgzt13QLRd7dQaXlRBctstd
         hQQ58BfEU59yGxH9c+B2YoM0vYoNw56r3EpGvqzNHfMsPe3LHSl/LpylxZtjS8do403X
         1/+pzFvy/pioKbSrg6raKXPclPMJ48H/WpdeLjyPmq+6maNg9fckINn4DIqjI/mg2+NC
         U/Y2PDwMvwWKf5PmRTJ05PODYNbBkZZ1mOodldvDSROWf2v6Hl8UKPEMzqA3u1+Eq61V
         AATOlI/ysVW06TXcxt46ItYrq9l9sfqDZsiX1lhUPG97L534m31yvLgtsw1xn7oZkII6
         vOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1To/FE2fo06GVscvLcra+k1YFjbs4QDa36op6rS+9Q=;
        b=G4lQXsvYdRPsNXVVIUKMa3SbgbYBvoje3cP5yNg6EKAU1122izH5/ANIL7Tjv5T8nK
         DWFj5puMswhrLdyNCC6E7xSd1ijWO7iy6XWpAdEggtbhKk2/bPM8DNQPJrdqSA8AE/Ue
         Bdr4GgdUwnIo1J2ipG4KBLZvqGB0dlBM2zqRV5DxM9AZlMyXA5gmjnFtH1yKGju5PiUs
         Np0bT3z9G/7pClds5WUpQ5d78x0Zc0J6MpO8IvnnaWgCxCiG+05TFL811QnBizk9KhSB
         9HtesZuOikFVOSPKVi15CsO0FsE8hqSYc7k03PdryGMVVVMVjJ5M4Tkqh3Et2aTdFQo0
         xZ4A==
X-Gm-Message-State: AGi0PuaD8Ssdg108rGFYns8q1s9cox4TQIbVu8ztqU09tf2mE9iaXq+j
        9pZInzCv3nVkc+TWMqBr68w=
X-Google-Smtp-Source: APiQypJO7qFaWgNce6zeOx/bQnSLcuLGLVzvqfUJVy0ofRvBoAIFL8GBzpwR7xgq3XgwYktAMQbxHQ==
X-Received: by 2002:a65:498f:: with SMTP id r15mr23544492pgs.345.1587051870251;
        Thu, 16 Apr 2020 08:44:30 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:29 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 14/18] matchpathcon: create internal matchpathcon_fini interface
Date:   Thu, 16 Apr 2020 10:43:48 -0500
Message-Id: <20200416154352.21619-15-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Now that matchpathcon_fini is marked deprecated, create an
matchpathcon_fini2 interface for internal users. We create
a new header file for matchpathcon_internal interfaces.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/matchpathcon.c          | 10 ++++++++--
 libselinux/src/matchpathcon_internal.h |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/src/matchpathcon_internal.h

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index bddf77a49ce1..8515c88c2bb8 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -3,6 +3,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include "selinux_internal.h"
+#include "matchpathcon_internal.h"
 #include "label_internal.h"
 #include "callbacks.h"
 #include <limits.h>
@@ -317,7 +318,7 @@ void matchpathcon_filespec_destroy(void)
 
 static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
 {
-	matchpathcon_fini();
+	matchpathcon_fini2();
 }
 
 void __attribute__((destructor)) matchpathcon_lib_destructor(void);
@@ -357,7 +358,7 @@ int matchpathcon_init(const char *path)
 	return matchpathcon_init_prefix(path, NULL);
 }
 
-void matchpathcon_fini(void)
+void matchpathcon_fini2(void)
 {
 	free_array_elts();
 
@@ -367,6 +368,11 @@ void matchpathcon_fini(void)
 	}
 }
 
+void matchpathcon_fini(void)
+{
+	matchpathcon_fini2();
+}
+
 /*
  * We do not want to resolve a symlink to a real path if it is the final
  * component of the name.  Thus we split the pathname on the last "/" and
diff --git a/libselinux/src/matchpathcon_internal.h b/libselinux/src/matchpathcon_internal.h
new file mode 100644
index 000000000000..3affa687327f
--- /dev/null
+++ b/libselinux/src/matchpathcon_internal.h
@@ -0,0 +1,6 @@
+#ifndef SRC_MATCHPATHCON_INTERNAL_H_
+#define SRC_MATCHPATHCON_INTERNAL_H_
+
+void matchpathcon_fini2(void);
+
+#endif
-- 
2.17.1

