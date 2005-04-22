Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M27o7C013418
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 22:07:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3M1xvVU011426
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 01:59:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Alex Ackerman <alex@darkhonor.com>
Subject: Re: pppd Patch for PPTPClient
Date: Fri, 22 Apr 2005 12:02:40 +1000
Cc: selinux@tycho.nsa.gov
References: <41E40180.9020500@darkhonor.com>
In-Reply-To: <41E40180.9020500@darkhonor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504221202.43118.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 12 January 2005 03:40, Alex Ackerman <alex@darkhonor.com> wrote:
> Comments?

+allow pppd_t self:unix_stream_socket { accept connectto listen };

Better to change the previous line to create_stream_socket_perms.

+allow pppd_t var_run_t:sock_file { create setattr unlink write };

Need a better type for this, var_run_t:sock_file should not exist in strict 
policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
