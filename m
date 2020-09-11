Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B99C43461
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A56D2076C
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UphAzaAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIKPYG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgIKPWl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:22:41 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01599C06134F
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:23:33 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y25so2327265oog.4
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cR1i5Zp04xbbN78oPnVdn8t8s28gVc0F9H5XwygC9h4=;
        b=UphAzaAadbeeItT3lDSnyueSyzxkPcqNG7JAFislF5Oj9V8xtyuSTE+StZQHz4/5nr
         jiwAvl7c6rmplWXOhMCIGkKmwoIhfnxoQ7fpK+qQActhnFlyjD1ukqTGGJolQe5K9YJf
         vLA8r0t8wrdyxIx5dgeOPoIoGYMq2aPzdSKE5mrRh14lf7ZnDe38/QK2DKWZxKRWwe9W
         lAZvwhP2C2l1pD3JUan/vhk36ONkag/ozsBXEQq6FWGFTBjdL13D5u9TYh3O7svqPGLX
         hgSmR+/iOBcIYrW6fe+cvqA3Wc/4MSXG7puKcawX8AJUt2e8o1E7k6C/7y/jCNMCghlJ
         aNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cR1i5Zp04xbbN78oPnVdn8t8s28gVc0F9H5XwygC9h4=;
        b=LkRP+HefRZSYm+44vy6JLhYHIFZv9MGaIIeZu8lIEkP3+PTyLrFLXsiJqJ2ggi9bVy
         +Ow4KObTeRayqtmZ0fjW6pGtyyqCjKgG8TK8596QCdq0aXuuPDtB49m++SzZcNXuEFp2
         MWvIlgBrdQGKnRSzvUZM2a75liKk5KjkhopIY0kIfvUqxcF+4/OLINZYCD+ghdARc6Qt
         K9nyxlD0erbqnuilpkfZvMrGXTHk2hCMpFuKQjZGcB2Jd4WZHOJx6NzS3ceIkjRdWhiS
         K8i40iUGyO9XWsO6a/Ks8bmWDUJNI9nqpqVibDh5ilgwW8yPnANXSctsJq7Ghq1L4tM6
         uWNg==
X-Gm-Message-State: AOAM531apq4FdE+7Pnyp3cyAJXGktOrQmvXa1bQHxCR2XBp37rqCgphK
        rQzGHGmAhYPf+oiYKP1D+PnXqqNj3iSUrorDfED1Qmy0G2g=
X-Google-Smtp-Source: ABdhPJzZeD6qG6v2QsuNEhgEZc0Dph3/DrQrCJb7V/cBOSxfDDEC5KSpR0OeyZvAWUvqdhJ17UD5rDu7HI9tqUrpn+4=
X-Received: by 2002:a4a:dc44:: with SMTP id q4mr1789718oov.71.1599834213241;
 Fri, 11 Sep 2020 07:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200909222822.23198-1-nramas@linux.microsoft.com> <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com>
In-Reply-To: <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 11 Sep 2020 10:22:33 -0400
Message-ID: <CAEjxPJ7Q+7mBh1hjY7sZiEAjX7Z8afrpzMP6UTwDrO3=pKVoRQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Add helper functions to get and set checkreqprot
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 10:07 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Sep 9, 2020 at 6:28 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > checkreqprot data member in selinux_state struct is accessed directly by
> > SELinux functions to get and set. This could cause unexpected read or
> > write access to this data member due to compiler optimizations and/or
> > compiler's reordering of access to this field.
> >
> > Add helper functions to get and set checkreqprot data member in
> > selinux_state struct. These helper functions use READ_ONCE and
> > WRITE_ONCE macros to ensure atomic read or write of memory for
> > this data member.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c            |  6 +++---
> >  security/selinux/include/security.h | 10 ++++++++++
> >  security/selinux/selinuxfs.c        |  5 +++--
> >  3 files changed, 16 insertions(+), 5 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index cbdd3c7aff8b..cc29177c8858 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -143,6 +143,16 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
> >  }
> >  #endif
> >
> > +static inline bool checkreqprot_enabled(const struct selinux_state *state)
> > +{
> > +       return READ_ONCE(state->checkreqprot);
> > +}
> > +
> > +static inline void checkreqprot_set(struct selinux_state *state, bool value)
> > +{
> > +       WRITE_ONCE(state->checkreqprot, value);
> > +}
>
> This is a nitpick, and I recognize that Stephen already suggested the
> use of "*_set()" and "*_enabled()" for names, but if we are going to
> name the setter "*_set()" let's also name the getter "*_get()".

I just suggested that we be consistent with the existing naming for
enforcing_*(), which I thought came from you?
