Date: Fri, 12 Apr 2002 10:21:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: Russell Coker <russell@coker.com.au>, <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412161729.B29624@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204121019570.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Tom wrote:

> One thing that I noticed during this setup was that the patched login
> and ssh tools do not appear to work if they run on a non-lsm kernel.
> While this is probably the right thing to do security-wise, it also
> means that keeping a non-SELinux kernel as "rescue system" on-disk
> doesn't help a thing.

I can't speak for the Debian selinux packages, but the upstream SELinux
modified daemons and utilities run fine on non-SELinux kernels and non-LSM
kernels.  They simply fall back to the ordinary processing in that case.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
