Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JEVgQT006503
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:31:42 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JEVdfP017082
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:31:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: fc5 policy patch
Date: Sat, 20 May 2006 00:31:44 +1000
Cc: Daniel Walsh <dwalsh@redhat.com>
References: <200605200005.12042.russell@coker.com.au>
In-Reply-To: <200605200005.12042.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605200031.47765.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 20 May 2006 00:05, Russell Coker <russell@coker.com.au> wrote:
> My patch makes the anti-virus setup basically work.  Due to the complexity
> of the system there is a possibility of corner cases that I've missed, but
> the only way we will discover that is to get this policy released and have
> people try it.

Naturally immediately after I posted that message I discovered such a corner 
case, mail is apparently written to /var/lib/clamav by procmail and the 
policy does not permit that.  Determining the correct solution to this will 
take a bit of time (hopefully I'll have it done before my client starts work 
on Monday).

My previous patch is still worth including, it makes clamav usable on FC5, the 
update to allow storing the virus messages (or whatever it is that procmail 
is doing) can come later.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
