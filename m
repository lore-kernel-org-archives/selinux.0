Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h54AYEI4021399
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 06:34:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h54AXess009965
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 10:33:40 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h54AXchY009962
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 10:33:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: postfix rules
Date: Wed, 4 Jun 2003 20:33:20 +1000
References: <200306041119.15601.carsten.grohmann@raumbildsysteme.de>
In-Reply-To: <200306041119.15601.carsten.grohmann@raumbildsysteme.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306042033.20756.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Jun 2003 19:19, Carsten Grohmann wrote:
> I would add domain_auto_trans(postfix_master_t,
> postfix_postqueue_exec_t, postfix_postqueue_t)
> ,but I'm not sure.
>  What do you thing?

Adding that policy will solve the apparent problem, I've added it to my tree.

However I am curious as to why this happens on your system but not on mine.  
I've run many Postfix machines with different versions of Postfix and 
configurations and not had it run postqueue from postfix_master_t.

I suspect that perhaps your distribution has different scripts for Postfix to 
run during it's startup phase than in Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
