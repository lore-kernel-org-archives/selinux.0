Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA12415
	for <selinux@tycho.nsa.gov>; Sat, 5 Oct 2002 02:28:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA09170
	for <selinux@tycho.nsa.gov>; Sat, 5 Oct 2002 06:26:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id GAA09166
	for <selinux@tycho.nsa.gov>; Sat, 5 Oct 2002 06:26:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: RH8 policy support
Date: Sat, 5 Oct 2002 08:28:09 +0200
Cc: selinux@tycho.nsa.gov
References: <20021004211432.73107.qmail@web40001.mail.yahoo.com>
In-Reply-To: <20021004211432.73107.qmail@web40001.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <200210050828.09485.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Oct 2002 23:14, Brad Chapman wrote:
> > Wrappers for rpm and related commands to run them in system_u:system_r .
>
> I can certainly try this, but it will be ugly and evil and will need some
> major cleanups before going into the CVS.

No, just copy my code for wrapping dpkg.

> > Support for relabelling files after installing a new RPM package.
>
> How would you do that?

rpm triggers should do it, just need to call a script that gets a list of 
files in the package and then uses "setfiles -s" to relabel them.

> > Policy to make the install scripts start daemons in the correct domain.
>
> What install scripts do you mean?

Well if you install a new version of cron then the package manager has to stop 
the old version and start the new version.  You don't want cron running in 
the rpm_t domain...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
