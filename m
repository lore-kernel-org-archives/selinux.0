Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i569kYrT028778
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 05:46:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i569kTRQ003724
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 05:46:30 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: successful cupsys admin: advantages of running pam_selinux
Date: Sun, 6 Jun 2004 19:46:26 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040606000852.GA6673@lkcl.net>
In-Reply-To: <20040606000852.GA6673@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406061946.26814.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 6 Jun 2004 10:08, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> it is with some amazement that, by adding pam_selinux to /etc/pam.d/cups
> and by adding an ordinary user to the lpadmin group that i was able
> to have that ordinary user set up a local printer and actually print
> to it (openoffice).

How does cups use pam_selinux?

Cups doesn't spawn a shell, and even if it tried the policy does not permit 
domain transitions to user domains.

Cups doesn't have any terminal devices to relabel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
