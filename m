Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9AC43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD1920869
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 17:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lSMEWA6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfKGRtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:49:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbfKGRtE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 12:49:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so2274869lfp.4
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s23dxj0JF+myWDnxbncL/KYoewB8cWSuED9Bp6RLkuc=;
        b=lSMEWA6s6CcMHaHYEKuUz1b2xTSCF+FErfeZRQIaqMnx8HaGzhafpLC0h3UiV9W/ou
         8F2RzG8M2NP5AAMvyoSCrw13KLfTxnH7qxWb4qnF8UVqqFrWfIQtFkOGG+GLXPPV13bo
         EmDSVSiDS6VOgWzfaTFkOKUDlFDe4UcGyhKLX1ZDBNA+l0TF7p0lra3dBqHcUlfHf5eX
         +aRubeHLCjkb6x93zdJUHd4S++Dcwy7b6O912KTw+mzbDhSP1j5YxXxMn14nQIUekCtJ
         qbON8u5VSXHml0+uMFt4xOex33vCNOSf513QgGvh502Ew4v0IUZUxQpLnhcMsSZGGxeR
         lUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s23dxj0JF+myWDnxbncL/KYoewB8cWSuED9Bp6RLkuc=;
        b=tqIWnb+sRmHhMxdg/pHYFE8Hvy51B6iZQTu2gpNmSBDIrzm4MrlH+EB1da6DmGin9A
         An1hfEo9+82TFUEzRR7oDTTcx0y5q3T/d5rAJqkMglwnehYXaPPsRMmsBgBbBzS0MGLG
         vp5DNg7jLA8icjGTSGRgPLgTWsBGYmg9eme0dRw9x4yhKt5dE7aA+LyFGaVxuR8D2yuQ
         iOfTudbWHXmCo1cUX5UnqkFczrvLquj766tof+Qqe3H25Ymw78QDh3B6BKU53MCt9yz2
         +AnpP1uuUu3Dxktkkbj+b3xequ10HWyZyM+OkAJ8NNs7HSMaHDwURIwlOakA/NmSde4t
         R8OA==
X-Gm-Message-State: APjAAAVLbQbAVFDOF5GIpyhB15w6VHepUJ1MYS44CutVXlpXpAmhMqO6
        CSXWxE/3cbHbxm7Bb5D3e6CVRbYqGcurZ3Jw76j6zX4=
X-Google-Smtp-Source: APXvYqxEyXNPaV6Lr8yMn8/m271Kv5JLR6CFUx9eQMqMKDiNbV27Ia/P9iCiVTv2wRwitbqkb8+ZnU5d/Ic/fnv7AFM=
X-Received: by 2002:a19:895:: with SMTP id 143mr3216134lfi.158.1573148941977;
 Thu, 07 Nov 2019 09:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20191030131633.9356-1-sds@tycho.nsa.gov> <CAHC9VhQG=2VwJiM=LrZxZaSXWELbsu61pw2ynNgL0NAO+SvYMA@mail.gmail.com>
 <de944969-6d9f-8fbd-ffe1-4f9bdd7410f2@tycho.nsa.gov>
In-Reply-To: <de944969-6d9f-8fbd-ffe1-4f9bdd7410f2@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Nov 2019 12:48:51 -0500
Message-ID: <CAHC9VhSzoDnHK+fDXocShQALW32ctoOOC7GOeb_tEQsnm-1d0g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and confidentiality
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 31, 2019 at 10:01 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/31/19 5:59 AM, Paul Moore wrote:
> > On Wed, Oct 30, 2019 at 9:16 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> Add SELinux access control hooks for lockdown integrity and
> >> confidentiality. This effectively mimics the current implementation of
> >> lockdown (caveat noted below). If lockdown is enabled alongside SELinux,
> >> then the lockdown access control will take precedence over the SELinux
> >> lockdown implementation.
> >>
> >> Note that this SELinux implementation allows the integrity and
> >> confidentiality reasons to be controlled independently from one another.
> >> Thus, in an SELinux policy, one could allow integrity operations while
> >> blocking confidentiality operations.

...

> > I don't have any objections to adding a hook to control access to the
> > lockdown functionality (I think it's a good idea), but I am a little
> > nervous about the granularity of the control.  Sticking with just an
> > integrity and a confidentiality permission seems okay, but I worry
> > about adding additional permissions until we have a better idea of how
> > the lockdown functionality is adopted by developers and we see how the
> > lockdown_reason evolves.
>
> Ok, so let's discuss what if anything else is needed for a final non-RFC
> version of this patch.
>
> One thing that I wondered about was whether we ought to include the
> reason information in the audit record as supplemental data via a new
> LSM_AUDIT_DATA_* type for help in policy debugging / development.
> However, the lockdown_reasons[] string array is presently private to the
> lockdown module so we would have to export that or replicate it for
> creating a string representation of the reason if we were to do so.
> That would expose the reasons in terms of audit data but not as a basis
> for the permission check. Note that the lockdown module logs these
> reason strings via pr_notice() when it denies access, so it appears that
> exposing the strings as part of audit data would not introduce any extra
> kernel stable ABI guarantees?

That is an interesting question: do we consider dmesg output to be
part of the stable kernel API?  My hunch would be "no", as I've seen
things change quite a bit there over the years, but IANL (I Am Not
Linus).  However, that said, logging a reason string via audit seems
like a good idea (especially since there is presently a many-to-one
mapping between reasons and the SELinux permission).  Further, while
the audit field name is part of the kernel API, the value is much more
open.

> I also wasn't sure about the pr_warn() above.  If we reach it, it is
> effectively a kernel bug. We could mirror what the lockdown module does
> in lockdown_is_locked_down(), i.e. use WARN() instead.  Of course, the
> SELinux hook won't even be reached in this case if the lockdown module
> is enabled, but the lockdown module could be disabled so I guess we need
> to check it too.

Since this seems security relevant, I wonder if we should be using SELINUX_ERR?

> If we take the lockdown class with just integrity and confidentiality
> permissions now and later introduce finer granularity, we'll presumably
> need a policy capability to select whether the coarse-grained or
> fine-grained permissions are used.

True, although I'm not overly worried about the need to use policy
capabilities; I'm more worried about jumping into too fine a
granularity before we see how this will be used.

-- 
paul moore
www.paul-moore.com
