Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OIW5Ha002890
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 14:32:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6OIUrFB021627
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:30:53 GMT
Received: from mvmail1.mv.cougaarsoftware.com (h-68-165-169-235.SNVACAID.covad.net [68.165.169.235])
	by jazzswing.ncsc.mil  with ESMTP id h6OIUlGD021616
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:30:52 GMT
From: "Michael Luu" <mluu@cougaarsoftware.com>
To: "'Russell Coker'" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: can't log into machine w/ ssh
Date: Thu, 24 Jul 2003 11:44:44 -0700
Message-ID: <000901c35213$a6ce2590$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200307241411.20962.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

thanks for your help!

mike

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Thursday, July 24, 2003 11:11 AM
To: Michael Luu; selinux@tycho.nsa.gov
Subject: Re: can't log into machine w/ ssh


On Thu, 24 Jul 2003 13:54, Michael Luu wrote:
> when all else fails, rebooting the machine will make things work. :) 
> anyways, would you happen to know which services needs to be restarted

> when i do add users and perform policy updates?

Nothing needs to be restarted.

I guess that you had sshd running in the wrong domain, and that when you

rebooted it was started in the right domain.

You have to use run_init to start daemons...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
