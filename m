Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h35MEAI4011013
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 17:14:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h35ME9xH024858
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 22:14:09 GMT
Received: from tartarus.telenet-ops.be (tartarus.telenet-ops.be [195.130.132.46])
        by jazzband.ncsc.mil  with ESMTP id h35ME9Dl024855 for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 22:14:09 GMT
Date: Sun, 6 Apr 2003 00:14:02 +0200
From: Kurt Roeckx <Q@ping.be>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: sshd problem.
Message-ID: <20030405221401.GA14639@ping.be>
References: <20030405164654.GA3200@ping.be> <200304060740.27292.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200304060740.27292.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Apr 06, 2003 at 07:40:27AM +1000, Russell Coker wrote:
> On Sun, 6 Apr 2003 02:46, Kurt Roeckx wrote:
> > If I run run_init /etc/init.d/ssh start it fails to start, even in
> > permissive mode.  I have no idea why it fails, I see nothing in
> > the logs.
> >
> Try putting a "sleep 1" after the line in the /etc/init.d/ssh file that starts 
> the sshd and it should work.
> 
> I'm not sure whether this is a bug in expect or in the daemon.

That worked, thanks.


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
