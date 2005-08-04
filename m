Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j74Lg5gA016752
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2005 17:42:06 -0400 (EDT)
Received: from storix.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j74LY9il017264
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2005 21:34:10 GMT
Received: from rich (65.106.88.139.ptr.us.xo.net [65.106.88.139])
	by storix.com (Postfix) with ESMTP id 03F931596F
	for <selinux@tycho.nsa.gov>; Thu,  4 Aug 2005 14:36:37 -0700 (PDT)
Subject: chcon v. setfilecon
From: rich turner <rich@storix.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 04 Aug 2005 14:38:18 -0700
Message-Id: <1123191498.4481.76.camel@rich>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

what is the difference between these commands? it seems they both do the
same thing.

is setfilecon deprecated and replaced with chcon?

on my fedora core3 system i have the setfilecon command but not the
chcon command. on fc4 i have the chcon command.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
