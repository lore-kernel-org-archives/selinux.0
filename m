Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F8C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CBC20873
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlD9sXCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD3PWD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgD3PWD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 11:22:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56853C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:22:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so1871886iob.3
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ds3fjVqAnEYTzUIHx3HITSAmaLsN7+8R+AWpw2z9Gnc=;
        b=FlD9sXCLRvNqd9wybKum6JJZ2wUd0LVf0tXTrimXctD/JHQpeEyUwh6hgcqlUe88Iy
         XjX2zGfEU9FTzi+7pZBD6vbvRHjK/Dho9xG2T2ScaWr3g0mdOgqaH696DPy4EoNdK/up
         mHqVdlnnTVwPAC82AFinuFtLLk7iaoVOTDlI5kJBjivkR4NqEA/K7E7iKlFFikcv9LdM
         I3MMssvtcH1YUiO5QG08oGOy2Gk1PZfQPi32wdTdBDnarzWwZIPoJwFMinm0PP9oaxzN
         jFscfuNGUln2WKxTSwoV/n2A7y9LJCBRCB0MD62QqUv9gf+zU55rSN9/MKrkuvb7mL9q
         RHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ds3fjVqAnEYTzUIHx3HITSAmaLsN7+8R+AWpw2z9Gnc=;
        b=eCpJdQFOOeCVaYl+xtgJblH0UkNpFNYvbpt1dCxLvFCLqc/cWs8AtqONqyfqNu1Cop
         xS6EbWmgC/B7xxMNk/64NQ1a3U6B2XjZQie/PltqjBpu7cmLL8rKrDePHHEmuHFAfBx7
         5DqdXXEhYL9F+odMezQaYMt0tmdeRZ+Ywt9NPHI+j2sr6BZUlcpiGLOGEK+Y50c51FUH
         VJBV5E0TFhb0crt89grFs1pVVlmgjyCuV7wnUWS9jW3rhajMSvjs/XCfCmqFFNWD7nDF
         Ty+5n4y88LwG377On6jk4JM7DNPBWEOimL6W3GMpNOlKg1txSDT2vjqO/mbpFDncL1Ay
         CjLg==
X-Gm-Message-State: AGi0PuZoe7dC9I2Og0LFd6uXvuRE4Vzkir38GwODuL4ns4oX2MPfvRV7
        oZhsVb83CymZ7hJCd3YLLRxJq1H3rQi9j+u0MPR6m5XgrJ0=
X-Google-Smtp-Source: APiQypJCvSW1vOEGiKvt/AOc0SgBRNPXSSTYZp+5ngfUwGPwOwPUEz22KhjQGnH+uaq4SuK1l73ITmszU36UOeOLTMM=
X-Received: by 2002:a5d:8b4e:: with SMTP id c14mr2353465iot.139.1588260122448;
 Thu, 30 Apr 2020 08:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpOQzZazxrEhZZR198GJBiuZOLBMkTnxN3_JnzyD01Kdg@mail.gmail.com>
 <CAJfZ7==7Q1ur3Jozo0XBovwh6XsM17pqb=CcGv4f6RLzHxbEmQ@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC5649ED3B8F@ORSMSX101.amr.corp.intel.com> <CAFftDdp0SghSGPrAXrr4nZvbqaHn8QSWNWN1Qh=MQPdAGCOBuQ@mail.gmail.com>
In-Reply-To: <CAFftDdp0SghSGPrAXrr4nZvbqaHn8QSWNWN1Qh=MQPdAGCOBuQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 30 Apr 2020 10:21:51 -0500
Message-ID: <CAFftDdoQB--2j6Ewe3hWU6+H-ARc879x05wUaBoHKSWk4y-zXg@mail.gmail.com>
Subject: Re: Deprecated Annotations in libselinux
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 9:50 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> >
> >
> >
> > > -----Original Message-----
> > > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > > On Behalf Of Nicolas Iooss
> > > Sent: Sunday, April 19, 2020 8:37 AM
> > > To: William Roberts <bill.c.roberts@gmail.com>; SElinux list
> > > <selinux@vger.kernel.org>
> > > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > > Subject: Re: Deprecated Annotations in libselinux
> > >
> > > On Wed, Apr 15, 2020 at 11:10 PM William Roberts <bill.c.roberts@gmail.com>
> > > wrote:
> > > >
> > > > So I am reviving the work to look at annotating deprecated functions.
> > > > I was wondering what folks are thinking around the utility program
> > > > matchpathcon, since that interface is deprecated, do we want to:
> > > >
> > > > 1. link that statically so we can use internal (non-deprecated)
> > > > functions 2. update it to use selabel_open and friends.
> > > > 3. Keep it but have it print out "deprecated" and return 1.
> > > > 4. Some mix of options 3 and 1
> > >
> > > Hello,
> > > I did not really follow closely why functions are getting deprecated.
> > > >From the patch series, it appears that matchpathcon_init() is being
> > > deprecated in favor of selabel_open(). That can make sense.
> >
> > They have been deprecated for a long time, Im just investogatingusing the deprecated
> > Annotation to encourage folks to move to the new interfaces and suggest the new
> > Interface in the warning message.
> >
> > >
> > > >From a CLI perspective, the interface of selabel_lookup seems to be
> > > more complex to use that matchpathcon:
> > >
> > > $ matchpathcon /etc/shadow
> > > /etc/shadow system_u:object_r:shadow_t
> > > $ selabel_lookup -b file -k /etc/shadow
> > > Default context: system_u:object_r:shadow_t
> > >
> > > Moreover, looking at selabel_lookup --help, it was not clear that the file for which
> > > I wanted the context needs to be given as a -k option, because the usage line
> > > states "[-f file]" (that means something else).
> > > This increases the difficulty of using selabel_lookup instead of matchpathcon.
> > > Therefore as a SELinux user, I would rather keep matchpathcon program. Would
> > > it be difficult to implement option 2 "update matchpathcon to use selabel_open()
> > > and friends"?
> >
> > I'm leaving the interfaces the same in this series, and we can update matchpathcon later.
> > The only thing I am adding is a deprecated message to stderr for the matchpathcon util,
> > which we can drop.
> >
> > >
> > > That being said, if another option is chosen, I will add "alias
> > > matchpathcon=selabel_lookup -b file -k" to my shell configuration and be good
> > > with it. This would work for me because I never used any option that
> > > matchpathcon provides.
> > >
> > > Anyway, thanks for working on this subject!
> > > Nicolas
>
> I will bring them to merge and correct the commit messages. Thanks!

merged: https://github.com/SELinuxProject/selinux/pull/231
Thanks everyone!
