Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2MNcVx6027957
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 18:38:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2MNZ1lY021604
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 23:35:01 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2MNYwKX021601
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 23:34:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Kurt Roeckx <Q@ping.be>, selinux@tycho.nsa.gov
Subject: Re: ping problems.
Date: Sun, 23 Mar 2003 00:38:17 +0100
References: <20030322204530.GA20526@ping.be>
In-Reply-To: <20030322204530.GA20526@ping.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303230038.17087.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 22 Mar 2003 21:45, Kurt Roeckx wrote:
> avc:  denied  { ioctl } for  pid=1641 exe=/bin/ping6
> path=socket:[8429] dev=00:00 ino=8429
> scontext=kurt:sysadm_r:ping_t tcontext=kurt:sysadm_r:ping_t
> tclass=rawip_socket

If the following rule is added:
allow ping_t self:rawip_socket create_socket_perms;

Then it'll add the ioctl access, plus the following:
getattr setattr append connect shutdown

I think that those 5 accesses are ok and using the macro allows a simpler rule 
which is a benefit.

I've added the ioctl to my tree for the moment, I'll probably change to the 
macro later.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
