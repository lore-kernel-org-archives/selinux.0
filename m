Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Brian May <bam@snoopy.apana.org.au>
Subject: Re: kernel warning
Date: Wed, 30 Oct 2002 16:13:51 +0100
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210300819100.26525-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210300819100.26525-100000@raven>
MIME-Version: 1.0
Message-Id: <200210301613.51096.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Oct 2002 14:23, Stephen Smalley wrote:
> > It appears that with this patch, it is no longer possible to
> > compile the patched kernel without SE-LINUX support.
> >
> > Maybe the call to selinux_init() in main.c needs
> > to be wrapped with #ifdef CONFIG_SECURITY_SELINUX?
>
> You would only apply this patch if you intend to use SELinux, so it is
> implicit that SELinux is going to be enabled.  We could #ifdef it, but I'm
> not sure what the point is.  Now, if a generalized form of early
> initialization is added to the LSM patch, then this would go away and the
> SELinux-specific code would be hidden.

This means that I can't produce a single kernel-patch package that can be used 
by SE Linux, LIDS, and DTE users...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
