Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D5C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKINv7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKINv7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:59 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622C272C
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso1473649a12.3
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537915; x=1700142715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhTNOT9uR3yFuAxbYBtYVd1YZwmOtvhqXykEha1zcbg=;
        b=fp9iClX2a3FETDfwoc2IO5pgun0cOLpDkE9LX3QAwpd++qK7yJVbuTi9DkjULz03CY
         yPNjHdlNbJWYVP3BC8GZEcmHGZeyWikFUttMh4id8vNSGCFONDpbgBQ0UjdC6gRQk130
         7uIS59hBzrtUIE/2mZaVjnCT8igXAcOE97WebJJ7vNXc9dkf9P9p0szQl0DoPOm/ccCZ
         SSqMgzGPpX8UhYipbLVvwQm3im5AZQgtv+4F774wXjF7tNR1jQYBx0j1lND4KhPvpYMU
         ZSq5l38Hzf12vfGbvIjbJ0K7scvAoFsSMl3HTaD7zYM3BqJDSQ6bH8OmBmba07hwHuES
         zpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537915; x=1700142715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhTNOT9uR3yFuAxbYBtYVd1YZwmOtvhqXykEha1zcbg=;
        b=tcfdgghV9YagepO6LXiaZM6yFmpnMmwJdg8Baweq64NIA/LwIy2lVxJLO4bIUPZuzO
         iCmxWCAls5+WOIpgcTqFjL9MvQKU8qsK67P8H9Ru5FrxvgfFZNChyVk6gx+JmSpus7Tp
         8dOF8JbJChTXnHiHN6taQKh+5gGt5Z9j47yGYrRMvHs7eEAb596DiQ3YHUep6MU596GA
         XBo/MQaxU+Dk4qrvsG2Ve02ennlO05dc5O4UQaJtFJ2qsxLmIR7OKRRjAbIyfX2SOlcH
         MzWz/LmmjtjGm7qKD4YeWTQc7tyXkpwrdA54AkWxhy+G+oCpR1cMcmNKeqv4IR3+x93o
         lPjQ==
X-Gm-Message-State: AOJu0Yy8R+LOf+db1VtWr6PcUxSIriVtvvdn+WLOowBi4kbZ7RfYohpm
        rNGenf0EW5soWZq0QYe4fHNVVnKhO5g=
X-Google-Smtp-Source: AGHT+IFPUO/h1pR0T8zsqEO4skNpcrTJ9OzRgRb2vHduLj5NGWshEH7PoB0VFnkNr1UEmzkRDzHT3w==
X-Received: by 2002:a17:906:d553:b0:9be:45b3:3116 with SMTP id cr19-20020a170906d55300b009be45b33116mr4785848ejc.71.1699537914696;
        Thu, 09 Nov 2023 05:51:54 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:54 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/7] ci: bump Fedora to version 39
Date:   Thu,  9 Nov 2023 14:51:45 +0100
Message-ID: <20231109135148.42688-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
References: <20231109135148.42688-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently the GitHub Action vm_testsuite fails:

    The requested URL returned error: 404

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/ci/Vagrantfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
index b6023367..f3c90b71 100644
--- a/scripts/ci/Vagrantfile
+++ b/scripts/ci/Vagrantfile
@@ -2,7 +2,7 @@
 # vi: set ft=ruby :
 # Vagrant configuration file which creates a virtual machine that can run the
 # test suite using fedora-test-runner.sh, in an environment similar to the one
-# used for automated continuous integration tests (Travis-CI)
+# used for automated continuous integration tests (GitHub Actions)
 #
 # To create a new virtual machine:
 #
@@ -34,7 +34,7 @@ SCRIPT
 # backwards compatibility). Please don't change it unless you know what
 # you're doing.
 Vagrant.configure("2") do |config|
-  config.vm.box = "fedora/36-cloud-base"
+  config.vm.box = "fedora/39-cloud-base"
   config.vm.synced_folder "../..", "/root/selinux"
 
   config.vm.provider "virtualbox" do |v|
-- 
2.42.0

