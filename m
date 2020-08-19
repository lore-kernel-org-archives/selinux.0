Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4BC433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C920882
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="o9/YzJzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHSPFz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgHSPFs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 11:05:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB504C061383
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:05:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m20so18395102eds.2
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MtGpYyGp/kpRk+QtQyP/L47DdXNqhkrRCAomMgBgGAg=;
        b=o9/YzJzYwIeIcFDBYQRVnqzG4EY05d6PBrceTlLQ0I8IqEMFK5wIq8noWErQFbKNgS
         bwQbKEhiorfkdohQ5WmFugb6nGRPH5AvpIcCY/UkCBvbZpv6N6e8sAfNJ+Q8TBO7fv0H
         jqO+wZpj+fj3vXh7w/ho/4ZhFs/eo5T66wVPeNnVO16oMerwkLsBYIEZ3e75wC4Vylvj
         ZE+SJKp50s2Tn7nOAgKqwltqEAbxXnM8i96rU7PZOcN64EkFZds621PSSmJtMBR4nzxx
         QqlIhB/lOz0E8IV5DZtlmvSHYtJnVkM+mvyZroF1pqGXUEW6zh5ejiGzR7ZCp4MUzCXX
         bI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MtGpYyGp/kpRk+QtQyP/L47DdXNqhkrRCAomMgBgGAg=;
        b=aKOWRtehCnrO/sskJ5cDJ7faKXOOYpLYX1s0Fpi0YN9/DrYBwFXrUMdpp3dQP0zwit
         opCcHao9gmrMoG61XDpMOnVfS6NAz89W3hpzM5i1hbHQmR86CC+pRKtnRkjOn2Ofl5WA
         zb0dOhd4RaisJCd6RhE/bXZ1E8d58r925s+z5E0/coMZD92mCGqwcLErwM8kIBnV693a
         Dht+ZUgdLeehbzr69uwED/Sk45yqhRSC8CbfCHg6CHOu3/wklpk87R/dnDCZYJMQvUEF
         xWlfVCFhld4BwngaQKDw05lPoUsA5PR2Qnht+AeZyTdfpg/3a9fuym8IIp86CRt5zzd9
         yGFA==
X-Gm-Message-State: AOAM533wFQLyLVv9nRygLbfnpxUQYem2WsTTHAc1TvHKWkpFdy0Mln8f
        siAKIp7o37XYj4ANx5sONmkC7pnMB9U=
X-Google-Smtp-Source: ABdhPJwGdxvIaAakn8MR+2aTNs0GKitQ/tAzvEIe/LlA2W+cumjo2TjUq/q3hnn+TcFkQyhjYjgkTg==
X-Received: by 2002:a50:ec90:: with SMTP id e16mr25796223edr.234.1597849542092;
        Wed, 19 Aug 2020 08:05:42 -0700 (PDT)
Received: from debianHome.localdomain (x4d018a81.dyn.telefonica.de. [77.1.138.129])
        by smtp.gmail.com with ESMTPSA id k6sm18932921ejj.41.2020.08.19.08.05.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:05:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] sepolgen: print extended permissions in hexadecimal
Date:   Wed, 19 Aug 2020 17:05:33 +0200
Message-Id: <20200819150534.18026-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All tools like ausearch(8) or sesearch(1) and online documentation[1]
use hexadecimal values for extended permissions.
Hence use them, e.g. for audit2allow output, as well.

[1]: https://github.com/strace/strace/blob/master/linux/64/ioctls_inc.h

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/sepolgen/src/sepolgen/refpolicy.py |  5 ++---
 python/sepolgen/tests/test_access.py      | 10 +++++-----
 python/sepolgen/tests/test_refpolicy.py   | 12 ++++++------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 43cecfc7..74763687 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -407,10 +407,9 @@ class XpermSet():
 
         # print single value without braces
         if len(self.ranges) == 1 and self.ranges[0][0] == self.ranges[0][1]:
-            return compl + str(self.ranges[0][0])
+            return compl + hex(self.ranges[0][0])
 
-        vals = map(lambda x: str(x[0]) if x[0] == x[1] else "%s-%s" % x,
-                   self.ranges)
+        vals = map(lambda x: hex(x[0]) if x[0] == x[1] else "%s-%s" % (hex(x[0]), hex(x[1]), ), self.ranges)
 
         return "%s{ %s }" % (compl, " ".join(vals))
 
diff --git a/python/sepolgen/tests/test_access.py b/python/sepolgen/tests/test_access.py
index 73a5407d..623588e0 100644
--- a/python/sepolgen/tests/test_access.py
+++ b/python/sepolgen/tests/test_access.py
@@ -171,7 +171,7 @@ class TestAccessVector(unittest.TestCase):
         a.merge(b)
         self.assertEqual(sorted(list(a.perms)), ["append", "read", "write"])
         self.assertEqual(list(a.xperms.keys()), ["ioctl"])
-        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 42 12345 }")
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 0x2a 0x3039 }")
 
     def text_merge_xperm2(self):
         """Test merging AV that does not contain xperms with AV that does"""
@@ -185,7 +185,7 @@ class TestAccessVector(unittest.TestCase):
         a.merge(b)
         self.assertEqual(sorted(list(a.perms)), ["append", "read", "write"])
         self.assertEqual(list(a.xperms.keys()), ["ioctl"])
-        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 42 12345 }")
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 0x2a 0x3039 }")
 
     def test_merge_xperm_diff_op(self):
         """Test merging two AVs that contain xperms with different operation"""
@@ -203,8 +203,8 @@ class TestAccessVector(unittest.TestCase):
         a.merge(b)
         self.assertEqual(list(a.perms), ["read"])
         self.assertEqual(sorted(list(a.xperms.keys())), ["asdf", "ioctl"])
-        self.assertEqual(a.xperms["asdf"].to_string(), "23")
-        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 42 12345 }")
+        self.assertEqual(a.xperms["asdf"].to_string(), "0x17")
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 0x2a 0x3039 }")
                          
     def test_merge_xperm_same_op(self):
         """Test merging two AVs that contain xperms with same operation"""
@@ -222,7 +222,7 @@ class TestAccessVector(unittest.TestCase):
         a.merge(b)
         self.assertEqual(list(a.perms), ["read"])
         self.assertEqual(list(a.xperms.keys()), ["ioctl"])
-        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 23 42 12345 }")
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 0x17 0x2a 0x3039 }")
 
 class TestUtilFunctions(unittest.TestCase):
     def test_is_idparam(self):
diff --git a/python/sepolgen/tests/test_refpolicy.py b/python/sepolgen/tests/test_refpolicy.py
index 4b50c8aa..c7219fd5 100644
--- a/python/sepolgen/tests/test_refpolicy.py
+++ b/python/sepolgen/tests/test_refpolicy.py
@@ -90,17 +90,17 @@ class TestXpermSet(unittest.TestCase):
         a.complement = True
         self.assertEqual(a.to_string(), "")
         a.add(1234)
-        self.assertEqual(a.to_string(), "~ 1234")
+        self.assertEqual(a.to_string(), "~ 0x4d2")
         a.complement = False
-        self.assertEqual(a.to_string(), "1234")
+        self.assertEqual(a.to_string(), "0x4d2")
         a.add(2345)
-        self.assertEqual(a.to_string(), "{ 1234 2345 }")
+        self.assertEqual(a.to_string(), "{ 0x4d2 0x929 }")
         a.complement = True
-        self.assertEqual(a.to_string(), "~ { 1234 2345 }")
+        self.assertEqual(a.to_string(), "~ { 0x4d2 0x929 }")
         a.add(42,64)
-        self.assertEqual(a.to_string(), "~ { 42-64 1234 2345 }")
+        self.assertEqual(a.to_string(), "~ { 0x2a-0x40 0x4d2 0x929 }")
         a.complement = False
-        self.assertEqual(a.to_string(), "{ 42-64 1234 2345 }")
+        self.assertEqual(a.to_string(), "{ 0x2a-0x40 0x4d2 0x929 }")
 
 class TestSecurityContext(unittest.TestCase):
     def test_init(self):
-- 
2.28.0

