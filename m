Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OH58Ha001948
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 13:05:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OH57DW029816
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 17:05:07 GMT
Received: from mvmail1.mv.cougaarsoftware.com (h-68-165-169-235.SNVACAID.covad.net [68.165.169.235])
        by jazzband.ncsc.mil  with ESMTP id h6OH56eN029813 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 17:05:07 GMT
From: "Michael Luu" <mluu@cougaarsoftware.com>
To: "'Russell Coker'" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: can't log into machine w/ ssh
Date: Thu, 24 Jul 2003 10:17:58 -0700
Message-ID: <000201c35207$8726c6e0$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200307232334.34931.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

the user mike only has the user_r role.

mike

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Wednesday, July 23, 2003 8:35 PM
To: Michael Luu; selinux@tycho.nsa.gov
Subject: Re: can't log into machine w/ ssh


On Tue, 22 Jul 2003 21:49, Michael Luu wrote:
> sshd[3817]: fatal: Could not obtain SID for user mike

In the default configuration if the user is authorised for only the role

sysadm_r then this will be the result.

If you want to allow sysadm_r logins over ssh then you have to change
the ssh 
policy, but I strongly recommend that you just permit the user to use
another 
role.

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
