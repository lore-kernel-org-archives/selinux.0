Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6ODEBHa000461
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 09:14:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6ODD4FB029095
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 13:13:05 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6ODD3GD029080
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 13:13:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Michael Luu" <mluu@cougaarsoftware.com>, <selinux@tycho.nsa.gov>
Subject: Re: can't log into machine w/ ssh
Date: Wed, 23 Jul 2003 23:34:34 -0400
References: <001801c350bc$b91cec20$ef0111ac@mluudt>
In-Reply-To: <001801c350bc$b91cec20$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307232334.34931.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 22 Jul 2003 21:49, Michael Luu wrote:
> sshd[3817]: fatal: Could not obtain SID for user mike

In the default configuration if the user is authorised for only the role 
sysadm_r then this will be the result.

If you want to allow sysadm_r logins over ssh then you have to change the ssh 
policy, but I strongly recommend that you just permit the user to use another 
role.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
