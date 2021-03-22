Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C86C433DB
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05FD6196C
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 14:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCVOKK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhCVOKH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 10:10:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55915C061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 07:10:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s2so12366188qtx.10
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2ZTiqFfxa9/9i99WHWkJ3orKJFSRIjNhM0k6RaTL+o=;
        b=cY1KNh9LSMIzM2LbB3wYJJdMkzUxSwa5dLLbBB5oY+zHo74ERPjC69fQOfgz5w0Xd7
         FZqJYbGUrsgAm3T45tIklBJQuCiM6CD0fFbEZLhOKvu5lu895LBOSVpOWYdvq8ReWbxi
         o65VGhtVBeuHYSPe3HlR+XAg7irCZhVaBZw5TY6q3149urDAf1iUvyrpW50I7XebXjAi
         nJaHUTgp7ZZOHwAj3H1LJnweZH3yI+3+cPT+xGSocuTCYqST83vyHxlTEIf77Jj9yJvz
         D5/7JYphz6Uzpk0tP9e92nCHwm+kOoOPqIUY1ffuX2mJD8ZVwB5SdESMCbHTv3GiLtqD
         7elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2ZTiqFfxa9/9i99WHWkJ3orKJFSRIjNhM0k6RaTL+o=;
        b=PfiNqn9DMIhvOhjjnmrxAJnxTBbsBHyUbnd38wsYIjbTTg5G0ESGqMgmDo8ORiCHKh
         Jx3v+FGiA8E6XKtyvKygFhPUrHTInsUpTijpNY6iN+knK7JCj6L2VD6v31vUdJ8LxU7W
         dVbkK+PvZyufWaFX69h8gnhhYLDqTmjQKUAEkE8qrdt5ppFIC7ubOdLyp4dQ9KH9L0VD
         fc3elT6MbEjUcGAv+4lXZVLmjwBMAw+onMbAdFkJusv45O0aN01hR48sXAQtdwGjkmub
         Q3hczLLxbdM2rSf5h4TDqk6aYKEDsvGgBNg4SQbVdcWWp0FtRzy5cy9xio3ccnD/9jRY
         FoKg==
X-Gm-Message-State: AOAM530SXAck0HBXNu0UUKpj+NRsd8RkklFW2HhjaP/BN9sSFBhekmTz
        nXJEcSaU06szzPWi1HaZf7rAd3bNn2o5QQ==
X-Google-Smtp-Source: ABdhPJykhh2irzd4swm6lHWIXvp6rMnGhL9BH7hVxtrYTFfGF6aslW6liwM+Y61MXDEsrabGlvuHtg==
X-Received: by 2002:ac8:498d:: with SMTP id f13mr100768qtq.54.1616422206364;
        Mon, 22 Mar 2021 07:10:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h5sm9617113qko.83.2021.03.22.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:10:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Allow permission expressions when using map classes
Date:   Mon, 22 Mar 2021 10:10:03 -0400
Message-Id: <20210322141003.22846-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following policy will cause a segfault:
  (class CLASS (PERM))
  (class C (P1 P2 P3))
  (classorder (CLASS C))
  (sid SID)
  (sidorder (SID))
  (user USER)
  (role ROLE)
  (type TYPE)
  (category CAT)
  (categoryorder (CAT))
  (sensitivity SENS)
  (sensitivityorder (SENS))
  (sensitivitycategory SENS (CAT))
  (allow TYPE self (CLASS (PERM)))
  (roletype ROLE TYPE)
  (userrole USER ROLE)
  (userlevel USER (SENS))
  (userrange USER ((SENS)(SENS (CAT))))
  (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

  (classmap CM (PM1 PM2 PM3))
  (classmapping CM PM1 (C (P1)))
  (classmapping CM PM2 (C (P2)))
  (classmapping CM PM3 (C (P3)))
  (allow TYPE self (CM (and (all) (not PM2))))

The problem is that, while permission expressions are allowed for
normal classes, map classes are expected to only have permission
lists and no check is done to verify that only a permission list
is being used.

When the above policy is parsed, the "and" and "all" are seen as
expression operators, but when the map permissions are converted to
normal class and permissions, the permission expression is assumed
to be a list of datums and since the operators are not datums a
segfault is the result.

There is no reason to limit map classes to only using a list of
permissions and, in fact, it would be better to be able to use them
in the same way normal classes are used.

Allow permissions expressions to be used for map classes by first
evaluating the permission expression and then converting the
resulting list to normal classes and permissions.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index d2ecbd43..6990fc07 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2130,6 +2130,10 @@ static int __evaluate_classperms_list(struct cil_list *classperms, struct cil_db
 				}
 			} else { /* MAP */
 				struct cil_list_item *i = NULL;
+				rc = __evaluate_classperms(cp, db);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}				
 				cil_list_for_each(i, cp->perms) {
 					struct cil_perm *cmp = i->data;
 					rc = __evaluate_classperms_list(cmp->classperms, db);
-- 
2.26.2

