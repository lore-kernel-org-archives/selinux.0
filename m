Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ALDsrT001558
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:13:54 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5ALDnP2028153
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:13:49 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 21:13:52 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BYWEe-0001m3-Qm
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 20:33:16 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BYWpM-0000tY-28
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 21:11:12 +0000
Date: Thu, 10 Jun 2004 21:11:12 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610211112.GG2861@lkcl.net>
References: <20040609214126.GF5727@lkcl.net> <20040609232932.GD2142@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040609232932.GD2142@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 01:29:32AM +0200, Thomas Bleher wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-06-10 01:06]:
> > hi,
> > 
> > debian's postfix init.d script does a whole stackload of
> > things like copy over /etc/localtime, /etc/services.
> > 
> > it's rather scary.
> > 
> > ... and it doesn't work.
> > 
> > by disabling the chroot (setting SYNC_CHROOT="") i managed
> > to get postfix to start (and it works)
> > 
> > i don't know if i was supposed to have these enabled
> 
> IIRC the consensus was that the chroot setup should be disabled. The
> reasoning was that SELinux can provide better protection than a chroot
> and it would just give postfix unnecessary permissions.
 
 oh.

 ah.

 hmm...

 then, the question becomes - how should that information be
 relayed?

 if it bit me (who is coming into this blind with no prior
 knowledge or expectations other than "install it and find out
 how to fix it if it's broke") then it's definitely going to
 bite other people.


 how about having an se-postfix package that puts
 SYNC_CHROOT="" into /etc/default/postfix for you?

 or, adding an extra question to postfix dpkg questions to
 ask?


> Thomas
> 
> BTW:
> > 	allow postfix_cleanup_t postfix_cleanup_t:capability { sys_chroot };
> You can write these as
>         allow postfix_cleanup_t self:capability sys_chroot;
> which makes it both shorter and easier to read.

 thank you thomas :)

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
