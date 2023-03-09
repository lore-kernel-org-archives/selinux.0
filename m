Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D42CC74A44
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCIVvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjCIVv3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:29 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34778103397
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:26 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id jo29so2475364qvb.0
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaMLv6M9i07udDiQUH2sZxvn1a3s0tfcGjtScEovecE=;
        b=gcJpAHjyeVrvoTfLkckpwr5ArRxZQXzfz7eoviv1u2WJcOcX+zrm7D5JbqrrFm1biE
         J4+Tt5QVrYeZcUsH4+GqehD9GD2l2QckN/YEBraD6FD8MbELeSvKqYmdsS812euVjlOq
         Gv4r1oJBONISnF7aAUfdGdWfMTd/fgYk2hYCT5XtFQhIQr/B8ZKumvNnBQcrZ5MQU1GV
         yYCLNGPZbXOM8y0/sY1WiYRPlgeQLjXdG/dNB/3CPtpoqGNj66t4KMbAH8A2qn/9k/1J
         wFtN7m/voWUGe9eO78FbCv5lcV2db33Q2G/GGBjb4crAOhS7Zm200dfojvQko+lSAVn6
         gCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaMLv6M9i07udDiQUH2sZxvn1a3s0tfcGjtScEovecE=;
        b=umyJu2wArgOVMKrzQM7nTELvMp6uN9ENglDszVSWNnv0GRUaVONc0Py5YYXeBtjGJk
         EiwmlRFUHj8qbTlQLjquwdwx+hwBI+aE7uib+gEXMTHCIJeo7dl08Q0qOymefyiQSYdr
         0GumwCFe7TOlN6W3kt5/PDSMoBo/8+/icOV+ht+VgpI8LGbjnbxXnNavmGgbNiD8J8TW
         XrXFvnb9B4hzfraLfvxohATrVHtzyp1efvoXb1NhS96t9NgvUfTlcJJefQB7F6EMbXlo
         c+n4nvUBTbyHojENHCUmCDQMFzYKxMEaRn/LJKwdabQEbvmnQ9BWHkoG8r+99dRnnMV7
         +sdw==
X-Gm-Message-State: AO0yUKWpzfR6fQA7r09eDEcZyfffjcIzr0JLRo+fTOaPZvQMQyZitd1m
        vrqqCnv8a4l+x02+rZbN3jMYLjT7wJM=
X-Google-Smtp-Source: AK7set8zoFa2zMifPS1VY/PnI6Y4BCBA6Gy23q0BCNuHll6FeUqVN4D/BHV6dSch8l2VLZsd1+MUag==
X-Received: by 2002:a05:6214:1bcd:b0:56e:a3a2:1a0f with SMTP id m13-20020a0562141bcd00b0056ea3a21a0fmr46902519qvc.46.1678398684607;
        Thu, 09 Mar 2023 13:51:24 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:24 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 8/9 v2] secilc/test: Add deny rule tests
Date:   Thu,  9 Mar 2023 16:51:13 -0500
Message-Id: <20230309215114.357831-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2:
Changed and added deny rule tests.

 secilc/test/deny_rule_test.cil | 946 +++++++++++++++++++++++++++++++++
 1 file changed, 946 insertions(+)
 create mode 100644 secilc/test/deny_rule_test.cil

diff --git a/secilc/test/deny_rule_test.cil b/secilc/test/deny_rule_test.cil
new file mode 100644
index 00000000..26fc1045
--- /dev/null
+++ b/secilc/test/deny_rule_test.cil
@@ -0,0 +1,946 @@
+(class CLASS (PERM))
+(class C1 (p1a p1b p1c p1d))
+(class C2 (p2a p2b p2c p2d))
+(class C3 (p3a p3b p3c p3d))
+(class C4 (p4a p4b p4c p4d))
+(classorder (CLASS C1 C2 C3 C4))
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(type TYPE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(allow TYPE self (CLASS (PERM)))
+(roletype ROLE TYPE)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
+
+(classmap cm5 (mp5a mp5b))
+(classmapping cm5 mp5a
+	      (C2 (p2a p2b)))
+(classmapping cm5 mp5b
+	      (C2 (p2c p2d)))
+
+(classpermission cp6)
+(classpermissionset cp6 (C3 (p3a p3b)))
+(classpermissionset cp6 (C4 (p4a p4b)))
+
+(classpermission cp7)
+(classpermissionset cp7 (C2 (p2a p2b)))
+(classpermissionset cp7 (C2 (p2c p2d)))
+
+; Test 1
+(type t01a)
+(type t01b)
+(allow t01a t01b (C1 (p1a)))
+(deny t01a t01b (C1 (p1a)))
+(neverallow t01a t01b (C1 (p1a)))
+
+; Test 2
+(type t02a)
+(type t02b)
+(allow t02a t02b (C1 (p1a p1b)))
+(deny t02a t02b (C1 (p1a)))
+(neverallow t02a t02b (C1 (p1a)))
+; (neverallow t02a t02b (C1 (p1b))) ; This check should fail
+
+; Test 3
+(type t03a)
+(type t03b)
+(allow t03a t03b (C1 (p1a)))
+(deny t03a t03b (C1 (p1a p1b)))
+(neverallow t03a t03b (C1 (p1a p1b)))
+
+
+; Test 11
+(type t11a)
+(type t11b)
+(type t11c)
+(type t11d)
+(typeattribute a11a)
+(typeattribute a11b)
+(typeattributeset a11a (t11a t11b))
+(typeattributeset a11b (t11c t11d))
+(allow a11a a11b (C1 (p1a)))
+(deny a11a a11b (C1 (p1a)))
+(neverallow a11a a11b (C1 (p1a)))
+
+; Test 12
+(type t12a)
+(type t12b)
+(type t12c)
+(type t12d)
+(typeattribute a12a)
+(typeattribute a12b)
+(typeattributeset a12a (t12a t12b))
+(typeattributeset a12b (t12c t12d))
+(allow t12a t12c (C1 (p1a)))
+(deny a12a a12b (C1 (p1a)))
+(neverallow a12a a12b (C1 (p1a)))
+
+; Test 13
+(type t13a)
+(type t13b)
+(type t13c)
+(type t13d)
+(typeattribute a13a)
+(typeattribute a13b)
+(typeattributeset a13a (t13a t13b))
+(typeattributeset a13b (t13c t13d))
+(allow a13a a13b (C1 (p1a)))
+(deny t13a t13c (C1 (p1a)))
+(neverallow t13a t13c (C1 (p1a)))
+; (neverallow t13b t13d (C1 (p1a))) ; This check should fail
+
+; Test 21
+(type t21a)
+(type t21b)
+(allow t21a t21b (cm5 (mp5a)))
+(deny t21a t21b (cm5 (mp5a)))
+(neverallow t21a t21b (cm5 (mp5a)))
+
+; Test 22
+(type t22a)
+(type t22b)
+(allow t22a t22b (cm5 (mp5a mp5b)))
+(deny t22a t22b (cm5 (mp5a)))
+(neverallow t22a t22b (cm5 (mp5a)))
+; (neverallow t22a t22b (cm5 (mp5b))) ; This check should fail
+
+; Test 23
+(type t23a)
+(type t23b)
+(allow t23a t23b (cm5 (mp5a)))
+(deny t23a t23b (cm5 (mp5a mp5b)))
+(neverallow t23a t23b (cm5 (mp5a mp5b)))
+
+; Test 24
+(type t24a)
+(type t24b)
+(allow t24a t24b (C2 (p2a)))
+(deny t24a t24b (cm5 (mp5a)))
+(neverallow t24a t24b (cm5 (mp5a)))
+
+; Test 25
+(type t25a)
+(type t25b)
+(allow t25a t25b (cm5 (mp5a)))
+(deny t25a t25b (C2 (p2a)))
+(neverallow t25a t25b (C2 (p2a)))
+; (neverallow t25a t25b (C2 (p2b))) ; This check should fail
+
+; Test 31
+(type t31a)
+(type t31b)
+(allow t31a t31b cp6)
+(deny t31a t31b cp6)
+(neverallow t31a t31b cp6)
+
+; Test 32
+(type t32a)
+(type t32b)
+(allow t32a t32b cp6)
+(deny t32a t32b (C3 (p3a p3b)))
+(neverallow t32a t32b (C3 (p3a p3b)))
+; (neverallow t32a t32b (C4 (p4a p4b))) ; This check should fail
+
+; Test 33
+(type t33a)
+(type t33b)
+(allow t33a t33b (C3 (p3a)))
+(deny t33a t33b cp6)
+(neverallow t33a t33b cp6)
+
+; Test 34
+(type t34a)
+(type t34b)
+(allow t34a t34b cp7)
+(deny t34a t34b (cm5 (mp5a mp5b)))
+(neverallow t34a t34b (cm5 (mp5a mp5b)))
+
+; Test 35
+(type t35a)
+(type t35b)
+(allow t35a t35b (cm5 (mp5a mp5b)))
+(deny t35a t35b cp7)
+(neverallow t35a t35b cp7)
+
+; Test 36
+(type t36a)
+(type t36b)
+(allow t36a t36b cp7)
+(deny t36a t36b (cm5 (mp5a)))
+(neverallow t36a t36b (cm5 (mp5a)))
+
+; Test 37
+(type t37a)
+(type t37b)
+(allow t37a t37b (cm5 (mp5a)))
+(deny t37a t37b cp7)
+(neverallow t37a t37b cp7)
+
+; Test 41
+(type t41a)
+(allow t41a self (C1 (p1a)))
+(deny t41a self (C1 (p1a)))
+(neverallow t41a self (C1 (p1a)))
+
+; Test 42
+(type t42a)
+(allow t42a self (C1 (p1a)))
+(deny t42a t42a (C1 (p1a)))
+(neverallow t42a t42a (C1 (p1a)))
+
+; Test 43
+(type t43a)
+(allow t43a t43a (C1 (p1a)))
+(deny t43a self (C1 (p1a)))
+(neverallow t43a self (C1 (p1a)))
+
+; Test 51
+(type t51a)
+(type t51b)
+(typeattribute a51a)
+(typeattributeset a51a (t51a t51b))
+(allow a51a self (C1 (p1a)))
+(deny a51a self (C1 (p1a)))
+(neverallow a51a self (C1 (p1a)))
+
+; Test 52
+(type t52a)
+(type t52b)
+(typeattribute a52a)
+(typeattributeset a52a (t52a t52b))
+(allow t52a self (C1 (p1a)))
+(deny a52a self (C1 (p1a)))
+(neverallow a52a self (C1 (p1a)))
+
+; Test 53
+(type t53a)
+(type t53b)
+(typeattribute a53a)
+(typeattributeset a53a (t53a t53b))
+(allow a53a self (C1 (p1a)))
+(deny t53a self (C1 (p1a)))
+(neverallow t53a self (C1 (p1a)))
+; (neverallow t53b self (C1 (p1a))) ; This check should fail
+
+; Test 54
+(type t54a)
+(type t54b)
+(typeattribute a54a)
+(typeattributeset a54a (t54a t54b))
+(allow a54a self (C1 (p1a)))
+(deny a54a a54a (C1 (p1a)))
+(neverallow a54a a54a (C1 (p1a)))
+
+; Test 55
+(type t55a)
+(type t55b)
+(typeattribute a55a)
+(typeattributeset a55a (t55a t55b))
+(allow a55a a55a (C1 (p1a)))
+(deny a55a self (C1 (p1a)))
+(neverallow a55a self (C1 (p1a)))
+; (neverallow t55a t55b (C1 (p1a))) ; This check should fail
+; (neverallow t55b t55a (C1 (p1a))) ; This check should fail
+
+; Test 56
+(type t56a)
+(type t56b)
+(typeattribute a56a)
+(typeattributeset a56a (t56a t56b))
+(allow a56a self (C1 (p1a)))
+(deny t56a t56a (C1 (p1a)))
+(neverallow t56a t56a (C1 (p1a)))
+
+; Test 57
+(type t57a)
+(type t57b)
+(typeattribute a57a)
+(typeattributeset a57a (t57a t57b))
+(allow t57a t57a (C1 (p1a)))
+(deny a57a self (C1 (p1a)))
+(neverallow a57a self (C1 (p1a)))
+
+; Test 58
+(type t58a)
+(type t58b)
+(typeattribute a58a)
+(typeattributeset a58a (t58a t58b))
+(allow t58a self (C1 (p1a)))
+(deny a58a a58a (C1 (p1a)))
+(neverallow a58a a58a (C1 (p1a)))
+
+; Test 59
+(type t59a)
+(type t59b)
+(typeattribute a59a)
+(typeattributeset a59a (t59a t59b))
+(allow a59a a59a (C1 (p1a)))
+(deny t59a self (C1 (p1a)))
+(neverallow t59a self (C1 (p1a)))
+; (neverallow t59a t59b (C1 (p1a))) ; This check should fail
+; (neverallow t59b t59a (C1 (p1a))) ; This check should fail
+
+; Test 61
+(type t61a)
+(type t61b)
+(type t61c)
+(type t61d)
+(type t61e)
+(type t61f)
+(type t61g)
+(type t61h)
+(type t61i)
+(type t61j)
+(type t61k)
+(type t61l)
+(type t61m)
+(type t61n)
+(type t61o)
+(type t61p)
+(type t61q)
+(type t61r)
+(type t61s)
+(type t61t)
+(type t61u)
+(type t61v)
+(type t61w)
+(type t61x)
+(type t61y)
+(type t61z)
+(typeattribute a61a)
+(typeattribute a61b)
+(typeattribute a61c)
+(typeattribute a61d)
+(typeattributeset a61a (t61a t61b t61c t61d t61e t61f t61g t61h t61k t61l t61m t61n t61s t61t))
+(typeattributeset a61b (t61a t61b t61c t61d t61e t61f t61i t61j t61k t61l t61o t61p t61u t61v))
+(typeattributeset a61c (t61a t61b t61c t61d t61g t61h t61i t61j t61m t61n t61q t61r t61w t61x))
+(typeattributeset a61d (t61a t61b t61e t61f t61g t61h t61i t61j t61o t61p t61q t61r t61y t61z))
+(allow a61a a61b (C1 (p1a)))
+(deny a61c a61d (C1 (p1a)))
+(neverallow a61c a61d (C1 (p1a)))
+; Below should fail
+(typeattribute a61w)
+(typeattribute a61x)
+(typeattribute a61y)
+(typeattributeset a61w (t61e t61f t61k t61l t61s t61t)) ; a61a and not a61c
+(typeattributeset a61x (t61a t61b t61c t61d t61g t61h t61m t61n)) ; a61a and a61c
+(typeattributeset a61y (t61c t61d t61k t61l t61u t61v)) ; a61b and not a61d
+; (neverallow a61w a61b (C1 (p1a))) ; This check should fail
+; (neverallow a61x a61y (C1 (p1a))) ; This check should fail
+
+; Test 62
+(type t62a)
+(type t62b)
+(type t62c)
+(type t62d)
+(type t62e)
+(type t62f)
+(type t62g)
+(type t62h)
+(type t62i)
+(type t62j)
+(type t62k)
+(type t62l)
+(type t62m)
+(type t62n)
+(type t62o)
+(type t62p)
+(type t62q)
+(type t62r)
+(type t62u)
+(type t62v)
+(type t62w)
+(type t62x)
+(type t62y)
+(type t62z)
+(typeattribute a62a)
+(typeattribute a62b)
+(typeattribute a62c)
+(typeattribute a62d)
+(typeattributeset a62a (t62m))
+(typeattributeset a62b (t62a t62b t62c t62d t62e t62f t62i t62j t62k t62l t62o t62p t62u t62v))
+(typeattributeset a62c (t62a t62b t62c t62d t62g t62h t62i t62j t62m t62n t62q t62r t62w t62x))
+(typeattributeset a62d (t62a t62b t62e t62f t62g t62h t62i t62j t62o t62p t62q t62r t62y t62z))
+(allow a62a a62b (C1 (p1a)))
+(deny a62c a62d (C1 (p1a)))
+(neverallow a62c a62d (C1 (p1a)))
+; Below should fail
+(typeattribute a62x)
+(typeattribute a62y)
+(typeattributeset a62x (t62m)) ; a62a and a62c
+(typeattributeset a62y (t62c t62d t62k t62l t62u t62v)) ; a62b and not a62d
+; (neverallow a62x a62y (C1 (p1a))) ; This check should fail
+
+; Test 63
+(type t63a)
+(type t63b)
+(type t63c)
+(type t63d)
+(type t63e)
+(type t63f)
+(type t63g)
+(type t63h)
+(type t63i)
+(type t63j)
+(type t63k)
+(type t63l)
+(type t63m)
+(type t63n)
+(type t63o)
+(type t63p)
+(type t63q)
+(type t63r)
+(type t63s)
+(type t63t)
+(type t63w)
+(type t63x)
+(type t63y)
+(type t63z)
+(typeattribute a63a)
+(typeattribute a63b)
+(typeattribute a63c)
+(typeattribute a63d)
+(typeattributeset a63a (t63a t63b t63c t63d t63e t63f t63g t63h t63k t63l t63m t63n t63s t63t))
+(typeattributeset a63b (t63o))
+(typeattributeset a63c (t63a t63b t63c t63d t63g t63h t63i t63j t63m t63n t63q t63r t63w t63x))
+(typeattributeset a63d (t63a t63b t63e t63f t63g t63h t63i t63j t63o t63p t63q t63r t63y t63z))
+(allow a63a a63b (C1 (p1a)))
+(deny a63c a63d (C1 (p1a)))
+(neverallow a63c a63d (C1 (p1a)))
+; Below should fail
+(typeattribute a63w)
+(typeattributeset a63w (t63e t63f t63k t63l t63s t63t)) ; a63a and not a63c
+; (neverallow a63w a63b (C1 (p1a))) ; This check should fail
+
+; Test 64
+(type t64a)
+(type t64b)
+(type t64c)
+(type t64d)
+(type t64e)
+(type t64f)
+(type t64g)
+(type t64h)
+(type t64i)
+(type t64j)
+(type t64k)
+(type t64l)
+(type t64m)
+(type t64n)
+(type t64o)
+(type t64p)
+(type t64q)
+(type t64r)
+(type t64s)
+(type t64t)
+(type t64u)
+(type t64v)
+(type t64y)
+(type t64z)
+(typeattribute a64a)
+(typeattribute a64b)
+(typeattribute a64c)
+(typeattribute a64d)
+(typeattributeset a64a (t64a t64b t64c t64d t64e t64f t64g t64h t64k t64l t64m t64n t64s t64t))
+(typeattributeset a64b (t64a t64b t64c t64d t64e t64f t64i t64j t64k t64l t64o t64p t64u t64v))
+(typeattributeset a64c (t64m))
+(typeattributeset a64d (t64a t64b t64e t64f t64g t64h t64i t64j t64o t64p t64q t64r t64y t64z))
+(allow a64a a64b (C1 (p1a)))
+(deny a64c a64d (C1 (p1a)))
+(neverallow a64c a64d (C1 (p1a)))
+; Below should fail
+(typeattribute a64w)
+typeattribute a64x)
+(typeattribute a64y)
+(typeattributeset a64w (t64a t64b t64c t64d t64e t64f t64g t64h t64k t64l t64n t64s t64t)) ; a64a and not a64c
+(typeattributeset a64x (t64m)) ; a64a and a64c
+(typeattributeset a64y (t64c t64d t64k t64l t64u t64v)) ; a64b and not a64d
+; (neverallow a64w a64b (C1 (p1a))) ; This check should fail
+; (neverallow a64x a64y (C1 (p1a))) ; This check should fail
+
+; Test 65
+(type t65a)
+(type t65b)
+(type t65c)
+(type t65d)
+(type t65e)
+(type t65f)
+(type t65g)
+(type t65h)
+(type t65i)
+(type t65j)
+(type t65k)
+(type t65l)
+(type t65m)
+(type t65n)
+(type t65o)
+(type t65p)
+(type t65q)
+(type t65r)
+(type t65s)
+(type t65t)
+(type t65u)
+(type t65v)
+(type t65w)
+(type t65x)
+(typeattribute a65a)
+(typeattribute a65b)
+(typeattribute a65c)
+(typeattribute a65d)
+(typeattributeset a65a (t65a t65b t65c t65d t65e t65f t65g t65h t65k t65l t65m t65n t65s t65t))
+(typeattributeset a65b (t65a t65b t65c t65d t65e t65f t65i t65j t65k t65l t65o t65p t65u t65v))
+(typeattributeset a65c (t65a t65b t65c t65d t65g t65h t65i t65j t65m t65n t65q t65r t65w t65x))
+(typeattributeset a65d (t65o))
+(allow a65a a65b (C1 (p1a)))
+(deny a65c a65d (C1 (p1a)))
+(neverallow a65c a65d (C1 (p1a)))
+; Below should fail
+(typeattribute a65w)
+(typeattribute a65x)
+(typeattribute a65y)
+(typeattributeset a65w (t65e t65f t65k t65l t65s t65t)) ; a65a and not a65c
+(typeattributeset a65x (t65a t65b t65c t65d t65g t65h t65m t65n) ; a65a and a65c
+(typeattributeset a65y (t65a t65b t65c t65d t65e t65f t65i t65j t65k t65l t65p t65u t65v)) ; a65b and not a65d
+; (neverallow a65w a65b (C1 (p1a))) ; This check should fail
+; (neverallow a65x a65y (C1 (p1a))) ; This check should fail
+
+; Test 71
+(type t71a)
+(type t71b)
+(type t71c)
+(type t71d)
+(type t71e)
+(type t71f)
+(type t71g)
+(type t71h)
+(type t71i)
+(type t71j)
+(type t71k)
+(type t71l)
+(type t71m)
+(type t71n)
+(type t71o)
+(type t71p)
+(type t71q)
+(type t71r)
+(type t71s)
+(type t71t)
+(type t71w)
+(type t71x)
+(type t71y)
+(type t71z)
+(typeattribute a71a)
+(typeattribute a71c)
+(typeattribute a71d)
+(typeattributeset a71a (t71a t71b t71c t71d t71e t71f t71g t71h t71k t71l t71m t71n t71s t71t))
+(typeattributeset a71c (t71a t71b t71c t71d t71g t71h t71i t71j t71m t71n t71q t71r t71w t71x))
+(typeattributeset a71d (t71a t71b t71e t71f t71g t71h t71i t71j t71o t71p t71q t71r t71y t71z))
+(allow a71a self (C1 (p1a)))
+(deny a71c a71d (C1 (p1a)))
+(neverallow a71c a71d (C1 (p1a)))
+; Below should fail
+(typeattribute a71w)
+(typeattribute a71x)
+(typeattributeset a71w (t71e t71f t71k t71l t71s t71t)) ; a71a and not a71c
+(typeattributeset a71x (t71c t71d t71m t71n) ; (a71a and a71c) and not a71d
+; (neverallow a71w self (C1 (p1a))) ; This check should fail
+; (neverallow a71x self (C1 (p1a))) ; This check should fail
+
+; Test 72
+(type t72a)
+(type t72b)
+(type t72c)
+(type t72d)
+(type t72e)
+(type t72f)
+(type t72g)
+(type t72h)
+(type t72i)
+(type t72j)
+(type t72m)
+(type t72n)
+(type t72o)
+(type t72p)
+(type t72q)
+(type t72r)
+(type t72w)
+(type t72x)
+(type t72y)
+(type t72z)
+(typeattribute a72a)
+(typeattribute a72c)
+(typeattribute a72d)
+(typeattributeset a72a (t72g))
+(typeattributeset a72c (t72a t72b t72c t72d t72g t72h t72i t72j t72m t72n t72q t72r t72w t72x))
+(typeattributeset a72d (t72a t72b t72e t72f t72g t72h t72i t72j t72o t72p t72q t72r t72y t72z))
+(allow a72a self (C1 (p1a)))
+(deny a72c a72d (C1 (p1a)))
+(neverallow a72c a72d (C1 (p1a)))
+
+; Test 73
+(type t73a)
+(type t73b)
+(type t73c)
+(type t73d)
+(type t73e)
+(type t73f)
+(type t73g)
+(type t73h)
+(type t73i)
+(type t73j)
+(type t73k)
+(type t73l)
+(type t73m)
+(type t73n)
+(type t73o)
+(type t73p)
+(type t73q)
+(type t73r)
+(type t73s)
+(type t73t)
+(type t73y)
+(type t73z)
+(typeattribute a73a)
+(typeattribute a73c)
+(typeattribute a73d)
+(typeattributeset a73a (t73a t73b t73c t73d t73e t73f t73g t73h t73k t73l t73m t73n t73s t73t))
+(typeattributeset a73c (t73g))
+(typeattributeset a73d (t73a t73b t73e t73f t73g t73h t73i t73j t73o t73p t73q t73r t73y t73z))
+(allow a73a self (C1 (p1a)))
+(deny a73c a73d (C1 (p1a)))
+(neverallow a73c a73d (C1 (p1a)))
+; Below should fail
+(typeattribute a73w)
+(typeattributeset a73w (t73a t73b t73c t73d t73e t73f t73h t73k t73l t73m t73n t73s t73t)) ; a73a and not a73c
+; (neverallow a73w self (C1 (p1a))) ; This check should fail
+
+; Test 74
+(type t74a)
+(type t74b)
+(type t74c)
+(type t74d)
+(type t74e)
+(type t74f)
+(type t74g)
+(type t74h)
+(type t74i)
+(type t74j)
+(type t74k)
+(type t74l)
+(type t74m)
+(type t74n)
+(type t74q)
+(type t74r)
+(type t74s)
+(type t74t)
+(type t74w)
+(type t74x)
+(typeattribute a74a)
+(typeattribute a74c)
+(typeattribute a74d)
+(typeattributeset a74a (t74a t74b t74c t74d t74e t74f t74g t74h t74k t74l t74m t74n t74s t74t))
+(typeattributeset a74c (t74a t74b t74c t74d t74g t74h t74i t74j t74m t74n t74q t74r t74w t74x))
+(typeattributeset a74d (t74g))
+(allow a74a self (C1 (p1a)))
+(deny a74c a74d (C1 (p1a)))
+(neverallow a74c a74d (C1 (p1a)))
+; Below should fail
+(typeattribute a74w)
+(typeattribute a74x)
+(typeattributeset a74w (t74e t74f t74k t74l t74s t74t)) ; a74a and not a74c
+(typeattributeset a74x (t74a t74b t74c t74d t74h t74m t74n) ; (a74a and a74c) and not a74d
+; (neverallow a74w self (C1 (p1a))) ; This check should fail
+; (neverallow a74x self (C1 (p1a))) ; This check should fail
+
+; Test 81
+(type t81a)
+(type t81b)
+(type t81c)
+(type t81d)
+(type t81e)
+(type t81f)
+(type t81g)
+(type t81h)
+(type t81i)
+(type t81j)
+(type t81k)
+(type t81l)
+(type t81m)
+(type t81n)
+(type t81o)
+(type t81p)
+(type t81q)
+(type t81r)
+(type t81s)
+(type t81t)
+(type t81u)
+(type t81v)
+(type t81w)
+(type t81x)
+(typeattribute a81a)
+(typeattribute a81b)
+(typeattribute a81c)
+(typeattributeset a81a (t81a t81b t81c t81d t81e t81f t81g t81h t81k t81l t81m t81n t81s t81t))
+(typeattributeset a81b (t81a t81b t81c t81d t81e t81f t81i t81j t81k t81l t81o t81p t81u t81v))
+(typeattributeset a81c (t81a t81b t81c t81d t81g t81h t81i t81j t81m t81n t81q t81r t81w t81x))
+(allow a81a a81b (C1 (p1a)))
+(deny a81c self (C1 (p1a)))
+(neverallow a81c self (C1 (p1a)))
+; Below should fail
+(typeattribute a81w)
+(typeattribute a81x)
+(typeattribute a81y)
+(typeattribute a81z)
+(typeattribute a81ya)
+(typeattribute a81yb)
+(typeattribute a81yc)
+(typeattribute a81yd)
+(typeattributeset a81w (t63e t63f t63k t63l t63s t63t)) ; a81a and not a81c
+(typeattributeset a81x (t81a t81b t81c t81d)) ; a81a and a81c and a81b
+(typeattributeset a81y (t81g t81h t81m t81n)) ; (a81a and a81c) and not a81b
+(typeattributeset a81z (t81e t81f t81i t81j t81k t81l t81o t81p t81u t81v)) ; a81b and not (a81a and a81c)
+(typeattributeset a81ya (t81h t81m t81n))
+(typeattributeset a81yb (t81g t81m t81n))
+(typeattributeset a81yc (t81g t81h t81n))
+(typeattributeset a81yd (t81g t81h t81m))
+; (neverallow a81w a81b (C1 (p1a))) ; This check should fail
+; (neverallow a81y a81b (C1 (p1a))) ; This check should fail
+; (neverallow a81x a81z (C1 (p1a))) ; This check should fail
+; (neverallow t81g a81ya (C1 (p1a))) ; This check should fail
+; (neverallow t81h a81yb (C1 (p1a))) ; This check should fail
+; (neverallow t81m a81yc (C1 (p1a))) ; This check should fail
+; (neverallow t81n a81yd (C1 (p1a))) ; This check should fail
+
+; Test 82
+(type t82a)
+(type t82b)
+(type t82c)
+(type t82d)
+(type t82e)
+(type t82f)
+(type t82g)
+(type t82h)
+(type t82i)
+(type t82j)
+(type t82k)
+(type t82l)
+(type t82m)
+(type t82n)
+(type t82o)
+(type t82p)
+(type t82q)
+(type t82r)
+(type t82u)
+(type t82v)
+(type t82w)
+(type t82x)
+(typeattribute a82a)
+(typeattribute a82b)
+(typeattribute a82c)
+(typeattributeset a82a (t82c))
+(typeattributeset a82b (t82a t82b t82c t82d t82e t82f t82i t82j t82k t82l t82o t82p t82u t82v))
+(typeattributeset a82c (t82a t82b t82c t82d t82g t82h t82i t82j t82m t82n t82q t82r t82w t82x))
+(allow a82a a82b (C1 (p1a)))
+(deny a82c self (C1 (p1a)))
+(neverallow a82c self (C1 (p1a)))
+; Below should fail
+(typeattribute a82x)
+(typeattribute a82z)
+(typeattributeset a82x (t82c)) ; a82a and a82c and a82b
+(typeattributeset a82z (t82a t82b t82d t82e t82f t82i t82j t82k t82l t82o t82p t82u t82v)) ; a82b and not (a82a and a82c)
+; (neverallow a82x a82z (C1 (p1a))) ; This check should fail
+
+; Test 83
+(type t83a)
+(type t83b)
+(type t83c)
+(type t83d)
+(type t83e)
+(type t83f)
+(type t83g)
+(type t83h)
+(type t83i)
+(type t83j)
+(type t83k)
+(type t83l)
+(type t83m)
+(type t83n)
+(type t83q)
+(type t83r)
+(type t83s)
+(type t83t)
+(type t83w)
+(type t83x)
+(typeattribute a83a)
+(typeattribute a83b)
+(typeattribute a83c)
+(typeattributeset a83a (t83a t83b t83c t83d t83e t83f t83g t83h t83k t83l t83m t83n t83s t83t))
+(typeattributeset a83b (t83c))
+(typeattributeset a83c (t83a t83b t83c t83d t83g t83h t83i t83j t83m t83n t83q t83r t83w t83x))
+(allow a83a a83b (C1 (p1a)))
+(deny a83c self (C1 (p1a)))
+(neverallow a83c self (C1 (p1a)))
+; Below should fail
+(typeattribute a83w)
+(typeattribute a83y)
+(typeattribute a83ya)
+(typeattribute a83yb)
+(typeattribute a83yc)
+(typeattribute a83yd)
+(typeattribute a83ye)
+(typeattribute a83yf)
+(typeattribute a83yg)
+(typeattributeset a83w (t63e t63f t63k t63l t63s t63t)) ; a83a and not a83c
+(typeattributeset a83y (t83a t83b t83d t83g t83h t83m t83n)) ; (a83a and a83c) and not a83b
+(typeattributeset a83ya (t83b t83d t83g t83h t83m t83n))
+(typeattributeset a83yb (t83a t83d t83g t83h t83m t83n))
+(typeattributeset a83yc (t83a t83b t83g t83h t83m t83n))
+(typeattributeset a83yd (t83a t83b t83d t83h t83m t83n))
+(typeattributeset a83ye (t83a t83b t83d t83g t83m t83n))
+(typeattributeset a83yf (t83a t83b t83d t83g t83h t83n))
+(typeattributeset a83yg (t83a t83b t83d t83g t83h t83m))
+; (neverallow a83w a83b (C1 (p1a))) ; This check should fail
+; (neverallow a83y a83b (C1 (p1a))) ; This check should fail
+; (neverallow t83a a83ya (C1 (p1a))) ; This check should fail
+; (neverallow t83b a83yb (C1 (p1a))) ; This check should fail
+; (neverallow t83d a83yc (C1 (p1a))) ; This check should fail
+; (neverallow t83g a83yd (C1 (p1a))) ; This check should fail
+; (neverallow t83h a83ye (C1 (p1a))) ; This check should fail
+; (neverallow t83m a83yf (C1 (p1a))) ; This check should fail
+; (neverallow t83n a83yg (C1 (p1a))) ; This check should fail
+
+; Test 84
+(type t84a)
+(type t84b)
+(type t84c)
+(type t84d)
+(type t84e)
+(type t84f)
+(type t84g)
+(type t84h)
+(type t84i)
+(type t84j)
+(type t84k)
+(type t84l)
+(type t84m)
+(type t84n)
+(type t84o)
+(type t84p)
+(type t84q)
+(type t84r)
+(type t84s)
+(type t84t)
+(type t84u)
+(type t84v)
+(type t84w)
+(type t84x)
+(typeattribute a84a)
+(typeattribute a84b)
+(typeattribute a84c)
+(typeattributeset a84a (t84a t84b t84c t84d t84e t84f t84g t84h t84k t84l t84m t84n t84s t84t))
+(typeattributeset a84b (t84a t84b t84c t84d t84e t84f t84i t84j t84k t84l t84o t84p t84u t84v))
+(typeattributeset a84c (t84c))
+(allow a84a a84b (C1 (p1a)))
+(deny a84c self (C1 (p1a)))
+(neverallow a84c self (C1 (p1a)))
+; Below should fail
+(typeattribute a84w)
+(typeattribute a84x)
+(typeattribute a84z)
+(typeattributeset a84w (t84a t84b t84d t84e t84f t84g t84h t84k t84l t84m t84n t84s t84t)) ; a84a and not a84c
+(typeattributeset a84x (t84c)) ; a84a and a84c and a84b
+(typeattributeset a84z (t84a t84b t84d t84e t84f t84i t84j t84k t84l t84o t84p t84u t84v)) ; a84b and not (a84a and a84c)
+; (neverallow a84w a84b (C1 (p1a))) ; This check should fail
+; (neverallow a84x a84z (C1 (p1a))) ; This check should fail
+
+; Test 91
+(type t91a)
+(type t91b)
+(type t91c)
+(type t91d)
+(type t91e)
+(type t91f)
+(type t91g)
+(type t91h)
+(type t91i)
+(type t91j)
+(type t91k)
+(type t91l)
+(type t91m)
+(type t91n)
+(type t91q)
+(type t91r)
+(type t91s)
+(type t91t)
+(type t91w)
+(type t91x)
+(typeattribute a91a)
+(typeattribute a91c)
+(typeattributeset a91a (t91a t91b t91c t91d t91e t91f t91g t91h t91k t91l t91m t91n t91s t91t))
+(typeattributeset a91c (t91a t91b t91c t91d t91g t91h t91i t91j t91m t91n t91q t91r t91w t91x))
+(allow a91a self (C1 (p1a)))
+(deny a91c self (C1 (p1a)))
+(neverallow a91c self (C1 (p1a)))
+; Below should fail
+(typeattribute a91w)
+(typeattributeset a91w (t91e t91f t91k t91l t91s t91t)) ; a91a and not a91c
+; (neverallow a91w self (C1 (p1a))) ; This check should fail
+
+; Test 92
+(type t92a)
+(type t92b)
+(type t92c)
+(type t92d)
+(type t92g)
+(type t92h)
+(type t92i)
+(type t92j)
+(type t92m)
+(type t92n)
+(type t92q)
+(type t92r)
+(type t92w)
+(type t92x)
+(typeattribute a92a)
+(typeattribute a92c)
+(typeattributeset a92a (t92m))
+(typeattributeset a92c (t92a t92b t92c t92d t92g t92h t92i t92j t92m t92n t92q t92r t92w t92x))
+(allow a92a self (C1 (p1a)))
+(deny a92c self (C1 (p1a)))
+(neverallow a92c self (C1 (p1a)))
+
+; Test 93
+(type t93a)
+(type t93b)
+(type t93c)
+(type t93d)
+(type t93e)
+(type t93f)
+(type t93g)
+(type t93h)
+(type t93k)
+(type t93l)
+(type t93m)
+(type t93n)
+(type t93s)
+(type t93t)
+(typeattribute a93a)
+(typeattribute a93c)
+(typeattributeset a93a (t93a t93b t93c t93d t93e t93f t93g t93h t93k t93l t93m t93n t93s t93t))
+(typeattributeset a93c (t93m))
+(allow a93a self (C1 (p1a)))
+(deny a93c self (C1 (p1a)))
+(neverallow a93c self (C1 (p1a)))
+; Below should fail
+(typeattribute a93w)
+(typeattributeset a93w (t93a t93b t93c t93d t93e t93f t93g t93h t93k t93l t93n t93s t93t)) ; a93a and not a93c
+; (neverallow a93w self (C1 (p1a))) ; This check should fail
-- 
2.39.2

