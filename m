Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03015
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 11:21:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA21445
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 15:20:31 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA21441
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 15:20:29 GMT
Date: Wed, 25 Jul 2001 01:21:08 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Stephen Smalley <sds@tislabs.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Apache configuration
In-Reply-To: <Pine.SOL.3.95.1010723104715.3466L-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.31.0107250046470.26706-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Jul 2001, Stephen Smalley wrote:

>
> On Sun, 22 Jul 2001, James Morris wrote:
>
> > I've been working on a simple policy configuration for the Apache server,
> > a patch for which is attached below.
>
> A more complex policy configuration for apache has been developed
> by some folks at MITRE, but your simple policy configuration may
> be more appropriate if you only want to serve static content.  I've
> adjusted the MITRE apache policy for our new LSM-based SELinux
> prototype, and it will be included in releases of that prototype.
> MITRE could probably provide a copy of the original apache policy
> for the original SELinux prototype.

Hi Stephen,

Thanks for looking at this, it was my first attempt at configuring Flask
policy, so I'm quite relieved that you didn't seem to find any serious
issues!

I initially considered a more detailed configuration including the ability
to execute scripts, although it quickly became apparent that this could
indeed become complex for a useful non-static implementation (e.g. one
that would be able to run mod_perl, php scripts or java servlets, and
other types of complex apache modules).

I'm now looking at thttpd as a possibly better choice of server for static
files -- perhaps it may be useful to offer both a more fully featured
Apache and a simpler thttpd.


- James
-- 
James Morris
<jmorris@intercode.com.au>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
