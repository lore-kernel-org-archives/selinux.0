Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h415lDI4008690
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 01:47:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h415lC7R024795
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 05:47:12 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h415lAKP024792 for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 05:47:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: SUDO package
Date: Thu, 1 May 2003 15:46:26 +1000
Cc: selinux@tycho.nsa.gov
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com> <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil> <3EB01EC8.7070602@redhat.com>
In-Reply-To: <3EB01EC8.7070602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305011546.26265.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 May 2003 05:06, Daniel J Walsh wrote:
> Ok I just went back and read the code again and it looks like I can
> implement the terminal stuff.
> There is a -b option on the sudo command that allows sudo to run in
> background.  Or using job
> control you could run the command in background.
>
> sudo -r sysadm_r /usr/bin/PROGRAM &
>
> So what happens to control over the terminal in this situation?

There was recently a long discussion about this topic on another list (a 
closed list).

The consensus of opinion was that when doing su/sudo type operations to an 
untrusted context on a vanilla Linux kernel then you have to open a new 
pseudo-tty.  On SE Linux changing the type of the pty device is enough.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
