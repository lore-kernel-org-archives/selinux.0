Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A9C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjKIN3x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIN3x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:29:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4C630CF
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:29:50 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77ba6d5123fso162546185a.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699536589; x=1700141389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lqj0axUqYNBzjyHqqYv4RU8V6LA+QVooet68xk0py0=;
        b=nSM7RSfvLt0OI7gUpcj9HTifqfVG2PBX/TFpmg1x/CjvGh4WlG7SlAbuWscv9/MpCC
         d+o3xgIitBypQhZnIp1qctJerAmK+MGhAqhTmf6TKB+Vy5BysZhEBzuYZ6PaSgj3oQXf
         jiaCBeX3XNSTuV426gDA2qv3GTyWwbGgieAb5Oqd8qHC/RP/22xp0d9T6xQkpAWdd1UE
         IpEldpz7M2O8QqQx3nuQwBBKyYiSpHNLX/J/+reikYW5WwgJAovHeGDN7igzMQRCFd7C
         ercUQdBa3j5hAZ+T+MJiXyuHQ1S4WJ22PK4iAOrD6vwHgEcXFIl08W4HAIEkcmipRBBf
         elcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536589; x=1700141389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Lqj0axUqYNBzjyHqqYv4RU8V6LA+QVooet68xk0py0=;
        b=Xrq7XXeA/s254ed+TO1+JxA3AS2A2gKeKEkuS9zDBtmNrj+hvtpAQY5YYAKw9n2RxK
         bLps8hL/ZUxiIwAITsx6QNdKfW17PSLl8CJpNXxpDet+vy/+Nxm53PhksCqb2g+gXDam
         TAYZuBCUG1gPqgqH3S4CylUjGDNkGrCVpRrvF3xdvHDxCFqjBWktVEHQJJiTEpmXmiL9
         AfCHnjVV3137rq1YFfwIH/nk9yizyafokMlnDBA0t3nWijoyLPn0lqi1mQ+dL7Jq2cVv
         R+uTDsfwJXL1gIbm9vj6y7Kzui/S/eZR9fNCUMQb4RLdeMsWK2mjXmAgUHHh/e5ESyzj
         9k1w==
X-Gm-Message-State: AOJu0YzMD/sTlalxqpIQra5qz2s2wjFqYeGTb13+hbdrosdraJc0r2GK
        Gbp2VEr/J1Bnby3EiEv5+/FTG0cGrVQ=
X-Google-Smtp-Source: AGHT+IFOovcd2zqmEsgB/8KWNPUZsb0TMWvQGcg0uoqgU1RW/qiUgHIeoLExlI/y3xgETBJ+vPnATA==
X-Received: by 2002:a05:620a:d4c:b0:779:e22e:1e8 with SMTP id o12-20020a05620a0d4c00b00779e22e01e8mr8167797qkl.36.1699536588904;
        Thu, 09 Nov 2023 05:29:48 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a004f00b007788c1a81b6sm2010451qkt.46.2023.11.09.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:29:48 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/tests: Update the order of neverallow test results
Date:   Thu,  9 Nov 2023 08:29:44 -0500
Message-ID: <20231109132944.3338574-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The patch set [1] by Christian Göttsche <cgzones@googlemail.com> to
use the DJB2a hash function caused the ordering of the reported
neverallow failures to change in the libsepol tests.

Change the expected test results to reflect the new ordering.

[1] https://lore.kernel.org/all/20230816123845.80171-1-cgzones@googlemail.com/

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/tests/test-neverallow.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-neverallow.c
index c0a2bfa8..7d6ad00e 100644
--- a/libsepol/tests/test-neverallow.c
+++ b/libsepol/tests/test-neverallow.c
@@ -101,10 +101,10 @@ static void test_neverallow_basic(void)
 		"neverallow on line 81 of policies/test-neverallow/policy.conf.std (or line 81 of policies/test-neverallow/policy.conf.std) violated by allow test5_t test5_t:file { read };",
 		"neverallow on line 89 of policies/test-neverallow/policy.conf.std (or line 89 of policies/test-neverallow/policy.conf.std) violated by allow test6_1_t test6_1_t:file { read };",
 		"neverallow on line 97 of policies/test-neverallow/policy.conf.std (or line 97 of policies/test-neverallow/policy.conf.std) violated by allow test7_1_t test7_1_t:file { read };",
-		"neverallow on line 106 of policies/test-neverallow/policy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violated by allow test8_t test8_t:file { write };",
 		"neverallow on line 106 of policies/test-neverallow/policy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violated by allow test8_t test8_t:file { read };",
-		"neverallow on line 115 of policies/test-neverallow/policy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violated by allow test9_t test9_t:file { read };",
+		"neverallow on line 106 of policies/test-neverallow/policy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violated by allow test8_t test8_t:file { write };",
 		"neverallow on line 115 of policies/test-neverallow/policy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violated by allow test9_t test9_t:file { write };",
+		"neverallow on line 115 of policies/test-neverallow/policy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violated by allow test9_t test9_t:file { read };",
 		"neverallow on line 124 of policies/test-neverallow/policy.conf.std (or line 124 of policies/test-neverallow/policy.conf.std) violated by allow test10_1_t test10_1_t:file { read };",
 		"neverallow on line 131 of policies/test-neverallow/policy.conf.std (or line 131 of policies/test-neverallow/policy.conf.std) violated by allow test11_t test11_t:process { dyntransition transition };",
 		"neverallow on line 143 of policies/test-neverallow/policy.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) violated by allow test12_3_t test12_1_t:file { getattr };",
@@ -162,22 +162,22 @@ static void test_neverallow_minus_self(void)
 		"33 neverallow failures occurred",
 		"neverallow on line 77 of policies/test-neverallow/policy_minus_self.conf.std (or line 77 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test3_1_t test3_2_t:file { read };",
 		"neverallow on line 85 of policies/test-neverallow/policy_minus_self.conf.std (or line 85 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test4_1_t test4_2_t:file { read };",
-		"neverallow on line 93 of policies/test-neverallow/policy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
 		"neverallow on line 93 of policies/test-neverallow/policy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
+		"neverallow on line 93 of policies/test-neverallow/policy_minus_self.conf.std (or line 93 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
 		"neverallow on line 101 of policies/test-neverallow/policy_minus_self.conf.std (or line 101 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
 		"neverallow on line 118 of policies/test-neverallow/policy_minus_self.conf.std (or line 118 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
 		"neverallow on line 127 of policies/test-neverallow/policy_minus_self.conf.std (or line 127 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
 		"neverallow on line 137 of policies/test-neverallow/policy_minus_self.conf.std (or line 137 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
 		"neverallow on line 157 of policies/test-neverallow/policy_minus_self.conf.std (or line 157 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
 		"neverallow on line 166 of policies/test-neverallow/policy_minus_self.conf.std (or line 166 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
-		"neverallow on line 175 of policies/test-neverallow/policy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
 		"neverallow on line 175 of policies/test-neverallow/policy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
-		"neverallow on line 193 of policies/test-neverallow/policy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
+		"neverallow on line 175 of policies/test-neverallow/policy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
 		"neverallow on line 193 of policies/test-neverallow/policy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
+		"neverallow on line 193 of policies/test-neverallow/policy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
 		"neverallowxperm on line 201 of policies/test-neverallow/policy_minus_self.conf.std (or line 201 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl };",
 		"neverallowxperm on line 219 of policies/test-neverallow/policy_minus_self.conf.std (or line 219 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl { 0x101-0x102 };",
-		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
 		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl { 0x103 };",
+		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
 		"neverallowxperm on line 261 of policies/test-neverallow/policy_minus_self.conf.std (or line 261 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl { 0x9511 };",
 		"neverallowxperm on line 272 of policies/test-neverallow/policy_minus_self.conf.std (or line 272 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl { 0x9511 };",
 		"neverallowxperm on line 283 of policies/test-neverallow/policy_minus_self.conf.std (or line 283 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0x9511 };",
@@ -185,10 +185,10 @@ static void test_neverallow_minus_self(void)
 		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
 		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
 		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
 		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };",
-		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
 		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };",
+		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
 		"neverallowxperm on line 337 of policies/test-neverallow/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
 		"neverallowxperm on line 337 of policies/test-neverallow/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
 		"neverallowxperm on line 348 of policies/test-neverallow/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
@@ -231,23 +231,23 @@ static void test_neverallow_not_self(void)
 		"34 neverallow failures occurred",
 		"neverallow on line 78 of policies/test-neverallow/policy_not_self.conf.std (or line 78 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test3_1_t test3_2_t:file { read };",
 		"neverallow on line 86 of policies/test-neverallow/policy_not_self.conf.std (or line 86 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test4_1_t test4_2_t:file { read };",
-		"neverallow on line 94 of policies/test-neverallow/policy_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
 		"neverallow on line 94 of policies/test-neverallow/policy_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test5_2_t test5_1_t:class5 { perm };",
+		"neverallow on line 94 of policies/test-neverallow/policy_not_self.conf.std (or line 94 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test5_1_t test5_2_t:class5 { perm };",
 		"neverallow on line 102 of policies/test-neverallow/policy_not_self.conf.std (or line 102 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test6_1_t test6_2_t:class6 { perm };",
 		"neverallow on line 119 of policies/test-neverallow/policy_not_self.conf.std (or line 119 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test8_1_t test8_2_t:file { read };",
 		"neverallow on line 128 of policies/test-neverallow/policy_not_self.conf.std (or line 128 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test9_1_t test9_2_t:file { read };",
 		"neverallow on line 138 of policies/test-neverallow/policy_not_self.conf.std (or line 138 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test10_1_t test10_2_t:file { read };",
 		"neverallow on line 158 of policies/test-neverallow/policy_not_self.conf.std (or line 158 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test12_1_t test12_2_t:file { read };",
 		"neverallow on line 167 of policies/test-neverallow/policy_not_self.conf.std (or line 167 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
-		"neverallow on line 176 of policies/test-neverallow/policy_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
 		"neverallow on line 176 of policies/test-neverallow/policy_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test14_2_t test14_1_t:file { read };",
+		"neverallow on line 176 of policies/test-neverallow/policy_not_self.conf.std (or line 176 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
 		"neverallow on line 185 of policies/test-neverallow/policy_not_self.conf.std (or line 185 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
-		"neverallow on line 194 of policies/test-neverallow/policy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
 		"neverallow on line 194 of policies/test-neverallow/policy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
+		"neverallow on line 194 of policies/test-neverallow/policy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
 		"neverallowxperm on line 202 of policies/test-neverallow/policy_not_self.conf.std (or line 202 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl };",
 		"neverallowxperm on line 220 of policies/test-neverallow/policy_not_self.conf.std (or line 220 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl { 0x101-0x102 };",
-		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
 		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl { 0x103 };",
+		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
 		"neverallowxperm on line 262 of policies/test-neverallow/policy_not_self.conf.std (or line 262 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl { 0x9511 };",
 		"neverallowxperm on line 273 of policies/test-neverallow/policy_not_self.conf.std (or line 273 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl { 0x9511 };",
 		"neverallowxperm on line 284 of policies/test-neverallow/policy_not_self.conf.std (or line 284 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0x9511 };",
@@ -255,10 +255,10 @@ static void test_neverallow_not_self(void)
 		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
 		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
 		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
 		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };",
-		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
 		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };",
+		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
 		"neverallowxperm on line 338 of policies/test-neverallow/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
 		"neverallowxperm on line 338 of policies/test-neverallow/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
 		"neverallowxperm on line 349 of policies/test-neverallow/policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
-- 
2.41.0

