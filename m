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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95110C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731F82082E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3iXQbQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgDTPqP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgDTPqO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F38BC061A0F
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g30so5128555pfr.3
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1To/FE2fo06GVscvLcra+k1YFjbs4QDa36op6rS+9Q=;
        b=R3iXQbQuL91FyeOEp7cA6xv+nqBLxHye/ZCKcc5tLKvqzfxcp7KAJXzsrMKbiCMR5H
         QNqslt7gqquFGTLavnlvC+dKYlsXT/v19uc6u60qE186pzVnr2qx1uvmhD3ZV2Y03eV+
         qbWSnyOF8OcSeluB/5YUtTRTjSDLbhpV3NXN5ZZjV/y51+IAPUSi27vqYlTxADpXK1Gi
         3rmIvgwsXyhSBXMguEvGZ1u/stu9DFJBDUGymDkQ/YLEz33Cs1XyY1BtH1G1CCf9k/ew
         UnuGW593pK+sPI58qP1dhcEvDMFooRZflUetHKO7z8hpO0J2Hu0UYI4LlK8RBIJ/sCg2
         LGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1To/FE2fo06GVscvLcra+k1YFjbs4QDa36op6rS+9Q=;
        b=Valr7jmuA9mZH40GKsHDYdcpBFQYBGA8Cjy2vxCOwlp+vyB/lSAToPzqXUsssyW7Bj
         WoOFKyZEljhQ7dtmGvldCkKT15gyBjlqg8kD3XVtykGbqmP+J9BPxZLI83/gsiVoDEFN
         X8eWVmuJK71QraV4NttAUQA4JrK8T7fcd4UOLMgFOmTuI3KJ8L/JnjnG68P/8WWdmHt+
         +aKFaJzoseaUNZ56jxfA5ZLE6c6W5DzNEowrSvE5cDXpURJD/yfuaZ6MdXQGZUi+p04y
         D+E/TFRLFK7TYkWK8TS2Ay8CM1SR6OQ9f0qbgDkTtXxMSPja5tN3ENfCZtfg64aqcOfc
         eVqw==
X-Gm-Message-State: AGi0PuYKZVPp7FFQYqghBQOv/sg956Mj2fBMpvN3MOQ0ddOpO4sXXZf3
        rI4GngaS9mv91a6Ym8iQKXw=
X-Google-Smtp-Source: APiQypJhwJMHm03E1IHO24d8OL17mlR1ir0u1Ggfk8AJDmSldWbO/iamT+7h09JRaJ53o5kshTXKTg==
X-Received: by 2002:a63:e708:: with SMTP id b8mr17588308pgi.128.1587397574085;
        Mon, 20 Apr 2020 08:46:14 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:13 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 14/19] matchpathcon: create internal matchpathcon_fini interface
Date:   Mon, 20 Apr 2020 10:45:32 -0500
Message-Id: <20200420154537.30879-15-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
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

