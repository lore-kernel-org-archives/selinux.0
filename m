Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A85EC43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586A52086B
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 21:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586A52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeK1IEx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeK1IEx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 28 Nov 2018 03:04:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 566F4308A94F;
        Tue, 27 Nov 2018 21:05:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5AC5DD73;
        Tue, 27 Nov 2018 21:05:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 948752208FC; Tue, 27 Nov 2018 16:05:42 -0500 (EST)
Date:   Tue, 27 Nov 2018 16:05:42 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: overlayfs access checks on underlying layers
Message-ID: <20181127210542.GA2599@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 27 Nov 2018 21:05:43 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 27, 2018 at 08:58:06PM +0100, Miklos Szeredi wrote:
> [resending with fixed email address for Paul Moore]
> 
> Moving discussion from github[1] to here.
> 
> To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
> underlying layers") was added in 4.20-rc1 to make overlayfs access
> checks on underlying "real" filesystems more consistent.  The
> discussion leading up to this commit can be found at [2].  The commit
> broke some selinux-testsuite cases, possibly indicating a security
> hole opened by this commit.
> 
> The model this patch tries to follow is that if "cp --preserve=all"
> was allowed to the mounter from underlying layer to the overlay layer,
> then operation is allowed.  That means even if mounter's creds doesn't
> provide permission to for example execute underying file X, if
> mounter's creds provide sufficient permission to perform "cp
> --preserve=all X Y"  and original creds allow execute on Y, then the
> operation is allowed.  This provides consistency in the face of
> copy-ups.  Consistency is only provided in sane setups, where mounter
> has sufficient privileges to access both the lower and upper layers.

[cc daniel walsh]

I think current selinux testsuite tests are written keeping these
rules in mind.

1. Check overlay inode creds in the context of task and underlying
   inode creds (lower/upper), in the context of mounter.

2. For a lower inode, if said file is being copied up, then only
   check MAY_READ on lower. This is equivalent to mounter creating
   a copy of file and providing caller access to it (context mount).

For the case of special devices, we do not copy up these. So should
we continue to do check on lower inode in the context of mounter
(instead of not doing any check on lower at all).

For being able to execute a file, should we atleast check MAY_READ
on lower.

I am not sure why did we have to drop current checks on special file
and execute. I will read through the thread you pointed out.

Thanks
Vivek
