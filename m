Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OIARHa002601
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 14:10:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6OI9JFB019956
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:09:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6OI9IGD019946
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:09:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Michael Luu" <mluu@cougaarsoftware.com>, <selinux@tycho.nsa.gov>
Subject: Re: can't log into machine w/ ssh
Date: Thu, 24 Jul 2003 14:10:26 -0400
References: <000201c35207$8726c6e0$ef0111ac@mluudt>
In-Reply-To: <000201c35207$8726c6e0$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307241410.26751.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jul 2003 13:17, Michael Luu wrote:
> the user mike only has the user_r role.

Run "grep ssh /etc/security/default_contexts" and check what's in there.  It 
should include user_r:user_t in the sshd_t line.

Also make sure that sshd is running as sshd_t.

Then check for avc denied messages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
