Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91210C433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 01:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3146822257
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 01:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IxRV2uOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgJIBDr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 21:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJIBDr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 21:03:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709CC0613D4
        for <selinux@vger.kernel.org>; Thu,  8 Oct 2020 18:03:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so10643405ejd.13
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2020 18:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sf18sy5cFiqzhxmHs+f/BFCK6VarsaYerE+/z3lsjXY=;
        b=IxRV2uOpm7lCPjisn4dWl/y5bAz8o6YefQObub9q0QPN2H/XNETe7S3bquMsOPxDBi
         AnI7seispDAWJc64iwt5NGgOACgF+LL+mT9Xhf/86Z8kG74zUnNBHQkuttF3mupy8lov
         D4LJiyTgE0HgN5vdiHt/6WUoRHJ76FX7zuefwJVtOLjhykq/cxxiedNJzuwyChbr+EpC
         DlyxmjbjUSkSuarkO88kEM9GLSejG8ZwcKiWz6c4WbKk2knWMoGmi1cdOSJaqIT2Xoqi
         XRZlZ1ibMiPaQPudm4N1YZyRpY2YSZxGiljGrAlV/emRjV9sqDpeBsVIFxmGOrs7K3s4
         Mhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sf18sy5cFiqzhxmHs+f/BFCK6VarsaYerE+/z3lsjXY=;
        b=gb3c7xf65AvcnCtyw2EXChiBQK+mTMpssQhllUZDDC8I8T4x7mCkQj1X5uNvMiJ7nq
         /Ylk79m1RGsIZ9hmrDbVYlLjPxorBBBejPWhozjF1zoCQ2so1J1oXUB2RxH9ivCjsWiS
         3AB4QpBvWhqjXzqEIxr14k1Ht7m2ZBz9M8w7hJVMKiv91glS7jhkLHRNOQw18YE6QIX+
         pbD+75yw1qfSnkQQNQY56f1ZjeW/HzdwNn6I9ccLsqj//uBlIBInNy06+sBgjwKjqshs
         XkKuIY3Udjge7Swx/7fHjW86LoUfp4hcKjT3/q/w4Xz4kXX52YiQpByinX7xyMkug8BO
         NeMg==
X-Gm-Message-State: AOAM5321fYC+WMCKbPNVyLNJ6y9CZiDCpHM5wrc/ueclV8ozoJq3/PNE
        4zi8ZmtoPZWTM2YMvjjZ9kCTbGxRaSxuL8ZMf8Dc
X-Google-Smtp-Source: ABdhPJzQAt453SU3ysBgOsKp+uIfpxsBvwshJbbdoK5afkKzK0C1WDpQB9Hgx01S5r+CzeuwXJsANX0rJxhyi0MmwIY=
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr11220954eja.488.1602205425543;
 Thu, 08 Oct 2020 18:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com> <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
In-Reply-To: <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Oct 2020 21:03:34 -0400
Message-ID: <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Chuck Lever <chucklever@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

->On Thu, Oct 8, 2020 at 9:50 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > Hi folks,
> > >
> > > From some linux kernel module, is it possible to query and find out
> > > whether or not selinux is currently enabled or not?
> > >
> > > Thank you.
> >
> > [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> > that the LSM list]
> >
> > In general most parts of the kernel shouldn't need to worry about what
> > LSMs are active and/or enabled; the simply interact with the LSM(s)
> > via the interfaces defined in include/linux/security.h (there are some
> > helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> > bit more on what you are trying to accomplish?
>
> Hi Paul,
>
> Thank you for the response. What I'm trying to accomplish is the
> following. Within a file system (NFS), typically any queries for
> security labels are triggered by the SElinux (or I guess an LSM in
> general) (thru the xattr_handler hooks). However, when the VFS is
> calling to get directory entries NFS will always get the labels
> (baring server not supporting it). However this is useless and affects
> performance (ie., this makes servers do extra work  and adds to the
> network traffic) when selinux is disabled. It would be useful if NFS
> can check if there is anything that requires those labels, if SElinux
> is enabled or disabled.

[Adding Chuck Lever to the CC line as I believe he has the most recent
LSM experience from the NFS side - sorry Chuck :)]

I'll need to ask your patience on this as I am far from a NFS expert.

Looking through the NFS readdir/getdents code this evening, I was
wondering if the solution in the readdir case is to simply tell the
server you are not interested in the security label by masking out
FATTR4_WORD2_SECURITY_LABEL in the nfs4_readdir_arg->bitmask in
_nfs4_proc_readdir()?  Of course this assumes that the security label
genuinely isn't needed in this case (and not requesting it doesn't
bypass access controls or break something on the server side), and we
don't screw up some NFS client side cache by *not* fetching the
security label attribute.

Is this remotely close to workable, or am I missing something fundamental?

-- 
paul moore
www.paul-moore.com
