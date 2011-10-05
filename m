Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p95IUKUv002817
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 14:30:20 -0400
Received: from smtp27.mail.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p95IUIQh016797
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 18:30:19 GMT
Received: from [95.78.147.197] (port=21379 helo=localhost.localdomain)
	by smtp27.mail.ru with asmtp
	id 1RBWEJ-0003XC-00
	for selinux@tycho.nsa.gov; Wed, 05 Oct 2011 22:30:07 +0400
To: selinux@tycho.nsa.gov
Subject: New HIPS based on SELinux
From: Hramchenko <hramchenko@bk.ru>
Date: Thu, 6 Oct 2011 00:30:05 +0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201110060030.05639.hramchenko@bk.ru>
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
