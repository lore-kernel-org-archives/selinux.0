Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DAC433DF
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379E0207C4
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ubmRcAZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgESWXs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgESWXr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 18:23:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E5DC061A0F
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 15:23:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s19so796591edt.12
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngvhsJYcA5G6dyPUD1U/cl98024Lw6TZ3TOEHlmMxW4=;
        b=ubmRcAZJlHIYESKF8bf805k5nrPU8potqljeWlSjHjWTOcDT5jeaP4yj7If4ElasU/
         NE20pI5uEBaN30dK4gZzS2r6z3TB++0loXkjLYhjk7CMz54t3nwFbZXJfUqSi2JKP58+
         s3GqTghoLje4tmQenxYXGov3WsqAozOeyzI+OL384+LP/ImEhyBcWPAV5gvlFNeZdurW
         hnxYauZ2xG37/X9w+X/SbFArtL1PBPl0kgDZsu3PZh8nrEqnkZXiWCvTDlMilgdKK9Oi
         JJxeqt3ByHb2TwY1EmdH3IrpxKj/d4DVopRwBZtxUI+E9AC9gO4/rzDws+DRSsDd+MJf
         Gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngvhsJYcA5G6dyPUD1U/cl98024Lw6TZ3TOEHlmMxW4=;
        b=SEJxqo7PjutBFiGWU1erHp+0IS39Ro70Jt8fk0tBl/swvwt3l+VOlZLdtyydjTaW8P
         lcfx7JHF28jLc/AIrMmAEXZl0gr4KCQvECuTVE81kC1u0bWnXE81tVxj2hVrMdQalsmz
         ORp4io/qFJmBjy/iaicnfAy4jlal3MrY2Pdnck7I6Ypk7pPiLmy2j1eAJw5CoxV7MjKN
         zAshTFS822jLtPm+8adshTO5+8/Q8UZx6Iy01hVRrTVXpmQma9Robi3tSQEBqy61sFQA
         4GMTeVzCkkoGDEpcAqiPTxjFSPb/VZV6vT3BQpKNjA5AaeZx+dZF4kOEFcGyJFphWt+r
         o28w==
X-Gm-Message-State: AOAM530cbZvLly7/jOG+yUWvwXp5UkP2vmkORdzQwei+HomBnuMFvLDs
        29x2zH70Uzc9D1e9LMRFz6mPA3ITdBUK3PK00Doi
X-Google-Smtp-Source: ABdhPJxdCSRTpZIjzrooaoa9KoWqsLZRsE7i3eLAB5Orfe6uT8XqT8/dPca+R9P2KJB3ShcN+qasPNIINVYgenPS1D0=
X-Received: by 2002:a05:6402:14d3:: with SMTP id f19mr791541edx.135.1589927025839;
 Tue, 19 May 2020 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200519151457.31618-1-william.c.roberts@intel.com>
 <20200519151457.31618-2-william.c.roberts@intel.com> <CAHC9VhRfWHPkz+rCSAa8kvwVu3dds9q47VfnBFSCJbV3GdMjwQ@mail.gmail.com>
 <CAFftDdpPS0wt3VHiMS6sMKTqAgviNB-TBRT1YqbrzgJftPFj_w@mail.gmail.com>
In-Reply-To: <CAFftDdpPS0wt3VHiMS6sMKTqAgviNB-TBRT1YqbrzgJftPFj_w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 May 2020 18:23:34 -0400
Message-ID: <CAHC9VhS8rV_bF1j9Q7bT97916TKeEpNoCDTmjit9YAyMcJ+chQ@mail.gmail.com>
Subject: Re: [PATCH] ci: run SE Linux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 6:16 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Tue, May 19, 2020 at 5:00 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, May 19, 2020 at 11:15 AM <bill.c.roberts@gmail.com> wrote:

...

> > > +dnf install -y \
> >
> > Another speaking from experience comment: you probably want to add
> > "--allowerasing" and "--skip-broken" to the dnf command line.  If you
> > can cope with the extra overhead, I would even suggest a "dnf clean
> > all -y" at the start.
>
> I don't see why we couldn't.
>
> Not really sure if it matters for those first two things, considering
> that were starting
> in the same state each time. Its not like we need to work on a system
> that's already
> been played with.

FWIW, the VM I use for my automated kernel testing doesn't get played
with (other than to fix dnf/Rawhide problems) and I can tell you from
experience that Rawhide finds itself broken in new and exciting ways
:)

You are using a stable Fedora release so it probably won't be too bad,
I'm just trying to share some of the lessons I've learned.

-- 
paul moore
www.paul-moore.com
