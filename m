Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MDXSrT001853
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 09:33:28 -0400 (EDT)
Received: from www.pu.kielce.pl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MDXOWF010438
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 13:33:28 GMT
Received: from [81.26.8.20] (port=44452 helo=[81.26.8.20] ident=pipen)
	by www.pu.kielce.pl with asmtp (TLS-1.0:DHE_RSA_RIJNDAEL_128_CBC_SHA:16)
	(Exim 4.30)
	id 1CA7Bk-0004cE-7W
	for selinux@tycho.nsa.gov; Wed, 22 Sep 2004 15:29:40 +0200
Message-ID: <41517FA8.7050207@pu.kielce.pl>
Date: Wed, 22 Sep 2004 15:35:36 +0200
From: "Artur M. Piwko" <pipen@pu.kielce.pl>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Role questions
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. When I su - from myuser:staff_r:staff_t to root I'm still myuser,
    instead of root:staff_r:staff_t. What I did wrong?
2. How can one set up initial sysadm_r password? All i see is:

# newrole -r sysadm_r
Authenticating myuser.
newrole: incorrect password for myser

Artur

-- 
Artur M. Piwko : AMP29-RIPE : ISPC:+48413496205 : jab:pipen@jabberpl.org
Akademia Swietokrzyska  ::  Uczelniane Centrum Informatyczne  ::  Kielce
PGP id:B969478F finger:35E6 E3A3 8120 F000 1375 5A1C 23A8 1A71 B969 478F
"Death is just life's way of telling you you've been fired"  --  unknown

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
