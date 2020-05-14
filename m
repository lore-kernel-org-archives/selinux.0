Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87014C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568AB20671
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="vXe9ls+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENN4F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENN4E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 09:56:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A40C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 06:56:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s9so2727782lfp.1
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAOHpj8cm64zeNHobI2iNXFJ/Bkp71mox7cCMQFgmB4=;
        b=vXe9ls+kpIwESvcCTG2R97DzXEtOVU8YH42951+sX6vL1H/2XUdGdNbwr/FXKFkPNG
         4I+gyMyJSXPh8VPaQ2eGH5z0a7NXKC9JS0h0r3Iv9yzQLv9EBNKub5G0t12oJHpFllvz
         hk2GfphTillpL3WiS/WVZKIgZAKvFrVoJzCaYzGXIiF0eRRsfPiA6xe83zezj/wcMQX4
         GnJuhVzxHBFZEvm3hqr5BCHgsfxWWduQ0R2ucVJAc0hJO5KP5AYsorT8WM+qSWB7PL4k
         hBswyXsve8A+xulI0MabAftcXRCEIG+lX6910a4TbKsKC0cH2WSRwHx9WfSY6YSONO4h
         IHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAOHpj8cm64zeNHobI2iNXFJ/Bkp71mox7cCMQFgmB4=;
        b=lvg8BmGA1GLBRoOlFPVX5COp/BTVna3NmR6c+u3KHRbzkz+01/Q1EiGTNAvIecQOp7
         25tfA2IVaW4fb5PS1G77OiSkik/aBnF4/DPpJOvDyfv+PWR5SnFmsp8Biwng21HvyfZ5
         Gnd3PNTEJoN1Nm8gauQ+r6YUQ0bainO9plwtuOL3UZomBvB8jrqrZ0vUXyHDSqKAM80j
         qv6s9F6rIqw8YTb+S+oxbPG3EEEmE2yNxXLSc70wf2NrQ/WmjAWmhQTLoyc8DiPN8K6L
         NQJNxyPPbeEX22cNbfrIYGwiTAuYtSNlEDEEuEbkN2JitUWDCx/s/5gMoSJDr9CZXNlF
         6Klw==
X-Gm-Message-State: AOAM533YMgUrbflBaALKJHa2SqTw3z3YEzQK6Mo8KxYSIMOvaK4aaHyo
        trdodwOQmBj3iQHQVdLOOCdf+//OxpN7BlKFhGXUWMKwxwqisg==
X-Google-Smtp-Source: ABdhPJxwH9GMTo8Lmd2lLJvSEhyKLXLhP8Uy5kLMf7/yM46dCMpzFxTGsctolKJKQaAam0/BnQTg8eDOIEsB9d59YDE=
X-Received: by 2002:ac2:5384:: with SMTP id g4mr3418645lfh.1.1589464561548;
 Thu, 14 May 2020 06:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
In-Reply-To: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Thu, 14 May 2020 09:55:50 -0400
Message-ID: <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com>
Subject: Re: Configuring MLS with a daemon operating at multiple sensitivities
To:     Paul Tagliamonte <paultag@debian.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 8:45 AM Paul Tagliamonte <paultag@debian.org> wrote:
>
> Hey SELinux fans,
>
> I've been playing with MLS on a test box. The "read down/write up"
> model makes total sense, but i'm running up against an odd problem set
> and trying to figure out how to best work this into an SELinux policy
> / configuration.
>
> I'm interested in having a demon that operates at multiple sensitivity
> levels depending on the security context of the peer network
> connection (within the same process, ideally, otherwise maybe
> threads?).
>
> I'm able to use NetLabel and CIPSO to mark packets with the desired
> sensitivity level, and I'm able to get that level via `getpeercon`
> during a network connection, but that connection's context hasn't been
> dominated by my process's. I'd like to either get that "combined"
> context (for instance, if my daemon is s0-s3:c1.c3 and the peer
> connection is s2-s15:c3, I'd like to see the value `s2.c3`), or to
> actually assume that role (to prevent reading/writing where it's not
> supposed to).

Joshua Brindle recently contributed a change that may get you what you want:
https://github.com/SELinuxProject/selinux/commit/9ba35fe8c280b7c91ec65b138d9f13e44ededaa9

Here is the corresponding kernel change:
https://github.com/torvalds/linux/commit/42345b68c2e3e2b6549fc34b937ff44240dfc3b6

The kernel change is in 5.5+ it seems, so you'll probably want to use
libsepol in your application.

Hope this helps.
-- 
Mike Palmiotto
https://crunchydata.com
