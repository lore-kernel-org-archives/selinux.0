Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h35LeaI4010911
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 16:40:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h35LauOv029564
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 21:36:56 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h35LasY1029556
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 21:36:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Kurt Roeckx <Q@ping.be>, selinux@tycho.nsa.gov
Subject: Re: sshd problem.
Date: Sun, 6 Apr 2003 07:40:27 +1000
References: <20030405164654.GA3200@ping.be>
In-Reply-To: <20030405164654.GA3200@ping.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304060740.27292.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 6 Apr 2003 02:46, Kurt Roeckx wrote:
> If I run run_init /etc/init.d/ssh start it fails to start, even in
> permissive mode.  I have no idea why it fails, I see nothing in
> the logs.
>
> If I run strace -f run_init /etc/init.d/ssh start, it starts
> without problems, which currently seems to be the only way I can
> make it start properly.

Try putting a "sleep 1" after the line in the /etc/init.d/ssh file that starts 
the sshd and it should work.

I'm not sure whether this is a bug in expect or in the daemon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
