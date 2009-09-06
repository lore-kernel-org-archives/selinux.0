Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n86H1Lbe019032
	for <selinux@tycho.nsa.gov>; Sun, 6 Sep 2009 13:01:21 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n86H0f51029011
	for <selinux@tycho.nsa.gov>; Sun, 6 Sep 2009 17:00:41 GMT
Received: from [IPv6:2001:6f8:1294:1:211:24ff:fee1:776c] ([IPv6:2001:6f8:1294:1:211:24ff:fee1:776c])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id n86H1Ghv017993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Sun, 6 Sep 2009 19:01:19 +0200
Subject: [refpolicy] shutdown domain
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 06 Sep 2009 19:01:15 +0200
Message-Id: <1252256475.22458.5.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

are there any plans to create a shutdown domain? For example a comment
in apcupsd.te asks for such a domain too:

# apcupsd runs shutdown, probably need a shutdown domain

Today, I'm running into the same problem. Are there any reasons _not_ to
create a shutdown domain? Otherwise I would like to create one.

cheers
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
