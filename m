Return-Path: <SRS0=utbs=UK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B128C43218
	for <selinux@archiver.kernel.org>; Tue, 11 Jun 2019 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BAA20820
	for <selinux@archiver.kernel.org>; Tue, 11 Jun 2019 03:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRlj2zqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390963AbfFKDE0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 23:04:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35463 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbfFKDE0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 23:04:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so6456232pfd.2;
        Mon, 10 Jun 2019 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+PtWLak2dg1C3eGg2eDELkNRTG2GcRoWi74DwVXfWM=;
        b=tRlj2zqJi3EkmGZuQqxxjp0WbWHqeZQcQP/nXQSlzQoiULcd5r1jVzUhtv7R99/oYc
         lW/XlzXpm53OVUIp+sGZIRekiex3s21ixAJjKUYlhA4XMXEoe/Cqnxrxvr/FT/MHLz+8
         LB6m1SkE7kuftutSLXGxdaVeOVi7i9+Xk0AbgnHzl8BdjiOwj6RWM2wiOS/J5wcSbbnF
         rG7tjHjIugIBm93YWXTVUkHjzj50MgLG1bHTP9rI5a+ebhh9Nyu16lCCViDvO0J3FVcd
         mkxy22+Z63ewIpJVvFpvmHV2XfYSi62AGdAtlLIR5jlM8VQ4ctVr5csivzzFvXgJraqS
         v6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+PtWLak2dg1C3eGg2eDELkNRTG2GcRoWi74DwVXfWM=;
        b=JAyNgUPpM4B+Ct6Ai8N6m557R+L2hUXbVDsP3lt7+Ize17R/O371YsiBnhs+SajvbF
         xHWVUXlIJDOXuOrl7nutw35czTviVWZV2kYIXYaKuoUrf8+GuUhLZRC61LozylT6ZLzz
         tmPaZyAcqwBj1vjgGto0c2zxXnRn11mM/5MKtz6rP0hIzWthaF2F0Y9JPS/sidbxTxF9
         lmCmrdqNfJXG0IDISutxXUTwdbczvwaFpVDtfQjn4uXgnLBOLmPpFny+X5SZSWP3dZzq
         XUhnyfSurRBl8ZZTuUcxcFvlsThgg53bdvGuIXrGQRoJP926jbXMleaUIf3lFWcg1nNJ
         AcuQ==
X-Gm-Message-State: APjAAAXS8TmjyryIIaZ6hNrh7QpTnMXVRHl08lho9W1L40PEGai0VH0G
        iaosHKiijERD/iVPW0FMrcU=
X-Google-Smtp-Source: APXvYqy/HcsULBNvRsdFwnXtNl6RcCaJssgVF/tEPpVMwZSYIlE2tJ9nEcarvWk61WhM+i3U8S4qSQ==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr75239163pfb.78.1560222265314;
        Mon, 10 Jun 2019 20:04:25 -0700 (PDT)
Received: from ubuntu ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id f10sm12369152pfd.151.2019.06.10.20.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 20:04:24 -0700 (PDT)
Date:   Mon, 10 Jun 2019 20:04:18 -0700
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_add_mnt_opt( )
Message-ID: <20190611030417.GA4013@ubuntu>
References: <20190606092342.GA21672@zhanggen-UX430UQ>
 <CAFqZXNuricWOMH3fQiCbPZyz2qwf7Gw1zmx1o+wLeTELSF=CUQ@mail.gmail.com>
 <20190607121134.GA3357@zhanggen-UX430UQ>
 <CAHC9VhS8W8p+9FwB9OHBhfsxP45ckjpqsqt6p85U5PZY=N=rYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS8W8p+9FwB9OHBhfsxP45ckjpqsqt6p85U5PZY=N=rYg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 10, 2019 at 03:31:50PM -0400, Paul Moore wrote:
> On Fri, Jun 7, 2019 at 8:11 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> >
> > On Fri, Jun 07, 2019 at 10:39:05AM +0200, Ondrej Mosnacek wrote:
> > > On Thu, Jun 6, 2019 at 11:23 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > > > In selinux_add_mnt_opt(), 'val' is allocated by kmemdup_nul(). It returns
> > > > NULL when fails. So 'val' should be checked. And 'mnt_opts' should be
> > > > freed when error.
> > > >
> > > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > > Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")
> > > > ---
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 3ec702c..4e4c1c6 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -1052,15 +1052,23 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
> > > >         if (token == Opt_error)
> > > >                 return -EINVAL;
> > > >
> > > > -       if (token != Opt_seclabel)
> > > > -               val = kmemdup_nul(val, len, GFP_KERNEL);
> > > > +       if (token != Opt_seclabel) {
> > > > +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> > > > +                       if (!val) {
> > > > +                               rc = -ENOMEM;
> > > > +                               goto free_opt;
> > > > +                       }
> > > > +       }
> > > >         rc = selinux_add_opt(token, val, mnt_opts);
> > > >         if (unlikely(rc)) {
> > > >                 kfree(val);
> > > > -               if (*mnt_opts) {
> > > > -                       selinux_free_mnt_opts(*mnt_opts);
> > > > -                       *mnt_opts = NULL;
> > > > -               }
> > > > +               goto free_opt;
> > > > +       }
> > > > +       return rc;
> > >
> > > At this point rc is guaranteed to be 0, so you can just 'return 0' for
> > > clarity. Also, I visually prefer an empty line between a return
> > > statement and a goto label, but I'm not sure what is the
> > > general/maintainer's preference.
> >
> > Am I supposed to revise and send a patch v4 for this, or let the
> > maintainer do this? :-)
> 
> First a few things from my perspective: I don't really care too much
> about the difference between returning "0" and "rc" here, one could
> argue that "0" is cleaner and that "rc" is "safer".  To me it isn't a
> big deal and generally isn't something I would even comment on unless
> there was something else in the patch that needed addressing.  I care
> a more about the style choice of having an empty line between the
> return and the start of the goto targets (vertical whitespace before
> the jump targets is good, please include it), but once again, I'm not
> sure I would comment on that.  The patch subject line is a bit
> confusing in that we already discussed when to use "selinux" and when
> to use "lsm", but I imagine there might be some confusion about using
> both so let me try and clear that up now: don't do it unless you have
> a *really* good reason to do so :)  In this case it is all SELinux
> code so there is no reason why you should be including the "lsm"
> prefix.
Thanks for your comments. I was uncertain of the meaning of "lsm". So I
used"selinux: lsm:". I am aware of that now.

Thanks
Gen
> 
> You've been pretty responsive, so if you don't mind submitting a v4
> with the changes mentioned above, that would be far more preferable to
> me making the changes.  I have some other comments about maintainer
> fixes to patches, but I'll save that for the other thread :)
> 
> -- 
> paul moore
> www.paul-moore.com
