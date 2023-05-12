Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F328C77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbjELJaL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjELJaK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:30:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A3EA
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so17483500a12.2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883808; x=1686475808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+VSt7J7nLm19MMKo+1ALSSpQAvSm18sJcPCcmx8kgU=;
        b=pv6eNqZ8A3ZT7ZVVkeVXiwdqmU1LGDKa+TlWAaTjIv4/LPR4ngHf2Z00UTYaR5wFV2
         c7IGre/UgYstRVtTXJRfu73fWqX7iUPh+GzX0nWt2fuoqJRqjHgWZ4RGxmmSRfQJNfa/
         oeUNXKXzNjxAs4s+QMudOxYuvsvC/+sxuAD0F5t11hDmr8Z81/6jJWXXfl0ckmohMA+g
         f0AyJXQ1tnJTf8h1rW5/KDlxZUhiy/EP707o1S8Yzgz/zg3Jb3r0A0vzrHl/5GGIE+yu
         D0E/438c25Li2fvmxfhU8DsBl3pHfn3O4dcJy+ObqOt+82nzWxl1HftVBVMOBDC16Fj+
         oEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883808; x=1686475808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+VSt7J7nLm19MMKo+1ALSSpQAvSm18sJcPCcmx8kgU=;
        b=XNcQulwGd8hygg6yyglR9RMoqvRSTP72jCFk9Dt8K8QumjVtue1yxSAyQYBDjLMayn
         CLS65OplNVKmDnhQH+8RknQRywKvj8VtLufYy6pUibMY2tOMbJAqxPzY8/mG4QxD8qMf
         Gqrd6maNhjcuaDny3DRqDy9yeMuCZzntnkbezbJN2gXghraMJlAX3oEa5BevbqeBw2dr
         PbImdAPO9tTy4fmfDl3vITJiTj7lmnzEB7kvoHZuz3f6/CHYltVTa9mjmEewqEK1SNEA
         NG7kyAFDHjI9wIRzRKD/V1ofxQ2VTFUpepQ8oJHodBsi7YaHhUKV7Gpe7PDVO9sgPA+t
         qq6Q==
X-Gm-Message-State: AC+VfDyLAAGu7kH8tHm6fnPT3WD+XnX32vfKmdPg/T6Vsfe7nDPsPpj3
        cmBfy8Ueq57TqWIYLUUWshqVHnSEwr1D2w==
X-Google-Smtp-Source: ACHHUZ7j23YtplhDMLTCmIpAWiNbYS7yt2O9nsLUAuE/VeiHKJ4MaxFPcYtNhYXaUeNhGzrUcXm/Zg==
X-Received: by 2002:a17:906:9b8b:b0:96a:7de4:dd24 with SMTP id dd11-20020a1709069b8b00b0096a7de4dd24mr3469006ejc.66.1683883807670;
        Fri, 12 May 2023 02:30:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id tc19-20020a1709078d1300b00969f2d5267asm4636356ejc.114.2023.05.12.02.30.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:30:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] libsepol: validate old style range trans classes
Date:   Fri, 12 May 2023 11:29:58 +0200
Message-Id: <20230512093001.49208-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512093001.49208-1-cgzones@googlemail.com>
References: <20230512093001.49208-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For old style range transition rules the class defaults to process.
However the policy might not declare the process class leading to
setting a wrong bit later on via:

    if (ebitmap_set_bit(&rtr->tclasses, rt->target_class - 1, 1))

UBSAN report:

    policydb.c:3684:56: runtime error: unsigned integer overflow: 0 - 1 cannot be represented in type 'uint32_t' (aka 'unsigned int')

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b79c19b9..605d290a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3650,10 +3650,10 @@ static int range_read(policydb_t * p, struct policy_file *fp)
 			if (rc < 0)
 				goto err;
 			rt->target_class = le32_to_cpu(buf[0]);
-			if (!value_isvalid(rt->target_class, p->p_classes.nprim))
-				goto err;
 		} else
 			rt->target_class = p->process_class;
+		if (!value_isvalid(rt->target_class, p->p_classes.nprim))
+			goto err;
 		r = calloc(1, sizeof(*r));
 		if (!r)
 			goto err;
-- 
2.40.1

