Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC1C07E99
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FE7611F2
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhGIPab (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231976AbhGIPaa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jul 2021 11:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625844467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGgvRb7ldJO3RjHChSuXIroDn41KTYr6B2QiWafJ5SM=;
        b=gjIzwtvpRWlWUyHG2yMOfGneoEuqioSlCswA0naEFcaKTkDD1QdFu93dTmCh5CpTxsQBQa
        ACw56XlvikwazTEfWaiTsyGga696C8hkdrZh3NsDvfSxIfNk3m9du/ior80n3JWYS2G9rQ
        /ToKzaLok1UdntvUjavDmQNgUrsTdiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-nwwfoorGMTe-hi9eoWaHFQ-1; Fri, 09 Jul 2021 11:27:43 -0400
X-MC-Unique: nwwfoorGMTe-hi9eoWaHFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF09F1842154;
        Fri,  9 Jul 2021 15:27:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-62.rdu2.redhat.com [10.10.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11DEA5C1A3;
        Fri,  9 Jul 2021 15:27:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7364622054F; Fri,  9 Jul 2021 11:27:37 -0400 (EDT)
Date:   Fri, 9 Jul 2021 11:27:37 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210709152737.GA398382@redhat.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709091915.2bd4snyfjndexw2b@wittgenstein>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 09, 2021 at 11:19:15AM +0200, Christian Brauner wrote:
> On Thu, Jul 08, 2021 at 01:57:38PM -0400, Vivek Goyal wrote:
> > Currently user.* xattr are not allowed on symlink and special files.
> > 
> > man xattr and recent discussion suggested that primary reason for this
> > restriction is how file permissions for symlinks and special files
> > are little different from regular files and directories.
> > 
> > For symlinks, they are world readable/writable and if user xattr were
> > to be permitted, it will allow unpriviliged users to dump a huge amount
> > of user.* xattrs on symlinks without any control.
> > 
> > For special files, permissions typically control capability to read/write
> > from devices (and not necessarily from filesystem). So if a user can
> > write to device (/dev/null), does not necessarily mean it should be allowed
> > to write large number of user.* xattrs on the filesystem device node is
> > residing in.
> > 
> > This patch proposes to relax the restrictions a bit and allow file owner
> > or priviliged user (CAP_FOWNER), to be able to read/write user.* xattrs
> > on symlink and special files.
> > 
> > virtiofs daemon has a need to store user.* xatrrs on all the files
> > (including symlinks and special files), and currently that fails. This
> > patch should help.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> 
> Seems reasonable and useful.
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> One question, do all filesystem supporting xattrs deal with setting them
> on symlinks/device files correctly?

Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
symlink and device node on ext4, xfs and btrfs and it works fine.

https://github.com/rhvgoyal/misc/blob/master/generic-programs/user-xattr-special-files.sh

I probably can add some more filesystems to test.

Thanks
Vivek

> 
> >  fs/xattr.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 5c8c5175b385..2f1855c8b620 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -120,12 +120,14 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
> >  	}
> >  
> >  	/*
> > -	 * In the user.* namespace, only regular files and directories can have
> > -	 * extended attributes. For sticky directories, only the owner and
> > -	 * privileged users can write attributes.
> > +	 * In the user.* namespace, for symlinks and special files, only
> > +	 * the owner and priviliged users can read/write attributes.
> > +	 * For sticky directories, only the owner and privileged users can
> > +	 * write attributes.
> >  	 */
> >  	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
> > -		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> > +		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode) &&
> > +		    !inode_owner_or_capable(mnt_userns, inode))
> >  			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
> >  		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
> >  		    (mask & MAY_WRITE) &&
> > -- 
> > 2.25.4
> > 
> 

