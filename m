Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0F5L3Rb000908
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 00:21:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0F5L2iV008579
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 05:21:02 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i0F5L106008535 for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 05:21:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Subject: Re: Samba and NFSv4 user-space server
Date: Thu, 15 Jan 2004 16:19:58 +1100
References: <200401131419.23834.russell@coker.com.au> <84zncs2xxt.fsf@snoopy.apana.org.au>
In-Reply-To: <84zncs2xxt.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401151619.58669.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jan 2004 16:57, Brian May <bam@snoopy.apana.org.au> wrote:
>     Russell> We don't want to allow wide and arbitary changing of
>     Russell> context as setuid() allows.  But allowing transitions
>     Russell> between samba_user_t and samba_staff_t should be OK.
>
> Could you have the incoming TCP request go to a "wrapper" service that
> does nothing but redirect it to the "real" process that is already
> running with the correct UID/SE-Linux domain?
>
> Not sure how feasible this is, or what sort of performance penalty
> it might have though.

That won't work.  Samba supports having multiple identities on a single TCP 
connection, and NFSv4 supports similar things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
