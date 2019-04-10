Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA49C10F11
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C7220818
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD3ftOoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfDJMwg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:52:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33478 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDJMwg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 08:52:36 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so2023413iog.0;
        Wed, 10 Apr 2019 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32g/F2GpwQ9CxZvz1Ft4WS+BiOjylD57xp4fGGgCfE4=;
        b=jD3ftOoexJayZUN4iQDPrlKlISQoIsv1Plhwsbra4xx7Uavpj7+hBCH63cYJYKzAmR
         cINtAgCO8FY3Ui2rtEPyo8Zxce+uKRHIOOTWdWBc4GNwXgjHj/AbIBU4C6Mj7/N2E/bg
         RLSSw7Qs+0Uoga5N6utJavhIfMMW0qb9NHdnrG0yNDl4mytiaRRuH9ukVWQPh/uVrivg
         VBfdFhJkhhvVlwM7LJCt+1/BqOdYp0gOdPrz2wMsJFuSFfXMs5LNx64DH2I+LSA/VeDY
         r0rDTTnoT4gn1R1w1dhz173AFN4No42lrHuGxP3nKmoY1BLfVBfn8MJq2/KxrODTyFiU
         iW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32g/F2GpwQ9CxZvz1Ft4WS+BiOjylD57xp4fGGgCfE4=;
        b=H1/ZH9Dzf7hLp6YbJtQ/s5jC2UROvxBsTJGaAubHvbywAvs+K11FMDLF96lwZsX9oz
         Jcp07NQ3FYc8Wb8VUn7Lwswk+zsDqzMTM/fQxAkjHfuvW+kJ5DRjN7WycqaK/3qMuBLO
         tuOoWgcqTwhN0pNSG+or+fX9xlXhYS7CIdenue0SKyNiR2Ip4f0XgvhyWOHB332QwHDM
         e8qabkKSSMdiF/BdB0wUzRVvAOEzlmDUjeFt5+YWZ0clFNuFZwbwKMFqPQo6yWUvl6Dk
         6fFJD2oIGy20h1UVfpD/VOTN9unqw+u98SVi3rPIaNLpP0faV5DIJinQZQKZoNRmFwbI
         Xv7Q==
X-Gm-Message-State: APjAAAXl12x3sVObWpImgxdirelgJae6Xy1XUgv33YaqqtwkVXuLsWmm
        78BZTNljzOjYA8y5p9DRkl2VxaH2k+JOTOEFu+2ZRQ==
X-Google-Smtp-Source: APXvYqw5+fFbhmw6chP5SK/Ag2ERxRGIDSj493GNpURQ4eE2xwvYI8JtfLdnqxgYMSqXkJpxUXbhZ/3yLl8Iv4WK5UY=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr27004820iof.11.1554900754733;
 Wed, 10 Apr 2019 05:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190409213946.1667-1-casey@schaufler-ca.com>
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Wed, 10 Apr 2019 08:52:27 -0400
Message-ID: <CAB9W1A2yUNcdsJbXC_n8xhmnQBcZvHkFzHtk1jBeTS1+cv_VVw@mail.gmail.com>
Subject: Re: [PATCH 00/59] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 9, 2019 at 5:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> This patchset provides the changes required for
> the AppArmor security module to stack safely with
> "exclusive" security modules, those being SELinux and
> Smack.

What's the use case?  Who would use such support?

>
> Performance: Using a kernel compile benchmark indicates
> a performance impact of 0.15% for a Fedora 29 system
> with SELinux. Adding AppArmor has an additional 0.20%
> impact. Fedora does not include an AppArmor profile.
>
> A new process attribute identifies which security module
> information should be reported by SO_PEERSEC and the
> /proc/.../attr/current interface. This is provided by
> /proc/.../attr/display. Writing the name of the security
> module desired to this interface will set which LSM hooks
> will be called for this information. The first security
> module providing the hooks will be used by default.
>
> The use of integer based security tokens (secids) is
> generally (but not completely) replaced by a structure
> lsm_export. The lsm_export structure can contain information
> for each of the security modules that export information
> outside the LSM layer.
>
> The LSM interfaces that provide "secctx" text strings
> have been changed to use a structure "lsm_context"
> instead of a pointer/length pair. In some cases the
> interfaces used a "char *" pointer and in others a
> "void *". This was necessary to ensure that the correct
> release mechanism for the text is used. It also makes
> many of the interfaces cleaner.
>
> The security module stacking issues around netlabel
> not addressed here as they are beyond what is required
> to stack AppArmor with either SELinux or Smack.
>
> git://github.com/cschaufler/lsm-stacking.git#stack-5.1-rc2-apparmor
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c                |  25 ++-
>  fs/kernfs/dir.c                         |   6 +-
>  fs/kernfs/inode.c                       |  31 ++-
>  fs/kernfs/kernfs-internal.h             |   3 +-
>  fs/nfs/inode.c                          |  13 +-
>  fs/nfs/internal.h                       |   8 +-
>  fs/nfs/nfs4proc.c                       |  17 +-
>  fs/nfs/nfs4xdr.c                        |  16 +-
>  fs/nfsd/nfs4proc.c                      |   8 +-
>  fs/nfsd/nfs4xdr.c                       |  14 +-
>  fs/nfsd/vfs.c                           |   7 +-
>  fs/proc/base.c                          |   1 +
>  include/linux/cred.h                    |   3 +-
>  include/linux/lsm_hooks.h               |  93 ++++----
>  include/linux/nfs4.h                    |   8 +-
>  include/linux/security.h                | 137 ++++++++----
>  include/net/netlabel.h                  |  10 +-
>  include/net/scm.h                       |  14 +-
>  kernel/audit.c                          |  43 ++--
>  kernel/audit.h                          |   9 +-
>  kernel/auditfilter.c                    |   6 +-
>  kernel/auditsc.c                        |  77 ++++---
>  kernel/cred.c                           |  15 +-
>  net/ipv4/cipso_ipv4.c                   |  13 +-
>  net/ipv4/ip_sockglue.c                  |  12 +-
>  net/netfilter/nf_conntrack_netlink.c    |  29 ++-
>  net/netfilter/nf_conntrack_standalone.c |  16 +-
>  net/netfilter/nfnetlink_queue.c         |  38 ++--
>  net/netfilter/nft_meta.c                |  13 +-
>  net/netfilter/xt_SECMARK.c              |  14 +-
>  net/netlabel/netlabel_kapi.c            |   5 +-
>  net/netlabel/netlabel_unlabeled.c       | 101 +++++----
>  net/netlabel/netlabel_unlabeled.h       |   2 +-
>  net/netlabel/netlabel_user.c            |  13 +-
>  net/netlabel/netlabel_user.h            |   2 +-
>  net/unix/af_unix.c                      |  11 +-
>  security/apparmor/audit.c               |   4 +-
>  security/apparmor/include/audit.h       |   2 +-
>  security/apparmor/include/net.h         |   6 +-
>  security/apparmor/include/secid.h       |   9 +-
>  security/apparmor/lsm.c                 |  64 ++----
>  security/apparmor/secid.c               |  42 ++--
>  security/integrity/ima/ima.h            |  14 +-
>  security/integrity/ima/ima_api.c        |   9 +-
>  security/integrity/ima/ima_appraise.c   |   6 +-
>  security/integrity/ima/ima_main.c       |  34 +--
>  security/integrity/ima/ima_policy.c     |  19 +-
>  security/security.c                     | 366 ++++++++++++++++++++++++++++----
>  security/selinux/hooks.c                | 259 +++++++++++-----------
>  security/selinux/include/audit.h        |   5 +-
>  security/selinux/include/objsec.h       |  42 +++-
>  security/selinux/netlabel.c             |  25 +--
>  security/selinux/ss/services.c          |  18 +-
>  security/smack/smack.h                  |  18 ++
>  security/smack/smack_lsm.c              | 238 +++++++++++----------
>  security/smack/smack_netfilter.c        |   8 +-
>  security/smack/smackfs.c                |  12 +-
>  57 files changed, 1252 insertions(+), 781 deletions(-)
