Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B022EC433DB
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 18:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E58B64DD3
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 18:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhB1S54 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhB1S5w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 13:57:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21CC06174A;
        Sun, 28 Feb 2021 10:57:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so24157639ejf.11;
        Sun, 28 Feb 2021 10:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGackHlMqLcsa5EmwPJ7kiwHldPgT/RGt4PyODRzqNQ=;
        b=tM4tF/j7cMCJsiN0g+3jpfiK3Vu4+tkgCe4xasFo6/y6YYgVShfgLhYzeDIF5FAY5l
         Mo9bFRg8tHxu8ltzNuEByFEocFfgElUiSAtsKQKmr8KbyrdRLsdGSWXAAHl6y6vZpSNJ
         14+O940l57cfDy5TI0FiukVbW/KkQKJytTyY65hjgCG2l0bAUQINEqREKWopN9zcK/RI
         k2b/Kci41lZEjKORJEtzzqq3YIN987WaLvkaQJBL8HQkQtyySHAfNz11wAa/Si3qnxAD
         X/tsWQP1nDeUhsbeqw7J5if27QLIA/5ByWjb/m6hAgZLCQbg/8au4OSl4qbY4V/GqmaS
         kSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGackHlMqLcsa5EmwPJ7kiwHldPgT/RGt4PyODRzqNQ=;
        b=ewGXkb/a6Bzz6Muf1MLPpxluDgtZAm0vgGZhh4l9UYmTZozkSVAGAefunoVunITSUE
         CeKqJwnLDdbZP6XZSqrKq2TjSataU6n6Kzv8HGxmqaQtPrgIdRDRt/nuWEwx0KCnfvMC
         OMC5kSVE5k9v0qM/jZv2jTrMk10H+8KjdXP1yASKEYhr1z5ydz7PnP7pz8F4yIbLsuvv
         RSxGXy+n+C5bTRe2cJo+/6OWWSMJdd798ZGwGS9/TrKAIUD8EWbE/bVBtr6zlP5tJ1Oi
         vhv2qDT1TvlwGxvFp6UH4uWtyf0bGtLZ6BrhSA/UcM8n9FY4pwHL1PEPs/9bsW0n0bbm
         M/0A==
X-Gm-Message-State: AOAM532tWH9Y+asb3KlvKHCmLTRKAZt/Fm7yCRHdpkhcz8Lx3TTuVISb
        1syjAtD4uINbiCcrdSCIQQ==
X-Google-Smtp-Source: ABdhPJwcxswYxwoujA0TBNm20ZIM0B2TPmDMjbhy2MMXdtaYVTdJCGgHOxcUajX5x09b/mV3/JwYWw==
X-Received: by 2002:a17:906:1ecc:: with SMTP id m12mr12786914ejj.4.1614538631112;
        Sun, 28 Feb 2021 10:57:11 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id r11sm11964176edt.58.2021.02.28.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 10:57:10 -0800 (PST)
Date:   Sun, 28 Feb 2021 21:57:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 09/11] pragma once: convert
 scripts/selinux/genheaders/genheaders.c
Message-ID: <YDvnhQY+kuMVtwVf@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <YDvNF+QVOv3vqDbm@localhost.localdomain>
 <CAHC9VhTr0=WGvacsCGgpwiPwU_ziQeThV88ZqZRdVXqO+HafYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhTr0=WGvacsCGgpwiPwU_ziQeThV88ZqZRdVXqO+HafYQ@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 28, 2021 at 01:37:41PM -0500, Paul Moore wrote:
> On Sun, Feb 28, 2021 at 12:04 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > From 097f2c8b2af7d9e88cff59376ea0ad51b95341cb Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Tue, 9 Feb 2021 00:39:23 +0300
> > Subject: [PATCH 09/11] pragma once: convert scripts/selinux/genheaders/genheaders.c
> >
> > Generate security/selinux/flask.h and security/selinux/av_permissions.h
> > without include guards.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >  scripts/selinux/genheaders/genheaders.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> My LKML subscription must have died at some point due to mail bounces,
> or maybe I dopped it (?), because I'm not seeing the rest of this
> patchset for context.
> 
> However, unless the rest of the kernel transitions to this, or there
> is some other big win that I'm missing, I don't see much of a reason
> for this; can you provide some compelling reason for why we should
> make this change?  A quick search on "#pragma once" seems to indicate
> it is non-standard, so why replace the simple #ifdef/#define solution
> for this?

See https://lore.kernel.org/lkml/CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com/T/#t
