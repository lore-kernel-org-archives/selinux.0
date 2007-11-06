Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6D1J8c010177
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 08:01:19 -0500
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA6D1Bsc018103
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 13:01:17 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 2570318B62
	for <selinux@tycho.nsa.gov>; Wed,  7 Nov 2007 00:00:56 +1100 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nymKPYkSxqj for <selinux@tycho.nsa.gov>;
	Wed,  7 Nov 2007 00:00:55 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id E022D181BB
	for <selinux@tycho.nsa.gov>; Wed,  7 Nov 2007 00:00:55 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id A93ED21A23
	for <selinux@tycho.nsa.gov>; Wed,  7 Nov 2007 00:00:54 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: hkp port
Date: Wed, 7 Nov 2007 00:00:51 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711070000.53780.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://etbe.coker.com.au/2007/11/06/squid-and-se-linux/

As described in the above URL I believe that port 11371 (for GPG key transfer) 
needs to be labelled as http_port_t to permit GPG to use Squid.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
