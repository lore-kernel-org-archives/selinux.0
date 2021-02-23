Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1BC433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F06023C
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 13:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhBWNLT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhBWNLN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 08:11:13 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764FC061794
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 05:09:39 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k13so32613005ejs.10
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 05:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVS/PMB442gJrECqPUB6fPna36XfXvMXZlW80U1BWds=;
        b=EHe/k4w+Q7QQ+YJd0rol9f8WDMtP+YzhG9eFdR0nO51ki8WBTlaysUw0QXVjstua0n
         5I4774VPMXDy2pwuYQtwTHPw8dfoksb+ZRu9xp+5eTfQSFscZhEDYywKw7LnSMDmdFYf
         nnl5OIOokx6ncMejkcA0zASX+LIzgnE+loiarrLG06SQDHerTCq3meKx0csd8vbHXA3X
         KPkpHk12GcHfpcfzsRtiqDGIYSFeFyP4PvUWFVhxGzHf/yQ9nUYtcePD+B3H8zHKuhU3
         3PWm0Z99Fq/TihKMhA2zPhaPsXXHmpW/an14ZipqK6mDXpqmJmSSRS8Th4uQH2/7Vot9
         7iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVS/PMB442gJrECqPUB6fPna36XfXvMXZlW80U1BWds=;
        b=WUsL7c+8nyvcHXZruDb0oxrBlYrSXdk+pLqqBlR1s5toS9Bz5BJHJyrKv7bh8MAr8C
         Ul0nkW5arFx3CO76X9JCXLSXaxDyUm4Z968I7K78w0Hj3FeIwGgV2NZzRz/otD1BSebD
         Ipyt6Z0d1OTRwAKbkH9ABFAHFpkHsL24zpRM1Jd65ZR/TzOL9P5zathLk28mn0Gy5KDD
         o6NklxZ+1rCKpnVAB049KTh+4M9jPV0HkFzHWA2GdudIvX6AF6jb/dmWEQ2hwwbeJRFW
         8zTVBS93QHXu1sjm+XhsFTGeYZ2LkcXhESuVF4QTXOtt7p1Uhfutp5WpmFFq8MTJRKFk
         A9lQ==
X-Gm-Message-State: AOAM532C+HslV97W4aBFhTrUmYqCJ2yxW/8SyP+tnQBy3tWUDCrirq+4
        Fcp3nkWpzGvKeRAlOXr+5+hW7vK0e9s=
X-Google-Smtp-Source: ABdhPJzj8uzJXL93iTMl+25q5g7oifY7q4Nuv0p20k1NWxxq0/1o4H6AeA9YUsgwdFjP2guaUkA19A==
X-Received: by 2002:a17:906:511:: with SMTP id j17mr14246781eja.143.1614085778412;
        Tue, 23 Feb 2021 05:09:38 -0800 (PST)
Received: from dlaptop.localdomain (dynamic-077-001-133-101.77.1.pool.telefonica.de. [77.1.133.101])
        by smtp.gmail.com with ESMTPSA id u18sm12600933ejc.76.2021.02.23.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:09:38 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] libsepol/cil: handle SID without assigned context when writing policy.conf
Date:   Tue, 23 Feb 2021 14:09:17 +0100
Message-Id: <20210223130917.23360-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210220190806.22139-1-cgzones@googlemail.com>
References: <20210220190806.22139-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL permits not assigning a context to a SID, e.g. to an unused initial
SID, e.g. 'any_socket'.

When using the example policy from the SELinux Notebook,
https://github.com/SELinuxProject/selinux-notebook/blob/main/src/notebook-examples/cil-policy/cil-policy.cil,
secilc logs:

    No context assigned to SID any_socket, omitting from policy at cil-policy.cil:166

But secil2conf segfaults when writing the policy.conf:

    ../cil/src/cil_policy.c:274:2: runtime error: member access within null pointer of type 'struct cil_context'

Only print the sid context statement if a context was actually assigned.
The sid declaration is still included via cil_sid_decls_to_policy().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  Drop the statement completely in cil_sid_contexts_to_policy(),
  cause cil_sid_decls_to_policy() will have printed the context less
  declaration already.

 libsepol/cil/src/cil_policy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 74edb345..91e767b7 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1660,9 +1660,11 @@ static void cil_sid_contexts_to_policy(FILE *out, struct cil_list *sids, int mls
 
 	cil_list_for_each(i1, sids) {
 		sid = i1->data;
-		fprintf(out, "sid %s ", sid->datum.fqn);
-		cil_context_to_policy(out, sid->context, mls);
-		fprintf(out,"\n");
+		if (sid->context) {
+			fprintf(out, "sid %s ", sid->datum.fqn);
+			cil_context_to_policy(out, sid->context, mls);
+			fprintf(out,"\n");
+		}
 	}
 }
 
-- 
2.30.1

