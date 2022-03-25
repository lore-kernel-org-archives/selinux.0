Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B377C433F5
	for <selinux@archiver.kernel.org>; Fri, 25 Mar 2022 19:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiCYTvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiCYTvV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Mar 2022 15:51:21 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085EA25B92F
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 12:35:10 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d15so7389170qty.8
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJSUdA3K/wZwxZuMNqwfSPqYX3y/F32kL4u4RwO58hw=;
        b=kptgBqOnDMFkyNToSp5XQJk+7ptkFF5l/Gw90X7ARguKgZkwzOmtokLsgYjRsW09dJ
         PYH9Gbm/vC+Xu5hxn4JvU/sLjqlFfHn6Y3cnu96ieAFAOBDpwsKWbuJiznEz7nPOGN8T
         Rb5LY+Th4I8iexIYeK2dViyzYl+IFxgHLfU3yOlELCdKGWDsBSSSieEyqD9vVuR7QLfC
         JfuhxmweczJ+4b8w/68YtzR1tRRnuxbnf74HCwv4YNKU7ixEI20l8JSivWgdLfrSa+Zi
         OrE8ep/fX88hFKC66Kmu/5YRWTK0hHsHE+h6ZZAzqUGzoMtKGJaFMBM/Kmlt+XQGqg5v
         wiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJSUdA3K/wZwxZuMNqwfSPqYX3y/F32kL4u4RwO58hw=;
        b=DRxJlKVSxESqrYeIu/UDB306jDIWg58PwKMdcJJ9Ex/1a19ti3rMjkYDced954qCYb
         bLxmc0p5tbTHxCFtKqmslfFPEFZUxoI4/7+6huPgbTQPG7WFNUcvdb0ayqKCHPry8lHe
         4U0cOhNVHabNPb4JKEeOrTRcxhQgBof/ALUW6Sembqa7uewBWTApGCD4SVDzn9sW8+jA
         WA+JgtjALXtns4Kv8WSiynpfiPzGHil8++K0uwiOWdk+A61tXjv2dS9aab8RaRry5vDA
         RDN03UTcGR51MTp6lJnKh/QioyJ3C2oz0TFtXonS2qLwxPzdmDnk2JKfLx6BgUQsXiwG
         RH3A==
X-Gm-Message-State: AOAM533PQ6uRy9JU0epGH6/Cp3ra52vFdUhdGiBK7zFZnT9Bzp6Uhi4k
        2sJVj9wdg43QTNZme2ChITT/+xS6DuU=
X-Google-Smtp-Source: ABdhPJwsYAtp/ZAvq99um+H0vou9yrRZrHTRQFOWPITfUDxVvPp8IB4V4kVYLmHWyRq4NePm3a37QQ==
X-Received: by 2002:a05:620a:2a05:b0:67d:b5e6:e07d with SMTP id o5-20020a05620a2a0500b0067db5e6e07dmr7419941qkp.410.1648229424836;
        Fri, 25 Mar 2022 10:30:24 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm3837501qkg.64.2022.03.25.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:30:24 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] Add a file describing the security vulnerability handling process
Date:   Fri, 25 Mar 2022 13:30:13 -0400
Message-Id: <20220325173013.448231-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the file SECURITY.md which describes the SELinux userspace
security vulnerability handling process including who to contact.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 SECURITY.md | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 00000000..37630585
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,59 @@
+The SELinux Userspace Security Vulnerability Handling Process
+===============================================================================
+https://github.com/SELinuxProject/selinux
+
+This document attempts to describe the processes through which sensitive
+security relevant bugs can be responsibly disclosed to the SELinux userspace
+project and how the project maintainers should handle these reports. Just like
+the other SELinux userspace process documents, this document should be treated
+as a guiding document and not a hard, unyielding set of regulations; the bug
+reporters and project maintainers are encouraged to work together to address
+the issues as best they can, in a manner which works best for all parties
+involved.
+
+### Reporting Problems
+
+For serious problems or security vulnerabilities in the SELinux kernel code
+please refer to the SELinux Kernel Subsystem Security Policy in the link below:
+
+* https://github.com/SELinuxProject/selinux-kernel/blob/main/SECURITY.md
+
+Problems with the SELinux userspace that are not suitable for immediate public
+disclosure should be emailed to the current SELinux userspace maintainers, the
+list is below. We typically request at most a 90 day time period to address
+the issue before it is made public, but we will make every effort to address
+the issue as quickly as possible and shorten the disclosure window.
+
+* Petr Lautrbach, plautrba@redhat.com
+* Nicolas Iooss, nicolas.iooss@m4x.org
+* Jeffrey Vander Stoep, jeffv@google.com
+* Joshua Brindle, brindle@gmail.com
+* James Carter, jwcart2@gmail.com
+* Paul Moore, paul@paul-moore.com
+* Jason Zaman, perfinion@gentoo.org
+* Steve Lawrence, slawrence@tresys.com
+* William Roberts, bill.c.roberts@gmail.com
+* Ondrej Mosnacek, omosnace@redhat.com
+
+### Resolving Sensitive Security Issues
+
+Upon disclosure of a bug, the maintainers should work together to investigate
+the problem and decide on a solution. In order to prevent an early disclosure
+of the problem, those working on the solution should do so privately and
+outside of the traditional SELinux userspace development practices. One
+possible solution to this is to leverage the GitHub "Security" functionality to
+create a private development fork that can be shared among the maintainers, and
+optionally the reporter. A placeholder GitHub issue may be created, but details
+should remain extremely limited until such time as the problem has been fixed
+and responsibly disclosed. If a CVE, or other tag, has been assigned to the
+problem, the GitHub issue title should include the vulnerability tag once the
+problem has been disclosed.
+
+### Public Disclosure
+
+Whenever possible, responsible reporting and patching practices should be
+followed, including notification to the linux-distros and oss-security mailing
+lists.
+
+* https://oss-security.openwall.org/wiki/mailing-lists/distros
+* https://oss-security.openwall.org/wiki/mailing-lists/oss-security
-- 
2.34.1

