Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VBtVrT002526
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 07:55:31 -0400 (EDT)
Received: from smtp806.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VBsxHs003069
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 11:54:59 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp806.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 11:55:30 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bqryg-0001Oc-VE
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 11:24:39 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BqsdG-00025p-Lv
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 13:06:34 +0100
Date: Sat, 31 Jul 2004 13:06:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: policy version jumped to 18
Message-ID: <20040731120634.GK3378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

arg, wot a pain.

i am doing an install on another machine, just for fun
(and prior to doing an upgrade on another).

this is with my lovely 2.6.6-selinux1 kernel.

policy version being reported by the kernel i am using is 17.

checkpolicy is being a pain and reporting that it does version 18.

therefore, a make install does this:

creates a policy.conf file, and creates a .17 file (somewhere) because
that's what the kernel supports.

checkpolicy is then used to find what to check, which says "i do version 18".

consequently, i don't get anywhere.

hack-time...

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
