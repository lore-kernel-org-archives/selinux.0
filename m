Return-Path: <SRS0=kQjT=OO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902BC04EBF
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1733F214E0
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1733F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeLEKLB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:11:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42376 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeLEJiJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Dec 2018 04:38:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so18008704otk.9
        for <selinux@vger.kernel.org>; Wed, 05 Dec 2018 01:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMSq+9IexiUAXwjqwSKEoQCdcR2ED4AOzXA2Wi0hNPU=;
        b=f8NjXiDzlPkMMBbv9q/kyAjfaUIJ424zHWPJf2Rf8jEk5nIDFMba5aMRSIxMtuWpIC
         0okzH4ZULfsiGBuN2BH0GMPQz6f+QlHL5WdtfgYg2T8c6+KC0JR6KMpA+ANIgpd6ok+M
         iQzgX0ewau731SKkWbU6TYYuobKXXgzucIsUOqAMg/FuEgtB5aCJ7qTmh8vfuDcC0yqs
         YIUzOscXEho3+Dzh0z43iNckcF6kCBtFhQWxACJTEtc1MVSUPk22UtHiG6QFEdUaYwgE
         AJuyO9bxaj3o8kkQqM1/cyUAEfI1+s5uUeLWpIJ16t68Rgn5sSs5PnkaUVPv48IX+KJJ
         zMeg==
X-Gm-Message-State: AA+aEWbVVDdOkVMrwZ+WNd6VQlY6hEO+/jI5SI+2i5VJzRjmQ3nZZnWx
        5nI49ZGIjrfuQrgCywtHpW1+l/tUj2mtH6918N3T3w==
X-Google-Smtp-Source: AFSGD/USzg0FgcmYZnrB3CswE5DFfWi+BssbmwDC9OZHf1iuj2KlhKCVrmFnSONuWfXv0W9RJ+ggeB0EPz0NQjl7pl8=
X-Received: by 2002:a9d:60cf:: with SMTP id b15mr14342785otk.144.1544002688115;
 Wed, 05 Dec 2018 01:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au> <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAFqZXNu_=MxcX5jvX4y=5nrCqi7_btOGVccbH1NZ=xm3TGvaYQ@mail.gmail.com>
 <CAFqZXNv642dfT0PpB0M7sO5J90cAM7Luv0A8nX7JtEXqw=yu1w@mail.gmail.com>
 <CAFqZXNuv_mF8Yt50J3giZjxzZX_WwCOePZeEtmR-G_m+vRyPrQ@mail.gmail.com> <20181203215639.GV2217@ZenIV.linux.org.uk>
In-Reply-To: <20181203215639.GV2217@ZenIV.linux.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 5 Dec 2018 10:37:56 +0100
Message-ID: <CAFqZXNvSOzyhnTUxF2mP4BTFMVQ8H1uh-Yyn2fH2K=4yRDX-tQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 3, 2018 at 10:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Dec 03, 2018 at 11:12:59AM +0100, Ondrej Mosnacek wrote:
>
> > I think I figured out what's the problem. NFS still creates the
> > submount via the old vfs_submount() call, which calls
> > vfs_kern_mount(), which creates an fs_context with
> > FS_CONTEXT_FOR_USER_MOUNT because FS_CONTEXT_FOR_SUBMOUNT needs the
> > mountpoint dentry reference and there is currently no way to pass that
> > to vfs_kern_mount(). This is further complicated by the fact that
> > vfs_submount() accepts only a const reference to the mountpoint, while
> > vfs_new_fs_context() expects a non-const one...
> >
> > I think all users of the old vfs_submount call should be converted to
> > the new API before the VFS changes are merged into mainline, otherwise
> > they will break the SELinux submount fix. We could work around it in
> > the SELinux hook by checking the fc->sb_flags[_mask] for SB_SUBMOUNT,
> > but I guess that would be a hack.
>
> Could you take a look at vfs.git#Q28?  There's still a massive reshuffling
> going on, so there will be more branches; this one is the latest at the
> moment.

I just tested the Q28 branch rebased onto a recent Fedora rawhide
kernel (4.20.0-0.rc5.git0.1) and that code seems to be working fine.
The submount test failed with Q28 and succeeds with Q28+fix, as
expected. Also, the overlay tests failures are gone now (except for
the 4 known failures from GH issue #43, since I had to rebase onto
4.20-rcX).

This is the commit that I used as the SELinux submount fix:
https://gitlab.com/omos/linux-public/commit/47922f9c70a83008388b836c285f94c40da1af2b

Kernel builds:
Unfixed Q28:  https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/833311/
Fixed Q28:  https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/833312/

Selinux-testsuite reports:
=== Q28 ===
Test Summary Report
-------------------
overlay/test              (Wstat: 1024 Tests: 119 Failed: 4)
  Failed tests:  81, 83, 107, 112
  Non-zero exit status: 4
submount/test             (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
Files=54, Tests=615, 117 wallclock secs ( 0.20 usr  0.04 sys +  1.64
cusr  1.29 csys =  3.17 CPU)
Result: FAIL
Failed 2/54 test programs. 5/615 subtests failed.

=== Q28 + FIX ===
Test Summary Report
-------------------
overlay/test              (Wstat: 1024 Tests: 119 Failed: 4)
  Failed tests:  81, 83, 107, 112
  Non-zero exit status: 4
Files=54, Tests=615, 117 wallclock secs ( 0.22 usr  0.05 sys +  1.54
cusr  1.37 csys =  3.18 CPU)
Result: FAIL
Failed 1/54 test programs. 4/615 subtests failed.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
