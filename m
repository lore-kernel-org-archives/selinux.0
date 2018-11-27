Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C691FC43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D52208E7
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 09:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D52208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeK0ULn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:11:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33468 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbeK0ULm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 15:11:42 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so18681837oib.0
        for <selinux@vger.kernel.org>; Tue, 27 Nov 2018 01:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VeYNIEhl6I0P815TUv2St4I1yjEEHZt1/hiJSlXg7A=;
        b=DpQmNKdx++gZSbiVI3luWoqWC7dPoA6FVedm0e0KQRHWDbUKcxsqv47xbOH2BEspQi
         kGxnDVzRNdA1emFEWPEIVF/YCtOMGioGKP941kM5ogJLSIPnDkQCbfrhR3ou0xPxj4tJ
         R0XNh+hx/mZeZKSxpu0MAonl6xqyh2+igsAN9hOE0J4u5LCcUVUgaDszoY5Jvjx+FwLT
         ooWM+iu8O6Bg78nSn54GUmWObQI8SH1JuqLmTcgtanXIhOptk0878XhzHjuoo4BI3ALT
         00WfchlFSKomleQDrsAR6XwDHxDdHkPQuIIrL6lPtn4ogNm/U0G+jWbjCj33x5afxM14
         MRpA==
X-Gm-Message-State: AGRZ1gLY6nC0VpQk4salo5iUfNrxSa7HbPtfYRwOV8bBBLq0US6PSnFP
        bZMh7kRDoovdhVHqebzWFpf6nAvXd2VymXizWVEY1Q==
X-Google-Smtp-Source: AJdET5fRctI/moiaQ2GrAOfxzAysxckeQVwW7ze1F2DCXt/kdNAEc016UedbNS/rMJUj5UlgS1H1vDppNrwe2b0u7m0=
X-Received: by 2002:aca:50cf:: with SMTP id e198mr18396498oib.343.1543310067736;
 Tue, 27 Nov 2018 01:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
In-Reply-To: <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 27 Nov 2018 10:14:16 +0100
Message-ID: <CAFqZXNvUg9wNV4DBsFa+_Kkr5AMrdSGOkGuJmmF17MC59ASCig@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 27, 2018 at 9:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Nov 27, 2018 at 1:52 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Paul,
> >
> > Today's linux-next merge of the selinux tree got a conflict in:
> >
> >   security/selinux/hooks.c
> >
> > between commit:
> >
> >   0472421f47a9 ("vfs: Remove unused code after filesystem context changes")
> >
> > from the vfs tree and commit:
> >
> >   2cbdcb882f97 ("selinux: always allow mounting submounts")
> >
> > from the selinux tree.
> >
> > I fixed it up (the former removed the function updated by the latter -
> > I am not sure if there are further changes necessary) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.
>
> Hm... seems that there was some massive overhaul in the VFS code right
> at the wrong moment... There are new hooks for mounting now and the
> code that our commit changes is now here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/security/selinux/hooks.c?h=for-next#n3131

For convenience, here are direct links to the most important -next VFS
commits that are related:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=c87c47c34750e9ee1ff0345593f3cbf6726b9d4e
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=4786c3427b2517ee9c685f95bf5b3185e332e64d
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=37744f3d21f8dbf6bb65e1ecef38c2cf9503d202
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=0472421f47a97be4b741d55ffd18f68ed9ba7cea

>
> It seems that the logic is still the same, just now our patch (or the
> VFS one) needs to be updated to change the above line as such
> (untested pseudo-patch):
>
> - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))
>
> Thanks for the heads up, Stephen!
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
