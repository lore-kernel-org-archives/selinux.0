Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i57NIcrT008394
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 19:18:38 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i57NIYcx013943
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 19:18:35 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 7 Jun 2004 23:18:36 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BXSkA-0001K3-81
	for selinux@tycho.nsa.gov; Mon, 07 Jun 2004 22:37:26 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BXTLQ-0001WF-VZ
	for selinux@tycho.nsa.gov; Mon, 07 Jun 2004 23:15:56 +0000
Date: Mon, 7 Jun 2004 23:15:56 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: dpkg fails on installing nvidia-glx because /etc/init.d/nvidia-glx start is run
Message-ID: <20040607231556.GI3305@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya (russell?)

i just installed the nvidia-glx package (don't ask :)

i think i got it to install - by editing /etc/init.d/nvidia-glx
and temporarily putting exit 0 at the top of it.

is there provision for dpkg running /etc/init.d/NNNN scripts
and correctly... oh.

darn.

i get it.

i need to write an nvidia-glx policy, don't i?

:)

-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
