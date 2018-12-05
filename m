Return-Path: <SRS0=kQjT=OO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982CC04EB9
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B0F20892
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 16:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B0F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLEQQL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:16:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51598 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLEQQL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Dec 2018 11:16:11 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gUZqD-0006sq-IT; Wed, 05 Dec 2018 16:16:01 +0000
Date:   Wed, 5 Dec 2018 16:16:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181205161601.GW2217@ZenIV.linux.org.uk>
References: <20181127115246.00967523@canb.auug.org.au>
 <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
 <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAFqZXNu_=MxcX5jvX4y=5nrCqi7_btOGVccbH1NZ=xm3TGvaYQ@mail.gmail.com>
 <CAFqZXNv642dfT0PpB0M7sO5J90cAM7Luv0A8nX7JtEXqw=yu1w@mail.gmail.com>
 <CAFqZXNuv_mF8Yt50J3giZjxzZX_WwCOePZeEtmR-G_m+vRyPrQ@mail.gmail.com>
 <20181203215639.GV2217@ZenIV.linux.org.uk>
 <CAFqZXNvSOzyhnTUxF2mP4BTFMVQ8H1uh-Yyn2fH2K=4yRDX-tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNvSOzyhnTUxF2mP4BTFMVQ8H1uh-Yyn2fH2K=4yRDX-tQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 05, 2018 at 10:37:56AM +0100, Ondrej Mosnacek wrote:

> I just tested the Q28 branch rebased onto a recent Fedora rawhide
> kernel (4.20.0-0.rc5.git0.1) and that code seems to be working fine.
> The submount test failed with Q28 and succeeds with Q28+fix, as
> expected. Also, the overlay tests failures are gone now (except for
> the 4 known failures from GH issue #43, since I had to rebase onto
> 4.20-rcX).
> 
> This is the commit that I used as the SELinux submount fix:
> https://gitlab.com/omos/linux-public/commit/47922f9c70a83008388b836c285f94c40da1af2b

FWIW, I'm none too happy about the fix.  Observations:
	* sb_get_tree (and sb_kern_mount past the "LSM: lift parsing
LSM options into the caller of ->sb_kern_mount()" in this series)
is equivalent to sb_set_mnt_opts() + (for userland mounts) an selinux-only
MAC check.  IOW, application of options (for LSMs that have those
in the first place) + actual "are we permitted to mount that?" check.
	* the second part should be done only for userland mounts -
not automounting, not kernel-internal ones, etc.
	* a very common pattern is "vfs_get_tree, vfs_create_mount if we
hadn't failed that, then unconditional put_fs_context".  So much that it
clearly deserves a helper - too much boilerplate as it is.
	* look at the callers of vfs_get_tree():
1) afs_mntpt_do_automount(): submount, helper fodder.  No MAC.
2) nfs_do_submount(): submount, standalone, but caller will very shortly follow
with the rest of the helper.  No MAC.
3) btrfs_mount_root(): helper fodder, cloned context, probably no point
in the actual MAC - we are in ->get_tree(), the caller will decide if
it wants to bother.
4) do_nfs4_mount(): NFS counterpart of the above.
5) mount_one_hugetlbfs(): kernel-internal, helper fodder, no MAC.
6) pid_ns_prepare_proc(): kernel-internal, helper fodder, no MAC.
7) mq_create_mount(): kernel-internal, helper fodder, no MAC.

8) do_new_mount(): almost a helper fodder, wants MAC (mount(2) guts)
9) fsopen(2): standalone, wants MAC (it's mount(2)-equivalent)
10) vfs_kern_mount(): that's a bit more complicated.  It is, again,
a helper fodder.  The need of MAC depends upon the caller, in theory.
Callers:
	simple_pin_fs() - kernel-internal, no MAC
	init_mount_tree() - no MAC, that's the absolute root and that, by
definition, is much too early in the boot (before initramfs, etc.) for
any LSM shite to be applicable.  In any case, it's done by the kernel.
	kern_mount() - kernel-internal, no MAC
	cpuset_get_tree() - part of ->get_tree(), caller will decide if they
want the damn MAC.
	vfs_submount() - automounts, presumably no MAC.

Conclusion: fuck the MAC in vfs_get_tree().  Let's just lift it into
do_new_mount()/fsopen().  The only thing we really need there is to
keep ->s_umount held (exclusive) until after the MAC.  So let vfs_get_tree()
return with fc->root->d_sb->s_umount locked and have mount_create_mount()
(which is _always_ preceded by successful vfs_get_tree()), unlock the
sucker.  In vfs_get_tree() we need to do sb_set_mnt_opts(), with the
rest of it (selinux-only) called by do_new_mount()/fsopen(2).  All there
is to it...
