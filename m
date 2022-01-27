Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD2C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 18:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiA0SRV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231634AbiA0SRU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 13:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643307439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyK2WkNvkUr8+FrbUEhMRnqU7m4gUppuM2CT1yg+QBg=;
        b=IRvOh+GB0YDTcc+SPQwR7DTqHrdSH0rDBv/k7zggRyYwk/xi3hBtl1ljgYO0yKzZUFiefe
        cLBEo6X1/dY5SgD+IZXADgRqbIlAu7lFjgl3i5zCPCOXfN97Dz3BoFDUZyAJhLdD4dk70U
        80ba9WU0fr/uH7E56deby3PLmcCZ2lo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-WEeXN2MjMVi-W-TfFw5HAg-1; Thu, 27 Jan 2022 13:17:18 -0500
X-MC-Unique: WEeXN2MjMVi-W-TfFw5HAg-1
Received: by mail-yb1-f198.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so7476156ybg.8
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 10:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyK2WkNvkUr8+FrbUEhMRnqU7m4gUppuM2CT1yg+QBg=;
        b=S9KKKrWpH758CBgBj1hnCnUxM+/4fkc7GceEZ1bp54G2QQiX6ajgxOCyCtexxnyXDZ
         UTqW4VtOkNVpAOn0CYnJW0vyb3e/lIgSSSOu9cprPKVNj5PMx2cvO/bZB6eyYtOC2dl5
         h/SR24VJxFJfH38mzWJdwdGICi1jJbPb+1AsKKnw7xbCp6J4E6fE8q1PBlVhIcdA4TSr
         V4u7lZ7C/vz9nWpV1MTW4h9XxCe7Vz4au0Rrls+AkoAV2GKD1zFuel63B+5FF4cHDmZe
         FWTugJpi0Q15FzltDlFUGD8fN0JRuyT0NINkuX7Gs8nL7F+bFK06jKW3aSY+gSzZeNRg
         YM/Q==
X-Gm-Message-State: AOAM531RYiua6XYg+NAkKf8okS29Rq4px3XeREpAKTarKiGfTJb9BzK2
        yldC/o4xpGQ2/ILTnnze4BpBIKgh037IfKbLWa3LGfEeK1pMwrPp6Jmdq7OcthkdviXMkikP+Hz
        3rQYOdx4gAN7HM3KoXxInEsssdrjm5u+jng==
X-Received: by 2002:a25:2d0:: with SMTP id 199mr6349452ybc.31.1643307437712;
        Thu, 27 Jan 2022 10:17:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPvKQMNEsuDoYHLeeyH1PCclQrIXgSJK0lE3ClEv+uBqV3RGOqzeorXdlqlPEkZm+ZmVqpcSxtWxrbnhra9ks=
X-Received: by 2002:a25:2d0:: with SMTP id 199mr6349431ybc.31.1643307437480;
 Thu, 27 Jan 2022 10:17:17 -0800 (PST)
MIME-Version: 1.0
References: <164329905457.31174.9220154812163631144.stgit@olly>
 <CAFqZXNsKDLyz7E20uc7=1NaABcf8Gu8fhHExkttMN_5e59tY7g@mail.gmail.com> <CAHC9VhRkeaicR-i1YvB--FMNLneO1ydf9dPmtHduOkD376GdOw@mail.gmail.com>
In-Reply-To: <CAHC9VhRkeaicR-i1YvB--FMNLneO1ydf9dPmtHduOkD376GdOw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Jan 2022 19:17:01 +0100
Message-ID: <CAFqZXNuGf7jCcGB+d3VzEw3__uw8midh-rcWmTHmMDo7-27G5Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a type cast problem in cred_init_security()
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 6:27 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jan 27, 2022 at 12:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Jan 27, 2022 at 4:57 PM Paul Moore <paul@paul-moore.com> wrote:
> > > In the process of removing an explicit type cast to preserve a cred
> > > const qualifier in cred_init_security() we ran into a problem where
> > > the task_struct::real_cred field is defined with the "__rcu"
> > > attribute but the selinux_cred() function parameter is not, leading
> > > to a sparse warning:
> > >
> > >   security/selinux/hooks.c:216:36: sparse: sparse:
> > >     incorrect type in argument 1 (different address spaces)
> > >     @@     expected struct cred const *cred
> > >     @@     got struct cred const [noderef] __rcu *real_cred
> > >
> > > As we don't want to add the "__rcu" attribute to the selinux_cred()
> > > parameter, we're going to add an explicit cast back to
> > > cred_init_security().
> > >
> > > Fixes: b084e189b01a ("selinux: simplify cred_init_security")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/hooks.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index eae7dbd62df1..c057896e7dcd 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -213,7 +213,7 @@ static void cred_init_security(void)
> > >  {
> > >         struct task_security_struct *tsec;
> > >
> > > -       tsec = selinux_cred(current->real_cred);
> > > +       tsec = selinux_cred((__force const struct cred *)current->real_cred);
> > >         tsec->osid = tsec->sid = SECINITSID_KERNEL;
> > >  }
> >
> > How about using unrcu_pointer() instead of the cast? It seems to do
> > effectively the same while looking less ugly :)
>
> Ah ha!  I didn't know that function/macro existed :)

Full disclosure: I also discovered it today :) First I thought of
rcu_dereference_raw(), but I decided to skim through
<linux/rcupdate.h> looking for a better fit (rcu_dereference_raw()
also does READ_ONCE(), which is not really necessary in this case) and
found this one.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

