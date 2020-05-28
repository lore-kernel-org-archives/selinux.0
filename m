Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832BC433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A3F206F1
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XQ9yjlQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbgE1Mvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389873AbgE1Mvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 08:51:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D163AC05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:51:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so31896312ejb.10
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J78XCAOgkvD7tEFcNfkx/1vf0ojFsMHQHQDKQnJyJO4=;
        b=XQ9yjlQYJK6FKLbOe9rwomBAdZpaI21tOrcUsZzOjyzkL+NNnjwRWteGwmAXZMjbn/
         YW2lz2xAtb7rXL+QRKh7SxEUFWHMkKecq3o5QeWZp1widYmuJCvJhItj/6MTtsXpDAcd
         13kXKN4bww2wvM9+kCN4YjKfVy0ZIa8tyxxUhx08PRLWdrECjMa43yz0Lr2ir6lG+3Tp
         K0xpAaCg0nThbkwd3EKkc6ivEpLbCx5FzNWMMrUlX8SfHEm7kGPiVmGhKskvZ9IIm8El
         C5osEPC24JbUmqgW8WngoD0Xf6jaTwhV+FMjkmKe8NoqZVTJ2XdfUsmic66b4Z3g/iAU
         yDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J78XCAOgkvD7tEFcNfkx/1vf0ojFsMHQHQDKQnJyJO4=;
        b=nNR7U0Xm05D16sSIV7Enip7jZxrmmiG3g3mObgeifK0TG9fXR4U2xGvh52KlA7jl7w
         5DnII2tBEPioVDxc+Fizzb2ac++XBTxZpS/MjHJmERJOzSY/w/XSCxz9kU4Jns8c5dYX
         CvKRr9Bv+PFJysWs0ZV8Wn+iH9HQ8Q2FJ3b8h/TPtkE0gfkP+KIhzDXvjpA7prt0L5hj
         nAyWrLDjTLzQGbn0NaWC280MOHr712FoqdjPe6pgo3dK+EB8E3qr5R8650CBLddaoGBB
         XLP5VOBs2faeztDw07LZYi3RN2C6I+q+EyBwVX7g+zfU7QHN8WgZJ5K9VYG8L5zY7Dr7
         Sijw==
X-Gm-Message-State: AOAM533Nu56r6P0fk5KCYUDHL6w3tLE4NeI53XT1vupQ5tOY+A6v4PuU
        XrXFJr8c0c7V1VxOJCZHUx7JZnrI
X-Google-Smtp-Source: ABdhPJwgVpsFt2E0BmoTUrLMRnDP23qgJl25g9zV9Jo3GvFIJpZeLm64orppHxmKyykDuXmB0B2mpw==
X-Received: by 2002:a17:906:f0c6:: with SMTP id dk6mr2928338ejb.157.1590670295367;
        Thu, 28 May 2020 05:51:35 -0700 (PDT)
Received: from debianHome.localdomain (x4d03b0ba.dyn.telefonica.de. [77.3.176.186])
        by smtp.gmail.com with ESMTPSA id o59sm4537203edb.51.2020.05.28.05.51.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:51:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/3] sepolgen-ifgen: refactor default policy path retrieval
Date:   Thu, 28 May 2020 14:51:28 +0200
Message-Id: <20200528125128.26915-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528125128.26915-1-cgzones@googlemail.com>
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
 <20200528125128.26915-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On a SELinux disabled system `selinux.security_policyvers()` will fail;
do not bailout but use a fallback policy version to check if a binary
policy file with that extension exists.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/audit2allow/sepolgen-ifgen | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index 4a71cda4..48e60f1d 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -69,7 +69,11 @@ def get_policy():
     p = selinux.selinux_current_policy_path()
     if p and os.path.exists(p):
         return p
-    i = selinux.security_policyvers()
+    try:
+        i = selinux.security_policyvers()
+    except OSError:
+        # SELinux Disabled Machine
+        i = 50 # some high enough default value
     p = selinux.selinux_binary_policy_path() + "." + str(i)
     while i > 0 and not os.path.exists(p):
         i = i - 1
@@ -80,18 +84,16 @@ def get_policy():
 
 
 def get_attrs(policy_path, attr_helper):
+    if not policy_path:
+        policy_path = get_policy()
+    if not policy_path:
+        sys.stderr.write("No installed policy to check\n")
+        return None
+
     try:
-        if not policy_path:
-            policy_path = get_policy()
-        if not policy_path:
-            sys.stderr.write("No installed policy to check\n")
-            return None
         outfile = tempfile.NamedTemporaryFile()
     except IOError as e:
-        sys.stderr.write("could not open attribute output file\n")
-        return None
-    except OSError:
-        # SELinux Disabled Machine
+        sys.stderr.write("could not open attribute output file: %s\n" % e)
         return None
 
     fd = open("/dev/null", "w")
-- 
2.27.0.rc2

