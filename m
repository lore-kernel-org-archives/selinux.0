Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3P7Z88k003267
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 03:35:08 -0400
Received: from web86906.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3P7Z6gn025832
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 07:35:07 GMT
Date: Wed, 25 Apr 2007 07:34:51 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: cannot login using strict policy
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <513467.73422.qm@web86906.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Boot with 'enforcing=0 single', then run 'fixfiles
> relabel' if it
> doesn't automatically relabel, then reboot normally.


I installed strict policy and then relabelled the files using 'fixfiles relablel' after rebooting with 'enforcing=0 single'. Every thing went well, but when i try to login, i get an error message that 

localuser:root being added to access control list
-/bin/bash: /root/.bash_profile: permission denied.

Any idea?

Best,
JG


      ___________________________________________________________ 
Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for
your free account today http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
