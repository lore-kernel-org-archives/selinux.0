Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5FC43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8E2081C
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 17:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC8E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeK2EFZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:05:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbeK2EFZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 28 Nov 2018 23:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B946430832C1;
        Wed, 28 Nov 2018 17:03:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 492307C281;
        Wed, 28 Nov 2018 17:03:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C61052208FC; Wed, 28 Nov 2018 12:03:02 -0500 (EST)
Date:   Wed, 28 Nov 2018 12:03:02 -0500
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
Message-ID: <20181128170302.GA12405@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 28 Nov 2018 17:03:05 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 28, 2018 at 11:00:09AM +0100, Miklos Szeredi wrote:
> On Tue, Nov 27, 2018 at 10:05 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 08:58:06PM +0100, Miklos Szeredi wrote:
> > > [resending with fixed email address for Paul Moore]
> > >
> > > Moving discussion from github[1] to here.
> > >
> > > To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
> > > underlying layers") was added in 4.20-rc1 to make overlayfs access
> > > checks on underlying "real" filesystems more consistent.  The
> > > discussion leading up to this commit can be found at [2].  The commit
> > > broke some selinux-testsuite cases, possibly indicating a security
> > > hole opened by this commit.
> > >
> > > The model this patch tries to follow is that if "cp --preserve=all"
> > > was allowed to the mounter from underlying layer to the overlay layer,
> > > then operation is allowed.  That means even if mounter's creds doesn't
> > > provide permission to for example execute underying file X, if
> > > mounter's creds provide sufficient permission to perform "cp
> > > --preserve=all X Y"  and original creds allow execute on Y, then the
> > > operation is allowed.  This provides consistency in the face of
> > > copy-ups.  Consistency is only provided in sane setups, where mounter
> > > has sufficient privileges to access both the lower and upper layers.
> >
> > [cc daniel walsh]
> >
> > I think current selinux testsuite tests are written keeping these
> > rules in mind.
> >
> > 1. Check overlay inode creds in the context of task and underlying
> >    inode creds (lower/upper), in the context of mounter.
> >
> > 2. For a lower inode, if said file is being copied up, then only
> >    check MAY_READ on lower. This is equivalent to mounter creating
> >    a copy of file and providing caller access to it (context mount).
> >
> > For the case of special devices, we do not copy up these. So should
> > we continue to do check on lower inode in the context of mounter
> > (instead of not doing any check on lower at all).
> 
> Hmm, I'm trying to understand the logic... If we follow the "cp
> --preserve=all" thing, than mounter needs to have CREATE permission
> for the special file, not READ or WRITE.  Does that make sense?  Would
> that help with the context= mount use case?

Ok. If we follow "cp --preserve=all" methodology, then checking for
mounter CREATE permission on upper for special files makes sense. Or
change logic to copy up this special file during open. I am assuming
we don't copy up special file during open as it is not necessary
for things to work but copying up will work as well?

So rules will become.

- Two levels of checks.
- For lower level inode, check MAY_READ for regular files. (including
  exec).
- For special files, only make sure mounter can CREATE object in upper.

- What about checks on files on upper/. As of now we seem to check
  access in mounter's context if it is regular file. Skip the checks
  completely for special files and for executables.

While non-context mount should still be ok, but this means lot of
privilige granting to unprivileged process using context mounts. So
unprivileged process which could not open a device/socket/fifo for
read/write on host fs, can open it for those operations for context
mounts. 

IOW, for context mount case, an unprivileged user will gain lot of
privileges. But that seems to be the point of context mount anyway
on regular disks. If a disk is mounted using context mount option,
then all real labels are ignored and all access checking happens
using context label. We are doing similar thing. With one step extra
and that is making sure if mounter itself can not do certain operation
on host, that will still be denied.

This probably means that context= mounts should be used very carefully.
It will grant lot of priviliges to the process (and allow operations
which process could not do on host without overlayfs mount).

Case of device file still baffels me though. We don't do any mounter's
checks on device files. So if a device file is on upper which mounter
can't open for read but mounter is still granting priviliges to client
to open that device file. That's unintutive to me and seems counter
to the principle of that mounter can't give more priviliges than what
it itself can't do on host.

Dan, stephen, paul moore, does this sound ok to you folks from selinux
point of view.

Thanks
Vivek

