Return-Path: <SRS0=kQjT=OO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8216EC04EBF
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAB52081C
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 13:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAB52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeLENnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbeLENnT (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 5 Dec 2018 08:43:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CDBC307DAA2;
        Wed,  5 Dec 2018 13:43:18 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F24919741;
        Wed,  5 Dec 2018 13:43:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A24FB2208FC; Wed,  5 Dec 2018 08:43:17 -0500 (EST)
Date:   Wed, 5 Dec 2018 08:43:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: overlayfs access checks on underlying layers
Message-ID: <20181205134317.GA11337@redhat.com>
References: <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
 <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
 <20181204151549.GA21509@redhat.com>
 <20181204152248.GB21509@redhat.com>
 <CAJfpegtFVvq286HAorGLg6ywMsfs51KqaQwFkcuV7Dtu8TLaLg@mail.gmail.com>
 <20181204154243.GA16818@redhat.com>
 <665ec6f3-f16d-681f-30d5-eface14c9808@tycho.nsa.gov>
 <20181204161747.GC16818@redhat.com>
 <e8841bf0-d6b8-0e7d-6a35-055a06441d30@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8841bf0-d6b8-0e7d-6a35-055a06441d30@tycho.nsa.gov>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 05 Dec 2018 13:43:19 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 04, 2018 at 11:49:16AM -0500, Stephen Smalley wrote:
> On 12/4/18 11:17 AM, Vivek Goyal wrote:
> > On Tue, Dec 04, 2018 at 11:05:46AM -0500, Stephen Smalley wrote:
> > > On 12/4/18 10:42 AM, Vivek Goyal wrote:
> > > > On Tue, Dec 04, 2018 at 04:31:09PM +0100, Miklos Szeredi wrote:
> > > > > On Tue, Dec 4, 2018 at 4:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > 
> > > > > > Having said that, this still create little anomaly when mknod to client
> > > > > > is not allowed on context label. So a device file, which is on lower
> > > > > > and client can not open it for read/write on host, it can now be opened
> > > > > > for read/write because mounter will allow access. So why it is different
> > > > > > that regular copy up. Well, in regular copy up, we created a copy of
> > > > > > the original object and allowed writing to that object (cp --preserve=all)
> > > > > > model. But in case of device file, writes will go to same original
> > > > > > object. (And not a separate copy).
> > > > > 
> > > > > That's true.
> > > > > 
> > > > > In that sense copy up of special file should result in upper having
> > > > > the same label as of lower, right?
> > > > 
> > > > I guess that might be reasonable (if this behavior is a concern). So even
> > > > after copy up, client will not be able to read/write a device if it was
> > > > not allowed on lower.
> > > > 
> > > > Stephen, what do you think about retaining label of lower for device
> > > > files during copy up. What about socket/fifo.
> > > 
> > > We don't check client task access to the upper inode label, only to the
> > > overlay, right?  So the client is still free to access the device through
> > > the overlay even if we preserve the lower inode label on the upper inode?
> > > What do we gain?
> > 
> > That's only with latest code and Miklos said he will revert it for 4.20.
> > 
> > IOW, I am assuming that we will continue to check access to a file
> > on upper in the context of mounter. Otherwise, client will be able to access
> > files on upper/ which even mounter can't access.
> 
> I was assuming we're talking about the proposed solution, where we check
> client access to the overlay (unchanged), mounter access to lower
> (unchanged), copy-up if denied (new), mounter access to upper (new in the
> sense that previously we didn't copy-up on denials).
> 
> In that situation, propagating the lower inode label to the upper inode only
> impacts the mounter checks, and in that case makes copy-up pointless - if it
> wasn't allowed to lower it won't be allowed to upper.  If it is allowed,
> then client task is free to access the device regardless as long as it has
> permissions to the overlay inode.  So I don't see what we gain by
> propagating the lower inode label to the upper inode in the context mount
> case, and it creates an inconsistency between special files and regular
> ones.

If we agree on retaining lower label of lower device file on copy up, then
I am assuming we will change rule c) to copy up only non device files.
(because if you don't have access on lower, you will not have access
even after copy up).

There are other paths where copy up happnes. Like link or when file 
metadata (ownership, permissions, timestmap) changes. In those cases,
if we retain the lower label over copy up, it probably will help.

IOW, just by creating a link to a device, one will not get access to
a device on upper which could not be accessed on lower.

Device files are special anyway. In regular files we are creating a 
copy and user writes to copy. But that's not the case with device
files. So I guess these will have to be treated differently.

Thanks
Vivek
