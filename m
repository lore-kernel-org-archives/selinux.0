Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03612
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 09:50:39 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Editing crontabs
Date: Tue, 1 Oct 2002 15:50:28 +0200
Cc: Brian May <bam@snoopy.apana.org.au>, <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210010734350.1579-100000@raven> <200210011352.48238.russell@coker.com.au>
In-Reply-To: <200210011352.48238.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200210011550.28130.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 13:52, Russell Coker wrote:
> > As long as you assume that sysadm_t is the most privileged user domain,
> > then this should be fine.
>
> Well that assumption goes right through the default policy.  Removing or
> changing it would be as much work as it was to make multiple user roles
> work properly (which incidentally is still not complete).

Which incidentally is the reason why I didn't go all the way and add support 
for multiple administrative domains.  It would be a lot more pain for me, and 
I would not benefit from it.

It would probably be better to have multiple levels of administrative access, 
but it will be a huge amount of work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
