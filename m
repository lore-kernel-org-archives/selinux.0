Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m374DSj6016782
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 00:13:29 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m374DPos021806
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 04:13:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 3EC3418E5D
	for <selinux@tycho.nsa.gov>; Mon,  7 Apr 2008 14:13:22 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Claf7n9jOoTV for <selinux@tycho.nsa.gov>;
	Mon,  7 Apr 2008 14:13:22 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 0038B18E53
	for <selinux@tycho.nsa.gov>; Mon,  7 Apr 2008 14:13:21 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id BC46820EC5
	for <selinux@tycho.nsa.gov>; Mon,  7 Apr 2008 14:13:20 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: mcstransd
Date: Mon, 7 Apr 2008 15:13:15 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804071413.20072.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a plan for a mlstransd daemon?  If there is no plan for a different 
daemon for translating MLS contexts then this should be renamed to senstransd 
or something similar.

Also the man page mcs.8 (which incidentally needs the following patch) 
probably belongs somewhere else.  We need a mls.8 as well, and a man page for 
mcstransd (which I'll write soon).

--- mcstrans-0.2.7.orig/man/man8/mcs.8
+++ mcstrans-0.2.7/man/man8/mcs.8
@@ -20,7 +20,7 @@
 Certain applications like printing and auditing will use these labels to
 identify the files.  By setting a category on a file you will prevent
 other applications/services from having access to the files.
-.p
+.P
 Examples of file lables would be PatientRecord, CompanyConfidential etc.

 .SH "SEE ALSO"

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
