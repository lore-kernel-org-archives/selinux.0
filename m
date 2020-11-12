Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D2C2D0E4
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 21:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829A2216C4
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKLVHX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:07:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36182 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVHX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 16:07:23 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7746E5654C8
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 22:07:20 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id a15so7009292otf.5
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 13:07:20 -0800 (PST)
X-Gm-Message-State: AOAM5335p0nmBppDPjALeAqdMWpcZXD1ctJDOXsG3v1Ntm6X1uKokGhq
        QTbegwy7sGP6qrDdTvN96VveoGeaDUFpPhAm0Vw=
X-Google-Smtp-Source: ABdhPJz86spRhvZ9B1Xoz2Xnl14crX9aHzda3pfSQTj66yqpOb8ec9H7FjAlZiA54zkHhLk8suWfZsSLQ1xtks7DCFk=
X-Received: by 2002:a9d:1727:: with SMTP id i39mr830744ota.96.1605215239495;
 Thu, 12 Nov 2020 13:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20201111162340.527105-1-omosnace@redhat.com> <20201111162340.527105-4-omosnace@redhat.com>
 <CAJfZ7==T9MSFWb5x8fT93mD0ytSa__a_7t=PVWv0nxvFQta2Dw@mail.gmail.com>
In-Reply-To: <CAJfZ7==T9MSFWb5x8fT93mD0ytSa__a_7t=PVWv0nxvFQta2Dw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 12 Nov 2020 22:07:07 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mheKqaBkLwzb=DDwMG+OYBhkB8XmUL+y1HiZa1MJsBcg@mail.gmail.com>
Message-ID: <CAJfZ7=mheKqaBkLwzb=DDwMG+OYBhkB8XmUL+y1HiZa1MJsBcg@mail.gmail.com>
Subject: Re: [PATCH userspace v2 3/3] selinux_config(5): add a note that
 runtime disable is deprecated
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 12 22:07:20 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 11, 2020 at 10:19 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Nov 11, 2020 at 5:23 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > ...and refer to selinux(8), which explains it further.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policycoreutils/man/man5/selinux_config.5 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
> > index 1ffade15..8d56a559 100644
> > --- a/policycoreutils/man/man5/selinux_config.5
> > +++ b/policycoreutils/man/man5/selinux_config.5
> > @@ -48,7 +48,7 @@ SELinux security policy is enforced.
> >  .IP \fIpermissive\fR 4
> >  SELinux security policy is not enforced but logs the warnings (i.e. the action is allowed to proceed).
> >  .IP \fIdisabled\fR
> > -SELinux is disabled and no policy is loaded.
> > +No SELinux policy is loaded.  This option was used to disable SELinux completely, which is now deprected.  Use the \fBselinux=0\fR kernel boot option instead (see \fBselinux\fR(8)).
>
> Hi, there is a misspelling here: deprected -> deprecated. Otherwise
> the 3 patches look good to me, thanks!
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Thanks,
Nicolas

