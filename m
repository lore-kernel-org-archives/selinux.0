Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAN6WgIi010079
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 01:32:42 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAN6VA5q024651
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 06:31:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Linux Journal Article
Date: Tue, 23 Nov 2004 15:48:29 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0411122147260.7482-100000@thoron.boston.redhat.com> <1100375928.1691.17.camel@debby>
In-Reply-To: <1100375928.1691.17.camel@debby>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411231548.32753.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 14 November 2004 06:58, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> "Work also is being done on Security Enhanced X, where the aim is to
> have control over the X sessions so that, for instance, a hostile X
> program can't interfere with other X programs on the display."
>
> Does this mean that SElinux currently can't have an impact on X-related
> processes (gdm, Gnome, FVWM etc., and on Debian/unstable)?

SE Linux prevents X access to X servers started from another user role.  So if 
you had a dual-head machine and one user was logged in as user_r while 
another was logged in as staff_r they would not be able to access each 
other's X servers IF those X servers were started by entering "startx" from 
the command line.

If the X servers were started by gdm or a similar program then there would be 
nothing in SE Linux preventing the users from accessing each other's 
displays.

Also within one user role there is nothing to prevent an X client running in 
user_games_t from interfering with the X access of a program running in 
user_t.  This interferance means sniffing the keyboard input (capturing 
passwords), reading the contents of the window (copying confidential data), 
and impersonating programs (making it appear that Kmail is asking for the GPG 
pass-phrase to decrypt an email as part of an attack on GPG).

SE-X solves most of those issues.  However there are still some issues related 
to sharing a pty device between programs running in different domains.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
