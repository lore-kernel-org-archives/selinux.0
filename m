Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PEr6Qv027119
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 10:53:06 -0400
Received: from web86913.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3PEr5d2000866
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 14:53:05 GMT
Message-ID: <20070425145254.54446.qmail@web86913.mail.ukl.yahoo.com>
Date: Wed, 25 Apr 2007 14:52:54 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: cannot login using strict policy
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have installed strict policy and then relabelled the files using 'fixfiles relablel' after rebooting with 'enforcing=0 single'. Every thing went well, but when i try to login, i get an error message that 
localuser:root being added to access control list
-/bin/bash: /root/.bash_profile: permission denied.
Any idea?
Best,
JG


      ___________________________________________________________
Yahoo! Answers - Got a question? Someone out there knows the answer. Try it
now.
http://uk.answers.yahoo.com/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
