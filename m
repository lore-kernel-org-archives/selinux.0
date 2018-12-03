Return-Path: <SRS0=Et+u=OM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCDFC04EBF
	for <selinux@archiver.kernel.org>; Mon,  3 Dec 2018 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5D620850
	for <selinux@archiver.kernel.org>; Mon,  3 Dec 2018 21:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5D620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLCV4t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:56:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49008 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCV4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Dec 2018 16:56:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gTwCl-0001pC-Cp; Mon, 03 Dec 2018 21:56:39 +0000
Date:   Mon, 3 Dec 2018 21:56:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181203215639.GV2217@ZenIV.linux.org.uk>
References: <20181127115246.00967523@canb.auug.org.au>
 <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
 <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAFqZXNu_=MxcX5jvX4y=5nrCqi7_btOGVccbH1NZ=xm3TGvaYQ@mail.gmail.com>
 <CAFqZXNv642dfT0PpB0M7sO5J90cAM7Luv0A8nX7JtEXqw=yu1w@mail.gmail.com>
 <CAFqZXNuv_mF8Yt50J3giZjxzZX_WwCOePZeEtmR-G_m+vRyPrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNuv_mF8Yt50J3giZjxzZX_WwCOePZeEtmR-G_m+vRyPrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 03, 2018 at 11:12:59AM +0100, Ondrej Mosnacek wrote:

> I think I figured out what's the problem. NFS still creates the
> submount via the old vfs_submount() call, which calls
> vfs_kern_mount(), which creates an fs_context with
> FS_CONTEXT_FOR_USER_MOUNT because FS_CONTEXT_FOR_SUBMOUNT needs the
> mountpoint dentry reference and there is currently no way to pass that
> to vfs_kern_mount(). This is further complicated by the fact that
> vfs_submount() accepts only a const reference to the mountpoint, while
> vfs_new_fs_context() expects a non-const one...
> 
> I think all users of the old vfs_submount call should be converted to
> the new API before the VFS changes are merged into mainline, otherwise
> they will break the SELinux submount fix. We could work around it in
> the SELinux hook by checking the fc->sb_flags[_mask] for SB_SUBMOUNT,
> but I guess that would be a hack.

Could you take a look at vfs.git#Q28?  There's still a massive reshuffling
going on, so there will be more branches; this one is the latest at the
moment.

I really hate the situation around sb_clone_mnt_opts/sb_set_mnt_opts and
I'm none too fond of the way fs_context_validate is done, so there will
be quite a bit of LSM tweaking.  If we are doing that, let's do it
right...
