Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBM9EuIi026532
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2004 04:14:56 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBM9Ewlw014562
	for <selinux@tycho.nsa.gov>; Wed, 22 Dec 2004 09:14:59 GMT
Date: Wed, 22 Dec 2004 09:25:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: paranoid FC3 setup: banning all login access (!)
Message-ID: <20041222092538.GV6364@lkcl.net>
References: <20041220160039.GE24188@lkcl.net> <200412220406.iBM46g0D019149@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200412220406.iBM46g0D019149@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 21, 2004 at 11:06:41PM -0500, Valdis.Kletnieks@vt.edu wrote:

> On Mon, 20 Dec 2004 16:00:39 GMT, Luke Kenneth Casson Leighton said:
> > hi,
> > 
> > i have a requirement for setting up a server that might even ban
> > logins - even admin logins.
> > 
> > the only things that should be allowed are reboot (ctrl-alt-delete at
> > console) and services (e.g apache).
> 
> Umm.. how about this:
> 
> # chkconfig sshd off
> # chkconfig telnetd off
> 
> and then 'grep -v getty' to remove those from /etc/inittab?

 that's the practical side: thank you.

 i hope to recommend removing even the selinux policy that
 allows getty, sshd, telnetd and other login mechanisms from
 being run by users (!)

 
> Leave the ctrl-alt-del entry in inittab, and have a grub entry
> that boots with init=/bin/bash or similar single-user setup.
 
 ... with enable=0 most likely for simplicity, and no networking.

 the key issue is whether the customer says that running
 "enable=0" in that single-user no-networking mode is okay.

 if they say "no it isn't" then i will need to go further, as
 david caplan recommends, by instead of removing the selinux
 policy for getty, to enable it via a dynamic boolean.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
