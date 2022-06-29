Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914BC433EF
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiF2TJV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiF2TJS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 15:09:18 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B22BB17
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 12:09:17 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101d96fe0a5so22728629fac.2
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y+M+0nqUTXzoPZnnnrgQvLffGSn77BbkZwSBJp9U/gQ=;
        b=beHcJphEVvDDt8fggB607tm26c7jaBQVbV33nnZZUFJHWFevd1yN+RstJkTwOGjHOs
         nYhO/VonlsOOc9pwaSTEyTPiDJas/JmHpMYyAo6T5udBrZkpYJo0sh3H3AU0CTbo1KUb
         hs3K/Frj56x7st46bQ1p+A7Al4fGZCksMqbu0tfYoCG50L8ElZqj60yVVuvIF/db/cBL
         44H8mVHzUoLA93gFhJV6slbPtDDwj/TA1vvRnFfYEbWlrmIFXkOHmQDOWXTMh7Ht1Vms
         kTRq9LCdMXujlXky8WUgBnUJtprhM48Izmzw4w9HaHiHLl+si4e0SeBTpqT2YZcsXTuw
         ciAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+M+0nqUTXzoPZnnnrgQvLffGSn77BbkZwSBJp9U/gQ=;
        b=L5HNaBzylbDVH4jwzwDOxwvbGo/YCc3iByv9c5/MrA7qe7+265BqgN2ZJsJcbRBCxI
         +Lb0oHCOApz34wTP+ZFiaBmitFUNydc5wk6FrxdeI2LPqpEMDxnusgUMGp6muddTLpsE
         NadBZPtFwhX3NdjTqymIqwCYjTOD6hczSZRIJn565siXcsISkX5RJN879IJjlCeelI6e
         wqJvw5SVKXRc69eLf+nG+ROAHa2WCj4Mg6K562pYj0R6Cb9HdpzGhk5kfX1+j2xC3YtN
         LmrVhfrBjdPitZL5nZNmTkkRPcqmiYc6lLdo2IMK+v0pYPjkRh1mOokiFEf63h5bef4Y
         Yeiw==
X-Gm-Message-State: AJIora8KaLxKZkbt88oLuZUBh3pS61DUcITF465M0/ddb3oRR/IJm3K7
        D6Q7cXwgf3L0z2XEWmupZ/HwDsvLQZOFv06uEeg=
X-Google-Smtp-Source: AGRyM1uSgrLrDiwMMhmzIb3eBb9vbt0wzcB4Tt0UdDVhwYQ2PO/GJE9dkSypcdAibz4iaaTb5PBgHMZ+eRDk0/w+Rt8=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr4188371oap.156.1656529756994; Wed, 29
 Jun 2022 12:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220517140748.24238-2-cgzones@googlemail.com>
 <20220607170035.40090-1-cgzones@googlemail.com> <CAJfZ7==gTydDpHQN2YC_n1iVRsSqZGmHxhfu1CFGgniZ8a-Z3w@mail.gmail.com>
In-Reply-To: <CAJfZ7==gTydDpHQN2YC_n1iVRsSqZGmHxhfu1CFGgniZ8a-Z3w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 29 Jun 2022 15:09:05 -0400
Message-ID: <CAP+JOzQ1UFE2auipdctQTJNOATJjiaicb1mxQiDfa3uS5_mRbA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: restorecon: avoid printing NULL pointer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 28, 2022 at 5:06 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Tue, Jun 7, 2022 at 7:00 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The variable `curcon` is NULL in case the file has no current security
> > context.  Most C standard libraries handle it fine, avoid it nonetheles=
s
> > for standard conformance.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Hello,
> What is the status of this patch? As it looks good to me, I can merge
> it if nobody has any more comments.
>

This patch is fine. Patch 1 fixes a commit that has been reverted, so
it is not needed.
Thanks,
Jim


> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks,
> Nicolas
>
> > ---
> > v2:
> >    print "<no context>" instead of "(null)"
> > ---
> >  libselinux/src/selinux_restorecon.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 9f5b326c..3c441119 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -744,7 +744,9 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
> >                         selinux_log(SELINUX_INFO,
> >                                     "%s %s from %s to %s\n",
> >                                     updated ? "Relabeled" : "Would rela=
bel",
> > -                                   pathname, curcon, newcon);
> > +                                   pathname,
> > +                                   curcon ? curcon : "<no context>",
> > +                                   newcon);
> >
> >                 if (flags->syslog_changes && !flags->nochange) {
> >                         if (curcon)
> > --
> > 2.36.1
> >
>
