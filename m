Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F47C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0602073E
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd4JTOmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD2OuR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2OuR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 10:50:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A94C03C1AD
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 07:50:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c2so2470331iow.7
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKHVAuVV7Hr5z78rSee6b66tASqVMzIo+2hefdpExRw=;
        b=jd4JTOmNt+Il9kcoiM8+BhhyuqQapW3Lm+erw23pWglmL7x14eZeKTKNtS1eCD+qAJ
         QRvkNAp5RxOTzGmC1VDIqq0QMAkUFrcKAVJNfRqZP8JpoTf4hDi19RJ/PlOEiMMDUvbu
         H9FcUB+uc1QB+O64vwPWkGCmVcpJ07s4LI2SchtT68j4zUF4eWZIVmnxewluGLSxvfmY
         nf5U/5Kw6mim3roZB0w9jdoWCzRigzwuIvXxrLUhBfMXyGTG+eY2eeJ9K5o8hXvi0ihJ
         fSBPLC2SIku5kxKvrQKtUbMaPT48TMJ21GCNJASZCTyWMEBDruShA97MqQc8HRCO+/hU
         dgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKHVAuVV7Hr5z78rSee6b66tASqVMzIo+2hefdpExRw=;
        b=gXXBP5Aa7KBljdVZjEjFW0GDIMsYQXRz39tHYzOR+c/BfmG9TjkvweJUpJTJRX8qJ7
         3VO+9XXhBHCUeeDrAvqBNBaonea0S1lkwbaw3h/ZrghKtwuJ3DMbDq64hHknxAcX7bng
         Eab/zh4+qN7+yKDVP5CMq8BWz9wezQ3ohU2VWit53c/f+ssSBTtfiJrXt0VoK49oJHpg
         uk1AADYsyYVEELOINNug4FZQtArHPK6QY+Fpfc+ceqmfvk7q5iOWLj6gi0zceY3kl6mX
         DYHuNdYAZTeQ3e9v7otg/uehgmUXf9zw86p1QO5SXD1vrCrIqQCdGpEQQkV+/N39Kdnc
         zkwg==
X-Gm-Message-State: AGi0PuZCg2hEa1jYa/MrgRv4fISfsmEiRINxrD7TP9yMkw6OdffrwIBn
        m91NwODMdRGMcflIONpN+EeMQGwiVxRSGrFVDRNHNLFf
X-Google-Smtp-Source: APiQypKAuoi2x1CbtZOGZqm5l4PB7ftD+KE0vTMTF5n1MS81+UByFADEwHFnuwi1NlPBBQYwVDJszYAyUJC5TowIL/M=
X-Received: by 2002:a5d:9698:: with SMTP id m24mr31046669ion.143.1588171816490;
 Wed, 29 Apr 2020 07:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpOQzZazxrEhZZR198GJBiuZOLBMkTnxN3_JnzyD01Kdg@mail.gmail.com>
 <CAJfZ7==7Q1ur3Jozo0XBovwh6XsM17pqb=CcGv4f6RLzHxbEmQ@mail.gmail.com> <476DC76E7D1DF2438D32BFADF679FC5649ED3B8F@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649ED3B8F@ORSMSX101.amr.corp.intel.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 29 Apr 2020 09:50:05 -0500
Message-ID: <CAFftDdp0SghSGPrAXrr4nZvbqaHn8QSWNWN1Qh=MQPdAGCOBuQ@mail.gmail.com>
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

>
>
>
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of Nicolas Iooss
> > Sent: Sunday, April 19, 2020 8:37 AM
> > To: William Roberts <bill.c.roberts@gmail.com>; SElinux list
> > <selinux@vger.kernel.org>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Subject: Re: Deprecated Annotations in libselinux
> >
> > On Wed, Apr 15, 2020 at 11:10 PM William Roberts <bill.c.roberts@gmail.com>
> > wrote:
> > >
> > > So I am reviving the work to look at annotating deprecated functions.
> > > I was wondering what folks are thinking around the utility program
> > > matchpathcon, since that interface is deprecated, do we want to:
> > >
> > > 1. link that statically so we can use internal (non-deprecated)
> > > functions 2. update it to use selabel_open and friends.
> > > 3. Keep it but have it print out "deprecated" and return 1.
> > > 4. Some mix of options 3 and 1
> >
> > Hello,
> > I did not really follow closely why functions are getting deprecated.
> > >From the patch series, it appears that matchpathcon_init() is being
> > deprecated in favor of selabel_open(). That can make sense.
>
> They have been deprecated for a long time, Im just investogatingusing the deprecated
> Annotation to encourage folks to move to the new interfaces and suggest the new
> Interface in the warning message.
>
> >
> > >From a CLI perspective, the interface of selabel_lookup seems to be
> > more complex to use that matchpathcon:
> >
> > $ matchpathcon /etc/shadow
> > /etc/shadow system_u:object_r:shadow_t
> > $ selabel_lookup -b file -k /etc/shadow
> > Default context: system_u:object_r:shadow_t
> >
> > Moreover, looking at selabel_lookup --help, it was not clear that the file for which
> > I wanted the context needs to be given as a -k option, because the usage line
> > states "[-f file]" (that means something else).
> > This increases the difficulty of using selabel_lookup instead of matchpathcon.
> > Therefore as a SELinux user, I would rather keep matchpathcon program. Would
> > it be difficult to implement option 2 "update matchpathcon to use selabel_open()
> > and friends"?
>
> I'm leaving the interfaces the same in this series, and we can update matchpathcon later.
> The only thing I am adding is a deprecated message to stderr for the matchpathcon util,
> which we can drop.
>
> >
> > That being said, if another option is chosen, I will add "alias
> > matchpathcon=selabel_lookup -b file -k" to my shell configuration and be good
> > with it. This would work for me because I never used any option that
> > matchpathcon provides.
> >
> > Anyway, thanks for working on this subject!
> > Nicolas

I will bring them to merge and correct the commit messages. Thanks!
