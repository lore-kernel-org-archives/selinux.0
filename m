Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C310C35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D276320714
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRBeat1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBKW4L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:56:11 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43687 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBKW4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 17:56:11 -0500
Received: by mail-pg1-f202.google.com with SMTP id d9so123891pgd.10
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=z5hBZFlukE73X5tySesJV8jPEinxyOGgZx3qCpc+FhQ=;
        b=lRBeat1DM/6m8wVzhtbw3NbGYuXI5jrNZCMDH2bkPtPkorENZSb/rNayT9WHqeuj4z
         XNiVPVGX2pusznQ1ujf8QR2xOyBI/+zE5DN9wxiuYLG6WE5+drIQepezj2KwFMRbrZXL
         9pht2m3MheSA4XZzOWTsaYLJbHT7vKjw/CecQE80mFpR3gYzIRcVZib11+kBT1jsexEe
         6NcsyOlB/MGz7sS46G6OcUah1YEZi0GWN+npoLpF03tNcuX0eDaTYVVCBNhYAe7EM1DI
         GODlU6IlhvIVeuAEmd/Ih1Nu8CS43QgX1CsO4cXY4B2rg23HINcAnFHVQYeurJwrhMJN
         F/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=z5hBZFlukE73X5tySesJV8jPEinxyOGgZx3qCpc+FhQ=;
        b=LzizCA4AJAly1CX89xGMIqlEJkq+9xZOAmCbQfv10teX2K00Cm0K+CfYrdZLw4Q8u/
         sWo/SyhflrS6OR9WTMWacGp7w/koQrxLBOsCX27heY/fjOpP7ejrjTw2dS1gWJmBlugW
         spLl9kK2KGnfU331sHY4k9mK8aSX6EETPxrD6hzes3Z5NuZLKzr+KvcArHaOFH1Mglgl
         jbU+poJ6qw20qnJVr0d+WmJ9b3dH//ZSTR+R3VvKRDyAEE35yCiy9MIhNe3+rn86wZ9B
         PXvJ3Uki1NJPNBvFk53R1/ed3736mSQz+FSIKjJAciyXwo1W9dAZWnSh3QUlrsY7hZT3
         ZcKg==
X-Gm-Message-State: APjAAAVZl5+VAlgkW+xfTGMiXtwRg51G/u+dYEI13RgnhPnNupjpGx92
        lJAdJ+KgNZxMDxgLl59W3mtVcu/fgTk=
X-Google-Smtp-Source: APXvYqz3X0ton3FvOV+uorjZiWOGrdx8y9Xd27MZc3lIrLJXDLMtq+k4O5/wHZSBlOtX5wMSTKh//psjJJc=
X-Received: by 2002:a65:420b:: with SMTP id c11mr5419343pgq.306.1581461769152;
 Tue, 11 Feb 2020 14:56:09 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:41 -0800
Message-Id: <20200211225547.235083-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 0/6] Harden userfaultfd
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors and allows administrators to limit userfaultfd to
servicing user-mode faults, increasing the difficulty of using
userfaultfd in exploit chains invoking delaying kernel faults.

A new anon_inodes interface allows callers to opt into SELinux
management of anonymous file objects. In this mode, anon_inodes
creates new ephemeral inodes for anonymous file objects instead of
reusing a singleton dummy inode. A new LSM hook gives security modules
an opportunity to configure and veto these ephemeral inodes.

Existing anon_inodes users must opt into the new functionality.

Daniel Colascione (6):
  Add a new flags-accepting interface for anonymous inodes
  Add a concept of a "secure" anonymous file
  Teach SELinux about a new userfaultfd class
  Wire UFFD up to SELinux
  Let userfaultfd opt out of handling kernel-mode faults
  Add a new sysctl for limiting userfaultfd to user mode faults

 Documentation/admin-guide/sysctl/vm.rst | 13 ++++
 fs/anon_inodes.c                        | 89 +++++++++++++++++--------
 fs/userfaultfd.c                        | 29 ++++++--
 include/linux/anon_inodes.h             | 27 ++++++--
 include/linux/lsm_hooks.h               |  8 +++
 include/linux/security.h                |  2 +
 include/linux/userfaultfd_k.h           |  3 +
 include/uapi/linux/userfaultfd.h        |  9 +++
 kernel/sysctl.c                         |  9 +++
 security/security.c                     |  8 +++
 security/selinux/hooks.c                | 68 +++++++++++++++++++
 security/selinux/include/classmap.h     |  2 +
 12 files changed, 229 insertions(+), 38 deletions(-)

-- 
2.25.0.225.g125e21ebc7-goog

