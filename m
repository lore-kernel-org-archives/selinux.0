Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S8qSrT008367
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 04:52:28 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6S8pvAN027559
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:51:58 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 08:52:27 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BpjgJ-0000m6-Pd
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 08:20:59 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BpkLT-0008L3-KX
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 10:03:31 +0100
Date: Wed, 28 Jul 2004 10:03:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: umount fails on shutdown: causes next boot to fail
Message-ID: <20040728090331.GD28362@lkcl.net>
References: <20040728083831.GC28362@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040728083831.GC28362@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 28, 2004 at 09:38:32AM +0100, Luke Kenneth Casson Leighton wrote:

> hi,
> 
> got a bit of an issue with umount failing.
> 
> i have noticed that a double-reboot is required to clear things
> if a filesystem is not unmounted at shutdown time...
> 
> ... and now i have a filesystem (/var) that doesn't unmount
> _even during a regular shutdown_.

> [...]

> i think i will try again and this time actually manually try
> a umount /var myself.

answer: pump (dhcp client) was still running.  stopped both /usr
_and_ /var from being unmounted.

arg.

odd that it didn't show up in lsof, though.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
