Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MChiI4020957
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 08:43:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4MChKuO007132
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 12:43:20 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4MChGlV007122
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 12:43:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init woes
Date: Thu, 22 May 2003 22:41:35 +1000
References: <20030522112833.A2615@lemuria.org>
In-Reply-To: <20030522112833.A2615@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305222241.35921.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 May 2003 19:28, Tom wrote:
> I've started writing a policy for PXE daemon, improving tftpd policy,
> etc - when something weird happend to me.
>
> # run_init /etc/init.d/pxe start
> Authenticating root.
> Password:
> Starting PXE daemon: Intel PXE daemon, PXE-2.0 Beta-1 (build 001)
> Copyright (C) 1999  Intel Corporation
> pxe.
>
>
> So far, so good. Except that the pxe daemon dies right away. No debug
> output either, nothing in the logfiles.

Are you using my run_init or the NSA one?

If using mine then put "sleep 1" in the shell script after the daemon gets 
run.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
