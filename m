Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5E5ktrT016230
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 01:46:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5E5knbJ008902
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 01:46:52 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: kde (users) requires read permission to /var/spool/cups(/certs/0)
Date: Mon, 14 Jun 2004 15:46:29 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040613103203.GF2861@lkcl.net>
In-Reply-To: <20040613103203.GF2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406141546.29122.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 13 Jun 2004 20:32, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> don't exactly know what this is about, but if i boot in
> non-enforcing mode then i can add a local cupsys-managed
> printer WITHOUT having to type in a password (a desirable
> thing for a single user home office system), and i get this
> in the audit logs:
>
> 	allow user_t print_spool_t:dir { search };
> 			#EXE=/usr/bin/kdeinit  NAME=cups   :  search

On my system that directory is more 0700 so a user can't search it anyway.  
Are you sure that kde is doing the right thing?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
