Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04FC5Ii024571
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 10:12:05 -0500 (EST)
Received: from babbler.bmc.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04FC7A9000088
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 15:12:07 GMT
Date: Tue, 4 Jan 2005 09:11:34 -0600 (CST)
From: Richard Troth <rtroth@bmc.com>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modules needed to be compiled in for selinux to work
In-Reply-To: <200501050204.03428.russell@coker.com.au>
Message-ID: <Pine.LNX.4.53.0501040908010.4737@rmt-desk.bmc.com>
References: <200501050204.03428.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jan 2005, Russell Coker wrote:
> SE Linux has not worked correctly when compiled as a module
> since at least mid 2001.

Okay,  that answers the question I was going to ask Stephen.
(I've never tried,  so I did not know that Debian's "=m" would fail.)

>        I don't believe that there are any plans to try and change this.

Why?

> SE Linux must be linked into the kernel.  It makes sense to do
> the same with the capabilities module IMHO.

Certainly.
It makes sense that they be consistent.

-- R;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
