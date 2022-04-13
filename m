Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C570C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 16:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiDMQH7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiDMQHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 12:07:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A2644C3
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:05:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v4so2961742edl.7
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChcX0IA6gfWYvW+mwwz4Xx71w/VgH1MbMQOzwDnDWg0=;
        b=B0+cL230JsGRuza3n+zHl+dFuyWY6lMpIy5r/YdGXLxfQjE16FVMevhh24VafC0Nu0
         eKlkoKVf8QqjQwEz+uaInzEGsl35MJS4CrsOT/p649eJ2KlCiuXXglbdbvqYl/1/JxGX
         7z8uFjvHfiZycxs+jEsBd4yptle37+ajdbpKseN0gjGPCDarYMqmTTcvPq5goRv9+FGx
         z/NJuR/13mSsfvO4A9y0ndU4XLRAmVCfwcb5WpwQ7Svmm1xJSP/Erv7hRrSHNNltAGLT
         bOPyZvfsu3hUW2ELAnOwaDjtaoglFTC/PsnFeEakwFSCrYR34o7imui4EkimPX6IMbkc
         qDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChcX0IA6gfWYvW+mwwz4Xx71w/VgH1MbMQOzwDnDWg0=;
        b=5JyLS20nkklde7UQAG9YCWcb71aHaH1jXW3w+hBFINxjhwM6WA/iaVbEFAIS6qmj8T
         fuSetF+e111KFHAB4WCNUb/zRYvHWfOazYbjoI5ZJZfhGyS4hzTz9CtP2KZVQRVU3Du7
         afzxpyClZofSIIlsdxfCIRcukFSExwlKc6zP53gmzu7hdFaGR8zH+3xxwxu6vlAhGAXT
         8t16U/IiQuJFZLxZS8T2wle/9LidP7miNjxuhwvtZssJKMZJCMwUNqyZHLcfK1M8rCt/
         scYQbqoLr2+ewpT6caSBRC07hPCodNy1Ba2Fno6K75LdMWdC+TYZWZUjcI0F3hJ6nV9z
         QSMg==
X-Gm-Message-State: AOAM530GfoZhJ5mDS/nEhyIqx1wTyKxfTUE/hUYyFsV6G5PYeiITxhJd
        ITnbXNakDEMEjj5BUJV7tH1FF+3i+48=
X-Google-Smtp-Source: ABdhPJx631bSuCaOhzBhg5JtYV6vZ6AavSIWOj/3/k5MVDygH/RaUGw4Zeagv2xbBXlj08acglicQg==
X-Received: by 2002:a05:6402:11d0:b0:419:65c5:cde4 with SMTP id j16-20020a05640211d000b0041965c5cde4mr44966109edw.73.1649865921802;
        Wed, 13 Apr 2022 09:05:21 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-215-252.77.0.pool.telefonica.de. [77.0.215.252])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm1354259edt.70.2022.04.13.09.05.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:05:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/tests: adjust IPv6 netmasks
Date:   Wed, 13 Apr 2022 18:05:17 +0200
Message-Id: <20220413160517.64145-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

checkpolicy(8) since 01b88ac3 ("checkpolicy: warn on bogus IP address or
netmask in nodecon statement") warns about host bits set in IPv6
addresses.
Adjust IPv6 netmasks in the libsepol tests so that the used address ::1
does not set any host bits and running the tests does not print several
of the following warnings:

    net_contexts:15:WARNING 'host bits in ipv6 address set' at token '' on line 594:

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/tests/policies/test-deps/base-metreq.conf    | 2 +-
 libsepol/tests/policies/test-deps/base-notmetreq.conf | 2 +-
 libsepol/tests/policies/test-deps/small-base.conf     | 2 +-
 libsepol/tests/policies/test-expander/alias-base.conf | 2 +-
 libsepol/tests/policies/test-expander/role-base.conf  | 2 +-
 libsepol/tests/policies/test-expander/small-base.conf | 2 +-
 libsepol/tests/policies/test-expander/user-base.conf  | 2 +-
 libsepol/tests/policies/test-hooks/cmp_policy.conf    | 2 +-
 libsepol/tests/policies/test-hooks/small-base.conf    | 2 +-
 libsepol/tests/policies/test-linker/small-base.conf   | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libsepol/tests/policies/test-deps/base-metreq.conf b/libsepol/tests/policies/test-deps/base-metreq.conf
index 3e2f8407..b7528dde 100644
--- a/libsepol/tests/policies/test-deps/base-metreq.conf
+++ b/libsepol/tests/policies/test-deps/base-metreq.conf
@@ -516,7 +516,7 @@ genfscon proc /				gen_context(system_u:object_r:sys_foo_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:net_foo_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-deps/base-notmetreq.conf b/libsepol/tests/policies/test-deps/base-notmetreq.conf
index 8ff3d204..eee36dca 100644
--- a/libsepol/tests/policies/test-deps/base-notmetreq.conf
+++ b/libsepol/tests/policies/test-deps/base-notmetreq.conf
@@ -503,7 +503,7 @@ genfscon proc /				gen_context(system_u:object_r:sys_foo_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:net_foo_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-deps/small-base.conf b/libsepol/tests/policies/test-deps/small-base.conf
index 1411e624..98f49c23 100644
--- a/libsepol/tests/policies/test-deps/small-base.conf
+++ b/libsepol/tests/policies/test-deps/small-base.conf
@@ -504,7 +504,7 @@ genfscon proc /				gen_context(system_u:object_r:sys_foo_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:net_foo_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/libsepol/tests/policies/test-expander/alias-base.conf
index 57d4520e..b950039d 100644
--- a/libsepol/tests/policies/test-expander/alias-base.conf
+++ b/libsepol/tests/policies/test-expander/alias-base.conf
@@ -494,7 +494,7 @@ genfscon proc /				gen_context(system_u:object_r:system_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:system_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/libsepol/tests/policies/test-expander/role-base.conf
index a603390b..8e88b4be 100644
--- a/libsepol/tests/policies/test-expander/role-base.conf
+++ b/libsepol/tests/policies/test-expander/role-base.conf
@@ -476,7 +476,7 @@ genfscon proc /				gen_context(system_u:object_r:system_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:system_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-expander/small-base.conf b/libsepol/tests/policies/test-expander/small-base.conf
index 20005e3f..055ea054 100644
--- a/libsepol/tests/policies/test-expander/small-base.conf
+++ b/libsepol/tests/policies/test-expander/small-base.conf
@@ -714,7 +714,7 @@ genfscon proc /				gen_context(system_u:object_r:sys_foo_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:net_foo_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:net_foo_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/libsepol/tests/policies/test-expander/user-base.conf
index 1f84fd76..b31ee8cd 100644
--- a/libsepol/tests/policies/test-expander/user-base.conf
+++ b/libsepol/tests/policies/test-expander/user-base.conf
@@ -480,7 +480,7 @@ genfscon proc /				gen_context(system_u:object_r:system_t, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 system_u:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(system_u:object_r:system_t, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(system_u:object_r:system_t, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-hooks/cmp_policy.conf b/libsepol/tests/policies/test-hooks/cmp_policy.conf
index 1eccf4a8..9082b333 100644
--- a/libsepol/tests/policies/test-hooks/cmp_policy.conf
+++ b/libsepol/tests/policies/test-hooks/cmp_policy.conf
@@ -464,7 +464,7 @@ genfscon proc /				gen_context(g_b_user_1:object_r:g_b_type_1, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_type_1, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_user_1:object_r:g_b_type_1, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-hooks/small-base.conf b/libsepol/tests/policies/test-hooks/small-base.conf
index 1eccf4a8..9082b333 100644
--- a/libsepol/tests/policies/test-hooks/small-base.conf
+++ b/libsepol/tests/policies/test-hooks/small-base.conf
@@ -464,7 +464,7 @@ genfscon proc /				gen_context(g_b_user_1:object_r:g_b_type_1, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_type_1, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_user_1:object_r:g_b_type_1, s0)
 
 
 
diff --git a/libsepol/tests/policies/test-linker/small-base.conf b/libsepol/tests/policies/test-linker/small-base.conf
index 2bc14656..890ebbeb 100644
--- a/libsepol/tests/policies/test-linker/small-base.conf
+++ b/libsepol/tests/policies/test-linker/small-base.conf
@@ -593,7 +593,7 @@ genfscon proc /				gen_context(g_b_user_1:object_r:g_b_type_1, s0)
 #
 #nodecon 127.0.0.1 255.255.255.255 g_b_user_1:object_r:net_foo_t:s0
 
-nodecon ::1 FFFF:FFFF:FFFF:FFFF:: gen_context(g_b_user_1:object_r:g_b_type_1, s0)
+nodecon ::1 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF gen_context(g_b_user_1:object_r:g_b_type_1, s0)
 
 
 
-- 
2.35.2

