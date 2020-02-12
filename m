Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB3AC2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD831206DB
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 07:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nhg3rKGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgBLHvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:51:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39065 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgBLHvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 02:51:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so769225pgm.6
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 23:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yiz9WBSdL7NQOdvbn80An19iJZYDNk/obNeFYG2L8Bs=;
        b=nhg3rKGmLf/ztkCT+0gU6qiovpFdDomiRBtx3D5rpDSWaazkpSyqNkRTpVLBE9itSC
         Y7XnYaE4y5gNB0j5dMsvQxQI9z8S0g219xc81Yv/dTG9AvrN2ditkF9z9IIJ60b6K0Cs
         kOsenjKrpqo7cf+WM5hrgiUr1mMxkX8CsxpAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yiz9WBSdL7NQOdvbn80An19iJZYDNk/obNeFYG2L8Bs=;
        b=KiZEktjnMYNbybzZbgNn/XdY4h0+8pgD23IS/QBUk1bxerfcjKwMl27d+pWfIcoh9q
         /oL47m14/r+/Gq5RNfK3wK/yhjJcb9TuAYHldWR2ZxBvAq+pZ/V4ez2+9OwV1GBhuvoj
         zusoihCLrH+JdM5w1+5KhLh7eNYT6c4W31gpi5a1xobAoUEa2WEM/faTX88JVOLo4Fg7
         9Scuo8/E45RPppv8viiWUtdkvDogE1RhbEe5VzRyB+t7cVwcvcUqJ81uyNpD8Z1tR56K
         YWksPPLsB7eLJpHlOORiABqkIpGMOo5lwiT1q4iwGynW2TorTlosQREughRLE0h4jnmj
         PwZA==
X-Gm-Message-State: APjAAAUu8IiQTUV59Xe49EJOTJZUZGLe39tlW+ccd/pgACepREXrLarq
        72RPvD/6oXLHkYtA98m8mIdC7Q==
X-Google-Smtp-Source: APXvYqyPQNw1fJJzxrr+Vej5UzAZPt9dUWwkqtIGchQ+MVvd9EJarctCHQVbAN0x96enDO2Wl9uRtg==
X-Received: by 2002:a63:5558:: with SMTP id f24mr6981271pgm.92.1581493860306;
        Tue, 11 Feb 2020 23:51:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b98sm5858832pjc.16.2020.02.11.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:50:59 -0800 (PST)
Date:   Tue, 11 Feb 2020 23:50:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     timmurray@google.com, nosh@google.com, nnk@google.com,
        lokeshgidra@google.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, selinux@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
Message-ID: <202002112332.BE71455@keescook>
References: <20200211225547.235083-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi!

Firstly, thanks for working on this! It's been on my TODO list for a
while. :)

Casey already recommended including the LSM list to CC (since this is a
new LSM -- there are many LSMs). Additionally, the series should
probably be sent _to_ the userfaultfd maintainers:
	Andrea Arcangeli <aarcange@redhat.com>
	Mike Rapoport <rppt@linux.ibm.com>
and I'd also CC a couple other people that have done recent work:
	Peter Xu <peterx@redhat.com>
	Jann Horn <jannh@google.com>

More notes below...

On Tue, Feb 11, 2020 at 02:55:41PM -0800, Daniel Colascione wrote:
> Userfaultfd in unprivileged contexts could be potentially very
> useful. We'd like to harden userfaultfd to make such unprivileged use
> less risky. This patch series allows SELinux to manage userfaultfd
> file descriptors and allows administrators to limit userfaultfd to
> servicing user-mode faults, increasing the difficulty of using
> userfaultfd in exploit chains invoking delaying kernel faults.

I actually think these are two very different goals and likely the
series could be split into two for them. One is LSM hooking of
userfaultfd and the SELinux attachment, and the other is the user-mode
fault restrictions. And they would likely go via separate trees (LSM
through James's LSM tree, and probably akpm's -mm tree for the sysctl).

> A new anon_inodes interface allows callers to opt into SELinux
> management of anonymous file objects. In this mode, anon_inodes
> creates new ephemeral inodes for anonymous file objects instead of
> reusing a singleton dummy inode. A new LSM hook gives security modules
> an opportunity to configure and veto these ephemeral inodes.
> 
> Existing anon_inodes users must opt into the new functionality.
> 
> Daniel Colascione (6):
>   Add a new flags-accepting interface for anonymous inodes
>   Add a concept of a "secure" anonymous file
>   Teach SELinux about a new userfaultfd class
>   Wire UFFD up to SELinux

The above is the first "series"... I don't have much opinion about it,
though I do like the idea of making userfaultfd visible to the LSM.

>   Let userfaultfd opt out of handling kernel-mode faults
>   Add a new sysctl for limiting userfaultfd to user mode faults

Now this I'm very interested in. Can you go into more detail about two
things:

- What is the threat being solved? (I understand the threat, but detailing
  it in the commit log is important for people who don't know it. Existing
  commit cefdca0a86be517bc390fc4541e3674b8e7803b0 gets into some of the
  details already, but I'd like to see reference to external sources like
  https://duasynt.com/blog/linux-kernel-heap-spray)

- Why is this needed in addition to the existing vm.unprivileged_userfaultfd
  sysctl? (And should this maybe just be another setting for that
  sysctl, like "2"?)

As to the mechanics of the change, I'm not sure I like the idea of adding
a UAPI flag for this. Why not just retain the permission check done at
open() and if kernelmode faults aren't allowed, ignore them? This would
require no changes to existing programs and gains the desired defense.
(And, I think, the sysctl value could be bumped to "2" as that's a
better default state -- does qemu actually need kernelmode traps?)

Thanks again for the patches!

-Kees

> 
>  Documentation/admin-guide/sysctl/vm.rst | 13 ++++
>  fs/anon_inodes.c                        | 89 +++++++++++++++++--------
>  fs/userfaultfd.c                        | 29 ++++++--
>  include/linux/anon_inodes.h             | 27 ++++++--
>  include/linux/lsm_hooks.h               |  8 +++
>  include/linux/security.h                |  2 +
>  include/linux/userfaultfd_k.h           |  3 +
>  include/uapi/linux/userfaultfd.h        |  9 +++
>  kernel/sysctl.c                         |  9 +++
>  security/security.c                     |  8 +++
>  security/selinux/hooks.c                | 68 +++++++++++++++++++
>  security/selinux/include/classmap.h     |  2 +
>  12 files changed, 229 insertions(+), 38 deletions(-)
> 
> -- 
> 2.25.0.225.g125e21ebc7-goog
> 

-- 
Kees Cook
