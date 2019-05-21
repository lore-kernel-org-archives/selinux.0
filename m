Return-Path: <SRS0=L5Vm=TV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501C6C04AAF
	for <selinux@archiver.kernel.org>; Tue, 21 May 2019 20:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9EC2173E
	for <selinux@archiver.kernel.org>; Tue, 21 May 2019 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HqKCwuT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEUUXP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 May 2019 16:23:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34254 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfEUUXP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 May 2019 16:23:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so14110696lfi.1
        for <selinux@vger.kernel.org>; Tue, 21 May 2019 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGsw9meU7G7A0v7S1hg5gO3PLF4ljBd/H9BbyFd15lI=;
        b=HqKCwuT9NgzPlNJEQQgvXHwD7HXgSK6qbTCAn2LBRBYBkytl76mpo8cUd5UKFp9EOf
         /Szn6BnjZHiQ3dDQWF4XPDA+atwwQNAenY4XxM2olDm+MUCpItHqQ3y+jfptPguxsf17
         IN4NTAuxZm7P501M66GJGS53cf2g13hUCPmpWHcFA5njypWWbIp+yKLenGQBl3Qvv5b2
         GGJ/fEHOzgn0Kgy+6e2t4e6Jrfs/U3f0kFvoq0PrK5z/gUpFgCvdbNJIwBkQEHfnKFWi
         4/KxP1EC89eK0+ZZYqE0BPZOc0xl6P/aaIGKmnY3Htfcup78Xeu9l2VQiuMYNhJ0HcTT
         fPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGsw9meU7G7A0v7S1hg5gO3PLF4ljBd/H9BbyFd15lI=;
        b=jLSDxxrla2o0150Zg0//ATz+s8yThw/33UD7XPaHh9b+98YAXmWeM49PzShliEAoXQ
         igmDJtNycu0oWv8can43R4qrrrHjfX3n9PVrX4rITc5gcMMjG27/EEbcqcseWmD8CSNw
         oGqbOs9p1w/x3qFwieV1OsukGjyKfxkmOGSp1KxJIHQc1lahC7gTFHqs9LsFFnJXmQGp
         k8/RIR30IoKKDGUgoffT9+yVquFbE7fD77/l+jIOc8itC3bt9zaZS37KLin4CgNFzVj6
         C7O7cB3hFM3/Nk7pt3pL3tUaK/HE2PmN5ePCg673agi40pqalgqLInF80g6ySYUQpGTd
         W/AA==
X-Gm-Message-State: APjAAAVJUlqLCnSUshnSW1FaTLVmFI9thkpcLlLLTCkFqiIHSmUwNz0n
        jGjkhWDDClPBIyCeENpcRmbyVSbyRtgKiv/uCN4Q
X-Google-Smtp-Source: APXvYqzHlwpTLSoRvolURDbkMpTjw0qqLpb4HAJpk1RmFIiCs77jeOpTtGriolNM07oCrkf7jyZcPKBmjfsbMiF7Eag=
X-Received: by 2002:a19:a8b:: with SMTP id 133mr1605852lfk.35.1558470192678;
 Tue, 21 May 2019 13:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
 <CAHC9VhSU7pzWby78gHkYKm3t1LopSCoHBfmp=uBc+mF234K8mg@mail.gmail.com>
 <20190509001345.GA23407@osadl.at> <CAHC9VhQ2qnZEzJAh027TgT8LMrtpzLyj79p=BCVGJKSFMQjjEw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ2qnZEzJAh027TgT8LMrtpzLyj79p=BCVGJKSFMQjjEw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 May 2019 16:23:01 -0400
Message-ID: <CAHC9VhRPZKHt7EoK=O2keuyMm=fYyEAbWjJTG0uFA_Z6o_0-3A@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: provide __le variables explicitly
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 9, 2019 at 3:40 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, May 8, 2019 at 8:14 PM Nicholas Mc Guire <der.herr@hofr.at> wrote:
> > On Wed, May 08, 2019 at 05:47:32PM -0400, Paul Moore wrote:
> > > On Wed, May 8, 2019 at 2:27 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > > > While the endiannes is being handled properly sparse was unable to verify
> > > > this due to type inconsistency. So introduce an additional __le32
> > > > respectively _le64 variable to be passed to le32/64_to_cpu() to allow
> > > > sparse to verify proper typing. Note that this patch does not change
> > > > the generated binary on little-endian systems - on 32bit powerpc it
> > > > does change the binary.
> > > >
> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > ---
> > > >
> > > > Problem located by an experimental coccinelle script to locate
> > > > patters that make sparse unhappy (false positives):
> > > >
> > > > sparse complaints on different architectures fixed by this patch are:
> > > >
> > > > ppc6xx_defconfig
> > > >   CHECK   security/selinux/ss/ebitmap.c
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > >
> > > > Little-endian systems:
> > > >
> > > > loongson3_defconfig
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > >
> > > > x86_64_defconfig
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > >
> > > > Patch was compile-tested with: x86_64_defconfig,loongson3_defconfig (both
> > > > little-endian) and ppc603_defconfig (big-endian).
> > > >
> > > > On little-endian systems the patch has no impact on the generated binary
> > > > (which is expected) but on the 32bit powerpc it does change the binary
> > > > which is not expected but since I'm not able to generate the .lst files
> > > > in security/selinux/ss/ due to the lack of a Makefile it is not clear
> > > > if this is an unexpected side-effect or due only to the introduction of
> > > > the additional variables. From my understanding the patch does not change
> > > > the program logic so if the code was correct on big-endian systems before
> > > > it should still be correct now.
> > >
> > > This is a bit worrisome, but I tend to agree that this patch *should*
> > > be correct.  I'm thinking you're probably right in that the resulting
> > > binary difference could be due to the extra variable.  Have you tried
> > > any other big-endian arches?
> > >
> >
> > just tried ppc64_defconfig + AUDIT=y, SECURITY=y, SECURITY_NETWORK=y, SECURITY_SELINUX=y
> >
> > sparse will complain in the original version about:
> >   CHECK   security/selinux/ss/ebitmap.c
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> >
> > which is the same as 32bit ppc - after the patch is applied that is resolved
> > and and the generated ebitmap.o files are binary identical.
> >
> > I just had chosen ppc6xx_defconfig as my big-endian test-target as SELINUX
> > was on there by default so I assumed it would be the most reasonable
> > compile-test target.
>
> Thanks.
>
> I think this is probably safe to merge once the merge window closes.

... and that time is now; merged into selinux/next.  Thanks.

/me crosses his fingers on this one

-- 
paul moore
www.paul-moore.com
