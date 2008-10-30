Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9UJE1Ct025360
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 15:14:01 -0400
Received: from thumper.research.telcordia.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9UJCSbY012357
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 19:12:28 GMT
Received: from [127.0.0.1] (vpntnlA166.research.telcordia.com [128.96.58.166])
	by thumper.research.telcordia.com (8.13.6/8.13.5) with ESMTP id m9UJDxpj010165
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 15:14:00 -0400 (EDT)
Message-ID: <490A0775.8040001@research.telcordia.com>
Date: Thu, 30 Oct 2008 15:13:57 -0400
From: Sanjai Narain <narain@research.telcordia.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux policy parser
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I would appreciate pointers to any tools that parse SELinux 
policy files (either text or binary). I am planning to write algorithms 
to analyze such policies.

Not sure if this makes sense but given that tools like apol  read policy 
files, can they be made to dump their internal representations into a 
text file?

Thanks. -- Sanjai


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
