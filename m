Return-Path: <SRS0=Et+u=OM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ECAC04EB9
	for <selinux@archiver.kernel.org>; Mon,  3 Dec 2018 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF33C20672
	for <selinux@archiver.kernel.org>; Mon,  3 Dec 2018 10:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF33C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeLCKNe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:13:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41329 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeLCKNe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Dec 2018 05:13:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so11037520otk.8
        for <selinux@vger.kernel.org>; Mon, 03 Dec 2018 02:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ee5MzXKjsJApX3Q9g1W+pvCi2Bew74wyWbLRCwigAAM=;
        b=sHdL5FO9QhlYZCzyGYaNHmBVTOSEOvkjyPdHXOEVDQ2u3BdlsmEkR6kztgnsSqNcky
         1pb0vldCFHLybMwD6jsrbGN16hCgK9FSstvxaajXqcfWR9OOz5w7xAAqqJ/gyQRMEogM
         58urmAS8HxHfZoZxYyf4iTBhhVHR9L9YZrqVuUlHWPfahH/+3AYIGzDSQM5ajpkeRspm
         ow1yfK8luuBfpUlY/Ubaaq87EqwG0ZJp9lpPdAckUUZqwPHMuGBYyoEhrdviU2AqmQMU
         JpfhB8uDV3zLtFfn+b3crDIeatSfeHLUTIcxohOFgULbAADrPkVubIJSIbrolIhTE//d
         /6hg==
X-Gm-Message-State: AA+aEWaBlp0pSv0pSuAEk7ec8wRzKNe07vHxOiE2ynbwdvjpfTDFWdTw
        oPQPzbu7z0R6j53j2mPIyi1xray9AQKUKdm+VBB1tQ==
X-Google-Smtp-Source: AFSGD/Xoy2PHeY4UsNoSOBqeKEKp/HR6dLJHHDUcKuVMzqruldlRd8pOvVA9KOsP9NcxPH+3xGgQh3tvntegBeIfKic=
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr9406395otb.236.1543831990311;
 Mon, 03 Dec 2018 02:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au> <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAFqZXNu_=MxcX5jvX4y=5nrCqi7_btOGVccbH1NZ=xm3TGvaYQ@mail.gmail.com> <CAFqZXNv642dfT0PpB0M7sO5J90cAM7Luv0A8nX7JtEXqw=yu1w@mail.gmail.com>
In-Reply-To: <CAFqZXNv642dfT0PpB0M7sO5J90cAM7Luv0A8nX7JtEXqw=yu1w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Dec 2018 11:12:59 +0100
Message-ID: <CAFqZXNuv_mF8Yt50J3giZjxzZX_WwCOePZeEtmR-G_m+vRyPrQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 2, 2018 at 10:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Dec 1, 2018 at 10:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Nov 29, 2018 at 11:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Wed, Nov 28, 2018 at 10:52 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Nov 27, 2018 at 6:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > > Hi Ondrej,
> > > > >
> > > > > On Tue, 27 Nov 2018 09:53:32 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > >
> > > > > > Hm... seems that there was some massive overhaul in the VFS code right
> > > > > > at the wrong moment... There are new hooks for mounting now and the
> > > > >
> > > > > The mount changes have been in linux-next since before the last
> > > > > release ...
> > > > >
> > > > > > code that our commit changes is now here:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/security/selinux/hooks.c?h=for-next#n3131
> > > > > >
> > > > > > It seems that the logic is still the same, just now our patch (or the
> > > > > > VFS one) needs to be updated to change the above line as such
> > > > > > (untested pseudo-patch):
> > > > > >
> > > > > > - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> > > > > > + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))
> > > > >
> > > > > OK, so from tomorrow I will use that merge resolution.  Someone needs
> > > > > to remember to tell Linus about this when the latter of the vfs and
> > > > > selinux trees reach him.
> > > >
> > > > I will, or at least I'll do my best to remember; since we only have a
> > > > few more week until the merge window I like my odds.  FWIW, I
> > > > typically do a test merge on top of Linus' tree before sending the
> > > > SELinux PR just to verify that everything is relatively clean and
> > > > there are no surprises.
> > > >
> > > > Ondrej, please work with David Howells to ensure that submounts are
> > > > handled correctly in his mount rework.
> > >
> > > OK, I will verify that the SELinux submount fix rebased on top of
> > > vfs/work.mount in the way I suggested above passes the same testing
> > > (seliinux-testsuite + NFS crossmnt reproducer). I am now building two
> > > kernels (vfs/work.mount with and without the fix) to test. Let me know
> > > if there is anything more to do.
> >
> > I tested the proposed patch ([1]; fixed as per correction from David
> > Howells) applied on top of patches v4.19-rc3..vfs/work.mount applied
> > on top of the 4.19.5-300 Fedora 29 kernel.
> >
> > However, the submount test was still failing, so I looked again at the
> > list of the possible 'purpose' values and it turns out the value used
> > by NFS et al. is actually FS_CONTEXT_FOR_ROOT_MOUNT (it is actually
> > documented nicely in Documentation/filesystems/mount_api.txt). So I'll
> > need to build a new test kernel with updated patch ([2]) and retest...
>
> Unfortunately, even with FS_CONTEXT_FOR_ROOT_MOUNT the submount test
> is still failing. (Actually, re-reading the description for
> FS_CONTEXT_FOR_ROOT_MOUNT it seems it is not actually related to
> submounts, although we should probably still skip the check for it,
> too.) I will need to dig deeper into this on Monday...

I think I figured out what's the problem. NFS still creates the
submount via the old vfs_submount() call, which calls
vfs_kern_mount(), which creates an fs_context with
FS_CONTEXT_FOR_USER_MOUNT because FS_CONTEXT_FOR_SUBMOUNT needs the
mountpoint dentry reference and there is currently no way to pass that
to vfs_kern_mount(). This is further complicated by the fact that
vfs_submount() accepts only a const reference to the mountpoint, while
vfs_new_fs_context() expects a non-const one...

I think all users of the old vfs_submount call should be converted to
the new API before the VFS changes are merged into mainline, otherwise
they will break the SELinux submount fix. We could work around it in
the SELinux hook by checking the fc->sb_flags[_mask] for SB_SUBMOUNT,
but I guess that would be a hack.

>
> FWIW, the generated AVC denial is still the same so it must be failing
> the check in that particular hook (the FILESYSTEM__MOUNT permission is
> checked only in that single place):
>
> type=AVC msg=audit(02.12.2018 01:55:03.626:604) : avc:  denied  {
> mount } for  pid=4036 comm=cat name=/ dev="0:48" ino=2
> scontext=unconfined_u:unconfined_r:test_readnfs_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:nfs_t:s0 tclass=filesystem permissive=0
>
> >
> > BTW, the vfs/work.mount changes alone seem to cause some overlay test
> > failures (I didn't test a clean 4.19.5 so it may be due to some stable
> > patch as well):
> >
> > Test Summary Report
> > -------------------
> > overlay/test              (Wstat: 3072 Tests: 119 Failed: 12)
> >  Failed tests:  66, 74, 76-77, 79, 87, 95, 103, 108, 110-111
> >                117
> >  Non-zero exit status: 12
> >
> > The failing tests are all in the context mount section, but I don't
> > think this is (directly) related to [3] because there are much more
> > tests failing and the kernel I was testing didn't include the
> > problematic OverlayFS patch. Perhaps the VFS patches somehow broke the
> > parsing of the context= mount option?
> >
> > [1] https://gitlab.com/omos/linux-public/commit/fe5478717ddde92e3ea599e14051ad57522fdf47
> > [2] https://gitlab.com/omos/linux-public/commit/f5c58adc7babd62e4bfe8cda799459d263dc5186
> > [3] https://github.com/SELinuxProject/selinux-kernel/issues/43
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Associate Software Engineer, Security Technologies
> > Red Hat, Inc.
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
