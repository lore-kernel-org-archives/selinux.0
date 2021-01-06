Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8735C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F10C2312F
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 16:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAFQRH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbhAFQRG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 11:17:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F60C06134C
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 08:16:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r7so2928967wrc.5
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 08:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BanXaS+GRC+mii5SlhoGjCVRoUt1/ezHIsHxxmoQYU=;
        b=fln/+McggUkDbmMChxWDjnXZVVtOCq0ZT00y8PCotxIQkgP4ZFhyathKH7MKVRxEN9
         IJzpsPfL8fLghNQBVAQNrHsNYLBuDBtW6/GdrmOBS5e+C0bIFZZfAG1Fps0tN61308YS
         R9+O46l3t0CE5nndPLnnhCG9TSvH5vCEyykfAzZzYY+0InuDT+KnJYq/RArXgNx2Enez
         ofRtEuDeReYoGUsE9F+K+2pSqos/OVhb+TlPpyokUdNhkOiGpTjqytcV06q0lNQO0jai
         823M2YH8MYw0pzm5T53O+TPaOc2PVcSCjpVhkF6BZr66lxFgRudHZbvQ683JHwM0d2wL
         bCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BanXaS+GRC+mii5SlhoGjCVRoUt1/ezHIsHxxmoQYU=;
        b=JlZjcUF7xVjzJlE+7JGnDhWAkaVoD89DNnOnCwUhs2Bvwb2Iv8CI859tKmmpiHSkBt
         W4P8G41dtKP+XJfxPx4meNecv8TADDNLY5wjT0ObqYlVFncsTHhmZ5yM0bKYZwCxxhFr
         pL7s4n3MjH11AC4ASLLZ9E6fw64uh6vNJVpgBKW8Io8HApkMNh2kF4L6K1gSb0G7ecAp
         ZP55LYLqUzswSs1wN2bls8AxjfMPv3uwuLxZbUSME9fTZIIoa58EnsICO9Q8v+GO622T
         2p2+kpKwtM4lRAWTAeeIAYJLgvCBCiKciPXLQ/mKhMPjWGC9URW3woGRubrZq9QXSDTN
         cmDg==
X-Gm-Message-State: AOAM530US8JumL8qx3OMJraRkZmZNxylWkukVJA5sKOgnX94hTFwpTpK
        XwodThGKk5dZN44akQnvU9Z3TscOKmHX1sVZCMEsBc+DL7oCiQ==
X-Google-Smtp-Source: ABdhPJyYJlQJoUiU9ghUyAgW8xsoXfq0a/SH6KuPuIr9seQ4Pbc2hMUP2uk2pHiDsgdw1AI8f58F3ngEtUAAdGrNR4A=
X-Received: by 2002:adf:84c1:: with SMTP id 59mr5161073wrg.409.1609949784915;
 Wed, 06 Jan 2021 08:16:24 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl> <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
 <ypjlv9cc50hj.fsf@defensec.nl> <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
 <ypjla6tmgoka.fsf@defensec.nl> <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
 <ypjl5z4agmt4.fsf@defensec.nl> <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
 <ypjlsg7ef6nh.fsf@defensec.nl> <CAP2Ojcg5d=i0FKM0f1DTqtT2N3ftKEEqJq4=zdZr4m22xn4zjA@mail.gmail.com>
 <ypjlo8i2f519.fsf@defensec.nl> <CAFqZXNuUdij1v4yvSvpLJPi+0KSFSR46k+c52E3=QdF-f_C9yQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuUdij1v4yvSvpLJPi+0KSFSR46k+c52E3=QdF-f_C9yQ@mail.gmail.com>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Wed, 6 Jan 2021 21:46:13 +0530
Message-ID: <CAP2Ojci+UGvCCr6XMHYvm6jCr4p9GmwM3j97ZFLoqB2prNH4gQ@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dominick / Ondrej ,

Thanks for valuable inputs , I will try to evaluate them .

Ashish

On Wed, Jan 6, 2021 at 9:30 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Jan 6, 2021 at 4:40 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> > Ashish Mishra <ashishm@mvista.com> writes:
> >
> > > Hi Dominick ,
> > >
> > > Will look at the re-labelling as you suggested.
> > > Is there any doc / blog / implementation etc to understand the
> > > sequence and commands to do this.
> > > To understand this step in a better way.
> > >
> > > We are working with such a setup freshly so any inputs / guidance will
> > > be helpful.
> > >
> > > Thanks for your time & inputs for this long thread .
> >
> > For docs i would suggest selinuxproject.org and
> > https://github.com/SELinuxProject/selinux-notebook/blob/main/src/toc.md
> >
> > For implementations i would suggest looking at how OpenWrt implemented
> > SELinux as this is a very simple implementation and the target seems to
> > be relatively similar to yours with the exception that OpenWrt does not
> > use a volatile root but instead uses a read-only squashfs and a overlay.
> >
> > You can also look at Fedora CoreOS for inspiration, and Googles SEAndroid.
> >
> > Implementing meaningful SELinux for exotic use cases like yours is not
> > trivial though IMHO. Using reference policy as a base-policy might not
> > be optimal for your use-case (to say the least) and it would probably be easier to create a
> > policy from scratch instead in the longer run.
>
> Well said. I'll just add that you'll at the very least need to remove
> the "genfscon" rule for "rootfs" from your policy and replace it with
> an appropriate "fs_use_xattr" one to be able to relabel the root
> filesystem. (Assuming it uses tmpfs under the hood (or supports
> xattrs), otherwise you may need to mount tmpfs somewhere and chroot
> into it at the beginning of your init script. Or something like
> that...)
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
