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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E33CC388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 22:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB522074A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 22:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUR84Rqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462487AbgJWWh3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461456AbgJWWh3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 18:37:29 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C23C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 15:37:29 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u62so3780551iod.8
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fe+esJEg9wSUQtS4l6GOWZkPWWfczptoItmgqO3B+6k=;
        b=tUR84RqcV+CmPd82vUfa7nosqUnLT1ocQONBiU02pVaZQYhaElT4mn3YG+KXymUP3E
         bbC0Ywo6wLnN5DsZK0z94wDyowtnyrvobPCHKc8NOPtuIhg7aMChxl336aGysTk2PbPN
         Vv+FGBASy7Z5k2JBdSERRWdvjRPclcHKS1uSqqvEI4fhqI0FvPDrV19Qre9/YcDBHl8F
         HQmrtmmy5Ad38nkkaAhlCW4oBVej7logtXz5THvCmj0eDK6WTm9OFlst3bHOUcK53pwS
         xxfGti5Rpu27QHlNqYQxUs/blmCKNE0YsU12B9NBa1sZerk8nGmoPW/c66qu/spA6rYD
         VURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fe+esJEg9wSUQtS4l6GOWZkPWWfczptoItmgqO3B+6k=;
        b=MigyS/IvFVdNZgwWYIHtp9UTBSisbFpzCKfy8K1FY5HmtuCKRejWgkqL6pqLLuP8mH
         0E/ogUEIjWD7JR52GG15+i4bCpGNa9Wn5sjMsLbH9T4HzEo1ZIrMLGONXRfFJraLfuvm
         jByG1PJ++lfXVa0dbWsAbTFLyVs1YAeBN9z/Y8E/3BEeL8dlICRh9uM2lGgmqbf06DUk
         y5ZBgl152Ob/wpuW2VPFa7XCRRbsWiuxuMozQ9Re/RvssdoJgLZ2axdY8Y6pjy57im1S
         KcwjsITG3+80DxF94dmsnrW+SkZtx2FRQl0wCA5rLDpmfyxU6pbFPjyJXC1hUux819FE
         O1jQ==
X-Gm-Message-State: AOAM530WI7akg0Likcy9EkJbVpM9xtatjpGmNWXHdzkm9N/6gzPZqQWr
        FEwqp23KOgSlGyY0yRkpl1Wh8ntGseWMBHJ5KPk=
X-Google-Smtp-Source: ABdhPJwr8jjYPTeAQIJ0ncp2U99l3ybtBCaeFnQTVApI7HHOzqmPKNxope3lSGLdcoR0mjiZ9CJNi5uL4Li4LQWtSSY=
X-Received: by 2002:a02:3e13:: with SMTP id s19mr3675220jas.61.1603492648819;
 Fri, 23 Oct 2020 15:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpW+Cj+vSUbb9RZV+3BTboWoW32TR9GaLU0p2Niu-yPhw@mail.gmail.com>
 <5B9C0581-1FC8-4063-B245-CA30C68FA29B@gmail.com>
In-Reply-To: <5B9C0581-1FC8-4063-B245-CA30C68FA29B@gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 23 Oct 2020 17:37:17 -0500
Message-ID: <CAFftDdpdSwCB4jZn22cSeTHiwPmsZPUZMhtAYardTouAcgxpmA@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     Ian M <merinian@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 23, 2020 at 5:20 PM Ian M <merinian@gmail.com> wrote:
>
> Thanks, cpio supporting extended attributes would be very helpful right n=
ow.
>
> After looking through the ref policy I see there is a genfscon statement =
for rootfs which is what is labeling everything as root_t.

Yeah, genfscon is the way to say, hey this filesystem, all things have
this label. genfscon takes paths, for more specific labelling,
IIRC, cannot be used on rootfs; that feature only works for proc/sysfs
like pseudo filesystems.

>
> Would I break everything terribly if I removed that and setup an fs_use_x=
attr for the rootfs?

Yes because there is no xattr support, so it would choke and die when
the kernel wants the xattr.

Here's some other things to consider:
1. There is no xattr support. You would need to see if that patch or
something equivalent was accepted and then what kernel
    version, and determine if your kernel supports it. Then at build
time for the image you would have to create that dotfile that contains
the
    labels and package it in the CPIO archive. Then you could use the
fs_use_xattr IIUC.
2. I could be mistaken, but I think in recent years I have seen
patches or articles that other FS types can be used for the initial
root filesystem
    now without a need for initrd, so you could, IIUC, boot directly
into a labelled ext4 filesystem. You would have to label that file
system during build.
3. Most linuxt things boot into an initrd and then pivot to the actual
root filesystem, you could do that as well.

This would take some digging likely to figure out, or find someone
that knows way more than me. That shouldn't be too terribly hard,
I don't know much.

>
>
> Thanks,
>
> Ian Merin
>
> > On Oct 23, 2020, at 3:49 PM, William Roberts <bill.c.roberts@gmail.com>=
 wrote:
> >
> > =EF=BB=BFOn Fri, Oct 23, 2020 at 2:05 PM James Carter <jwcart2@gmail.co=
m> wrote:
> >>
> >>> On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> I hope this is the right list for this question:
> >>>
> >>> I've got an embedded system that uses its initramfs as its root files=
ystem as well.  At boot, after the selinux policy loads, everything on the =
rootfs is incorrectly labeled as system_u:object_r:root_t.   I have tempora=
rily worked around this by adding a restorecon on the rootfs at boot, but
> >
> > IIRC, when I worked on the Android integration we had to do the same
> > thing. Android comes with it's own init in the ramdisk, so we just
> > called restorecon on the parts of
> > ramdisk that were of interest within the init daemon codebase itself.
> > I don't think theirs anyway around that IIRC as the CPIO archive
> > doesn't support xattrs.
> >
> > I do recall seeing this patchset:
> > https://lwn.net/Articles/788922/
> >
> > I didn't look much into it, but if that got merged, you might be able
> > to apply labels to ramdisk images.
> >
> >> since the rootfs is a ramdisk the changes do not survive a system rebo=
ot.
> >>>
> >>> I may be incorrect, but my understanding (assumption?) is that the la=
bels would be applied when the policy is loaded at boot.  So I cannot under=
stand why the labels are always incorrect.
> >>>
> >> Filesystem labels are not applied when the policy is labeled. On
> >> filesystems that support xattrs, a fs_use_xattr rule is used to tell
> >> SELinux to use the label stored in the security.selinux xattrs, but
> >> the filesystem will still have to be labeled initially. If the fs does
> >> not support xattrs and every file can be labeled the same, then a
> >> genfscon rule can be used.
> >>
> >> I am not sure of your exact case, but you can find more information in
> >> the SELinux Notebook - See
> >> https://github.com/SELinuxProject/selinux-notebook
> >>
> >> Jim
> >>
> >>>
> >>> Thanks,
> >>>
> >>> Ian
