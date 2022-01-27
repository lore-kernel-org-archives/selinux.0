Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596EC433FE
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbiA0R0g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbiA0R0e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 12:26:34 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFEC06173B
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:26:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ah7so7434452ejc.4
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xau7rOafC/Mt4FD6m1Uhzd34PjCSS1U4KKfTU1dW0wM=;
        b=2u2a7XGZSWlXPt0OkFMp4isj7gNhMROH+HXNrFCWWwwyH6Nm+1CPjYEhNXm5hkYeuq
         WzHUlts7Ga14Fq4NreCZxRRx6Jwsa0VKLqjbG4I4QTjr/dQ/9oDgcyyR2SSwPIp5uYh8
         /lzIu6rUYWwoQH+GhQ1We4bmDRTiqfuo7ZjXG3lgYW3WO8WPeGkhrzs5uiBNCYsCET1g
         CYhSZ2i46Cw27+tYHqkuEm+iYrXbYUqL3tMnAoBUeQON0RRhABsjDDRYM+vSkYhRZX3H
         SgAdV72EJX29XzzoYQbZB4Kj6TWkLqD7dfbmKZrMN8VhK9jUzJ+7GKSPHdcHqIDpiOhm
         GO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xau7rOafC/Mt4FD6m1Uhzd34PjCSS1U4KKfTU1dW0wM=;
        b=rEv4ydwFu1wTNdXq5Z8j5Sn6QXMhZuncVryQ29KcgivB0sbWIrdCyalA2qW/Otyq8N
         s+9ljMJ6cALaym8Lp+Y5LeezWYeCiVnlqIG2oRbOTxjWFmCm/wyVZMMkf0PzIaOR2SdG
         uSvfjtXxiS8PX++h33viaglmSfTMJfXzsUCBPa56pO7DaYWMtztxDIf+JyB7ptrC3ddm
         iTTIAzTDUgMpCrHxdWhDnKLwzCYCs8PJh24K9cr8z0VKtDHSFs3+LHtGTpKUA+ovaw1/
         Y8QV4XQL4sVQQFjfecKSOxNaydJjVu936XEGonIz5/TpIrOaZs7czHVUk4Z8DWGey90f
         3WCw==
X-Gm-Message-State: AOAM530F+valgL1gLadIjL3ABoBiBOBXNu+dcNkSmtEk9WlLxErx524W
        NL6VxKm8p+/aI9qmjUjl8TJtRvUhruvHngq8FoCRC9WvhQ==
X-Google-Smtp-Source: ABdhPJzb8cgd9W1ok7GYr//fhHNsq8jrrmmvIcJTtUp3IAThTZ+o6ymkwmZe2UlQFPEhEteClDe0aPLBbTTPWXqfM3A=
X-Received: by 2002:a17:906:1e06:: with SMTP id g6mr3676334ejj.517.1643304392359;
 Thu, 27 Jan 2022 09:26:32 -0800 (PST)
MIME-Version: 1.0
References: <164329905457.31174.9220154812163631144.stgit@olly> <CAJ2a_DcD+zCnLp5jqR0R48MZjmRsviucb6182S4OGpf_o0uw+g@mail.gmail.com>
In-Reply-To: <CAJ2a_DcD+zCnLp5jqR0R48MZjmRsviucb6182S4OGpf_o0uw+g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 12:26:22 -0500
Message-ID: <CAHC9VhTBZRkM4CAWP+F_kZ2D-su+YNeP_wWxMpoAMdusCLiGLg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a type cast problem in cred_init_security()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 11:26 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 27 Jan 2022 at 16:57, Paul Moore <paul@paul-moore.com> wrote:
> >
> > In the process of removing an explicit type cast to preserve a cred
> > const qualifier in cred_init_security() we ran into a problem where
> > the task_struct::real_cred field is defined with the "__rcu"
> > attribute but the selinux_cred() function parameter is not, leading
> > to a sparse warning:
> >
> >   security/selinux/hooks.c:216:36: sparse: sparse:
> >     incorrect type in argument 1 (different address spaces)
> >     @@     expected struct cred const *cred
> >     @@     got struct cred const [noderef] __rcu *real_cred
> >
> > As we don't want to add the "__rcu" attribute to the selinux_cred()
> > parameter, we're going to add an explicit cast back to
> > cred_init_security().
> >
> > Fixes: b084e189b01a ("selinux: simplify cred_init_security")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index eae7dbd62df1..c057896e7dcd 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -213,7 +213,7 @@ static void cred_init_security(void)
> >  {
> >         struct task_security_struct *tsec;
> >
> > -       tsec =3D selinux_cred(current->real_cred);
> > +       tsec =3D selinux_cred((__force const struct cred *)current->rea=
l_cred);
> >         tsec->osid =3D tsec->sid =3D SECINITSID_KERNEL;
> >  }
> >
>
> Thanks for cleaning up.
> Just out of curiosity: the kernel doc[1] suggests using
> prepare_creds() + commit_creds() to update creds.
> Is is not required here because this is initialization code and the
> members osid and sid are only used by initialized SELinux?

Generally, yes, you are correct in that you would want to do the
prepare/commit dance when altering credentials, but this is a special
case as it is only used to set the credentials of the initial task
when it is created during boot.  At this point in the system's
lifetime we really don't have to worry about the same things that we
do when the system is up and running so it is safe (and easier!) to
just modify the credential directly.

--=20
paul-moore.com
