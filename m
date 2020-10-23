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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C361DC388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 19:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554912192A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAa9P+6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754952AbgJWTtj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754934AbgJWTtj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 15:49:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C0C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 12:49:39 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n5so2539016ile.7
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SzWHKACsKZJsC3vtNfb1dcVCLQ9UtIS2F696ubq2nBk=;
        b=PAa9P+6hzZqqpVxsjkcEQe86143S/fQq8u7SLm0ucM/78+QjgP0N/T+Kj0nrYBK1OZ
         mgAOM1ODkQEDg12oGx6UJumTK3ML/ys5Xrs98H2JxMbw0nOtlS5FS7pMIOU8sWQahN0x
         S/fYJP/SB8aZicTpix8Ab1onXD6G+OOVlAp+qbIZXTByGTnu2w1xRCZAUw/wAVB7g+nk
         pSRpk+g2OOGUFc5ThP6nbTl4PUvULr9E1L1FS5z2htyVidUoedXO9RPN/n9OoIizcCq3
         XzEqdVeZAd0SzA6vZalGqUXH8eRWnHSX54tzhzJUwaXb+ROddrVRwZcAVON0EEOGnA+p
         Nytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SzWHKACsKZJsC3vtNfb1dcVCLQ9UtIS2F696ubq2nBk=;
        b=aBvfdYNEEAmeQL03vznYMHwGI5STQbyVVTkfRaMtIe+NI1wPP2TgqFOVkMB+P46rCP
         m2tH52EfrhJEIgSq/ofE4uOkj/BNZDtgmX3kyIRG+RkS/6dXmMcxVYdR6b0pWiDgbFzQ
         CsKypZ08NlbP+HadUxlSh38m90j+ccLg0Ut1016sqBvM6V2fjiWuVJMJdMpo3eMDsE4h
         tYQtT5W288BlDg7dQdrWDSj5r1omYAlKfk+twjeQeClnWlvcNSZKP2Ja1si/ZxYDe643
         I9v4wfpCH535/uO48M49sCMUWF0e3KMGTHBF13cY7YESNuG7omZzxKaiLx1uz51L8PPS
         U7PQ==
X-Gm-Message-State: AOAM532lYtAHUuJoTrGU+gPFrWYrmMglp3+tcbEELc95fVtZ2eh2aix9
        MZw9/1qie5wGiRxty0zBpUH1//xc7GId79eX8MrZ9q7R1HaPNw==
X-Google-Smtp-Source: ABdhPJy9KjOA69UNA2o/SCKxy2razc64FgrL2PWLvfRqSFURKpqQBViemaPXd/+EAKNl+YDlrvz/lz1tEBy0Ue9PO9M=
X-Received: by 2002:a92:1911:: with SMTP id 17mr2973436ilz.129.1603482578777;
 Fri, 23 Oct 2020 12:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <08E7D9BD-ACF8-4DDA-85A7-52F5C89B274F@gmail.com> <CAP+JOzTd21176V19FkvVzSyp_qDE3KOH3QbmXpou3YRuJ8drPQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTd21176V19FkvVzSyp_qDE3KOH3QbmXpou3YRuJ8drPQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 23 Oct 2020 14:49:27 -0500
Message-ID: <CAFftDdpW+Cj+vSUbb9RZV+3BTboWoW32TR9GaLU0p2Niu-yPhw@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     James Carter <jwcart2@gmail.com>
Cc:     Ian M <merinian@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 23, 2020 at 2:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
> >
> > Hello,
> >
> > I hope this is the right list for this question:
> >
> > I've got an embedded system that uses its initramfs as its root filesys=
tem as well.  At boot, after the selinux policy loads, everything on the ro=
otfs is incorrectly labeled as system_u:object_r:root_t.   I have temporari=
ly worked around this by adding a restorecon on the rootfs at boot, but

IIRC, when I worked on the Android integration we had to do the same
thing. Android comes with it's own init in the ramdisk, so we just
called restorecon on the parts of
ramdisk that were of interest within the init daemon codebase itself.
I don't think theirs anyway around that IIRC as the CPIO archive
doesn't support xattrs.

I do recall seeing this patchset:
https://lwn.net/Articles/788922/

I didn't look much into it, but if that got merged, you might be able
to apply labels to ramdisk images.

> since the rootfs is a ramdisk the changes do not survive a system reboot.
> >
> > I may be incorrect, but my understanding (assumption?) is that the labe=
ls would be applied when the policy is loaded at boot.  So I cannot underst=
and why the labels are always incorrect.
> >
> Filesystem labels are not applied when the policy is labeled. On
> filesystems that support xattrs, a fs_use_xattr rule is used to tell
> SELinux to use the label stored in the security.selinux xattrs, but
> the filesystem will still have to be labeled initially. If the fs does
> not support xattrs and every file can be labeled the same, then a
> genfscon rule can be used.
>
> I am not sure of your exact case, but you can find more information in
> the SELinux Notebook - See
> https://github.com/SELinuxProject/selinux-notebook
>
> Jim
>
> >
> > Thanks,
> >
> > Ian
