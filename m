Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TM7JrT023140
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 18:07:19 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TM6lbB022821
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 22:06:47 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 22:07:18 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BqIZN-00017Y-Sj
	for selinux@tycho.nsa.gov; Thu, 29 Jul 2004 21:36:10 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BqJEG-0003JZ-9A
	for selinux@tycho.nsa.gov; Thu, 29 Jul 2004 23:18:24 +0100
Date: Thu, 29 Jul 2004 23:18:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pear-shaped behaviour after enough make reloads
Message-ID: <20040729221824.GR9950@lkcl.net>
References: <20040728211229.GB18711@lkcl.net> <1091126965.21971.160.camel@moss-spartans.epoch.ncsc.mil> <20040729202419.GI9950@lkcl.net> <1091133123.21971.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091133123.21971.200.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

for completeness on list, i should mention that i was modifying
policy files during the make reloads.

stephen mentioned that apparently if inodes are using a SID
that is deleted, no amount of subsequent make reloads will
reattach the SID to that inode.

what happened because of what i was doing to my computer "fits"
with this explanation.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
