Date: Thu, 31 Oct 2002 09:08:06 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@tislabs.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
Message-ID: <20021030220806.GB16395@snoopy.apana.org.au>
References: <200210301613.51096.russell@coker.com.au> <Pine.GSO.4.33.0210301441331.12970-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210301441331.12970-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 30, 2002 at 02:48:12PM -0500, Stephen Smalley wrote:
> For the separate SELinux patch to work for LIDS and DTE users, you would
> need to drop those changes as well as #ifdef the initialization call.  You
> would also need to add stub hook functions for inode_init to the LIDS and
> DTE modules.

What parts of the seperate SELinux patch would break LIDS and DTE users?
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
