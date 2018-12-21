Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1BCC43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CDC21927
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbeLUUT1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:19:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeLUUT1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:19:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so6404295wml.2
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 12:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HyC6Q6qtZ1rTOVKxIOO74CGqaQzY3uNsGoDOByIWro=;
        b=CgqEcGVyULsb/7g1NS6MJ7jjCRtBiiSVqSj240aweS+7K5gLSfM0mLBSKnuE/nxFzs
         ctRFxHq98iYaYU8+zACHn/fo0jArfXhhBPJT5v627SBYxEQ9twhh0C7AtKnHBfgcfgA0
         utEkPJaECRdDOo80S7BWQ9dS5FK3oLdpimw8oOnKWIGzBon0JG+lAOo0hUrKPOW2yttZ
         eDZHjkXavn/1JZnJEpOU2XmSJCnLtXKU4VE7mm/mgGHeqcCkyLTVGqXkHyWgBn920GDm
         crqu98Zyx9Q/keiCOgsagOWWcyDQtwndJ7SkTfklOFVy0bPBEMeJCzeqkvhHuBBCCbFV
         3C8Q==
X-Gm-Message-State: AJcUukceW+fPzc7RDqAbike3ld6m/2x/X/DU7mTyot8bez/JRhPBlb6h
        CnRHPOqwS1VWluhBusAshHKU8hfQZHk=
X-Google-Smtp-Source: ALg8bN5sWhC0ee3TULslXv5KewP9VYKBwoJdTyl/JcLQRgTHrtxfk4Zw8kN8OOQUPAEF5L8EGMNh4Q==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr4133971wmq.151.1545423565309;
        Fri, 21 Dec 2018 12:19:25 -0800 (PST)
Received: from localhost.localdomain.com (adsl-dyn216.78-99-85.t-com.sk. [78.99.85.216])
        by smtp.gmail.com with ESMTPSA id r12sm17378087wrq.3.2018.12.21.12.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:19:23 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 0/2] Fix SELinux context mount with the cgroup filesystem
Date:   Fri, 21 Dec 2018 21:18:51 +0100
Message-Id: <20181221201853.24015-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains two bugfixes that fix mounting the cgroup filesystem
with the 'context=' option under SELinux (and potentially other cases as well).

Changes in v2:
 - drop first patch (already picked up by cgroups maintainer)
 - extract the genfs special handling condition into a separate function
 - check for SBLABEL_MNT directly in selinux_inode_setsecurity() and in
   selinux_inode_notifysecctx() just translate -ENOTSUPP to 0
v1: https://lore.kernel.org/selinux/20181213141739.8534-1-omosnace@redhat.com/

Note that this series is testable only with patch [1] applied (it has already
been picked up by Tejun Heo, so I dopped it from this series).

The first patch fixes SELinux to always disallow relabeling inodes that
belong to a 'context=' mount.

The second patch fixes SELinux to ignore security_inode_notifysecctx() calls
and disallow security_inode_setsecurity() calls on inodes that belong to
a 'context=' mount.

Testing: Passed selinux-testsuite and verified using the reproducers.

[1] https://lore.kernel.org/selinux/20181213141739.8534-2-omosnace@redhat.com/

Ondrej Mosnacek (2):
  selinux: never allow relabeling on context mounts
  selinux: do not override context on context mounts

 security/selinux/hooks.c | 49 ++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

-- 
2.19.2

