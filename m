Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, Stephen Smalley <sds@tislabs.com>
Subject: Re: kernel warning
Date: Wed, 30 Oct 2002 23:22:01 +0100
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200210301613.51096.russell@coker.com.au> <Pine.GSO.4.33.0210301441331.12970-100000@raven> <20021030220806.GB16395@snoopy.apana.org.au>
In-Reply-To: <20021030220806.GB16395@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200210302322.01805.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Oct 2002 23:08, Brian May wrote:
> On Wed, Oct 30, 2002 at 02:48:12PM -0500, Stephen Smalley wrote:
> > For the separate SELinux patch to work for LIDS and DTE users, you would
> > need to drop those changes as well as #ifdef the initialization call. 
> > You would also need to add stub hook functions for inode_init to the LIDS
> > and DTE modules.
>
> What parts of the seperate SELinux patch would break LIDS and DTE users?

I'm not sure.  It was my understanding of the conversation between you and 
Steve that some parts of SE Linux will be unconditionally enabled if you 
apply the second patch.  So in my latest kernel patch package I put a bunch 
of extra #ifdef's in...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
