Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63802C282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AB020880
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 15:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RXRR/NYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfA1PL3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:11:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35779 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1PL3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 10:11:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so14555613ljb.2
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66f6s90Hw8yi+QpEvTxfdryxc/mTGBaa7Bo/HEe+7XA=;
        b=RXRR/NYdRX4ntQPx3ZjjuKX0Y+MTPt1pVJRcC0cGEDnfR6PsIzPP/eWWEQyazXRIev
         +IH3/nEADztKdfNprO758afZSqOSyotHPMSdomU14Nu42ExqesYIG1gjZtm3us1AvRnt
         3YfrZqzh0I/CpL3pNmIQ2FG0bzN4KMZ7MHp08d5qMyUKhACMCHlexU1IKUOyhA05vM9C
         fiuK0/JiX2/f7m48rw+EOS8ikAWLDPnVEzQcud8Pt4JPBsOsxekTAOBNbxh/vwY22epr
         NTSeuCw4RHA/SSJPnIukCK8kS4fwNjDH4dXfYU3CWOpUrcjohRk14/oB3peEubZmnRd8
         iXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66f6s90Hw8yi+QpEvTxfdryxc/mTGBaa7Bo/HEe+7XA=;
        b=Eif99JErwKA2v8VgCxet1hwpoBNs0ZqsakBBOUacJW6Iz5p/foXxsXMJmgxi6T/LdT
         2y09tVVkdrx4DojVvEXQ6rhdKJrr95w4Pi4EZz609GP9MHuTyAwYKeu3abcYx8Rpn+K3
         yvTP6klanFuh2Fw5K05CwYof8laqhWkd4TbIHaJzs484ZbfJkuvLm24s2EyEnRharurV
         eRO+5/sGdFMh/E73LLyjeAcTqQENPm7kSfemTZvpEChIOYwiK9AhOqaZPkUoQKgxVvpb
         tQOAS8npCJBc+xzxRu0ilIMj17iZv9SmPPA68QhlgVkp0fUDVaC1FZEegVOhugfY2uGU
         mKcg==
X-Gm-Message-State: AJcUukeA8dR3bs+q0gx+DgVr2eG9+5WIbJDoRuW4ukddRLmtHtxGRsld
        YBoaZbnNhdz0PWDnQcks2p+qqlP3lGXzalPHo3R9Di8=
X-Google-Smtp-Source: ALg8bN6PJBcEFRvTc4RD7N/5LqFxMPlU2an+fLpLQQT7Ci9uglgjCRJvRKa/1NxIs2Dxmg65nMdj3Kk6sT2ap6V0o6c=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr17509532ljj.161.1548688287607;
 Mon, 28 Jan 2019 07:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20190126101816.1065-1-omosnace@redhat.com> <9a9ed7ba-b4ab-34a9-4d14-81ac4a418eb4@tycho.nsa.gov>
In-Reply-To: <9a9ed7ba-b4ab-34a9-4d14-81ac4a418eb4@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 10:11:16 -0500
Message-ID: <CAHC9VhQuFPQ9C5=FxP1LEetZVHRsfmQV2qH5TErTaPuBW9wcsQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: replace BUG_ONs with WARN_ONs in avc.c
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 28, 2019 at 8:23 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/26/19 5:18 AM, Ondrej Mosnacek wrote:
> > These checks are only guarding against programming errors that could
> > silently grant too many permissions. These cases are better handled with
> > WARN_ON(), since it doesn't really help much to crash the machine in
> > this case.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/avc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 3a27418b20d7..84f108f4100a 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -1059,7 +1059,7 @@ int avc_has_extended_perms(struct selinux_state *state,
> >       int rc = 0, rc2;
> >
> >       xp_node = &local_xp_node;
> > -     BUG_ON(!requested);
> > +     WARN_ON(!requested);
>
> Should this be:
>         if (WARN_ON(!requested))
>                 return -EACCES;

I think so, it would be bad not to return an error in this case (and
the similar one below).

> >
> >       rcu_read_lock();
> >
> > @@ -1149,7 +1149,7 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
> >       int rc = 0;
> >       u32 denied;
> >
> > -     BUG_ON(!requested);
> > +     WARN_ON(!requested);
>
> And likewise
>
> >
> >       rcu_read_lock();
> >
> >

-- 
paul moore
www.paul-moore.com
