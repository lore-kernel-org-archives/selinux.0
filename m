Return-Path: <SRS0=Z14I=EN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCB7C388F7
	for <selinux@archiver.kernel.org>; Sat,  7 Nov 2020 14:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FEC206ED
	for <selinux@archiver.kernel.org>; Sat,  7 Nov 2020 14:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jh1/IvVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgKGOSu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 7 Nov 2020 09:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgKGOSu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 7 Nov 2020 09:18:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA14C0613CF
        for <selinux@vger.kernel.org>; Sat,  7 Nov 2020 06:18:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 7so5976778ejm.0
        for <selinux@vger.kernel.org>; Sat, 07 Nov 2020 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiDocss4Ln7nrR7P7VFmUIzkki7aoP9kdneNVH5PtEc=;
        b=jh1/IvVPwik0p4DsRFOdkaIgMXrBh7BzP4d41h0h6KNWdkvz9B7gSYF9IL2zdDAFQG
         aoholuva7ENm8egSpRGPFctWPkGPkQng6L24k77pUEFMNt05N1DN+eCmB0XKVIHKmKt4
         rCcMVxHf42t2ZFwKyY+BvzLC+bZcAGI/5lQ32yVKhN3cPcWLWK4YUYEgEX9jZYblVmHk
         CHWEjYJX1uut+bgpEg+4VjibEkIJLk9kIxU5tzoEQX0HMdaiwnjEHhRORU3McvIhHWCL
         wrhLaY46CLBDe5G7C4zP8AnBuRdx79R3jsrOojFL00TRJ9oSfHQtp7TtflJn2kD0QPUB
         0w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiDocss4Ln7nrR7P7VFmUIzkki7aoP9kdneNVH5PtEc=;
        b=PtV1xHC2wQPLoeCbwqmBWufRwIAOPeWvMG4SzgZ66leeXpFFJGOn20lhPy4Qv55Ogq
         vD/Ba7lJ6PNve8fF8s8F26W5fOJjA3C4LIOBEFUciuzI/3z8OWKGPm+Up7Ki1ibeIljA
         50f5PU0ilAuczsURUUZyhL4+XatT4BIjxeJ0ZPoKkhIfEHpcSGQXhPTB8g1VBK5jCvKC
         Gv+lRLUQaqBjeBVYSRv0eIGcpvloWQyWUv2LaJhv/DrieWEgRfHtPie1+OiGMO3ONmns
         9ZbGCNYXVhYuV8RnY+xtp32M+M+0zYAs5qW7QbnRWQEnI4WFiBfja63WCGJcTFne77sF
         LNoA==
X-Gm-Message-State: AOAM5331zbPm6/gOkn3L6zRladqio5AQpbLjcfGOY9axXSO8S63bmgSQ
        RburMH1rlc9HiJ9gLTT/xNOKza03QJ7iIpnGVfFFjnjlag==
X-Google-Smtp-Source: ABdhPJxm/V1jwXNc84tpziKIhAMn63qf3ESbjxUKSUJtJsNcS1FUu3HwAHXxuC858CM4jU+vkcadSSTLRAUkxC1HaWg=
X-Received: by 2002:a17:906:cb0f:: with SMTP id lk15mr6666844ejb.431.1604758728460;
 Sat, 07 Nov 2020 06:18:48 -0800 (PST)
MIME-Version: 1.0
References: <CAP2Ojcgr2NkjZxL3_Fcu2Tj00ahCOqvx+i0qzn2mcsrNE-iFrA@mail.gmail.com>
In-Reply-To: <CAP2Ojcgr2NkjZxL3_Fcu2Tj00ahCOqvx+i0qzn2mcsrNE-iFrA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 7 Nov 2020 09:18:37 -0500
Message-ID: <CAHC9VhTqYyOGSdyG0syvLG30sWC9kb_NmjbWaNrefgFkzCjDAg@mail.gmail.com>
Subject: Re: Inputs for error " libselinux.so.1: cannot open shared object
 file: No such file or directory "
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 7, 2020 at 6:57 AM Ashish Mishra <ashishm@mvista.com> wrote:
> Hi Senior Member's  ,
>
> I am trying to get the SELINUX on one of our evaluation boards (MIPS based).
> The SDK running is custom makefile based & kernel is linux-4.9 series.
>
> 1) To get the selinux , i have enabled the kernel configuration w.r.t SELINUX
>      I can see the entry created under /sys folder
>             ~ # ls /sys/fs/selinux/
>
> 2) But when i run command of selinux  like selinuxenabled , i am getting
>      Error message of :
>      selinuxenabled: error while loading shared libraries:
> libselinux.so.1: cannot open shared object file: No such file or
> directory
>
>      But i can see the library at /lib folder
>           ~ # find / -name libselinux
>           ~ # find / -name 'libselinux*'
>                     /lib/libselinux.so
>                     /lib/libselinux.so.1
>
> Can members please provide any input as to which package is missing
> here or probable areas to look to solve the problem.
> Idea was to build a selinux setup

Hi Ashish,

This looks like the SELinux userspace libraries may not have been
built/installed correctly.  How did you install the SELinux userspace?

-- 
paul moore
www.paul-moore.com
