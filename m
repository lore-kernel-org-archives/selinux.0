Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D9C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1942073B
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="SmsqRdLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgE2Ocj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2Ocj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 10:32:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964AC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:32:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g28so1615406qkl.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2OOIIQscD/kD+b3RU51eaDEYkCMnqZrGXtrN7Xuuu4=;
        b=SmsqRdLM3IrXtEUQGUkQJRS+HoH5/aoQqBBPHRnaC+YNKRxC8WQHUNwm7kYSByAACT
         DNItn47aqz/hxvdgkHLocjjk9Nd/8+H/BXU+ylfGoZE93fBQgLmb4RDpOcavtajiXv8l
         6Z5h0R1orD0Rq8I5mC4jDuLkTjHL2IhXoeqLi6Ek6SV2yvIrpztiARIrbFVV5pwSwXnf
         IXRMfzWd/1Aj2aGV/jtuJReEUIlEz02fl1pD+0GCRIPNppRTey1wvKVSqElQ2R3EZ/sf
         NP7Oo9hxuhctnf+Ed0sGbxyghIJINKBE9NABNWDngpodxZUQD4H5ZofXiF5Bz1RGIXZF
         eX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2OOIIQscD/kD+b3RU51eaDEYkCMnqZrGXtrN7Xuuu4=;
        b=W+0vbY7YT73wsApOqtNgThqUa3PIC3A/Jh/g9nOFDJzRLozmeo01TOnMykTngYzGK3
         VxaP9yS3YLx8+0BrH6WT+doJcvXcCcTDWHdXNhWTOzX2LEfvJQ6mr9UxCBio+W5r9fJg
         9uIrWPEdJbUh/KYJVre1g6nJAlLJSe+U6ASmTV1tHU+9YXh8Ugg3EiOcvnI4qIOYDSD6
         gwl4MiinGMvZdu7uOisFzPtejr0Je9wS4jl6tgKl90Mn8e0MO18LuRm/0rBU+7rJGHJF
         y84mqEBv/zl0ExzPQuekvEUNy2MNGnAs6ONugdW8kCu9FOas5wzXh/9uil7QiLmTIKCt
         Y/1w==
X-Gm-Message-State: AOAM5316bpXViLl6KDL8oeOBPv59b8TolgNcL6cbgBmI6q9SIq1jKnUq
        1YhO1KkxSy7MxNY327aoUtD2PREkiwfaYedkycexJhmr
X-Google-Smtp-Source: ABdhPJxWdLebaVkt673uepQAvPHhUMJyQ7gJdWczIJAKANXeW8GJlGk0bQ9IoYzbnuRQfdKXI6xUNcZb3DrTuu7WetA=
X-Received: by 2002:a37:8a42:: with SMTP id m63mr7886086qkd.230.1590762758138;
 Fri, 29 May 2020 07:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200526170217.32966-1-pww@edgekeep.com> <CAEjxPJ6F75V9=vCW6V9gnA7sc-7uPm_vU7h5ppSbqZVWqC=_ZA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6F75V9=vCW6V9gnA7sc-7uPm_vU7h5ppSbqZVWqC=_ZA@mail.gmail.com>
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Fri, 29 May 2020 10:33:22 -0400
Message-ID: <CAGeouKEoKANFUoEhoRCUNGbS+r-fGn2oEWuA3phdP1DGORqg+Q@mail.gmail.com>
Subject: Re: [PATCH] Add restorecon -x opt to not cross FS boundaries (cf
 github #208)
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

My test infrastructure has been, uh, limited, so far (working with
some, uh, restrictions). I'll take the time to build a complete test
system, reapply, test, then resubmit. Thanks for the advice on
including the URL, much cleaner.

Thanks,

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP


On Fri, May 29, 2020 at 10:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 1:04 PM Peter Whittaker <pww@edgekeep.com> wrote:
> >
> > Folks, this patch adds and documents a "-x" option for restorecon
> > to prevent it from crossing file system boundaries, as requested
> > in github issue #208.
> >
> > P
> >
> > Signed-off-by: Peter Whittaker <pww@edgekeep.com>
>
> You didn't update the actual ropts string so restorecon -x fails even
> after this patch.
> Did you test your change?
> In your patch description, you can put the following line before your
> Signed-off-by
> and drop the separate references to github issue #208 in the subject
> line and body:
> Fixes: https://github.com/SELinuxProject/selinux/issues/208
>
> > ---
> >  policycoreutils/setfiles/restorecon.8 |  7 +++++++
> >  policycoreutils/setfiles/setfiles.c   | 11 +++++++++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
> > index bbfc83fe..0d1930de 100644
> > --- a/policycoreutils/setfiles/restorecon.8
> > +++ b/policycoreutils/setfiles/restorecon.8
> > @@ -13,6 +13,7 @@ restorecon \- restore file(s) default SELinux security contexts.
> >  .RB [ \-F ]
> >  .RB [ \-W ]
> >  .RB [ \-I | \-D ]
> > +.RB [ \-x ]
> >  .RB [ \-e
> >  .IR directory ]
> >  .IR pathname \ ...
> > @@ -31,6 +32,7 @@ restorecon \- restore file(s) default SELinux security contexts.
> >  .RB [ \-F ]
> >  .RB [ \-W ]
> >  .RB [ \-I | \-D ]
> > +.RB [ \-x ]
> >
> >  .SH "DESCRIPTION"
> >  This manual page describes the
> > @@ -153,6 +155,11 @@ option of GNU
> >  .B find
> >  produces input suitable for this mode.
> >  .TP
> > +.B \-x
> > +prevent
> > +.B restorecon
> > +from crossing file system boundaries.
> > +.TP
> >  .SH "ARGUMENTS"
> >  .IR pathname \ ...
> >  The pathname for the file(s) to be relabeled.
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> > index 16bd592c..afd579e3 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -43,8 +43,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
> >  {
> >         if (iamrestorecon) {
> >                 fprintf(stderr,
> > -                       "usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
> > -                       "usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
> > +                       "usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
> > +                       "usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
> >                         name, name);
> >         } else {
> >                 fprintf(stderr,
> > @@ -386,6 +386,13 @@ int main(int argc, char **argv)
> >                 case '0':
> >                         null_terminated = 1;
> >                         break;
> > +                case 'x':
> > +                        if (iamrestorecon) {
> > +                               r_opts.xdev = SELINUX_RESTORECON_XDEV;
> > +                        } else {
> > +                               usage(argv[0]);
> > +                        }
> > +                        break;
> >                 case 'h':
> >                 case '?':
> >                         usage(argv[0]);
> > --
> > 2.20.1
> >
