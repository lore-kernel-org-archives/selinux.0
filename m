Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7490DC77B6E
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 21:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDLVEe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDLVES (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 17:04:18 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F915244
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:17 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z3so4642123qvs.8
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333453; x=1683925453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3or0EyPzoOoHWymTfEZiSJxfKOg7J1n6Iw5ufQ3oWU=;
        b=ZmiEH/RdrHsMyn4NRPbyxTYKhDu52zca7hyHB3fqQY/WsjGjx2jk44j7wSPJy6jAaS
         EvXWQsxc8RWdg9EztVWEwoOV5BzDZc/WTN9QolRW4I3scKHMtO3bxD2bNJiB7Ku/z5Gs
         eFDmcdd5IfIEQCpk6VCPp5jxDNpaLD6dJPEdgjvQ50G+uwwLze8sNSSogKrFiuHNpBH4
         Jo7dBCkf80ceyWq8+JKZUHskP6/PNszSZtEqQJ00J8skUFhRbyn/p6bOZwqeucwuY3Gq
         dt24z4/3KFvNwdg0TDmpe1vLgAqbFXrVYjyIdICW9vmhrq6xERUhRA+OvcDymq+Gc2LF
         yECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333453; x=1683925453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3or0EyPzoOoHWymTfEZiSJxfKOg7J1n6Iw5ufQ3oWU=;
        b=WthSkm83i73DfgYvxynMDjrf4WgeseUTwjhvK6qlIuNGexo/U9NWLbp/VRSGdAFeaQ
         rZbFqy16HFSWBuv/eRsfTbF88SMKeUgcvS545vrS9xQFEe1GsQYyl/OUuvxcDOnDQ+/n
         6t5Qa3Oxt+JVHXMRyuR68JrObX5NFGodJYXIQouULi60G+4t4+cm5OhZfcxlxzW8BB0o
         Pq0oBz0qvny/vM6ZEo58iSZnYLLOWVz04toKU65vAyd0wAAuRss5KamzwHkjy14oiSS5
         Hvyk/FU/EpXdSoS2M1HlYNZ1s5IsU4ppIcn2QMB5gnY/tqM8qcu937UppU2hskyxd+pr
         C/SQ==
X-Gm-Message-State: AAQBX9dxXrgQsr1OJaTjDEB687+X+DdLlJSzlhBCQrMWxIpLBzxQFL+U
        1gTexwIRGNkxfPLH5gg9dkTbPrASpFU=
X-Google-Smtp-Source: AKy350af+U4smig58IfgPX/h/WNJi9jUnVdIGjS+OFHOFMOUGa57OGSoq3ZxvTQwb8NkhevESvEVSw==
X-Received: by 2002:ad4:5743:0:b0:5e9:46d:fb52 with SMTP id q3-20020ad45743000000b005e9046dfb52mr987247qvx.34.1681333453309;
        Wed, 12 Apr 2023 14:04:13 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm5025758qvb.104.2023.04.12.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:13 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6] secilc/test: Add notself and other tests
Date:   Wed, 12 Apr 2023 17:04:06 -0400
Message-Id: <20230412210406.522892-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412210406.522892-1-jwcart2@gmail.com>
References: <20230412210406.522892-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/test/notself_and_other.cil | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 secilc/test/notself_and_other.cil

diff --git a/secilc/test/notself_and_other.cil b/secilc/test/notself_and_other.cil
new file mode 100644
index 00000000..9b33bfcb
--- /dev/null
+++ b/secilc/test/notself_and_other.cil
@@ -0,0 +1,65 @@
+(class CLASS (PERM))
+(class C1 (p1a p1b p1c p1d p1e))
+(classorder (CLASS C1))
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
+(type ta)
+(type tb)
+(type tc)
+(type td)
+
+(typeattribute aab)
+(typeattributeset aab (ta tb))
+
+(typeattribute aac)
+(typeattributeset aac (ta tc))
+
+(typeattribute abc)
+(typeattributeset abc (tb tc))
+
+(typeattribute aabc)
+(typeattributeset aabc (ta tb tc))
+
+(typeattribute a_all_not_ta)
+(typeattributeset a_all_not_ta (and (all) (not ta)))
+
+(typeattribute a_all_not_aab)
+(typeattributeset a_all_not_aab (and (all) (not aab)))
+
+; Test 01
+(allow ta notself (C1 (p1a)))
+; (neverallow ta a_all_not_ta (C1 (p1a))) ; This check should fail
+
+; Test 02
+(allow aab notself (C1 (p1b)))
+; (neverallow aab a_all_not_aab (C1 (p1b))) ; This check should fail
+
+; Test 03
+(allow aab other (C1 (p1c)))
+; (neverallow ta tb (C1 (p1c))) ; This check should fail
+; (neverallow tb ta (C1 (p1c))) ; This check should fail
+
+; Test 04
+(allow aabc other (C1 (p1d)))
+; (neverallow ta abc (C1 (p1d))) ; This check should fail
+; (neverallow tb aac (C1 (p1d))) ; This check should fail
+; (neverallow tc aab (C1 (p1d))) ; This check should fail
+
+; Test 05
+(allow ta other (C1 (p1e))) ; other used with a single type results in no rule
+(neverallow ta a_all_not_ta (C1 (p1e)))
-- 
2.39.2

