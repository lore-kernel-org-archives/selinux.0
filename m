Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h435qBI4020560
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 01:52:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h435qA7R023614
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 05:52:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h435q8KP023611 for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 05:52:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Akshay Gangam <gvakshay@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: Support for XWindows ?
Date: Sat, 3 May 2003 15:51:14 +1000
References: <20030503004232.1113.qmail@web20805.mail.yahoo.com>
In-Reply-To: <20030503004232.1113.qmail@web20805.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305031551.14261.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 3 May 2003 10:42, Akshay Gangam wrote:
> I have a running installed on a stand alone system,
> with lsm2.4+selinux+RH8.0 on it.
> The kernel is in permissive mode, but I have not moved
> to enforcing mode, since I not sure of the support for
> XWindows. Does changing is enforcing mode, leave me
> deprived of Emacs/Xwindows to read documentation or to
> open multiple terminal sessions ?

Notice the xdm.te and xserver.te files in the policy source directory.  These 
provide the security policy for a patched XDM (not included in a base SE 
Linux installation) and for running "startx" from the command line.

Note which email program that I am using to write this message...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
