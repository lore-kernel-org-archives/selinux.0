Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14CEC4332F
	for <selinux@archiver.kernel.org>; Sat, 11 Nov 2023 16:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKKQKM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Nov 2023 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQKL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Nov 2023 11:10:11 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A603A81
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 08:10:06 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778940531dbso191808585a.0
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699719005; x=1700323805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/6VP9tk/PKdfDj5a5022D+V62+KOF1HeDcVhmRrtao=;
        b=NZDcljVzyXJBNU30nAlbPbpNIzgTQ3AfEY47E2M3N3wcXm+DetD/mvx4gl+VDNS1J7
         nJWybnHSdCDVXuXM6OkaMEqqgyYIdzqsm5bMa1CrOZnL9YMPece+H66UCBjcmHBMLqs6
         Y6YWU7hynuF0+fATxMHcer56Ddp0KgoxWA8hN1Xbt8+ut+hovfK5X9sZsxQrBi69vkgC
         pYXGswD4znJA2xNkZYY9rhuKQfMUAJ9KKb1x6cjYRUtd5bT1VFVlEa1xl01N9thXW4+2
         WKu0/ulttrgIGu9nVWTP4px9uSmFhsr1MJceU0qHR+ptXUfKuQGYtwV/Iy7PZ5fjd6zv
         g15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699719005; x=1700323805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/6VP9tk/PKdfDj5a5022D+V62+KOF1HeDcVhmRrtao=;
        b=l6pyO7zp3rLYJ9c7cU8Yh8gYH8r/v/T2lAebOQtIuhMNKbzcNXW2EvJ9U0gbHRRYbV
         R3u8wiUakNIWCK+Dhg0ezT9ZqsJDhlVlXYPrX470HLknpWO6YLVJKwSUzPYL1Q3LDIgf
         m3kN6BdxeNFBckn1pcJ36d0FmhnW5+cHJohZHxEY3fc/1Z6e9/rz0t+n/7lS21mgpFFt
         kjk+IL3JgX2RpyRZcFLojHG5lo5PBcx5FD5BN0W7lLWJM0tceSvRmC4G7FJGOZFbYfW+
         b64phwDPEJ3OcoTDk+8BJgV0n5WenSatys38S3O3buIU/tQTiooOM+25vjhnAg0KHXRQ
         p7bQ==
X-Gm-Message-State: AOJu0Ywvma0CGCJkPdb/WDU8gMdHyDtu8IYtBOkoUJ0EKssAtjMf0+Ic
        mjOOBrt29QYw1UDkGnyDtNK68SuQmeH0TDpGaA==
X-Google-Smtp-Source: AGHT+IFV4wn5oFx7mbRdjAfFwwC1QjVPc0/WVMVzzRb/hbOxbCbsLSPUhMtfmiS2Pp6fMVdGgzXBoQ==
X-Received: by 2002:a0c:f68f:0:b0:66d:6869:5e62 with SMTP id p15-20020a0cf68f000000b0066d68695e62mr2588295qvn.46.1699719005523;
        Sat, 11 Nov 2023 08:10:05 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pv19-20020ad45493000000b0066cf4fa7b47sm667529qvb.4.2023.11.11.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:10:05 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] selinux: update filenametr_hash() to use full_name_hash()
Date:   Sat, 11 Nov 2023 11:09:55 -0500
Message-ID: <20231111160954.45911-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=paul@paul-moore.com; h=from:subject; bh=ZUBSWasGa17Hg4tPck9a19XRXUPsUtuc90AqTJ7IpjU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlT6dSzeoO4SbS9CwM6HwtMY8fGwIE6OJzFcH+g Nx5MXZuyraJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZU+nUgAKCRDqIPLalzeJ c5faEAC+o8cqBH6Bsvb2d4ph7wX0FsLkd11PpyCuf22aczf2uG4KBUeucwQrEW/7eF1g0C9IELe zmfK/EQfC0ZlOqFCKGEK/vTjd8s60XhvXfK47dlqnAAB2KVjx3oFulen7MGbpUKTrBNDCPxs4rn /FH00Ne2YRReldRnhK1ISFBLIkeoE5IQtnqr5JW2sbXpQnxuEQQn1uy++NTdSvuR2smZN/l1I9V AuQOmFDZAAHuD4fYcLRoJLpSsZdfLygjNNucDECZxl0iUWmp4SqBcFb4PYkOB1l0Llxl+gzuOjD y6FyQq0x+2RuEdw/Qfgnji9dvIB712WMErgBZtLQ7ePFc9OgdqmfyCxxyaDGgj1zoicBI52Hqhk AugyM8391X4LtwXYTSPV+nfN3ilJ30lnHMbQWrPNfFZFjoa2cpf2pwRnaNvhzSYZCHXpHnrW0p7 rms0DSvQuHTnFBHPHClWppXzyM3WshflCxdGOQ7Y58eoloP29uwCatFbAJgKfZm5CHJxmtk5NaB rS5LT8GEPHwgDzarKpLtfQ6CqEsg8mWZ0J1mXcfXWzYqUoddymyktN5bmgvQWt+TMwxYKrG5jiE chKvXQHDc8sRCpm4HHz3IRViS2vRq5g3X/4sgj275BrI9jt1m6MOYT8333WumdllNyBQrT1jNBW Sxs8bA/q9YpjauA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using full_name_hash() instead of partial_name_hash() should result
in cleaner and better performing code.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/policydb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2d528f699a22..0ab3b5429fcf 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -409,16 +409,9 @@ static int roles_init(struct policydb *p)
 static u32 filenametr_hash(const void *k)
 {
 	const struct filename_trans_key *ft = k;
-	unsigned long hash;
-	unsigned int byte_num;
-	unsigned char focus;
+	unsigned long salt = ft->ttype ^ ft->tclass;
 
-	hash = ft->ttype ^ ft->tclass;
-
-	byte_num = 0;
-	while ((focus = ft->name[byte_num++]))
-		hash = partial_name_hash(focus, hash);
-	return hash;
+	return full_name_hash((void *)salt, ft->name, strlen(ft->name));
 }
 
 static int filenametr_cmp(const void *k1, const void *k2)
-- 
2.42.1

