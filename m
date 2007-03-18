Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2I9suaR014607
	for <selinux@tycho.nsa.gov>; Sun, 18 Mar 2007 05:54:56 -0400
Received: from web86913.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2I9ss2N010531
	for <selinux@tycho.nsa.gov>; Sun, 18 Mar 2007 09:54:55 GMT
Message-ID: <20070318095444.98257.qmail@web86913.mail.ukl.yahoo.com>
Date: Sun, 18 Mar 2007 09:54:44 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: errors in debugging "services.c"
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Every body,

  I have included some "print" and some "manipulation"
statements with the ss/services.c file, in order to
get some of output, at various places during kernel
compilation.

 Unfortunately, i was not successful, in doing so, and
got a long list of errors, for missing standard
libraries e.g: 

security/selinux/ss/services.c:44:19: error: stdio.h:
No such file or directory
error: string.h: No such file or directory
error: stdlib.h: No such file or directory
error: stdint.h: No such file or directory
error: stderr undeclared (first use in this function)

(i have truncated the errors, because they were too
much verbose)


The difficulty is that, when i execute these print and
manipulation statements as a sepeate file within the
kerncel source tree i.e. within ss/, no problem at
all, and all went well. I think so, i am making some
path problems. If some body, can suggest me some thing
in this regard.

Thanking you in advance.
Best,
MA




		
___________________________________________________________ 
The all-new Yahoo! Mail goes wherever you go - free your email address from your Internet provider. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
