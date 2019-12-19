Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDBC2D0D1
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365C206D3
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 19:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZZsgX4iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfLSTWc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:22:32 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45430 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfLSTWb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 14:22:31 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so2656086qvu.12
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Tk44M4MmiCe5UGxROPjh8h4LC7InK62EBAS7k51RBJc=;
        b=ZZsgX4iLxT/XhypjZqh0PIvanO/AUgxRpus6JP+u35Ng2y7jI3t13RejEcUL4SoCCk
         4du1PJYQLQyJAXryBmovMUEmDPp2xOh5rojDbrgqHhkL8eJKEY12nO32VjEXhewf/aay
         UE7St2NiQxLeoM+2Jb/9KZ2n8EkVzcTC/vZHTTZkzcub8wgwxJbGCr9nOiUBEGDAY2AR
         cf/Rk4wjNxE4vBelmak86lkKTsfEUMfiWji7dk/X4EXuWcLQXh2thxirbRuhlRYH/d6B
         yYcnnE/Zo8DQr8gHv9htHJAEbBctpTPJOwTATf34vmJj61NZjh6lekCc1ZQnyGW1UM5x
         bUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Tk44M4MmiCe5UGxROPjh8h4LC7InK62EBAS7k51RBJc=;
        b=EFa6MVfBY4auidunXQMYR3ENsaTw0TgTbY5C/g3uJeW0scj5jjR1NSaDfKYdEEDL37
         nRv5/iQjmaDHdtuQtq8CtGmLN7361nFCl9XWFfGVpHpdw8Y5ASlh5wnvyvSp7Xlotpfe
         27U1HLgh36zTqP83FcNehJLXBSb4plqLPRVlKLItxIgAwAdbVJQSjX78KSjNEtVQrlSo
         /eVO1PVrxDocSg2DtsSXnsebb/u5Zhk8dtBupMBKj+dQCpPzoXLggtPAqWfTCHsP0jLB
         My+3EvqPqxaZlrqw+R1f+Bxw6zhUR3mVZF9GoMzXJzlGhjbah5pF3C6G8shzaLljO5rU
         581A==
X-Gm-Message-State: APjAAAW/q0Oa6H1WqAvcPDATask20/OVgYm1VRwP9bjRbMSZgYAM9qew
        IBQw3iBcl6S3jWSPgV7LTADit6v6uA==
X-Google-Smtp-Source: APXvYqzBo0FgALq9tMmqgmngIwmokTnYYZkmHNOgqt09ZMIAgFCXtZNw143H/zLf7OL+5h3Z69JA/g==
X-Received: by 2002:ad4:518b:: with SMTP id b11mr2921159qvp.195.1576783349897;
        Thu, 19 Dec 2019 11:22:29 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id 53sm2214736qtu.40.2019.12.19.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:22:29 -0800 (PST)
Subject: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
Date:   Thu, 19 Dec 2019 14:22:28 -0500
Message-ID: <157678334821.158235.2125894638773393579.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
code was originally developed to make it easier for Linux
distributions to support architectures where adding parameters to the
kernel command line was difficult.  Unfortunately, supporting runtime
disable meant we had to make some security trade-offs when it came to
the LSM hooks, as documented in the Kconfig help text:

  NOTE: selecting this option will disable the '__ro_after_init'
  kernel hardening feature for security hooks.   Please consider
  using the selinux=0 boot parameter instead of enabling this
  option.

Fortunately it looks as if that the original motivation for the
runtime disable functionality is gone, and Fedora/RHEL appears to be
the only major distribution enabling this capability at build time
so we are now taking steps to remove it entirely from the kernel.
The first step is to mark the functionality as deprecated and print
an error when it is used (what this patch is doing).  As Fedora/RHEL
makes progress in transitioning the distribution away from runtime
disable, we will introduce follow-up patches over several kernel
releases which will block for increasing periods of time when the
runtime disable is used.  Finally we will remove the option entirely
once we believe all users have moved to the kernel cmdline approach.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Kconfig     |    3 +++
 security/selinux/selinuxfs.c |    6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 996d35d950f7..580ac24c7aa1 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
 	  using the selinux=0 boot parameter instead of enabling this
 	  option.
 
+	  WARNING: this option is deprecated and will be removed in a future
+	  kernel release.
+
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SELINUX_DEVELOP
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 278417e67b4c..adbe2dd35202 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	int new_value;
 	int enforcing;
 
+	/* NOTE: we are now officially considering runtime disable as
+	 *       deprecated, and using it will become increasingly painful
+	 *       (e.g. sleeping/blocking) as we progress through future
+	 *       kernel releases until eventually it is removed */
+	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 

