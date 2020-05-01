Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C2AC47253
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723D124953
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 16:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="m5o6DjW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgEAQRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgEAQRs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 12:17:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB081C061A0E
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 09:17:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n4so7825417ejs.11
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23jPYeIHxkO0ujsGD7eYlRbwJShWG3r7UKIREhK5bgw=;
        b=m5o6DjW23uDqvbH6ScTDm+6wn+eSq6aJHkCW7h0E7PQK2TC3+9C/vXX2qmTMXOjDJV
         5m7dDloIaOCSsVWgmy7ijk65TLdTjrJ35UszXTvgQ+9FAhewqXUSAX95ukIByWJVG8Lc
         aJ7FU+3rG+rlYO/LV/MbE4r+CuM0NZfQfnEoIVfNHKM5uWW6T0vZY8K1Xh0pMqnuCdoB
         3NteUzx8k6UL8h+e6dKHslAXt3Zm5yYdLt8ZZFPmzTn15hRPVkNYH3tm/IV4ZnwkNiyz
         FKeNDhmMd7lLEeaZhxMAmD4CqLTsnybNjFKZKZBtJF0qDkGghOeiehwGobytDRRCd4i7
         HHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23jPYeIHxkO0ujsGD7eYlRbwJShWG3r7UKIREhK5bgw=;
        b=oEP00oH2d0N/87XDZoMTL/hZOI/I1qfCBjTw3EXqdsaEH2gG/Z3daguwTcwbGwvODm
         XMpmoLK9SbbOre+R7CATgVrThVYjZDzzAL6orJZSxeWZ6I4k61Gxye7+yW1VkBu36icm
         fHt1cZT2r6YzG5MYfRl+73GS/1J6qiEsHKjwvw1maFrN1HqbbIv19JeVIUfsAv3qviBx
         3MldES/uR8VlOKiIQR+He3kY6VR4wV21+abNEOFCkyuW19tklVnme2bJ1TFiW/ahxfQ8
         nkKOGZbo9UGb4lbR9ncJDfad+aHAK94M+mYu+4dP5Tl2abN3yLaCRji3mioZXCO+4Tzw
         fjWA==
X-Gm-Message-State: AGi0PuZlvhzsNWMgkIJMkNXYsO+Qd8hzQveMnhI1/mdvFE82pOzKfYou
        DALtOWZjs91TSlctqt309M75zM/DHDA7nloIaPofAU0=
X-Google-Smtp-Source: APiQypIXB+av6flcFldEWw+bS/wH+cxQMW/luqrFwIHVh8pa/MRqCUmiUnrrXtxszp5IfdTN8uKbEAzFnfW/lbRVEho=
X-Received: by 2002:a17:906:29c4:: with SMTP id y4mr3965185eje.95.1588349865367;
 Fri, 01 May 2020 09:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
 <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
In-Reply-To: <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 12:17:33 -0400
Message-ID: <CAHC9VhSBGaJc-dQZyyUECwrysoQ8a4w2ww4PgPyXVH5EEVOjCw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.7 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 7:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 30, 2020 at 2:24 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Two more SELinux patches to fix problems in the v5.7-rcX releases.
> > Wei Yongjun's patch fixes a return code in an error path, and my patch
> > fixes a problem where we were not correctly applying access controls
> > to all of the netlink messages in the netlink_send LSM hook.
>
> Side note: could we plan on (not for 5.7, but future) moving the "for
> each message" part of that patch into the generic security layer (ie
> security_netlink_send()), so that if/when other security subsystems
> start doing that netlink thing, they won't have to duplicate that
> code?
>
> Obviously the "for each message" thing should only be done if there is
> any security  hook at all..
>
> Right now selinux is the only one that does this, so there's no
> duplication of effort, but it seems a mistake to do this at the
> low-level security level.
>
> Or is there some fundamental reason why a security hook would want to
> look at a single skb rather than the individual messages?

Off the top of my head I can't think of why a LSM would want to look
only at the skb instead of the individual netlink messages.  I suppose
if that ever becomes an issue we could always pass the skb to the hook
along with the nlmsghdr, and the LSM would just need to deal with
being called multiple times for the same skb.  Another option might be
to give the LSM the option of registering one of two hooks for the
netlink_send hook; one type of hook would behave the same as the hook
does now, the other type would be called once for each message in the
skb.  Although this second option seems like a lot of extra complexity
for a questionable advantage, especially since only SELinux is using
the hook at the moment and we can easily change the hook without
breaking things.

It's also worth mentioning that we've always tried to keep the hook
layer (the stuff in security/security.c) relatively thin, but that's a
battle we've been slowly losing over time.  Moving the skb/nlmsghdr
processing into security_netlink_send() seems reasonable given some of
the other hooks.

Regardless, I'll work on something for an upcoming merge window, stay tuned.

-- 
paul moore
www.paul-moore.com
