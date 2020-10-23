Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD31C388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 22:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F53A2087D
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9v0MsHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757079AbgJWWUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757078AbgJWWUp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 18:20:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC688C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 15:20:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m65so2403060qte.11
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=mQZz7rXG5w9BI291gyKzXnuvjRjYdGDIbxM0GSTv2YA=;
        b=d9v0MsHb3pzo6QaCWfdt7pFj2vOPUsHFfd824pzf+bmnPjx8IPU4P4589+tAq5OhrN
         ilOoPyhDkbhdT1n7pcmLK0p6X4M1iRZt6efuW9gJH6sSF6No7kQGGbkzXD0WSqZOOyAk
         5aN37PFSTFlrkVjl/VfOxJXbDErqtDVQrkaOC+unouSV9ZcAijDRTYdyl0iEVbNSMOZu
         X1dF/ICXGlVQvosuQnvW1gn1GStKJoqJT4g6fUI09nrNZlkwPdiOJfuN90fVSGZV5EYk
         PBBeBX7zq431+VC/a4r5zkyT4bmkGZgiykaNNOxCEqbxwQ8Y5g+uNPrpdkn2j3yivDPn
         TX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=mQZz7rXG5w9BI291gyKzXnuvjRjYdGDIbxM0GSTv2YA=;
        b=cnxHmYsl6zoaUVNTzA6ulu6FCpvTKyAGNqqopET6H5rwcQiZL3a2Kh5QSJr2s50dIK
         ojwbQgrNxClWUWN008b8XRtLU0PHj+IRYosnJLJ/HFiXD3f6esNBpyfgp9u2GczTBUd3
         UuIjTZ6LMQo/URYJKQxrJx1HqvKtN+K/52Ns0tjolW+CG/yPvLsHUBRQ9jpLs7WXfUZl
         jB+hgtkCnxoS+uHyloc9av+NgAImq58ASSTAvhvU2UkCHntcpv9Lbr6jESCHhruBnpak
         jZe1tAuKMwF1iMWWHYb60Ybogea174w2Fg/QLdG7kXNW0B+QwFp9lmpK2fmBxgPhWFWg
         a3Yw==
X-Gm-Message-State: AOAM5333wQC+l0zVjQqtekga5Qacps+r7AlAIxeRIXUO8obbUBaPdjco
        7CcwXFGXNqnpxu78vmABuaNNU6axLkrDfg==
X-Google-Smtp-Source: ABdhPJxMOyB+y1yQzAVKzvDX45pnmQvpUa+MB+6YbINM7QnPJekd1x2ZA/meCcwup6TNcBmk9B35hQ==
X-Received: by 2002:ac8:5709:: with SMTP id 9mr4117872qtw.77.1603491644619;
        Fri, 23 Oct 2020 15:20:44 -0700 (PDT)
Received: from ?IPv6:2601:588:c500:7:7449:4d1b:9c31:364a? ([2601:588:c500:7:7449:4d1b:9c31:364a])
        by smtp.gmail.com with ESMTPSA id u15sm1894721qtj.75.2020.10.23.15.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 15:20:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Ian M <merinian@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: How to avoid relabeling rootfs at every boot
Date:   Fri, 23 Oct 2020 18:20:42 -0400
Message-Id: <5B9C0581-1FC8-4063-B245-CA30C68FA29B@gmail.com>
References: <CAFftDdpW+Cj+vSUbb9RZV+3BTboWoW32TR9GaLU0p2Niu-yPhw@mail.gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
In-Reply-To: <CAFftDdpW+Cj+vSUbb9RZV+3BTboWoW32TR9GaLU0p2Niu-yPhw@mail.gmail.com>
To:     William Roberts <bill.c.roberts@gmail.com>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks, cpio supporting extended attributes would be very helpful right now.=


After looking through the ref policy I see there is a genfscon statement for=
 rootfs which is what is labeling everything as root_t.

Would I break everything terribly if I removed that and setup an fs_use_xatt=
r for the rootfs?


Thanks,

Ian Merin

> On Oct 23, 2020, at 3:49 PM, William Roberts <bill.c.roberts@gmail.com> wr=
ote:
>=20
> =EF=BB=BFOn Fri, Oct 23, 2020 at 2:05 PM James Carter <jwcart2@gmail.com> w=
rote:
>>=20
>>> On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
>>>=20
>>> Hello,
>>>=20
>>> I hope this is the right list for this question:
>>>=20
>>> I've got an embedded system that uses its initramfs as its root filesyst=
em as well.  At boot, after the selinux policy loads, everything on the root=
fs is incorrectly labeled as system_u:object_r:root_t.   I have temporarily w=
orked around this by adding a restorecon on the rootfs at boot, but
>=20
> IIRC, when I worked on the Android integration we had to do the same
> thing. Android comes with it's own init in the ramdisk, so we just
> called restorecon on the parts of
> ramdisk that were of interest within the init daemon codebase itself.
> I don't think theirs anyway around that IIRC as the CPIO archive
> doesn't support xattrs.
>=20
> I do recall seeing this patchset:
> https://lwn.net/Articles/788922/
>=20
> I didn't look much into it, but if that got merged, you might be able
> to apply labels to ramdisk images.
>=20
>> since the rootfs is a ramdisk the changes do not survive a system reboot.=

>>>=20
>>> I may be incorrect, but my understanding (assumption?) is that the label=
s would be applied when the policy is loaded at boot.  So I cannot understan=
d why the labels are always incorrect.
>>>=20
>> Filesystem labels are not applied when the policy is labeled. On
>> filesystems that support xattrs, a fs_use_xattr rule is used to tell
>> SELinux to use the label stored in the security.selinux xattrs, but
>> the filesystem will still have to be labeled initially. If the fs does
>> not support xattrs and every file can be labeled the same, then a
>> genfscon rule can be used.
>>=20
>> I am not sure of your exact case, but you can find more information in
>> the SELinux Notebook - See
>> https://github.com/SELinuxProject/selinux-notebook
>>=20
>> Jim
>>=20
>>>=20
>>> Thanks,
>>>=20
>>> Ian
