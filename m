Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56B7prT029069
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 07:07:51 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i56B7mRQ004683
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 07:07:48 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 6 Jun 2004 11:07:48 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWur8-00013K-On
	for selinux@tycho.nsa.gov; Sun, 06 Jun 2004 10:26:22 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BWvSh-0002q0-Gc
	for selinux@tycho.nsa.gov; Sun, 06 Jun 2004 11:05:11 +0000
Date: Sun, 6 Jun 2004 11:05:11 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: successful cupsys admin: advantages of running pam_selinux
Message-ID: <20040606110511.GA10890@lkcl.net>
References: <20040606000852.GA6673@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040606000852.GA6673@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, so pam_selinux has nothing to do with successfully being
able to get a printer to work [and my conclusions based on the
assumption that it did are therefore invalid]

wow.  even more amazing: selinux doesn't get in the way _at all_!

On Sun, Jun 06, 2004 at 12:08:53AM +0000, Luke Kenneth Casson Leighton wrote:

> it is with some amazement that, by adding pam_selinux to /etc/pam.d/cups
> and by adding an ordinary user to the lpadmin group that i was able
> to have that ordinary user set up a local printer and actually print
> to it (openoffice).
> 
> i am aware that there are concerns about pam_selinux being inappropriate
> for certain things - openssh being one of them due to ttys not being
> managed properly, and kdm when you set AutoLogin is another.
> 
> however the prospect of having to code up a policy for doing what i
> just managed to do fills me with some trepidation.
> 
> i could not tell you where to begin to get the same effect as the
> lpadmin group.
> 
> six of one, half a dozen of the other.
> 
> i mention all this just in case someone thought "i know, pam_selinux
> is bad, let's drop it entirely".
> 
> l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
