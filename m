Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SGqOrT026528
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 12:52:24 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SGqNdb016947
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 16:52:23 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 15123C0AC
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 17:52:16 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C16c5-0004pP-Dw
	for selinux@tycho.nsa.gov; Sat, 28 Aug 2004 18:03:37 +0100
Date: Sat, 28 Aug 2004 18:03:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: kde 3.3 (kdm) issues
Message-ID: <20040828170337.GD11546@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i've encountered a problem with kde 3.3 it's related to kdm starting
up on the wrong console window:

> - kdm starts on the second console instead of the 7th like before the
>   upgrade
  
    that's because kdm uses the first available console unless told not
	to do so. the kdmrc shipped by Debian points kdm to use console #7,
    but your kdmrc probably doesnt. add this line to /etc/kde3/kdm/kdmrc:

		      ServerVTs=-7


now, bizarrely, kdm somehow starts up at the WRONG time, or there's
a missing option (see above).

if anyone else upgrades to kde 3.3 and subsequently finds odd things going
on with console logins, this is why.

l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
