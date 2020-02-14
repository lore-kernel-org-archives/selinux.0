Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E08C3B18F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 03:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4CD22314
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 03:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7u2Fkhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgBND06 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:26:58 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42649 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgBND05 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 22:26:57 -0500
Received: by mail-pf1-f201.google.com with SMTP id z26so5137667pfr.9
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0WYp+nOc4W1ueTL6njcvhwE6Wrya56t+7LdjPX2+2/g=;
        b=d7u2FkhwK0FN7IXYD8paZmQSKyhKm96rk0yh6wSPXStrq+ZyUe0RBJ0cSR/kkVrTZ7
         yyAcca7EmJ6rSMeEPPDmRMQPnPyEsl8d+DvxOEmq0DTwgrwmiGE7SqOajaQIzDeOuqcf
         Dup93fAzq0KZymXZwZ+fiEXw7p7pZvYsz9Sd3yWE6XW47saWou3JDaduJwLGhI/6aCvr
         jXEAo8CTJA5tMyHfa2LpOlraU1cl+g4iI3Mmkp15BOF9zeBzfcEkhcK1YsPI+ryUiGy1
         60g7n05mvI2V1MgGUXg5cFf4vvol75AtiWxiV1xP9EDlQm2jLHIy74/BgTZiK6/Tk6+T
         /DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0WYp+nOc4W1ueTL6njcvhwE6Wrya56t+7LdjPX2+2/g=;
        b=VKTJw7yUnBjXKtBVDDjpAMP4WLO2U80e7YvIjIOr86wBCjSJAE4h7xDpbB+lS29Lgd
         z7n7bXpmctoThxfILzzWc+/bUi/0Y4IgUKGB2Z+vi/ZcYZu1rtVz57QGgVkmgp2nhGbX
         ZpwTmB/M3A8rEt2N5TaKCibqZM6PQrhG3yQyrcdloAOhlt3dxxcpRybI0H+3t+627/6Q
         A7M+m6YFJrE6QswXUTbja4pfIXvr+SkbyNZ31nSDU7UXXk3G33cRD70finW1fk0vjXEc
         /5uJpCc7DPIVpcrIUPa8UiUw5D/TbH5gUgKdEybaZVtv/MsuJMS0YqGaglq0ImXdU8zO
         gntw==
X-Gm-Message-State: APjAAAXmXU62Cvp/VwLFC9+09bFAKaPACSk/fg2uOHMs/UTRBFu/IC+S
        rxSWWNRBOKqmxlFRsOvvVYQLaJqxiH8=
X-Google-Smtp-Source: APXvYqycI2BpuraXCc3IrQ2spptnq0wpysgGaSnKRL3VQeWA2X/FZ9eFhD8j0BwJp3nlWxw33egBUz7gUsU=
X-Received: by 2002:a63:5a11:: with SMTP id o17mr1256158pgb.60.1581650815604;
 Thu, 13 Feb 2020 19:26:55 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:26:32 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200214032635.75434-1-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 0/3] SELinux support for anonymous inodes and UFFD
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors and in the future, other kinds of
anonymous-inode-based file descriptor.  SELinux policy authors can
apply policy types to anonymous inodes by providing name-based
transition rules keyed off the anonymous inode internal name (
"[userfaultfd]" in the case of userfaultfd(2) file descriptors) and
applying policy to the new SIDs thus produced.

Inside the kernel, a pair of new anon_inodes interface,
anon_inode_getfile_secure and anon_inode_getfd_secure, allow callers
to opt into this SELinux management. In this new "secure" mode,
anon_inodes creates new ephemeral inodes for anonymous file objects
instead of reusing the normal anon_inodes singleton dummy inode. A new
LSM hook gives security modules an opportunity to configure and veto
these ephemeral inodes.

This patch series is one of two fork of [1] and is an
alternative to [2].

The primary difference between the two patch series is that this
partch series creates a unique inode for each "secure" anonymous
inode, while the other patch series ([2]) continues using the
singleton dummy anonymous inode and adds a way to attach SELinux
security information directly to file objects.

I prefer the approach in this patch series because 1) it's a smaller
patch than [2], and 2) it produces a more regular security
architecture: in this patch series, secure anonymous inodes aren't
S_PRIVATE and they maintain the SELinux property that the label for a
file is in its inode. We do need an additional inode per anonymous
file, but per-struct-file inode creation doesn't seem to be a problem
for pipes and sockets.

The previous version of this feature ([1]) created a new SELinux
security class for userfaultfd file descriptors. This version adopts
the generic transition-based approach of [2].

This patch series also differs from [2] in that it doesn't affect all
anonymous inodes right away --- instead requiring anon_inodes callers
to opt in --- but this difference isn't one of basic approach. The
important question to resolve is whether we should be creating new
inodes or enhancing per-file data.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c            | 196 ++++++++++++++++++++++++++++--------
 fs/userfaultfd.c            |  34 +++++--
 include/linux/anon_inodes.h |  13 +++
 include/linux/lsm_hooks.h   |   9 ++
 include/linux/security.h    |   4 +
 security/security.c         |  10 ++
 security/selinux/hooks.c    |  57 +++++++++++
 7 files changed, 274 insertions(+), 49 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

