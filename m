Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2159C7618B
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1C2229F9
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld4bxdAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGZK35 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:29:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38941 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfGZK35 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 06:29:57 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so103784100ioh.6
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2019 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wB26m8yUz8iRiEYc8sRBoM06jyQ/xqdK3z7G9qs7vG0=;
        b=ld4bxdAHY8a0RDWGfEW4rJNCj0blxWQe9Jw5is2cmvwIPc/cc+Cmm7iJ0Q6HqU+85a
         VC8fHKIspyaa9TQVC5997aJ3/QZ52Ole/juFp6mgE7mwZQzSPAiwAknrsUEtLk+Y2Je4
         ZnmFeLxtEHZNM7vsh0xh+hyeAkBqwEFysuhCMKcwfsHQrusuXqW2uvbvLe7E4AmAI7GU
         2sco4q4Jq/EDyw1N3ttiP1sOyrjdEnanCBc7I2EppEau/WtCQxIasqAsgDQ7LecnAY0d
         Vo6x2hn6pyhabdKdSOkWIcapwN7mDuA6H3XRKtdy1HO/BoAtGJ9q95RUlnR6+tV/PXnu
         WJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wB26m8yUz8iRiEYc8sRBoM06jyQ/xqdK3z7G9qs7vG0=;
        b=KBZm2Lw2ebN1yinGNgal2Iw1DVNegP51KBBcRuQWrkMx51AfRmf/DYspGDrix+exxu
         ADk7VWsA8tkEPTgAs1tEfbtz+hEzVmNsNBgsKr0svhe5xo1X5mBVo1Ch01JeAU3cIYwA
         qWtEPMxcptlnnhAZgsTkAUnvNR4vBeruRjQGZfZEdevixmA0MZwwq89q3KlbqV68P15E
         +Yp5Y/PU+SbhaSlOU8sEUuKRxMeQsooK3Vn5KsPbeQqnbNmBx229ZPBla+BQeB/680w5
         DsRCJtwlTAkytlLZSlS4oh5nwELndvBcv/n2YvmDXq9Zx+Obf9n5agJILEomgQighDvC
         6aJQ==
X-Gm-Message-State: APjAAAWLnA4J1cs6R//AE/ckWdz/lgt7EMCrEShY3zLsA/DS0c0ZZBtv
        qFOj5m65lsBmchnp02nCZreMt/PsdN66g8qqZqmt1/Jr5OfOAA==
X-Google-Smtp-Source: APXvYqxi3z8JDPaOud2HtvdQgfJlJfE3wmfutiWN45mcFR0HhlHjVRWnhozDB2ewsWwhRLAOGUUmgkZqoysjzMs7R0E=
X-Received: by 2002:a02:cd82:: with SMTP id l2mr95219316jap.96.1564136996315;
 Fri, 26 Jul 2019 03:29:56 -0700 (PDT)
MIME-Version: 1.0
From:   Claire Bocharova <claire.bocharova@gmail.com>
Date:   Fri, 26 Jul 2019 13:29:45 +0300
Message-ID: <CAF4UNDwgxPwEJ=pnEm6xKrXZuUoHWLWDxnqg-R9E11CfChhSvA@mail.gmail.com>
Subject: initramfs file-management
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

 Hello SELinux Devs.
  Long story short - currently trying to create custom dracut initramfs on
fedora 30 to prepare root mount, that requires creating/moving/copying files
between filesystems. As a result, with enabled SELinux, system ends up with
unlabeled_t edited files. After investigating a bit with rd.break, I found that
none of the utilities like "cp -Z" or "ls -Z" or "tar --selinux" working as
expected. First of I thought - missing libraries, maybe, so strace/ldd on a
working system and inside initramfs to compare, and all required files were
there, then rd.break with selinux=0 kernel boot option, and everything working
as expected, also, I tried load_policy inside initramfs, which also gives me
expected result - correct SELinux labels after file-management inside initramfs.
  So my question is - what exactly prevents user to view/edit SElinux context,
for example with getfattr/setfattr/ls-Z/tar--selinux, between
"kernel: SELinux: Initializing" and "load_policy" boot stages? Is it a
protection feature, and what I'm trying to achieve is a bad security design -
edit labels inside initramfs, or there is some tweak I don't know about.
  Right now it is reproducible with Fedora-Workstation-Live-x86_64-30-1.2.iso:
- rd.break -> ls -Z /sysroot/ == ?? || tar -xpzf --selinux == operation not
supported
- rd.break selinux=0 -> normal behavior
  Found previous discussion subjects like:
- [PATCH v2 14/15] selinux: allow setxattr on rootfs so initramfs code can set
them]
- [PATCH v2 15/15] selinux: delay sid population for rootfs till init is
complete
- overlayfs+selinux error: OPNOTSUPP
- SELinux with initramfs
- Where does linux kernel call initial policy load
- "star -xattr" in SELinux enabled system
  But some of them are quite outdated, so it would be really helpful to get
fresh tips from someone who sees the full picture.
  Thank you for your time.
