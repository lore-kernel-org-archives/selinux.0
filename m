Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBNCXWIi003228
	for <selinux@tycho.nsa.gov>; Thu, 23 Dec 2004 07:33:32 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBNCVhiX028598
	for <selinux@tycho.nsa.gov>; Thu, 23 Dec 2004 12:31:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: [patch] misc. policy updates
Date: Thu, 23 Dec 2004 23:33:17 +1100
Cc: Greg Norris <haphazard@kc.rr.com>, SELinux <selinux@tycho.nsa.gov>
References: <20041217012224.GA11330@yggdrasil.localdomain> <200412201201.11825.russell@coker.com.au> <1103579643.3220.32.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1103579643.3220.32.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412232333.20721.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 21 December 2004 08:54, James Carter <jwcart2@epoch.ncsc.mil> 
wrote:
> Merged both Greg's and Russell's patches.
>
> Russell, I added "log_domain(ddclient)" as you mention below.  I also
> added "var_lib_domain(ddclient)" since your patch assigns a
> var_lib_ddclient_t.  Or did you do something different there?

I was thinking of removing the var_lib_ddclient_t type as it has so many and 
hadn't tested before sending the email.  What you have done works well.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
