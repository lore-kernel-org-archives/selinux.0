Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75I36rT007196
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 14:03:06 -0400 (EDT)
Received: from smtp.polymtl.ca (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i75I2Vn4024484
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 18:02:32 GMT
Received: from fugusec.net (dsl-207-112-20-65.tor.primus.ca [207.112.20.65])
	by smtp.polymtl.ca (8.13.0/8.13.0) with ESMTP id i75I2rsx009516
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 14:02:59 -0400
Message-ID: <41127650.5060007@fugusec.net>
Date: Thu, 05 Aug 2004 14:02:56 -0400
From: Alexis Wagner <venon@fugusec.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: netifcon
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have read this comment in the file attrib.te : ... operations on the 
interface (XXX obsolete, not supported via LSM) .

I would like to know if I define a security context for an interface via 
netifcon would it be supported by SELinux ?

Thank you,

Alexis Wagner


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
