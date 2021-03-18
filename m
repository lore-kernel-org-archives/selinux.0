Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929C0C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5474A64E64
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCRN6j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 09:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhCRN6K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 09:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jgR9P6jXbSYMZFd8LHTG7QkBS3y37YvafT4UHNYN44=;
        b=cBWuSllPSB0Bxkl1FW5sXSfqhnIK1EpE7QvWIYFwt1ZHaxDrDR2Nt0tbPNXk06x3g7XXCX
        GU5d+Uy3Wt8zvfKbMD/+Ym9Kj1/Gah7KnYtOshRJbJoV20MuXGz56NWrV6umPwzDMcCtar
        FAEKxJALPLS21LsC1N0KSbDUd0T5dQA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310--wKLRn7mPNyOvxJj8NfsHw-1; Thu, 18 Mar 2021 09:58:06 -0400
X-MC-Unique: -wKLRn7mPNyOvxJj8NfsHw-1
Received: by mail-yb1-f199.google.com with SMTP id k189so9687062ybb.17
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 06:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jgR9P6jXbSYMZFd8LHTG7QkBS3y37YvafT4UHNYN44=;
        b=RszZ6mclY4Wn0asISje4JkytBR+dlVHpLAOhvPbgsx2aCyO4+gzCvCpYVFgRpqshdN
         v5xsJtmsXqAIq4jARjrsxEm3KmoidsXt0Q5Fj0rnMVkgecLAl6RRErcUFaYTM3djh+F6
         cZZrwsnARAAAIjjS0C4Z42dvXOFiXapPDpGO6ZHrCTWrC9JybelAm0UhkU6aMIDCgSg1
         VoN3cPzfFSEAKGTwUizGlF2xwx0Hrio9wkGKFokqiwp+LSolHbrVg548NN9qWBjk7IAb
         IetU9Dc8z1/DHDIS02PlC/t4FPtTZr8JU7NUvngQMJgw3ZnO+yppIYoIPifa75pO5mqQ
         VvaQ==
X-Gm-Message-State: AOAM533tTmo3d7usr25cqSOBbIEawrGpb/y3LVpjVM1QF+O9PnHxkRRF
        8dG2ZT04CHe8iXM8IldntjklI/xy9nHcbXv23ite5feJ4v6K+MMerj2QrrGOnu3vH6BELHiGwRc
        EhULWBpQ33/IA/g+HO9kTNC0aOHUuzbib2Q==
X-Received: by 2002:a5b:4a:: with SMTP id e10mr12107227ybp.436.1616075885891;
        Thu, 18 Mar 2021 06:58:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6iENcOP9Iytb2p/EfsHP6bxrvV0bORQGQGChlmVaavuao4Xi0oHqdPx9N2LVgYbrTKoELebDj3q69Pz/ewFY=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr12107202ybp.436.1616075885678;
 Thu, 18 Mar 2021 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
 <CAN-5tyGz2HRq9Y7OcBDLQ4K+=d_oPe4nOQ+VM7QGU27ksJi6EQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGz2HRq9Y7OcBDLQ4K+=d_oPe4nOQ+VM7QGU27ksJi6EQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Mar 2021 14:57:53 +0100
Message-ID: <CAFqZXNucLwmqLA1doWp+0hnz1oTCoaNEb-jorAjpUurAu-Jf9Q@mail.gmail.com>
Subject: Re: Weird bug in NFS/SELinux
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 2:43 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Thu, Mar 18, 2021 at 5:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hello,
> >
> > While trying to figure out why the NFS tests in the selinux-testsuite
> > [1] are failing, I ran into this strange bug: When I mount an NFS
> > filesystem on some directory, and then immediately attempt to create
> > exactly the same mount on the same directory (fails with -EBUSY as
> > expected per mount(2)), then all the entries inside the mount (but not
> > the root node) show up as unlabeled
> > (system_u:object_r:unlabeled_t:s0). For some reason this doesn't
> > happen if I list the directory contents between the two mounts.
> >
> > It happens at least with kernels 5.12-rc2 and 5.8.6, so it's likely an old bug.
> >
> > Minimal reproducer (assumes an SELinux-enabled system and that nothing
> > is mounted at /etc):
> > ```
> > # set up a trivial NFS export
> > systemctl start nfs-server
> > exportfs -o rw,no_root_squash,security_label localhost:/
> >
> > #
> > # reference scenario - single mount
> > #
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> >
> > ls -lZ /mnt    # labels are correct
> > ls -lZd /mnt   # label is correct
> >
> > #
> > # double mount - BUG
> > #
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> >
> > ls -lZ /mnt    # all labels are system_u:object_r:unlabeled_t:s0
> > ls -lZd /mnt   # label is correct
> >
> > #
> > # double mount with ls in between - OK
> > #
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > ls -lZ /mnt    # labels are correct
> > ls -lZd /mnt   # label is correct
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> >
> > ls -lZ /mnt    # labels are correct
> > ls -lZd /mnt   # label is correct
>
> Hi Ondrej, a couple of questions about the reproducer. (1) are you
> saying that only "mount, mount, ls" sequence is problematic as you
> write "mount, ls, mount, ls" is correct? (2) what is your selinux
> configuration. I can't reproduce it on my setup. I get the same labels
> regardless of how many times I mount.

(1) Yes, exactly.
(2) I reproduced it reliably on clean Fedora VM images (e.g. Fedora 33
or Rawhide, both showed this bug).

>
>
> > ```
> >
> > I haven't had time to dig deeper. Hopefully someone who knows the
> > internals of NFS will be able to find the root cause easier than me...
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> >
> > --
> > Ondrej Mosnacek
> > Software Engineer, Linux Security - SELinux kernel
> > Red Hat, Inc.
> >
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

