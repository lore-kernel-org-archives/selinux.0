Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD3DC43334
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 19:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiF3Tmb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiF3Tmb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 15:42:31 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 12:42:29 PDT
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA74198C
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 12:42:29 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0ABFA564E65
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 21:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656617747; bh=EJnTa24AWmnm8aGEK7+mzEk9ghjm81E/qbph41hmiow=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc;
        b=lEFxRRX9LvuhptpQ54Rz9XxtHQH5YgQ/Ad1gArGt40GrMZ6z19Cj08PBtpn/CuHnT
         feRoE1/ZBkebiTPhIP4TGF7TofJg1OLS71isbf30GSUG0HhUmMEbKLx/96mZydC/5L
         qDRSIwsmQ60z3Xwuip6eklvNqABvpBXWaAv4HfF8=
Received: by mail-io1-f47.google.com with SMTP id p69so161864iod.10
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 12:35:46 -0700 (PDT)
X-Gm-Message-State: AJIora+L0a/OecOKOyTjkve5yCfFC0ZoR2HQ7XwoXfO4QRWXFxKLahiZ
        5CjBj0XL/fD832zQyD16Qs1Pa8PnEaDF4XWyZoE=
X-Google-Smtp-Source: AGRyM1uyzyaRoUJ0LZiIMcWsBCRWNKhZYSdbH7SMlIjXZ0F/qPomklqt0fTHRtc4R/XMtrt4bUrzKRQdsqmjjjLMPQ8=
X-Received: by 2002:a05:6638:42cd:b0:339:eda0:7d3f with SMTP id
 bm13-20020a05663842cd00b00339eda07d3fmr6253931jab.41.1656617746256; Thu, 30
 Jun 2022 12:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220517140748.24238-2-cgzones@googlemail.com>
 <20220607170035.40090-1-cgzones@googlemail.com> <CAJfZ7==gTydDpHQN2YC_n1iVRsSqZGmHxhfu1CFGgniZ8a-Z3w@mail.gmail.com>
 <CAP+JOzQ1UFE2auipdctQTJNOATJjiaicb1mxQiDfa3uS5_mRbA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ1UFE2auipdctQTJNOATJjiaicb1mxQiDfa3uS5_mRbA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 30 Jun 2022 21:35:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nbr06NaqnoaOTgrdAHZhyND5USurJ1UeK-1=kcwo-Uog@mail.gmail.com>
Message-ID: <CAJfZ7=nbr06NaqnoaOTgrdAHZhyND5USurJ1UeK-1=kcwo-Uog@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: restorecon: avoid printing NULL pointer
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jun 30 21:35:47 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 9:09 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jun 28, 2022 at 5:06 PM Nicolas Iooss <nicolas.iooss@m4x.org> wro=
te:
> >
> > On Tue, Jun 7, 2022 at 7:00 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > The variable `curcon` is NULL in case the file has no current securit=
y
> > > context.  Most C standard libraries handle it fine, avoid it nonethel=
ess
> > > for standard conformance.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Hello,
> > What is the status of this patch? As it looks good to me, I can merge
> > it if nobody has any more comments.
> >
>
> This patch is fine. Patch 1 fixes a commit that has been reverted, so
> it is not needed.
> Thanks,
> Jim

This patch is now applied.

Thanks,
Nicolas

> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
> > Thanks,
> > Nicolas
> >
> > > ---
> > > v2:
> > >    print "<no context>" instead of "(null)"
> > > ---
> > >  libselinux/src/selinux_restorecon.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/sel=
inux_restorecon.c
> > > index 9f5b326c..3c441119 100644
> > > --- a/libselinux/src/selinux_restorecon.c
> > > +++ b/libselinux/src/selinux_restorecon.c
> > > @@ -744,7 +744,9 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> > >                         selinux_log(SELINUX_INFO,
> > >                                     "%s %s from %s to %s\n",
> > >                                     updated ? "Relabeled" : "Would re=
label",
> > > -                                   pathname, curcon, newcon);
> > > +                                   pathname,
> > > +                                   curcon ? curcon : "<no context>",
> > > +                                   newcon);
> > >
> > >                 if (flags->syslog_changes && !flags->nochange) {
> > >                         if (curcon)
> > > --
> > > 2.36.1
> > >
> >

