Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA8DqIBS030281
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 08:52:18 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA8DqHdJ018566
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 13:52:17 GMT
Received: from [IPv6:2001:6f8:900:6e8::2] (cl-1769.ham-01.de.sixxs.net [IPv6:2001:6f8:900:6e8::2])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id lA8DqPAN009613
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 14:52:27 +0100
Subject: type class key
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 08 Nov 2007 13:52:13 +0000
Message-Id: <1194529933.3293.7.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Every time I log into my system via ssh an audit is generated:

audit(1194529539.754:7803673): avc:  denied  { link } for  pid=9526
comm="sshd" scontext=system_u:system_r:sshd_t:s0-s0:c0.c1023
tcontext=system_u:system_r:dovecot_t:s0 tclass=key

and after logout the following:

audit(1194529580.969:7803674): avc:  denied  { search } for  pid=9526
comm="sshd" scontext=system_u:system_r:sshd_t:s0-s0:c0.c1023
tcontext=system_u:system_r:dovecot_t:s0 tclass=key

Quite frankly I even do not know what a type class "key" is. Can someone
explain to me what a type class "key" is? And maybe any suggestions why
ssh tries to access dovecot's key (which is an imap server).

cheers,
Stefan

PS: I'm running CentOS 5 with the latest updates and strict policy.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
