Return-Path: <SRS0=bAF8=OP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE8DC04EB8
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 23:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875D220878
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 23:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GBeT8YrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875D220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLFX6F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:58:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43837 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbeLFX6F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Dec 2018 18:58:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so1691735lff.10
        for <selinux@vger.kernel.org>; Thu, 06 Dec 2018 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxS9se1eC9pQxIr8xWpdeAw/kEJWYpXjQ1SuUNhWXhA=;
        b=GBeT8YrObhJKecs50P8kdW5yhUBArWhftk3c74i2984L1y431vf4KyCMPZ6XwUy53l
         arq8ubMaZF3Agtc49LqUXXYUPtKieEvBwnAqmMG23WUsmvHHR1+Qbya7Tzuqpfo5ndiS
         KbpqOdgjfRpyd1YeC3IbCEo97cq5pTBDE8ECujEiH/NoxTtHyju+2qFpxMoshs1PVzXe
         GAjMPlhHl2G083ncqFJUbHL2Dkac8jfl7t6zSQsmfr4SldeD0F2EBc/1U3V06hvU4IC+
         dI4Z6PkauQ2i2p1/IlzFqoZ8jDuyF7+pwg+FnkJm1gW6n8RXGHdfWgy4vIQbOLOqa6Qm
         6FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxS9se1eC9pQxIr8xWpdeAw/kEJWYpXjQ1SuUNhWXhA=;
        b=gKbkKX3dYo41OhD8IVk9oPCW6mAyfwfspzxOWEZPs8/v3vfly2xnHgvi0G9agTW9/h
         4671yeAeJeYGDDgrV8yHncYUo46y4yrjyy0YsUm0FDkysZiyR/39kyoS+mTErBU9Dj+/
         59EfSPbSWOe4ogIVJa973+WlZWbXRV7uKNcUeOE3mSQ845rdPHv1II2v/O41/56fl6l7
         7ZY1+fd1pUgCRNmME3YOm15BDnN5HX2HpfezfxvKQz71/qH85q27e7g1HNcRLjgNgIR/
         tHuLLpEfxEkPbS8Ky6Bi2D/CVX7IJ/zMMRVbxzrch0gUdcALBLeMh3+B/7OWENK/8N6A
         dQTg==
X-Gm-Message-State: AA+aEWYcFic0my9zOM8nUKTNAzZHZG0/gmPtT02f7mWIgjUdZbfZgnB0
        Uqt+O0JQw4bJNiOKTlzvHrLyRknrexUoiTbGtFeO
X-Google-Smtp-Source: AFSGD/VniEXyxk/j8MA6EmKLQaNysze/ed4CaW0oKxSCLg9xiWNBYpdnXPgPfkbskecFc1L2zVE2+TM/RxqSfuiWvTQ=
X-Received: by 2002:a19:6719:: with SMTP id b25mr5293lfc.38.1544140682191;
 Thu, 06 Dec 2018 15:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20181204204209.21542-1-sds@tycho.nsa.gov>
In-Reply-To: <20181204204209.21542-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Dec 2018 18:57:50 -0500
Message-ID: <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: avoid silent denials in permissive mode
 under RCU walk
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, bmktuwien@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 3:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> results in no audit messages at all if in permissive mode because the
> cache is updated during the rcu walk and thus no denial occurs on
> the subsequent ref walk.  Fix this by not updating the cache when
> performing a non-blocking permission check.  This only affects search
> and symlink read checks during rcu walk.
>
> Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> Reported-by: BMK <bmktuwien@gmail.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c         | 9 ++++++---
>  security/selinux/hooks.c       | 4 +++-
>  security/selinux/include/avc.h | 1 +
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 635e5c1e3e48..f0e7bc0dc442 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct selinux_state *state,
>             !(avd->flags & AVD_FLAGS_PERMISSIVE))
>                 return -EACCES;
>
> -       avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
> -                       xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
> +       if (!(flags & AVC_NONBLOCKING))
> +               avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested,
> +                               driver, xperm, ssid, tsid, tclass, avd->seqno,
> +                               NULL, flags);

I realize the issue here is specific to the VFS code paths, but if we
are going to introduce a general AVC flag to tell the AVC code not to
block, it seems like we should honor it everywhere.  I would suggest
moving the check into avc_update_node() itself (it's static, so
hopefully any perf impact will be negligible).

>         return 0;
>  }
>
> @@ -1199,7 +1201,8 @@ int avc_has_perm_flags(struct selinux_state *state,
>         struct av_decision avd;
>         int rc, rc2;
>
> -       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
> +       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
> +                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
>                                   &avd);
>
>         rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce012d9ec51..9b05f84808d9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3196,7 +3196,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>                 return PTR_ERR(isec);
>
>         rc = avc_has_perm_noaudit(&selinux_state,
> -                                 sid, isec->sid, isec->sclass, perms, 0, &avd);
> +                                 sid, isec->sid, isec->sclass, perms,
> +                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
> +                                 &avd);
>         audited = avc_audit_required(perms, &avd, rc,
>                                      from_access ? FILE__AUDIT_ACCESS : 0,
>                                      &denied);
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index ef899bcfd2cb..74ea50977c20 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -142,6 +142,7 @@ static inline int avc_audit(struct selinux_state *state,
>
>  #define AVC_STRICT 1 /* Ignore permissive mode. */
>  #define AVC_EXTENDED_PERMS 2   /* update extended permissions */
> +#define AVC_NONBLOCKING    4   /* non blocking */
>  int avc_has_perm_noaudit(struct selinux_state *state,
>                          u32 ssid, u32 tsid,
>                          u16 tclass, u32 requested,
> --
> 2.19.2
>

-- 
paul moore
www.paul-moore.com
