Return-Path: <SRS0=MPXq=TJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8136EC04AB1
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 19:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A721744
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 19:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wPsup362"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEITk4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 May 2019 15:40:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35027 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEITkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 May 2019 15:40:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id m20so3070427lji.2
        for <selinux@vger.kernel.org>; Thu, 09 May 2019 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ch5HLiNUbdzzp7mAUxeBmeNjCFg/GpZc2QwMMzZyJng=;
        b=wPsup362DAd3psjSHvLU2BYR3/+cIDk35eRFxJv7OPLf4B8DBxK2P1pTH73GwbPBpL
         DBo/pH0buXy6/OQbqrgDUAeibeKLDvf0PaO+qVg6j6LcOHTT42pbWhmDoHwJnusB2/B3
         +3oEeZnBwBljOkFfIGk3/XpKAH5vbCn1Rp0NegsLz7zWvyhV2OryUjcT8w85j31OW8Q+
         gVqCTZWYE61xodZLRna0NxS4FS2QQneroTYWpueE02IeWADyXmztqRnFBPSyF/xCfJPW
         Ei/tRFtWVvtX4AlJ6PulL161qULpVK8Gadg7pU88J1B+eJ+v6O2Wx3iPYJFxaY/TKYdR
         gsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ch5HLiNUbdzzp7mAUxeBmeNjCFg/GpZc2QwMMzZyJng=;
        b=UrpknjqxQhPzAzeGKXhkIv8FqnUlBhYZR7HYC+4uMxCOtrAeya9cuadoEx+vEWFsfr
         GhIsXkf2Wp5QXQb1EJjd+IqNFEUOTKeWrWBAcO6qGX4P2Qhp9GTWiWMgjlKUJXArMm1m
         6DsI5TuWAPtVPVO+NBYMG2Jxrbx1R+oMVaQY/6FRdmZQUlkHsa2cj2dhrGcoVsHOflvM
         bhLAqC48w8u4vrfEdiq5fFkKfB+USKjmcnHy54BlvZLELAg/A10054Wc8KXrgMrunKLo
         KRglWT/ZY2t5vwz8NfqqcJVOG3y20eMO8Lq75sZZ0ebcBBPJaHCSCfmFo+/gWt9kmObt
         Fx3A==
X-Gm-Message-State: APjAAAUInq3FHA2p22pFjHFSwSbeP4XMX6revidWJJ89yTm7XdQ1MHx6
        aJJ5vVWK4wkeUAIL4EfKRQu9WwY8ty29hjDAHC7D
X-Google-Smtp-Source: APXvYqwxm6N56BeGMIOKk8zY4FBZH0CSAHQssmwSOJvYO3VgbeLoLoGm/zXMN3y0gspjWxfItrilybhsu1plcWp7nY0=
X-Received: by 2002:a2e:9d0a:: with SMTP id t10mr3432630lji.95.1557430850530;
 Thu, 09 May 2019 12:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
 <CAHC9VhSU7pzWby78gHkYKm3t1LopSCoHBfmp=uBc+mF234K8mg@mail.gmail.com> <20190509001345.GA23407@osadl.at>
In-Reply-To: <20190509001345.GA23407@osadl.at>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 May 2019 15:40:39 -0400
Message-ID: <CAHC9VhQ2qnZEzJAh027TgT8LMrtpzLyj79p=BCVGJKSFMQjjEw@mail.gmail.com>
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

On Wed, May 8, 2019 at 8:14 PM Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Wed, May 08, 2019 at 05:47:32PM -0400, Paul Moore wrote:
> > On Wed, May 8, 2019 at 2:27 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > > While the endiannes is being handled properly sparse was unable to verify
> > > this due to type inconsistency. So introduce an additional __le32
> > > respectively _le64 variable to be passed to le32/64_to_cpu() to allow
> > > sparse to verify proper typing. Note that this patch does not change
> > > the generated binary on little-endian systems - on 32bit powerpc it
> > > does change the binary.
> > >
> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > ---
> > >
> > > Problem located by an experimental coccinelle script to locate
> > > patters that make sparse unhappy (false positives):
> > >
> > > sparse complaints on different architectures fixed by this patch are:
> > >
> > > ppc6xx_defconfig
> > >   CHECK   security/selinux/ss/ebitmap.c
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > >
> > > Little-endian systems:
> > >
> > > loongson3_defconfig
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > >
> > > x86_64_defconfig
> > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > >
> > > Patch was compile-tested with: x86_64_defconfig,loongson3_defconfig (both
> > > little-endian) and ppc603_defconfig (big-endian).
> > >
> > > On little-endian systems the patch has no impact on the generated binary
> > > (which is expected) but on the 32bit powerpc it does change the binary
> > > which is not expected but since I'm not able to generate the .lst files
> > > in security/selinux/ss/ due to the lack of a Makefile it is not clear
> > > if this is an unexpected side-effect or due only to the introduction of
> > > the additional variables. From my understanding the patch does not change
> > > the program logic so if the code was correct on big-endian systems before
> > > it should still be correct now.
> >
> > This is a bit worrisome, but I tend to agree that this patch *should*
> > be correct.  I'm thinking you're probably right in that the resulting
> > binary difference could be due to the extra variable.  Have you tried
> > any other big-endian arches?
> >
>
> just tried ppc64_defconfig + AUDIT=y, SECURITY=y, SECURITY_NETWORK=y, SECURITY_SELINUX=y
>
> sparse will complain in the original version about:
>   CHECK   security/selinux/ss/ebitmap.c
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
>
> which is the same as 32bit ppc - after the patch is applied that is resolved
> and and the generated ebitmap.o files are binary identical.
>
> I just had chosen ppc6xx_defconfig as my big-endian test-target as SELINUX
> was on there by default so I assumed it would be the most reasonable
> compile-test target.

Thanks.

I think this is probably safe to merge once the merge window closes.

-- 
paul moore
www.paul-moore.com
