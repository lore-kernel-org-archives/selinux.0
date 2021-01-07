Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3D7C433E0
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 07:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61F82311E
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 07:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbhAGHgB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAGHgB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jan 2021 02:36:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC6C0612F5
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 23:35:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m5so4612507wrx.9
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 23:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8NeuLo0Y0TX0SrzDgaY2p3Z6rCcW87zsoe5l+RlvDg=;
        b=aDA8lMTH21f/iuIwIb4bPl/L6H13s7B6IWgWFVmyoU3dNamNKKLThNjhZSzChnMacS
         HNUGoPklOm3LZWikOSC1VcsMlpqG5dOjvYeJh88nhYktu6McBoSdgd/5yeHwFaW+1KXE
         FEZ5D8sCUwbIw0Z9s5CLGJwZjagz64WDWYItgyKerhJwMczewkukQodj9uzy8Ixlw2UK
         yj7rR0qSvcstN2EHJ2B8BRezsznBT4k5Zyt+8eoAGRc8Fs6dIsUgZ6rW+WSaxJlhkQF/
         bQP6qijaZCGoma/MbGlIVja1QinxbImtbPRCzWgBuueLx+1XKIJm6aPtIkAAbju9Thzb
         jndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8NeuLo0Y0TX0SrzDgaY2p3Z6rCcW87zsoe5l+RlvDg=;
        b=KqVwxh8RRWdxjSFtmgbi5Nuqizhyywf2RgX3tS5ysdHl9uFukxElaU/uB2BSIL6InT
         YIQqLNbHj2UXbtogfZcNrRZesi9m2+W/erthffJe3eYqy3+gZKHtb8bJfdiyypXBUtHq
         vUb5gjH/0Icc9ATv2DwwgKs8i4wL0FepsWjjMRRyEqXcfqIjc5pKh23Uo8KFmYJIhRSM
         CLFa55k+zwWT7k8R2uGvlhaybLh6h32KleMOCe1PCUqV7yqGb+KwBCU9RaF4kHmro2gl
         e2/aoGuIP+AsHxnt7vIKhbFzcOyi8QhDDcf8eHWr/rjuaeBPDb/YYIKl02VziwEbswQF
         oGFw==
X-Gm-Message-State: AOAM532EtkMQ3T/OrarFxxspae/UV9ALdWbtGZvuBSprCf36D2DuogeY
        hidOVXuCUS4pKolEnYivZAuRogtjP63JgbNnFvx6+g==
X-Google-Smtp-Source: ABdhPJxfpO/vZa9yRPa7FamyHao8a9BvdEJ5UgF7jQl7d8g3r6mMpLCTBoObJx+zf4C1pcSLdAwwjw9VR7jtbe1hOiE=
X-Received: by 2002:a5d:558a:: with SMTP id i10mr7757634wrv.363.1610004918382;
 Wed, 06 Jan 2021 23:35:18 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl> <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
 <ypjlv9cc50hj.fsf@defensec.nl> <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
 <ypjla6tmgoka.fsf@defensec.nl> <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
 <ypjl5z4agmt4.fsf@defensec.nl> <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
 <ypjlsg7ef6nh.fsf@defensec.nl> <CAP2Ojcg5d=i0FKM0f1DTqtT2N3ftKEEqJq4=zdZr4m22xn4zjA@mail.gmail.com>
 <ypjlo8i2f519.fsf@defensec.nl> <CAFqZXNuUdij1v4yvSvpLJPi+0KSFSR46k+c52E3=QdF-f_C9yQ@mail.gmail.com>
 <CAP2Ojci+UGvCCr6XMHYvm6jCr4p9GmwM3j97ZFLoqB2prNH4gQ@mail.gmail.com> <ypjlble2f29c.fsf@defensec.nl>
In-Reply-To: <ypjlble2f29c.fsf@defensec.nl>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Thu, 7 Jan 2021 13:05:06 +0530
Message-ID: <CAP2Ojci8Bf+esbPoPhTK+M4-6X0g_xxFTZSOanq+147E1eCCrw@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks Dominick ,
This will be helpful , i will try to use IRC also

Thanks ,
Ashish

On Wed, Jan 6, 2021 at 10:09 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ashish Mishra <ashishm@mvista.com> writes:
>
> > Hi Dominick / Ondrej ,
> >
> > Thanks for valuable inputs , I will try to evaluate them .
> >
> > Ashish
>
> We have a IRC channel on chat.freenode.net where we can have casual and
> more interactive conversations if youre interested in that
>
> https://freenode.net/kb/answer/chat
>
> >
> > On Wed, Jan 6, 2021 at 9:30 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >>
> >> On Wed, Jan 6, 2021 at 4:40 PM Dominick Grift
> >> <dominick.grift@defensec.nl> wrote:
> >> > Ashish Mishra <ashishm@mvista.com> writes:
> >> >
> >> > > Hi Dominick ,
> >> > >
> >> > > Will look at the re-labelling as you suggested.
> >> > > Is there any doc / blog / implementation etc to understand the
> >> > > sequence and commands to do this.
> >> > > To understand this step in a better way.
> >> > >
> >> > > We are working with such a setup freshly so any inputs / guidance will
> >> > > be helpful.
> >> > >
> >> > > Thanks for your time & inputs for this long thread .
> >> >
> >> > For docs i would suggest selinuxproject.org and
> >> > https://github.com/SELinuxProject/selinux-notebook/blob/main/src/toc.md
> >> >
> >> > For implementations i would suggest looking at how OpenWrt implemented
> >> > SELinux as this is a very simple implementation and the target seems to
> >> > be relatively similar to yours with the exception that OpenWrt does not
> >> > use a volatile root but instead uses a read-only squashfs and a overlay.
> >> >
> >> > You can also look at Fedora CoreOS for inspiration, and Googles SEAndroid.
> >> >
> >> > Implementing meaningful SELinux for exotic use cases like yours is not
> >> > trivial though IMHO. Using reference policy as a base-policy might not
> >> > be optimal for your use-case (to say the least) and it would probably be easier to create a
> >> > policy from scratch instead in the longer run.
> >>
> >> Well said. I'll just add that you'll at the very least need to remove
> >> the "genfscon" rule for "rootfs" from your policy and replace it with
> >> an appropriate "fs_use_xattr" one to be able to relabel the root
> >> filesystem. (Assuming it uses tmpfs under the hood (or supports
> >> xattrs), otherwise you may need to mount tmpfs somewhere and chroot
> >> into it at the beginning of your init script. Or something like
> >> that...)
> >>
> >> --
> >> Ondrej Mosnacek
> >> Software Engineer, Platform Security - SELinux kernel
> >> Red Hat, Inc.
> >>
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
