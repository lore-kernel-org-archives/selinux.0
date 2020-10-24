Return-Path: <SRS0=veDM=D7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E05FC2D0A3
	for <selinux@archiver.kernel.org>; Sat, 24 Oct 2020 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A8C21707
	for <selinux@archiver.kernel.org>; Sat, 24 Oct 2020 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrbPJH/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761907AbgJXOOL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 24 Oct 2020 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760052AbgJXOOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 24 Oct 2020 10:14:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D19C0613CE
        for <selinux@vger.kernel.org>; Sat, 24 Oct 2020 07:14:10 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w17so4140520ilg.8
        for <selinux@vger.kernel.org>; Sat, 24 Oct 2020 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YmhS/k8bofVCdB2Zm3kq5puAxrsHYUOyCFfdDyrFyfI=;
        b=DrbPJH/dWuimBFUvAYo8YQ6cBdCqDlbe+RL2rTMqmKXHBtqaeUt0zX2JH09msVJZ8E
         sLjl59MGzDlNUNgoCVBMjqhiJwyF09M2VUJzLRRoGPa8suynB548CwaIW+I6d3KXpxgr
         polEqeemLtYMs25LE3YqLtX0QbB8/1ZF8n3at8UYqPaaPYxPcU4VDmQGalZCH0qiBO4i
         zEFuYpANE1s2vciLFpFOqvevysPRde1fknrbZBjEGkMQKRoB4woa/dnJLYYGx9oFytZB
         CI2o2JwG6mAQIaVIMuCyq5T9KtrY42FOJ/kMjqRSBHQQqJcJV/Y4jvRWt2qHW00yw9XU
         +Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YmhS/k8bofVCdB2Zm3kq5puAxrsHYUOyCFfdDyrFyfI=;
        b=CRIVi2VVN+K7U3NikJb1CbASd9KndaRVKtPSXzeKDJnM8OKRa047REAfH38/0nunsz
         m3Qjz+15F1nb4K8CJPA70qAhzs+bi42KcvRi5c1DnUZh1zJ+RGWkbzHE/YbOmjPilq7P
         9tmAK3cfmfRDxzZx60vzG0vkvEbB5W3yxEiTssjNGd9qozhWHE/2092/Qdys3zDfv+0K
         Uu76BnHr6PJRUO2F/OYgXc4tIy6gQAevCPtxhJxfGehReUMzwettwel0UXEoLl2rW/0v
         cDDrvA55Vmlot1Dq2MOe++UBpNxlzOx/Ny+Tnnavd/trcg+oYBBrueLPlFXTLLj63jhH
         teMw==
X-Gm-Message-State: AOAM5300WTRN0maxGKdY0ygnEbIfc8BUFpYuDkfQtQKALJz/PoTdx7lY
        8GqecMEUBosOUSZf47LTmY47f0OhfoO0dhVQiik=
X-Google-Smtp-Source: ABdhPJxQ3ES/5Zj6iwMT12N//Z1Lnep7I4xSByIZlhbEwUMLRBw+GS3t28+E3yQLEhirwBPmUaZxHhQkEL7dZ32IByA=
X-Received: by 2002:a92:874a:: with SMTP id d10mr5154750ilm.163.1603548850238;
 Sat, 24 Oct 2020 07:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpdSwCB4jZn22cSeTHiwPmsZPUZMhtAYardTouAcgxpmA@mail.gmail.com>
 <B129404A-41AA-4803-91CA-3F110BAE26BF@gmail.com>
In-Reply-To: <B129404A-41AA-4803-91CA-3F110BAE26BF@gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sat, 24 Oct 2020 09:13:59 -0500
Message-ID: <CAFftDdqwLidE7bc9Z0jLmJwvvTtfWCbeGHnZ3kUMP=y5gUguEQ@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     Ian M <merinian@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 23, 2020 at 5:40 PM Ian M <merinian@gmail.com> wrote:
>
> Thanks again, this is all very helpful.
>
> One point is that while the cpio format does not support extended attribu=
tes the actual ram disk that is mounted by Linux does.   Not sure if that c=
hanges your answer any.

No because you need to populate the xattrs before the filesystem is
mounted and files are accessed. SELinux needs that information
*before* anything is allowed to happen.
The genfscon statement provides that initial label since the
filesystem is absent. So labelling for prebuilt images is usually done
during build time or paying the cost of a
restorecon at boot. In this case, everyboot since it doesn't persist.

>
> Thanks,
>
> Ian
>
> > On Oct 23, 2020, at 6:37 PM, William Roberts <bill.c.roberts@gmail.com>=
 wrote:
> >
> > =EF=BB=BFOn Fri, Oct 23, 2020 at 5:20 PM Ian M <merinian@gmail.com> wro=
te:
> >>
> >> Thanks, cpio supporting extended attributes would be very helpful righ=
t now.
> >>
> >> After looking through the ref policy I see there is a genfscon stateme=
nt for rootfs which is what is labeling everything as root_t.
> >
> > Yeah, genfscon is the way to say, hey this filesystem, all things have
> > this label. genfscon takes paths, for more specific labelling,
> > IIRC, cannot be used on rootfs; that feature only works for proc/sysfs
> > like pseudo filesystems.
> >
> >>
> >> Would I break everything terribly if I removed that and setup an fs_us=
e_xattr for the rootfs?
> >
> > Yes because there is no xattr support, so it would choke and die when
> > the kernel wants the xattr.
> >
> > Here's some other things to consider:
> > 1. There is no xattr support. You would need to see if that patch or
> > something equivalent was accepted and then what kernel
> >    version, and determine if your kernel supports it. Then at build
> > time for the image you would have to create that dotfile that contains
> > the
> >    labels and package it in the CPIO archive. Then you could use the
> > fs_use_xattr IIUC.
> > 2. I could be mistaken, but I think in recent years I have seen
> > patches or articles that other FS types can be used for the initial
> > root filesystem
> >    now without a need for initrd, so you could, IIUC, boot directly
> > into a labelled ext4 filesystem. You would have to label that file
> > system during build.
> > 3. Most linuxt things boot into an initrd and then pivot to the actual
> > root filesystem, you could do that as well.
> >
> > This would take some digging likely to figure out, or find someone
> > that knows way more than me. That shouldn't be too terribly hard,
> > I don't know much.
> >
> >>
> >>
> >> Thanks,
> >>
> >> Ian Merin
> >>
> >>>> On Oct 23, 2020, at 3:49 PM, William Roberts <bill.c.roberts@gmail.c=
om> wrote:
> >>>
> >>> =EF=BB=BFOn Fri, Oct 23, 2020 at 2:05 PM James Carter <jwcart2@gmail.=
com> wrote:
> >>>>
> >>>>> On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> I hope this is the right list for this question:
> >>>>>
> >>>>> I've got an embedded system that uses its initramfs as its root fil=
esystem as well.  At boot, after the selinux policy loads, everything on th=
e rootfs is incorrectly labeled as system_u:object_r:root_t.   I have tempo=
rarily worked around this by adding a restorecon on the rootfs at boot, but
> >>>
> >>> IIRC, when I worked on the Android integration we had to do the same
> >>> thing. Android comes with it's own init in the ramdisk, so we just
> >>> called restorecon on the parts of
> >>> ramdisk that were of interest within the init daemon codebase itself.
> >>> I don't think theirs anyway around that IIRC as the CPIO archive
> >>> doesn't support xattrs.
> >>>
> >>> I do recall seeing this patchset:
> >>> https://lwn.net/Articles/788922/
> >>>
> >>> I didn't look much into it, but if that got merged, you might be able
> >>> to apply labels to ramdisk images.
> >>>
> >>>> since the rootfs is a ramdisk the changes do not survive a system re=
boot.
> >>>>>
> >>>>> I may be incorrect, but my understanding (assumption?) is that the =
labels would be applied when the policy is loaded at boot.  So I cannot und=
erstand why the labels are always incorrect.
> >>>>>
> >>>> Filesystem labels are not applied when the policy is labeled. On
> >>>> filesystems that support xattrs, a fs_use_xattr rule is used to tell
> >>>> SELinux to use the label stored in the security.selinux xattrs, but
> >>>> the filesystem will still have to be labeled initially. If the fs do=
es
> >>>> not support xattrs and every file can be labeled the same, then a
> >>>> genfscon rule can be used.
> >>>>
> >>>> I am not sure of your exact case, but you can find more information =
in
> >>>> the SELinux Notebook - See
> >>>> https://github.com/SELinuxProject/selinux-notebook
> >>>>
> >>>> Jim
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Ian
