Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C01BC433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Sep 2021 02:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F3961108
	for <selinux@archiver.kernel.org>; Fri, 17 Sep 2021 02:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbhIQCIm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Sep 2021 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhIQCIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Sep 2021 22:08:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E5C061574
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 19:07:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v22so19723608edd.11
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W1fYUbg9aMy3yjIbFReYSe3l8ekNYASZMIBdjWYh3+0=;
        b=oS1oUYAOulikpeCeTRggJ6GIObm33rGsYg/2MDvqtvqedMvCKVEF4XNAM1ZoUMuMxv
         pf5p71X2Q9mn6jH5vNabPWy/g2pRpFC4m9pSurhZghjxB217hARV6swqTBADCgQhrPUM
         rxsQytM+eFeU6oj3v8AP9os/IanzRqrb9p2LY7iQ1WQDmTUoK7Bt4s57tzV1srCssDjQ
         c3VYZSQCQSVr2L4LaoIZbOv688s1VwaW1hjWdeMA4lKHZnNNxngJuO7gdga7cCUZiAQa
         F37xIklrLN9f+ntJdNstVq+Ya+pU8pJDzm5xAmRY/d6Z5q6Oqs7EvzUb1hJHA5GBX44z
         Eh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W1fYUbg9aMy3yjIbFReYSe3l8ekNYASZMIBdjWYh3+0=;
        b=lM8FxEyzY7DML62atVoidvCY0VRbiZcld4zShmQUNECflafZTviK5K2MrjAbwDr0bf
         Gie+eCsa3nedd70a66o7MG2vCCgIa0z+Al4w6l/wroD8LxtjNsylfg/wuzrrjlSoYmx9
         ULxYdJgk9UpJUCqPtvi27TTV2zqdsxN1diJZFAUpxNt0jc7yocaqcz9SrK7isz4ov5Qt
         mKrlPaJai7xKgRClGiO7ER48mnwG6JCJ2LHAheo6u19CGBXB5WZXp7RZTe5K1hNsu+XT
         AaBDqiVsSV73oXwPfMcaIsuJybJlJbA/Ewx1otSUMtDhkxIiCjj/SSfLK55UP6kSbY7D
         hCuQ==
X-Gm-Message-State: AOAM5301KjagOGNRbL941IMrdxzUIK7hQGuNiJFBjzXX+KHgZAbJHWWR
        GeVsg/QRo4KeFo6EyQn9MeETXbdygRBUL2D07kOsExPrTw==
X-Google-Smtp-Source: ABdhPJxZBdpj/YGJZ2PAdlycT/N7zYZGZfFpdwzdr+0vC8tpzppgza3nv1hmwKgF3ofkILpJHOaJIhGQ1D9fFAW/dxg=
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr9936414edv.187.1631844437884;
 Thu, 16 Sep 2021 19:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com>
 <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com> <CAJ2a_DeuF2tqQ08piCUnJZwxOkWXfu7rBOrfoRP5f4ughYxBdQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeuF2tqQ08piCUnJZwxOkWXfu7rBOrfoRP5f4ughYxBdQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Sep 2021 22:07:06 -0400
Message-ID: <CAHC9VhTq8dOvHzZ48guwCmR9SBSc3rd5hivb6X2aVN+QCukWew@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 16, 2021 at 1:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Wed, 15 Sept 2021 at 20:28, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 12:24 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Add support for genfscon per-file labeling of securityfs files. This =
allows
> > > for separate labels and therby permissions for different files, e.g.
> > > /sys/kernel/security/integrity/ima/policy.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  security/selinux/hooks.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Hi Christian,
> >
> > It would be nice if you could add some additional notes on how this
> > was tested to the description above.
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 6517f221d52c..a18626424731 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
> > >             !strcmp(sb->s_type->name, "tracefs") ||
> > >             !strcmp(sb->s_type->name, "binder") ||
> > >             !strcmp(sb->s_type->name, "bpf") ||
> > > -           !strcmp(sb->s_type->name, "pstore"))
> > > +           !strcmp(sb->s_type->name, "pstore") ||
> > > +           !strcmp(sb->s_type->name, "securityfs"))
> > >                 sbsec->flags |=3D SE_SBGENFS;
> > >
> > >         if (!strcmp(sb->s_type->name, "sysfs") ||
> > > --
> > > 2.33.0
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> Something like:
>
>     Add support for genfscon per-file labeling of securityfs files. This =
allows
>     for separate labels and thereby access control for different files.
>     For example a genfscon statement
>         genfscon securityfs /integrity/ima/policy
> system_u:object_r:ima_policy_t:s0
>     will set a specific label to the IMA policy file and thus allow to
> control the ability
>     to set the IMA policy.
>     Setting labels directly, e.g. via chcon(1) or setfiles(8), is
> still not supported.
>
> ?

That's a much better description of the functionality, especially for
those who may not be very familiar with SELinux, thank you.  However I
was hoping to also hear some confirmation that you have tested this
and it worked without problem?

--=20
paul moore
www.paul-moore.com
