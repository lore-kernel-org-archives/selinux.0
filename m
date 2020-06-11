Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DEC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 17:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6298206DC
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 17:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk1fQ8J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgFKRaq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFKRap (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 13:30:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC708C03E96F
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 10:30:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so2483580pje.4
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pn93jZ6kamZb7hOg9NYSUVq82Zmc+C9bq+sEl+DhdTg=;
        b=Vk1fQ8J0QUF/WHUaUT5tNZFnNh/W7lqwjwF0kqA7KCGzFmwdY7hU1BAQgK2UCCGohb
         iLH7JcGHJS1G9WQyV61xv9qH4bxFgfU4Me9IYCvzXUi0RDEAhLwNpBudFX50uuXk2jhl
         Z3DIozixwuDeBIctTsca/GSzkHaGFf4cLhsdVo7jBtc2si/a4k/aJmXghXx6ce/3aMN9
         iVK8qybxKJskjLOVI1Emh5j1SMJK+Nl898cjtxYfbHU41gYBc504bk9mL3qPp9w88aV3
         ItFPRPXSJwG6eYZmKcNCYfxwuT7Qedxoz/8Z24mvFjBxTLDdoWg/FAnnCgaX/hswe2XB
         43nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pn93jZ6kamZb7hOg9NYSUVq82Zmc+C9bq+sEl+DhdTg=;
        b=bfUxtJDLPdyYoWCGU/ol8Qnhie/BLdkaaMiDkC9S0iyaUuXdXwiZ5nGd/ztr3OjVq9
         coW2o9x3X+O+U8gKrjgo91GWBR6CtKn5YDgMyq79DmA5z5cuN6TIxuOd01VARAi/j3ET
         LWbWkVr2GSkxiRIZV4UF+sJ/0Zyx1leYs5Wc4HxJdv3zsAuVFoRMG92pKx6Na77HAY6U
         WH6zqemh49M9QePLSCrjAACtHAB41Cz1llvCGVUXv0cIyhk6GSzvYRmltGOcniDtebzX
         Yy9CD6Cpt3iiOrqd1272GDtLCdNMbj9kTyly6JQGiufN1sgxXBmQnZnORjZeCGYMH34T
         Z+uw==
X-Gm-Message-State: AOAM532vVaKLZ2sSce30/X5SJIMTRrcwA1miWsJ34MfYCMiOLRAXCdSq
        iixtMwLFeemq74DH6tJQIkay55S5QT8=
X-Google-Smtp-Source: ABdhPJw86pEnLBbAY8bU5TlS4uhFLQtWsW05uZbuiPX8GumgKqndXAq+ImYHz7E6ouusLbiUXj93Vg==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr7705141pls.185.1591896645288;
        Thu, 11 Jun 2020 10:30:45 -0700 (PDT)
Received: from localhost.localdomain (jfdmzpr03-ext.jf.intel.com. [134.134.139.72])
        by smtp.gmail.com with ESMTPSA id q92sm3234492pjh.12.2020.06.11.10.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:30:44 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     paul@paul-moore.com, plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH v2] ci: dont use hardcoded project name
Date:   Thu, 11 Jun 2020 12:30:39 -0500
Message-Id: <20200611173039.21742-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdrszrtxO64GtiGKyszae-rNv9Kohzs-jwmxgtW3rfTnJw@mail.gmail.com>
References: <CAFftDdrszrtxO64GtiGKyszae-rNv9Kohzs-jwmxgtW3rfTnJw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Not everyone's github project is "selinux" so use the projects
name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
the absolute path to the project checkout on disk, so the
basename should be sufficient. The script that runs in the KVM
environment also needs to be updated where it can find the
selinux project code, so we pass it in through an env variable
in the ssh command.

Tested on Travis CI here:
  - https://travis-ci.org/github/williamcroberts/selinux/jobs/697307824

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
v2:
 - Fix the KVM script project location when it's not /root/selinux.

 scripts/ci/fedora-test-runner.sh | 10 ++++++++--
 scripts/ci/travis-kvm-setup.sh   |  6 ++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 0927ed5dad8f..569723387f6b 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -2,6 +2,12 @@
 
 set -ev
 
+#
+# We expect this to be set in the environment, but if it's not, most selinux projects
+# just have the same name as upstream, so choose that.
+#
+export SELINUX_DIR="${SELINUX_DIR:-/root/selinux}"
+
 # CI Debug output if things go squirrely.
 getenforce
 id -Z
@@ -58,7 +64,7 @@ dnf install -y \
 #
 # Move to selinux code and build
 #
-cd "$HOME/selinux"
+cd "$SELINUX_DIR"
 
 # Show HEAD commit for sanity checking
 git log -1
@@ -71,7 +77,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install-pywrap
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
 
 #
-# Get the selinux testsuite, but don't clone it in $HOME/selinux, move to $HOME
+# Get the selinux testsuite, but don't clone it in selinux git directory, move to $HOME
 # first.
 #
 cd "$HOME"
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 864dbac96a46..8d4cfb79f7d7 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -118,8 +118,10 @@ fi
 #
 # Great we have a host running, ssh into it. We specify -o so
 # we don't get blocked on asking to add the servers key to
-# our known_hosts.
+# our known_hosts. Also, we need to forward the project directory
+# so forks know where to go.
 #
-ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
+project_dir="$(basename "$TRAVIS_BUILD_DIR")"
+ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "SELINUX_DIR=/root/$project_dir /root/$project_dir/$TEST_RUNNER"
 
 exit 0
-- 
2.17.1

