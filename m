Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56AP9rT028893
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 06:25:10 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i56AP7RQ004114
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 06:25:07 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 6 Jun 2004 10:24:52 -0000
Date: Sun, 6 Jun 2004 10:22:15 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: successful cupsys admin: advantages of running pam_selinux
Message-ID: <20040606102215.GC9675@lkcl.net>
References: <20040606000852.GA6673@lkcl.net> <200406061946.26814.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406061946.26814.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 06, 2004 at 07:46:26PM +1000, Russell Coker wrote:
> On Sun, 6 Jun 2004 10:08, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > it is with some amazement that, by adding pam_selinux to /etc/pam.d/cups
> > and by adding an ordinary user to the lpadmin group that i was able
> > to have that ordinary user set up a local printer and actually print
> > to it (openoffice).
> 
> How does cups use pam_selinux?
 
  umm....

> Cups doesn't spawn a shell, and even if it tried the policy does not permit 
> domain transitions to user domains.
> 
> Cups doesn't have any terminal devices to relabel.

 i'll do an experiment: i'll remove the entry pam_selinux from
 /etc/pam.d/cups and see if i can add a printer...
 
 ... and it works.  hey, that's even better.

 thanks!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
