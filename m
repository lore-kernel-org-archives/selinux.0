Date: Wed, 30 Oct 2002 17:21:43 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
In-Reply-To: <20021030220806.GB16395@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0210301718430.22794-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 31 Oct 2002, Brian May wrote:

> On Wed, Oct 30, 2002 at 02:48:12PM -0500, Stephen Smalley wrote:
> > For the separate SELinux patch to work for LIDS and DTE users, you would
> > need to drop those changes as well as #ifdef the initialization call.  You
> > would also need to add stub hook functions for inode_init to the LIDS and
> > DTE modules.
>
> What parts of the seperate SELinux patch would break LIDS and DTE users?

As I said, you would need to drop the Makefile and defconfig diffs
entirely, wrap the init/main.c diff with an #ifdef, and add inode_init
stub hook functions to LIDS and DTE.  I don't plan on dropping the
Makefile and defconfig diffs from our patch, but I'm willing to fix up the
other issues in our patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
