Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T93IrT017169
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 05:03:19 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6T92mbB007614
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 09:02:48 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 09:03:18 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bq6KY-0000yW-HP
	for selinux@tycho.nsa.gov; Thu, 29 Jul 2004 08:32:02 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bq6zX-0001iT-Da
	for selinux@tycho.nsa.gov; Thu, 29 Jul 2004 10:14:23 +0100
Date: Thu, 29 Jul 2004 10:14:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: udev and .dev...
Message-ID: <20040729091423.GC6443@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dear selinux people,

ah ha!  okay, the reason why my hard drive was inaccessible
is because /.dev/* had all been set to default_t :)

soooo... to fix that [rather than a patch, a sed command]:

	:%s/u?dev/.?u?dev/g

this will allow setfiles to set up the security contexts on
the /.dev which is the _real_ filesystem /dev stuff which will
allow things like, oh, init (!!) to access the hard drive.

argh :)

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
