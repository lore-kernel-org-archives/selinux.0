Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7LN2SL022360
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 16:23:02 -0500
Received: by mail-qc0-f181.google.com with SMTP id w7so3179840qcr.40
 for <selinux@tycho.nsa.gov>; Fri, 07 Nov 2014 13:23:01 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/7] Security: Provide copy-up security hooks for unioned
 files
Date: Fri, 07 Nov 2014 16:22:58 -0500
Message-ID: <2455443.WUExuKDC0I@sifl>
In-Reply-To: <20141105154228.2555.55814.stgit@warthog.procyon.org.uk>
References: <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154228.2555.55814.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-unionfs@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, November 05, 2014 03:42:28 PM David Howells wrote:
> Provide two new security hooks for use with security files that are used
> when a file is copied up between layers:
> 
>  (1) security_inode_copy_up().  This is called so that the security label on
> the destination file can be set appropriately.
> 
>  (2) security_inode_copy_up_xattr().  This is called so that each xattr
> being copied up can be vetted - including modification and discard.

This didn't occur to me earlier, but we may want to pick a different phrase to 
use instead of "copy_up" as that has a special meaning for some security/MLS 
folks (although strangely enough, I suspect most of these copy-on-write 
operations will be "copy up" in the MLS sense of the word).

How about "security_inode_copy_overlay" or something like that?

> + * @inode_copy_up_xattr:
> + *	Filter/modify the xattrs being copied up when a unioned file is 
> ...copied
> + *	up from a lower layer to the union/overlay layer.
> + *	@src indicates the file that is being copied up.
> + *	@dst indicates the file that has being created by the copy up.
> + *	@name indicates the name of the xattr.
> + *	@value, *@size indicate the payload of the xattr.
> + *	Returns 0 to accept the xattr, 1 to discard the xattr or a negative
> + *	error code to abort the copy up.  The xattr buffer must be at least
> + *	XATTR_SIZE_MAX in capacity and the contents may be modified and 
> ....*@size
> + *	changed appropriately.

Just so I'm clean, if the LSM wanted to modify the xattr it would modify 
@value/@size and return 0?

-- 
paul moore
www.paul-moore.com
