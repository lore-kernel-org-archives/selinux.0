Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p95HdF0j032053
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 13:39:15 -0400
Received: from smtp10.mail.ru (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p95HdDVp028609
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 17:39:14 GMT
Received: from [95.78.147.197] (port=24605 helo=localhost.localdomain)
	by smtp10.mail.ru with asmtp
	id 1RBVR1-00077x-00
	for selinux@tycho.nsa.gov; Wed, 05 Oct 2011 21:39:11 +0400
From: Hramchenko <hramchenko@bk.ru>
To: SELinux <selinux@tycho.nsa.gov>
Subject: New HIPS based on SELinux
Date: Wed, 5 Oct 2011 23:39:10 +0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201110052339.10341.hramchenko@bk.ru>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all. 

I have created new host intrusion prevention system based on SELinux. 
It's focused on protection user's data. 
One of the main goals was to create lightweight replacement of 
setroubleshootd. 

I hope my program will be useful for SELinux users. 

The project home page:  
https://github.com/Hramchenko/userdatadefence/

With respect, Hramchenko Vitaliy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
