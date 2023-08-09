Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CCC04A94
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHIUk6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjHIUk5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:40:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA22B4
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:40:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76c845dc5beso18600285a.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691613655; x=1692218455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdAXdjPlcJJZnuSjjAZTF+V3dXht2gjja8vY+HRLBug=;
        b=VYmNge/TV1nDvZyGzMoSGhd9oLqBEG8YY/3zl1yelyjswrhRq3GmgzR0Ey7+WdxX2E
         +PilMd8GWZkM8YA0PCPwx+FpeTaAgO0z2f9kDl391Hc2QG6tKeFvgdTbEeQr38/LDRcH
         qT0IeDHmRB/UpE8ljL5HLXFhN2q8ut6Rv3txVgH6nytYOoIl1aXJg9K2RMhNaUDPmRfD
         RUc2CF2uf17ShCBDsKk6YcnlXgavOB9tzYY8yKOV3FjDdrir3aC94Ah5uETF/B9cCv+0
         zDV+3KAf7XZlKec2xt98LBP1nw+k9NrtMaoXo14y5aDmWkdXKR9Wlutv4tvicHjrQec/
         /VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613655; x=1692218455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdAXdjPlcJJZnuSjjAZTF+V3dXht2gjja8vY+HRLBug=;
        b=fzFGA4LheAgouBzwZAMBdoro/O5XKN2AyUu6GyCeOmJw08Ryd7gv8+FExg1lzb3lrC
         FTJMOOOz6MbgCtOT1VC50cr5PosKNoWkheF4kDSW3JKCldl9SbWGOpCpXwHUepxHpFgt
         NhGAv9SJPuqZnZX/jvSE0EohuVdxXgHcjxKFwqE1Y/8NEIhqgY2/+sSY+XbRUnL+xM4G
         +W9tNVo+qrbHyqSogdX28GjyflfilojrcBzsI5TvCxKINK41UUnk4ynhU9lVXoEyunlv
         T3dorin80a+WvGJ4cxcy+yiepKzZAfYzRxMlDSKEKmg8Xo54qEdjLUPuFVJN+X23iflL
         VP4g==
X-Gm-Message-State: AOJu0YyWsmW0Hj8MDnbtqumfzBkT4wpLFYkQ05DPwU4kApPLoYau1nKO
        WqJnAbKWjMo4zPulHUY7SS30BvVsQyw=
X-Google-Smtp-Source: AGHT+IEAIZ2xMRqJB9d0474EfMo9UlrekK+BJs7EFMBjpU/JIadD9BMVv1AF76Dp1q0pm9wH16zzdg==
X-Received: by 2002:a05:622a:52:b0:40d:4c6:bcdf with SMTP id y18-20020a05622a005200b0040d04c6bcdfmr600797qtw.35.1691613655660;
        Wed, 09 Aug 2023 13:40:55 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b0041020e8e261sm711295qtx.1.2023.08.09.13.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:40:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, cgzones@googlemail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 7/7 v2] secilc/test: Add notself and other tests
Date:   Wed,  9 Aug 2023 16:40:46 -0400
Message-ID: <20230809204046.110783-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809204046.110783-1-jwcart2@gmail.com>
References: <20230809204046.110783-1-jwcart2@gmail.com>
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
2.41.0

