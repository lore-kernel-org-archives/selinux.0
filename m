Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2AFobRb019821
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 10:50:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2AFoa0F024428
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 15:50:36 GMT
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
        by jazzband.ncsc.mil  with SMTP id i2AFoZgZ024421 for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 15:50:35 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: newrole failed in enforcing mode
Date: Wed, 10 Mar 2004 16:50:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200403101650.07042.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

last week I've installed a topical fedora system (fc1) with the 
topical packages from the nsa site. After the installation the 
system runs fine, but today i want to change the role of the user 
root in the enforcing mode. This failed in contrast to the  
permissive mode. Newrole means invalid password and the syslog have 
only an entry "pam_unix authentication failure".

I've the same/similar problem using Chris LiveCD.

Have anybody similar problems? Does anybody know what the reason of 
this behavior?

Thanks

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
