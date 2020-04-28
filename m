Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617DC83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26AB206B9
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 07:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD1HeV convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:34:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48818 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1HeR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 03:34:17 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8C1A5564985
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 09:34:14 +0200 (CEST)
Received: by mail-ot1-f44.google.com with SMTP id j26so31007788ots.0
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 00:34:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuY/8peo7R4luyjce2PDp7rdPvh5k5lGrCcZNuDj/9R1Ybi1rjf9
        jX0rNLdlt3drA4N2NrnMJHx+sQa/2/TpDWF94KM=
X-Google-Smtp-Source: APiQypJhZBt05Ws+tWPHQDLRSgFBZEioKsbNlUn82iub0PFD5nXSqiD6kAlPOFjVHYvYCM1QMuhWdTDuRquqj8N1D6w=
X-Received: by 2002:aca:895:: with SMTP id 143mr1931028oii.153.1588059253516;
 Tue, 28 Apr 2020 00:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200420114712.19160-1-cgzones@googlemail.com> <CAJfZ7==f_csxQOjszjArW1Y+zhuDpHpDt=OFkoNR0WgWPsbJ=g@mail.gmail.com>
In-Reply-To: <CAJfZ7==f_csxQOjszjArW1Y+zhuDpHpDt=OFkoNR0WgWPsbJ=g@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Apr 2020 09:34:02 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kH20RsnhScbo+HhAsibLtBPo4jJN+HP+T-BDmYVofrwQ@mail.gmail.com>
Message-ID: <CAJfZ7=kH20RsnhScbo+HhAsibLtBPo4jJN+HP+T-BDmYVofrwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: clarify handle-unkown configuration
 setting in man page
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 28 09:34:15 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 26, 2020 at 8:15 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Apr 20, 2020 at 1:47 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> For both patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody raises an objection, I will merge the 2 patches tomorrow,
> with "unkown" replaced with "unknown" in the subject of the first one.

Merged both patches about man pages. As discussed in another thread, I
did not merge the third patch (mark security_context_t typedef as
deprecated).

Thanks,
Nicolas
> > ---
> >  libsemanage/man/man5/semanage.conf.5 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
> > index 8efc7dd5..7d6f2fef 100644
> > --- a/libsemanage/man/man5/semanage.conf.5
> > +++ b/libsemanage/man/man5/semanage.conf.5
> > @@ -95,8 +95,8 @@ to this option set to "false").
> >
> >  .TP
> >  .B handle-unknown
> > -This option controls the kernel behavior for handling permissions defined in the kernel but missing from the actual policy.
> > -It can be set to "deny", "reject" or "allow".
> > +This option overrides the kernel behavior for handling permissions defined in the kernel but missing from the actual policy.
> > +It can be set to "deny", "reject" or "allow". By default the setting from the policy is taken.
> >
> >  .TP
> >  .B bzip-blocksize
> > --
> > 2.26.1
> >

