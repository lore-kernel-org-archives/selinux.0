Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A5C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804D720772
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 13:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ack7JKYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgGINLq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgGINLp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 09:11:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF08C061A0B;
        Thu,  9 Jul 2020 06:11:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j80so1692859qke.0;
        Thu, 09 Jul 2020 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dWD301dE5xQ6+5qgKu4psPrGwvipRdbm7OlZT1KZ6JU=;
        b=ack7JKYYhSdJlutv2jlpeZ02nv//RKssTA+3I7QJ+Ya9GHO38vGncpMoV30iBzGyz1
         Of4OrCjTjEy9b4UOshdEPpcRUCOE8baZxNnBmRjcAMjtQN4Nm8VXbXwfEFC0RJHqof1L
         LElaH0obf8fK4lKeAC0fCSFo6DEFMtHESzjCjlGkywPHpVLp3gfvlJ393XYRKhAMSLGQ
         PFVMvt3yXxYd3oJIVoQerqr3StWLRgaewKXVj2XjGlTHQjJ9RQMlBP+NmQ904GJdCv7j
         IdMDjPHUEiI3oktBmkV2juYX0r3cdWCDU+baMnKvQYbvEWULkudNNYaT9/obJgY/UzT8
         Qrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dWD301dE5xQ6+5qgKu4psPrGwvipRdbm7OlZT1KZ6JU=;
        b=MNEz7aqt+cd60XdkvnNfd7HLZTmLXckmfxwTrONQSIzdmWIVWgUCYXPmSu7PcfYKRd
         kvRsqjh2sFv5HGLwaFh4vMhfQcar1ZROnqw0lZqS7OSJDbVaQOyMdcxhWTJUO7V1FclY
         ka3JbOKQaiYLcNnxFURmdcsp8pNu9ReiRyUeqHu/W3ctZ/BfOX8pKcA53FBLij4U0rD8
         Q2+SJwWnNQ5PRjGgiO1WwJMp4rSZYy6tnlTXEm+8uU+OfVhhczCMxamQcbKuwE4QnFYg
         feO6zZ7LuGxwBTDkk7vlq87byfiFJi8CLfESk3M46RL4RJeGQmypWiPzAenpXdpBXHw6
         nHng==
X-Gm-Message-State: AOAM533SYjjYnWlIZGUnDgipjrnVdWh82sFHvSri98jMCgGjhO53KJMl
        vB4KurvGfRyCxbXMSlK8byw=
X-Google-Smtp-Source: ABdhPJxxtkzoREVSjiEzvnWjHLnBczww8te6gbgDX94Nc6SedFIANCnWNgY4+ufc0uakedUkGFPbVw==
X-Received: by 2002:a37:bcb:: with SMTP id 194mr64430179qkl.103.1594300304961;
        Thu, 09 Jul 2020 06:11:44 -0700 (PDT)
Received: from archlaptop.localdomain ([165.166.214.225])
        by smtp.gmail.com with ESMTPSA id z68sm3537153qke.113.2020.07.09.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:11:43 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:11:11 -0400
From:   Ethan Edwards <ethancarteredwards@gmail.com>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: selinux: ss: conditional.c fixed a checkpatch
 warning
Message-ID: <20200709131111.4mqrge6vjsbfs7ls@archlaptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`sizeof buf` changed to `sizeof(buf)`

Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
---
 security/selinux/ss/conditional.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 0cc7cdd58465..90a2f5927e55 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -215,7 +215,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	if (!booldatum)
 		return -ENOMEM;
 
-	rc = next_entry(buf, fp, sizeof buf);
+	rc = next_entry(buf, fp, sizeof(buf));
 	if (rc)
 		goto err;
 
@@ -416,7 +416,7 @@ int cond_read_list(struct policydb *p, void *fp)
 	u32 i, len;
 	int rc;
 
-	rc = next_entry(buf, fp, sizeof buf);
+	rc = next_entry(buf, fp, sizeof(buf));
 	if (rc)
 		return rc;
 
-- 
2.27.0

