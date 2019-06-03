Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B38CC04AB5
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E96726CEB
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 21:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ONMCeqFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfFCVuZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:50:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33576 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCVuZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 17:50:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id v29so6424468ljv.0
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2019 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9i0fLB3ctHjhbMv4GYPOBusi0dAWBcq7kpoGxU/5uy0=;
        b=ONMCeqFi2tN4KQtO8Da4s9yG59tc8l/KfFqoS1qMjM18ZALi+QRdNvLyvmqjblfODX
         AEDDqvyyVbhpxg/VK23dTgeYdOCNfUAeN9FMKxPHyN0oOgeZXok+ZdnjAU71ZRwhjRcZ
         RKItIQEhhsnBqu68xNOZ4kGcM7U88snPqRtDsLUEx8rf3Yhzq0Qic4T7B76sFqZf00i7
         AElPiJoLHOF+jb7bESf1g+jcZihky+tgr51oHeOGb6U4JSkGjP+rWTQfsGba+S3nPimu
         AO4tBX9I8ylLnCTVAKVNnUMY5lmasvu4gqpdI4OdGfoDFbNCBNxdy/VApJOD7Zps4aJo
         qZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9i0fLB3ctHjhbMv4GYPOBusi0dAWBcq7kpoGxU/5uy0=;
        b=Bqih7wgsin91+Unwl2a3qbMCf0KRYijNOWSYQBzVue6/IlVSiO2SFXut+FCQr9n15S
         GE49TUdaJGKsMge3jjIiXI2eLTBIRZ4c1kAoMAWoP6rsxzMMkV8xQ/bphP3xQPKcoY+m
         QmIKlVEZV544Fej5BcGuNDWmGYIM7wWkTLBLcCdi7RnE41oFvnKQWfjo/CUn4h8Vv99r
         VjamnConSmtWxeobtUasB0zuYrgx3vTvUIDvPtuCeauy82kf4L/hCrSu00DU+pMmvTF7
         SixXlT/x6CCzCvTdE9NlN7TJ5KC2jUTH1KdJ9yyj/J6Dv8ZEKutnZJhTAzB7pdQ1yM0P
         cLCw==
X-Gm-Message-State: APjAAAX+U6K3UD8hU6Tqp/sLAiwEL5VwMrIeyOs+Yfaf1YFKDn7gfn/4
        YDAT760PQ2fTNxVs5ZQCKjXCfQw42H4YAlZPT/977b8=
X-Google-Smtp-Source: APXvYqwOt5QwwF991N5QgfhgtcwXRJbuTWTAvKoJqehKyrnMTSwptDkGcIf1MEltn7xdxIzkIBJlP3kGx13ECWw/nmo=
X-Received: by 2002:a2e:900e:: with SMTP id h14mr14762142ljg.77.1559595589392;
 Mon, 03 Jun 2019 13:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190601021526.GA8264@zhanggen-UX430UQ> <20190601022527.GR17978@ZenIV.linux.org.uk>
 <20190601024459.GA8563@zhanggen-UX430UQ>
In-Reply-To: <20190601024459.GA8563@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Jun 2019 16:59:38 -0400
Message-ID: <CAHC9VhSbS6_Hp6_k0qpqQTvyG29ADx+b7JoXjDgXViO9bRXVMA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, omosnace@redhat.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 10:45 PM Gen Zhang <blackgod016574@gmail.com> wrote:
> On Sat, Jun 01, 2019 at 03:25:27AM +0100, Al Viro wrote:
> > On Sat, Jun 01, 2019 at 10:15:26AM +0800, Gen Zhang wrote:
> > > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > > returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> > > should be freed when error.
> >
> > What's the latter one for?  On failure we'll get to put_fs_context()
> > pretty soon, so
> >         security_free_mnt_opts(&fc->security);
> > will be called just fine.  Leaving it allocated on failure is fine...
> Paul Moore <paul@paul-moore.com> wrote:
> >It seems like we should also check for, and potentially free *mnt_opts
> >as the selinux_add_opt() error handling does just below this change,
> >yes?  If that is the case we might want to move that error handling
> >code to the bottom of the function and jump there on error.
> I am not familiar with this part. So could you please show the function
> call sequence?

I'm not sure I understand your question above, but I did review your
latest patch and agree with Ondrej's comment regarding the ret/rc
variable.  If you make that change I think we can merge this into
selinux/stable-5.2.

-- 
paul moore
www.paul-moore.com
