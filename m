Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j29FrnDo024359
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 10:53:50 -0500 (EST)
Received: from newi.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j29FmtVV014020
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 15:48:56 GMT
Message-Id: <6.2.1.2.0.20050309144019.03a894d0@cronus.newi.ac.uk>
Date: Wed, 09 Mar 2005 14:49:05 +0000
To: selinux@tycho.nsa.gov
From: Mark Davies <m.p.davies@newi.ac.uk>
Subject: memory access restrictions
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_21478187==.ALT"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=====================_21478187==.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

All,

 From what I have seen of SELinux and (most) other operating systems there 
is no control over what memory locations a program running can access. 
Malicious code in user areas could therefore access privileged information 
that has been put into memory by other programs, specifically worrying is 
the ability to access system level programs. With access is the potential 
for such data to be altered to help a user raise their privileges and so 
this is potentially a security concern. My question is, therefore, is 
anything being done to counteract this? My first idea was to have the 
kernel create an "exception" (not really the right term I know) in a 
program that tries to access any memory that has not been allocated to it. 
Your comments would be greatly appreciated, especially since I should like 
to implement such controls in the short term.





Mark Davies

Department Of Computing
North East Wales Institute
Wrexham
<http://www.daviessolutions.co.uk/>http://www.daviessolutions.co.uk
http://www.newi.ac.uk/daviesmp/
(+44) (01978) 293431


Mark Davies

Department Of Computing
North East Wales Institute
Wrexham
<http://www.daviessolutions.co.uk/>http://www.daviessolutions.co.uk
http://www.newi.ac.uk/daviesmp/  
--=====================_21478187==.ALT
Content-Type: text/html; charset="us-ascii"

<html>
<body>
All,<br><br>
 From what I have seen of SELinux and (most) other operating systems
there is no control over what memory locations a program running can
access. Malicious code in user areas could therefore access privileged
information that has been put into memory by other programs, specifically
worrying is the ability to access system level programs. With access is
the potential for such data to be altered to help a user raise their
privileges and so this is potentially a security concern. My question is,
therefore, is anything being done to counteract this? My first idea was
to have the kernel create an &quot;exception&quot; (not really the right
term I know) in a program that tries to access any memory that has not
been allocated to it. Your comments would be greatly appreciated,
especially since I should like to implement such controls in the short
term.<br><br>
<br><br>
<br>
<x-sigsep><p></x-sigsep>
Mark Davies<br><br>
Department Of Computing<br>
North East Wales Institute<br>
Wrexham<br>
<a href="http://www.daviessolutions.co.uk/">
http://www.daviessolutions.co.uk</a><br>
<a href="http://www.newi.ac.uk/daviesmp/" eudora="autourl">
http://www.newi.ac.uk/daviesmp/</a> <br>
(+44) (01978) 293431 </body>
<br>

<body>
<br><br>
Mark Davies<br><br>
Department Of Computing<br>
North East Wales Institute<br>
Wrexham<br>
<a href="http://www.daviessolutions.co.uk/">
http://www.daviessolutions.co.uk</a><br>
<a href="http://www.newi.ac.uk/daviesmp/" eudora="autourl">
http://www.newi.ac.uk/daviesmp/</a> </body>
</html>

--=====================_21478187==.ALT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
