Date: Wed, 30 Oct 2002 14:48:12 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brian May <bam@snoopy.apana.org.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
In-Reply-To: <200210301613.51096.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210301441331.12970-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, Russell Coker wrote:

> This means that I can't produce a single kernel-patch package that can be used
> by SE Linux, LIDS, and DTE users...

That isn't new; in prior releases, the SELinux-specific patch set the
SELinux option defaults in defconfig and set EXTRAVERSION to -selinux in
the top-level Makefile, so it wasn't appropriate for LIDS or DTE users
anyway.  [Are LIDS users now using the LSM kernel patch package, or are
they still using the separate LIDS package?  Are there any DTE users?]
For the separate SELinux patch to work for LIDS and DTE users, you would
need to drop those changes as well as #ifdef the initialization call.  You
would also need to add stub hook functions for inode_init to the LIDS and
DTE modules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
