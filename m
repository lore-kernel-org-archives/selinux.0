Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C7C54E4B
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A1A21974
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiS1LIT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgEHPmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPmc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFC0C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p12so1560306qtn.13
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DV1e4NV0jLhKZDsT4mAclKSFgDpKt8QFl5qn3Sey1E=;
        b=jiS1LIT+kMaPgqtclnbVm703MlU+/XRkQwDcueVyT3E8gSdZFl/csjuD8Si1AbRe+M
         GlDtumxsMGcDYXMwRFke7t6E2kpGI5AEjva/0+sQB1/rGXFxxqn/NSVsrPZFsQt7zbNY
         X5SIt/5xWKbMbs+r0enAD/SStNPqR3I7Xgqsm2M5mEHK7A/SewfYVg7tR3ksAPDFP0CG
         bFvbQR0W41AvZVKMz1WXkeW7YRxxmqAV7YtUgNAsBIODgnusa5imSVW5/UGnMKkdvXnH
         BIN2BlC1y4I5M6L4LCMbHRlaAwQNiPWmLPO51BF9/T6EIoVOZ2Sb8WWdNC7zlzpHc5W8
         QjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DV1e4NV0jLhKZDsT4mAclKSFgDpKt8QFl5qn3Sey1E=;
        b=KhHXo7JBGjr1xXcJXGmOuYFbZgfkLO2kNy61nVSkjMpbr17H31KGpw5nmbp1kYvKFr
         LQ4X4ZTZem0bYlgX4BoqBF1qUydhetF9LlvSd0nAqXuCzH5P73sM7ppvXn/su+ZDO7Ih
         Hxktjt11h8ZjUS6DixzkZ7D3G01Y/xLohzXZX9fNCqOJYxEKYjlRoH8lV5ypuIxHGyYq
         vwIvswC2wY+qhzcsN7Uqaj9igkTiJoQ6ENbHa/UDjJBj6A98B+tWgMyL6Ni51wArGUtl
         OR1TbviKS3Hm94WTjnDouKl0g75Ecf17wlyQR1WM9At806vmDNqQ6c2eUYH+bZ3iUfgZ
         9b8g==
X-Gm-Message-State: AGi0Puas8P9tqqywJc6lgkTsFqxgeQlhH5+9qj6bvHt+kP7Zp5BA0Sr+
        ZX7/2sfH87BNBoxQI6Fzzx9DYdmI
X-Google-Smtp-Source: APiQypIvWqdbdPSUm6t5FGqNrtV7Jv8T9khohi3RKXpgORQPyTiMTOwF+6TSqY3hLvcY3Oqd206Z+g==
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr3608751qto.77.1588952551060;
        Fri, 08 May 2020 08:42:31 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:30 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 15/15] README.md: Add instructions for Debian
Date:   Fri,  8 May 2020 11:41:38 -0400
Message-Id: <20200508154138.24217-16-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that the testsuite builds and runs on Debian, add instructions
to the README with the necessary dependencies and steps.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index b36494e..1f7e5d9 100644
--- a/README.md
+++ b/README.md
@@ -36,6 +36,8 @@ one primary security module may be active at a time.
 
 ### Userland and Base Policy
 
+#### Fedora or RHEL
+
 On a Fedora/RHEL based system the testsuite has the following userspace
 dependencies beyond a minimal install (other Linux distributions should have
 similar dependencies):
@@ -77,8 +79,70 @@ following command:
 		xfsprogs-devel \
 		libuuid-devel
 
+#### Debian
+
+On Debian, you must first take steps to install and activate SELinux since
+it is not enabled in the default install.  Make sure to backup your system
+first if you care about any local data.
+
+	# apt-get install selinux-basics selinux-policy-default auditd
+	# selinux-activate
+	# reboot
+
+After activating, make sure that your login shell is running in the
+correct context:
+
+	# id -Z
+
+If this shows something other than
+"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023", you will need
+to first fix labeling or policy problems in your base system before
+proceeding.  Make sure that your shell context is correct and you can
+switch to enforcing mode without breaking your system before
+proceeding.
+
+On Debian, you can install the userspace dependencies with the following
+command:
+
+	# apt-get install perl \
+		gcc \
+		selinux-policy-dev \
+		libselinux1-dev \
+		net-tools \
+		iptables \
+		libsctp-dev \
+		attr \
+		libbpf-dev \
+		libkeyutils-dev \
+		linux-headers-$(uname -r) \
+		quota \
+		xfsprogs \
+		xfslibs-dev \
+		uuid-dev
+
+On Debian, you need to build and install netlabel_tools manually since
+it is not yet packaged for Debian
+(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=959806):
+
+    # git clone https://github.com/netlabel/netlabel_tools
+    # cd netlabel_tools
+    # sudo apt-get install autotools-dev autoconf automake libtool pkg-config libnl-3-dev libnl-genl-3-dev
+    # ./autogen.sh
+    # ./configure --prefix=/usr
+    # make
+    # sudo make install
+
+Debian further requires reconfiguring the default /bin/sh to be bash
+to support bashisms employed in the testsuite Makefiles and scripts:
+
+    # dpkg-reconfigure dash
+
+Select "No" when asked if you want to use dash as the default system shell.
+
+#### Other Distributions
+
 The testsuite requires a pre-existing base policy configuration of SELinux,
-using either the old example policy or the reference policy as the baseline.
+using the reference policy as the baseline.
 It also requires the core SELinux userland packages (`libsepol`, `checkpolicy`,
 `libselinux`, `policycoreutils`, and if using modular policy, `libsemanage`)
 to be installed.  The test scripts also rely upon the SELinux extensions being
-- 
2.23.1

