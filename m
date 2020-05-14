Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043AC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 14:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3334F205CB
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 14:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENOBH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 10:01:07 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:35041 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENOBH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 10:01:07 -0400
Received: by mail-qk1-f176.google.com with SMTP id f13so3063651qkh.2
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 07:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRtS/RzARxwGyhrqTKGvb0zoMmziyJgBR/g3JxIj8Pg=;
        b=fh39AiQL5+5ru+BNbHmbZzEZvdMa2ggIpI4RFqYpM2iCiEVB+Ye/jbNeJCyTuz+7hb
         mqJ4atHNV3xEUBW3TAsm/hTHMJS+GfXCVEkWKzqiW6K0DrGHvaEEmsW6C1dWqlcLvjHF
         wcyFmALW4UeOxmJHqPFsJe/xA953MPtAwphWqNVZDJVu3BwtVClu361eWdUZ21Fw5V1U
         fGf9+uIBA6ByWS5dnYTmbChhYeGllu4lTzGf3w0rw5fa3rwYz6J19+VUGodp9BnvJJxt
         tiKeMZUBPnnuKRgifTNcJUmtMFINy7S+g/fh2WIHuJR1svCBncNyz6P9Vsrubs+DHqt2
         9qag==
X-Gm-Message-State: AOAM531kXxl0hJCUMLeunEfA3k3wmNVq8U9rDcJO8dNYqy6r7aE0vNAm
        zWAmuv6m2AWMsoH2rOJF+7RmhVTznQzhLDlus1HUKOQg
X-Google-Smtp-Source: ABdhPJwn5Xm9F7Feaetn2Ht4TnIbJ9pofwTiFYAV93vnS024MGHBPR3M6D66FqXQw4vF6Wd3FEKv+7Gf54e8jLV3E7Y=
X-Received: by 2002:a05:620a:2159:: with SMTP id m25mr4698738qkm.382.1589464866590;
 Thu, 14 May 2020 07:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
 <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com>
In-Reply-To: <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com>
From:   Paul Tagliamonte <paultag@debian.org>
Date:   Thu, 14 May 2020 10:00:55 -0400
Message-ID: <CAO6P2QS78aTzCvMHgUWmgmkVjEN9v0Wq0Lgys2puL6eRW+CLjg@mail.gmail.com>
Subject: Re: Configuring MLS with a daemon operating at multiple sensitivities
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hey there Mike,

Incredible! This is very helpful, thank you very much! I think this is
the missing building block I need.

Have a great day, and thank you to Josh!

   paultag


On Thu, May 14, 2020 at 9:56 AM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Thu, May 14, 2020 at 8:45 AM Paul Tagliamonte <paultag@debian.org> wrote:
> >
> > Hey SELinux fans,
> >
> > I've been playing with MLS on a test box. The "read down/write up"
> > model makes total sense, but i'm running up against an odd problem set
> > and trying to figure out how to best work this into an SELinux policy
> > / configuration.
> >
> > I'm interested in having a demon that operates at multiple sensitivity
> > levels depending on the security context of the peer network
> > connection (within the same process, ideally, otherwise maybe
> > threads?).
> >
> > I'm able to use NetLabel and CIPSO to mark packets with the desired
> > sensitivity level, and I'm able to get that level via `getpeercon`
> > during a network connection, but that connection's context hasn't been
> > dominated by my process's. I'd like to either get that "combined"
> > context (for instance, if my daemon is s0-s3:c1.c3 and the peer
> > connection is s2-s15:c3, I'd like to see the value `s2.c3`), or to
> > actually assume that role (to prevent reading/writing where it's not
> > supposed to).
>
> Joshua Brindle recently contributed a change that may get you what you want:
> https://github.com/SELinuxProject/selinux/commit/9ba35fe8c280b7c91ec65b138d9f13e44ededaa9
>
> Here is the corresponding kernel change:
> https://github.com/torvalds/linux/commit/42345b68c2e3e2b6549fc34b937ff44240dfc3b6
>
> The kernel change is in 5.5+ it seems, so you'll probably want to use
> libsepol in your application.
>
> Hope this helps.
> --
> Mike Palmiotto
> https://crunchydata.com



-- 
:wq
