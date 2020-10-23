Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2DC388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258BE20BED
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 22:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLOB/T58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757768AbgJWWk1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757766AbgJWWk1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 18:40:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6FC0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 15:40:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g13so1652497qvu.1
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aKtHixNRS1IqKyLIC1qMKi8Ri75H4X8q8IDufXwhihg=;
        b=mLOB/T58z8N78630p+zHZebxSU8u7/2cWK85QGATfR6xZ3R9QFc2vcFJ70kSwNcjxt
         BzmjJRkZjH61HMrs71dqTp6YY+Z1tQB4IVT2lpUp/a0+VwIyP1cTvQ15WgYnGRqUH9Gn
         NvgwKjcc0+1TEaftb5dVyUXS/sd30Y3a9bgkotG4paJPPc7Hf0aYa9cRDg0Gbw7yPNkO
         yUBfXekIDXt4wDyzzre8OgYSS8Rj74RTq9DdqmPQG/ZtWLSpcVXixsgPSzh4V7AnunMs
         4QIj1L01CRdNdD5yw1bGkMeAc0IwnBKplweqvLChc1Kod1QTfZSZ9PXU/kp/9nKsSBSj
         GDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aKtHixNRS1IqKyLIC1qMKi8Ri75H4X8q8IDufXwhihg=;
        b=EitFCcQKdafGdiu5ICXk/m+MK7YCXWjTvLpj1LYbJ2Adm1agB1+QzAgyR+7iv0SVKC
         +7lNt2lrAPcLPvytFB05DAR+8Q/un24FuDjz5W6GArbBxoTts8mfYojOP06nEtgiiYb0
         cgUqf+yAO/5ZnEdtcniF28WDfckm+IyWT0HDOiihODUclNez5fkuRaU5Lh8PbNLHp1kH
         Sw7bzKyGfdVM3sQg3yGbab/epxaKd+CvpJH0EghLtkpwDVHfpzQsgYjPS4NWuxgUBgtI
         C50lMC5bJlehVfyULPSNLBc34uoh5y41KiEjCLxwTyD+Et/FbcJ8TJGR2aqFWp2atsOK
         8tvQ==
X-Gm-Message-State: AOAM531MQvGGQqZ2909LR13b7FFXEiIxHim7gFv85r/eWln1Jizkvt+E
        7dUDGlccJX9tcYjcXdE3VXC86r8tZXVTxA==
X-Google-Smtp-Source: ABdhPJySAF2xMG8XnMgfIskK4FluraqofwyZR5BG8zJ3uLotiMRCG7b0ry1fp//DEvSx9+hVYYqO8A==
X-Received: by 2002:ad4:4141:: with SMTP id z1mr4925543qvp.33.1603492826329;
        Fri, 23 Oct 2020 15:40:26 -0700 (PDT)
Received: from ?IPv6:2601:588:c500:7:7449:4d1b:9c31:364a? ([2601:588:c500:7:7449:4d1b:9c31:364a])
        by smtp.gmail.com with ESMTPSA id a3sm1911058qtp.63.2020.10.23.15.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 15:40:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Ian M <merinian@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: How to avoid relabeling rootfs at every boot
Date:   Fri, 23 Oct 2020 18:40:24 -0400
Message-Id: <B129404A-41AA-4803-91CA-3F110BAE26BF@gmail.com>
References: <CAFftDdpdSwCB4jZn22cSeTHiwPmsZPUZMhtAYardTouAcgxpmA@mail.gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
In-Reply-To: <CAFftDdpdSwCB4jZn22cSeTHiwPmsZPUZMhtAYardTouAcgxpmA@mail.gmail.com>
To:     William Roberts <bill.c.roberts@gmail.com>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks again, this is all very helpful.

One point is that while the cpio format does not support extended attributes=
 the actual ram disk that is mounted by Linux does.   Not sure if that chang=
es your answer any.

Thanks,

Ian

> On Oct 23, 2020, at 6:37 PM, William Roberts <bill.c.roberts@gmail.com> wr=
ote:
>=20
> =EF=BB=BFOn Fri, Oct 23, 2020 at 5:20 PM Ian M <merinian@gmail.com> wrote:=

>>=20
>> Thanks, cpio supporting extended attributes would be very helpful right n=
ow.
>>=20
>> After looking through the ref policy I see there is a genfscon statement f=
or rootfs which is what is labeling everything as root_t.
>=20
> Yeah, genfscon is the way to say, hey this filesystem, all things have
> this label. genfscon takes paths, for more specific labelling,
> IIRC, cannot be used on rootfs; that feature only works for proc/sysfs
> like pseudo filesystems.
>=20
>>=20
>> Would I break everything terribly if I removed that and setup an fs_use_x=
attr for the rootfs?
>=20
> Yes because there is no xattr support, so it would choke and die when
> the kernel wants the xattr.
>=20
> Here's some other things to consider:
> 1. There is no xattr support. You would need to see if that patch or
> something equivalent was accepted and then what kernel
>    version, and determine if your kernel supports it. Then at build
> time for the image you would have to create that dotfile that contains
> the
>    labels and package it in the CPIO archive. Then you could use the
> fs_use_xattr IIUC.
> 2. I could be mistaken, but I think in recent years I have seen
> patches or articles that other FS types can be used for the initial
> root filesystem
>    now without a need for initrd, so you could, IIUC, boot directly
> into a labelled ext4 filesystem. You would have to label that file
> system during build.
> 3. Most linuxt things boot into an initrd and then pivot to the actual
> root filesystem, you could do that as well.
>=20
> This would take some digging likely to figure out, or find someone
> that knows way more than me. That shouldn't be too terribly hard,
> I don't know much.
>=20
>>=20
>>=20
>> Thanks,
>>=20
>> Ian Merin
>>=20
>>>> On Oct 23, 2020, at 3:49 PM, William Roberts <bill.c.roberts@gmail.com>=
 wrote:
>>>=20
>>> =EF=BB=BFOn Fri, Oct 23, 2020 at 2:05 PM James Carter <jwcart2@gmail.com=
> wrote:
>>>>=20
>>>>> On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> I hope this is the right list for this question:
>>>>>=20
>>>>> I've got an embedded system that uses its initramfs as its root filesy=
stem as well.  At boot, after the selinux policy loads, everything on the ro=
otfs is incorrectly labeled as system_u:object_r:root_t.   I have temporaril=
y worked around this by adding a restorecon on the rootfs at boot, but
>>>=20
>>> IIRC, when I worked on the Android integration we had to do the same
>>> thing. Android comes with it's own init in the ramdisk, so we just
>>> called restorecon on the parts of
>>> ramdisk that were of interest within the init daemon codebase itself.
>>> I don't think theirs anyway around that IIRC as the CPIO archive
>>> doesn't support xattrs.
>>>=20
>>> I do recall seeing this patchset:
>>> https://lwn.net/Articles/788922/
>>>=20
>>> I didn't look much into it, but if that got merged, you might be able
>>> to apply labels to ramdisk images.
>>>=20
>>>> since the rootfs is a ramdisk the changes do not survive a system reboo=
t.
>>>>>=20
>>>>> I may be incorrect, but my understanding (assumption?) is that the lab=
els would be applied when the policy is loaded at boot.  So I cannot underst=
and why the labels are always incorrect.
>>>>>=20
>>>> Filesystem labels are not applied when the policy is labeled. On
>>>> filesystems that support xattrs, a fs_use_xattr rule is used to tell
>>>> SELinux to use the label stored in the security.selinux xattrs, but
>>>> the filesystem will still have to be labeled initially. If the fs does
>>>> not support xattrs and every file can be labeled the same, then a
>>>> genfscon rule can be used.
>>>>=20
>>>> I am not sure of your exact case, but you can find more information in
>>>> the SELinux Notebook - See
>>>> https://github.com/SELinuxProject/selinux-notebook
>>>>=20
>>>> Jim
>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>>=20
>>>>> Ian
