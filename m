Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OIB7Ha002643
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 14:11:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6OI9xFB020025
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:09:59 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6OI9wGD020022
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:09:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Michael Luu" <mluu@cougaarsoftware.com>, <selinux@tycho.nsa.gov>
Subject: Re: can't log into machine w/ ssh
Date: Thu, 24 Jul 2003 14:11:20 -0400
References: <000301c3520c$aeee8be0$ef0111ac@mluudt>
In-Reply-To: <000301c3520c$aeee8be0$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307241411.20962.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jul 2003 13:54, Michael Luu wrote:
> when all else fails, rebooting the machine will make things work. :)
> anyways, would you happen to know which services needs to be restarted
> when i do add users and perform policy updates?

Nothing needs to be restarted.

I guess that you had sshd running in the wrong domain, and that when you 
rebooted it was started in the right domain.

You have to use run_init to start daemons...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
