Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF666C433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D636160F11
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 21:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhI0V6b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbhI0V6a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 17:58:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B74C061575
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 14:56:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y35so23907164ede.3
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZP+tsgkVLfv9lRIf5K9gdJZ/b0aMxZyUOTNMZUhb4I=;
        b=Cq1GwKrUDWiJVgVh3SMEM4B3JwitfBZc3kA0zilv0I4ltLidMbj1S4no9g3oEx98YM
         wm/gE1uonHbgRCCicKaoc2oFvoaOnPhCVlhCzVE+Hz5mHPzNxHqDdWgmEP2wl3Bj8R56
         Px5yoUL+1zkEnyISLLW96HI4Kuq7RW6uh6DLnLklgPJw4leGD3FkxFvbMu+QMwtOujvb
         vRxvG8TIbKpfNudX18ySavlRtC4dYlnqmHLLMKnoXk5tWnw+wwelW9mN/sr+9JRiPpNF
         TarONY15Af2thcEC8ymbiajKNKVOhQ6AZD+iyFQN5GxVgRnMjCMg6kHGAU2HvPtqLZjt
         oAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZP+tsgkVLfv9lRIf5K9gdJZ/b0aMxZyUOTNMZUhb4I=;
        b=X2wHHeuYM0uaqcfbbtGQp5hsyLKeUmsvAq+WzJCaQMnbSjksdFJeDfeNsgAuajtXUg
         piD6aY3ug3dNfz7w9K98RAbt2PQ2vR6Hc0hBFvaZhDujX1EDcws9xb/Ogd3vtZjwNbVv
         Ss/T02MboPluWR2tjoeYqh91FQ03b+elN7QuNI5YZbN6yro+dd5bCaIoAFVSHOI30ald
         6zz5DiTh/P19R7HCTaFlHbTwbiqwTqaTvSVMxokmGPiI8sgX7UAS6l3VYE8DrR1WPcP9
         sGsr3LSTLPlZ0xjSuqvPSQRRooA7vFMvEKdidzfPEyrC6SMVUGyrQC3VF4Y9FO6Muclo
         nYzw==
X-Gm-Message-State: AOAM530cgLmDh7ukcE+TJ1oE6nUEvSy2prqlADt3VMbQb75w20ZTX3XD
        e7+X/OUjjdBekiKEL6L0COO/utf1dKHDEnT4zQku8E/hpPjg
X-Google-Smtp-Source: ABdhPJxIidX3qtLZT7gSccANSiey62yi+sgWTx7wmu8Fgm3ntBEZbgGMBATKzu3NfBw68ObC6xe7ff/1ReqjoiAYCUk=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr2648118ejj.157.1632779809956;
 Mon, 27 Sep 2021 14:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com>
 <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com>
 <CAJ2a_DeuF2tqQ08piCUnJZwxOkWXfu7rBOrfoRP5f4ughYxBdQ@mail.gmail.com> <CAHC9VhTq8dOvHzZ48guwCmR9SBSc3rd5hivb6X2aVN+QCukWew@mail.gmail.com>
In-Reply-To: <CAHC9VhTq8dOvHzZ48guwCmR9SBSc3rd5hivb6X2aVN+QCukWew@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Sep 2021 17:56:39 -0400
Message-ID: <CAHC9VhSTgf6TA5JqDNfSvMk=7AOLzdqzZ1m8=PtSJGoRAt+1Eg@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 16, 2021 at 10:07 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 16, 2021 at 1:41 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > On Wed, 15 Sept 2021 at 20:28, Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Wed, Sep 15, 2021 at 12:24 PM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Add support for genfscon per-file labeling of securityfs files. Thi=
s allows
> > > > for separate labels and therby permissions for different files, e.g=
.
> > > > /sys/kernel/security/integrity/ima/policy.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  security/selinux/hooks.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > Hi Christian,
> > >
> > > It would be nice if you could add some additional notes on how this
> > > was tested to the description above.
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 6517f221d52c..a18626424731 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_bl=
ock *sb,
> > > >             !strcmp(sb->s_type->name, "tracefs") ||
> > > >             !strcmp(sb->s_type->name, "binder") ||
> > > >             !strcmp(sb->s_type->name, "bpf") ||
> > > > -           !strcmp(sb->s_type->name, "pstore"))
> > > > +           !strcmp(sb->s_type->name, "pstore") ||
> > > > +           !strcmp(sb->s_type->name, "securityfs"))
> > > >                 sbsec->flags |=3D SE_SBGENFS;
> > > >
> > > >         if (!strcmp(sb->s_type->name, "sysfs") ||
> > > > --
> > > > 2.33.0
> > >
> > > --
> > > paul moore
> > > www.paul-moore.com
> >
> > Something like:
> >
> >     Add support for genfscon per-file labeling of securityfs files. Thi=
s allows
> >     for separate labels and thereby access control for different files.
> >     For example a genfscon statement
> >         genfscon securityfs /integrity/ima/policy
> > system_u:object_r:ima_policy_t:s0
> >     will set a specific label to the IMA policy file and thus allow to
> > control the ability
> >     to set the IMA policy.
> >     Setting labels directly, e.g. via chcon(1) or setfiles(8), is
> > still not supported.
> >
> > ?
>
> That's a much better description of the functionality, especially for
> those who may not be very familiar with SELinux, thank you.  However I
> was hoping to also hear some confirmation that you have tested this
> and it worked without problem?

Hi Christian, my apologies on the delay, I was distracted by a few
other SELinux issues.  Thank you for sending out your testing notes in
the meantime.

Are you okay if I replace the original commit description with your
more verbose version?  If not, could you resend the patch with the
update commit description?

Thanks.

--=20
paul moore
www.paul-moore.com
