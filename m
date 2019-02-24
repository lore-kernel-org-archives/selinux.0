Return-Path: <SRS0=tF6o=Q7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973AC43381
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96C20878
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 22:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBXWgu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Feb 2019 17:36:50 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41757 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBXWgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Feb 2019 17:36:50 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B7AB35646AE
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 23:36:46 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id q81so5815054oic.5
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 14:36:46 -0800 (PST)
X-Gm-Message-State: AHQUAuYnoss/PSa0rRYxJmI6k0IXzeSOo4U/Ee/aa3RuaaFB+T6P+aS7
        hMh6vr3aY6dIlR1t+Anz3QvlYWoopgZLyKZPlZw=
X-Google-Smtp-Source: AHgI3Iamr5q9z15BJwfXrUwbln3q9ECuu3+B7Td++/kRXdUsiXCSx+MYKM0acpjavBuhdYrm0GLuhteMyuNaNoSWgLU=
X-Received: by 2002:aca:c3cb:: with SMTP id t194mr8958693oif.70.1551047805527;
 Sun, 24 Feb 2019 14:36:45 -0800 (PST)
MIME-Version: 1.0
References: <7853167.K65cXu0y11@neuromancer>
In-Reply-To: <7853167.K65cXu0y11@neuromancer>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 24 Feb 2019 23:36:34 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m4Nv5ynUPhekij+Bn4MXOw6xm9x27mFERZ3+Xw9X7Ojw@mail.gmail.com>
Message-ID: <CAJfZ7=m4Nv5ynUPhekij+Bn4MXOw6xm9x27mFERZ3+Xw9X7Ojw@mail.gmail.com>
Subject: Re: wildcards in file_contexts.subs for NixOS
To:     Russell Coker <russell.coker@daisee.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 24 23:36:47 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 22, 2019 at 5:26 AM Russell Coker <russell.coker@daisee.com> wrote:
>
> https://nixos.org/
>
> The NixOS distribution of Linux is based on having hashes of packages in the
> path names.
>
> /nix/store/l2b7y9waqwp4i1f03899yfsmzk8i7rid-shadow-4.5/bin/usermod
> /nix/store/l2b7y9waqwp4i1f03899yfsmzk8i7rid-shadow-4.5/bin/vipw
> /nix/store/lvrxkcf4b398nyiayknsqr44p8pl51s9-drbd-8.4.4/bin/drbdadm
> /nix/store/lvrxkcf4b398nyiayknsqr44p8pl51s9-drbd-8.4.4/bin/drbdsetup
> /nix/store/mzxhj1cxrhbqvsga4155xhw44iigwxxs-shadow-4.5-su/bin/su
> /nix/store/n3d4l234fppvz40jjyqlxa1jxglzbs48-xen-4.8.2/bin/xenconsoled
> /nix/store/n3d4l234fppvz40jjyqlxa1jxglzbs48-xen-4.8.2/bin/xenstored
> /nix/store/n3d4l234fppvz40jjyqlxa1jxglzbs48-xen-4.8.2/bin/xl
> /nix/store/n419slr5x6h4ydk2dd56nkwki7qpkf6v-fuse-2.9.7/bin/fusermount
> /nix/store/n419slr5x6h4ydk2dd56nkwki7qpkf6v-fuse-2.9.7/bin/mount.fuse
> /nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/libvirtd
> /nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/virsh
> /nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/virtlockd
> /nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/virtlogd
> /nix/store/pr94n9l1kvpiqilhjr308xbr8qmzilih-extra-utils/bin/blkid
> /nix/store/pr94n9l1kvpiqilhjr308xbr8qmzilih-extra-utils/bin/dmsetup
> /nix/store/pr94n9l1kvpiqilhjr308xbr8qmzilih-extra-utils/bin/e2fsck
>
> Above is a random sample of binaries that need labelling on a NixOS system.
> Before anyone asks, the naming of such paths is core to the way NixOS works,
> requesting a change in that regard is not viable.
>
> NixOS can run as a full OS (managing grub etc) or it can run on a system
> running a regular Linux distribution.  Running as a full OS or as a labelled
> chroot are the use cases that interest me.
>
> semanage fcontext -a -e / "/nix/store/*"
>
> setfiles -r /chroot/nix /etc/selinux/default/contexts/files/file_contexts \
> /chroot/nix/store -v
>
> I've written a patch to support commands like the above to label a Nix store
> (the above is a chroot example but the next step is to get full SE Linux
> support in NixOS).
>
> I've attached the patch.  I don't expect this version to be accepted upstream
> as-is.  But it's a place to start the discussion about how to approach this
> problem.
>
> Russell Coker
>
> PS Please use my personal address russell@coker.com.au for SE Linux
> discussions unrelated to NixOS.

Hello,

I agree it would be nice to be able to use SELinux on NixOS, and that
the first step consists in handling the file paths that are very
specific to this distribution. The patch you submitted adds the
support of source file contexts ending with "/*", but it does not
allow things like "match /chroot/nix/*/bin and replace it with
/usr/bin". This could be solved in several ways. The most
straightforward way probably consists in making selabel_sub_key() call
selabel_sub() several times, until no substitution occurred. An other
possibility could consist in using fnmatch() or regexp to match the
source pattern of substitution files, but I guess this would impact
performance too much.

I agree with adding support of source entries ending with "/*" in file
context substitution files. If others agree with this, for the next
iteration of the patch I suggest naming the new member of struct
selabel_sub "ends_with_star" instead of "wildcard". This would make
the code easier to understand.

Thanks,
Nicolas

