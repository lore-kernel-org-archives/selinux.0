Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6LNB5ah021415
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 19:11:05 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6LNB4E6004169
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 23:11:05 GMT
Received: from 78-3-104-211.adsl.net.t-com.hr ([78.3.104.211] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <warner@rubix.com>)
	id 1KL4Wx-00060h-SD
	for selinux@tycho.nsa.gov; Mon, 21 Jul 2008 16:11:02 -0700
Message-ID: <48851770.5020002@rubix.com>
Date: Tue, 22 Jul 2008 01:10:40 +0200
From: Andrew Warner <warner@rubix.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: questions about persistent storage of security contexts
Content-Type: multipart/alternative;
 boundary="------------010200060207060006040407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010200060207060006040407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am currently developing an "SELinux aware" DBMS (primarily TE and MLS) 
that is characterized by:

1. The need to store a security context (in some recoverable form) in 
our persistent database (storage size of the context is an important factor)
2. The need to frequently perform a high number of security access 
checks in a performance sensitive way

My question relates to the first characteristic from above. I am having 
trouble deciding on the best way to store the security context in the 
database. From my research I  see (I think!) three different 
representations for a security context: 1) string; 2) raw; 3) SID. 

The string representation, generally, seems clear as this is what is 
shown in all documentation as the context representation that exists in 
user space. My only question regarding the string representation is: is 
there is any hard limit to the length of the security context string? Do 
I need to allow for no theoretical size limit on a context string if I 
choose to store it?

I am inferring the the raw representation exists from seeing *_raw 
functions (e.g., security_compute_create_raw) referenced in selinux 
header files. Other than seeing these functions declared I am having 
trouble finding out much about a raw representation. Is there any 
advantage to storing/manipulating a context in its raw representation? 
That is, are they more suited for a fast security access check, are they 
smaller in size, or do they have a fixed or maximum length?

The SID I have also seen mentioned in various documentations but can 
determine little about them. My guess is that they are an integer value 
that is used for fast internal access, particularly for the AVC. Are 
SIDs indeed integer values? Are they persistent or are they meaningful 
only for a particular OS session?

I have also considered maintaining my own internal, persistent mapping 
between string based contexts and an integer representation, the mapping 
being stored/indexed inside the DBMS. This gives me a small storage 
overhead with a fixed size.

Any answers, pointers to documentation, or other help would be greatly 
appreciated!

Andy Warner


--------------010200060207060006040407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">Hello,<br>
<br>
I am currently developing an "SELinux aware" DBMS (primarily TE and
MLS) that is characterized by:<br>
<br>
1. The need to store a security context (in some recoverable form) in
our persistent database (storage size of the context is an important
factor)<br>
2. The need to frequently perform a high number of security access
checks in a performance sensitive way<br>
<br>
My question relates to the first characteristic from above. I am having
trouble deciding on the best way to store the security context in the
database. From my research I&nbsp; see</font><font face="Arial"> (I think!)</font><font
 face="Arial"> three different representations for a security context:
1) string; 2) raw; 3) SID.&nbsp; <br>
<br>
The string representation, generally, seems clear as this is what is
shown in all documentation as the context representation that exists in
user space. My only question regarding the string representation is: is
there is any hard limit to the length of the security context string?
Do I need to allow for no theoretical size limit on a context string if
I choose to store it?<br>
<br>
</font><font face="Arial">I am inferring </font><font face="Arial">the
the raw representation exists from seeing *_raw functions (e.g.,
security_compute_create_raw) referenced in selinux header files. Other
than seeing these functions declared I am having trouble finding out
much about a raw representation. Is there any advantage to
storing/manipulating a context in its raw representation? That is, are
they more suited for a fast security access check, are they smaller in
size, or do they have a fixed or maximum length?<br>
<br>
The SID I have also seen mentioned in various documentations but can
determine little about them. My guess is that they are an integer value
that is used for fast internal access, particularly for the AVC. Are
SIDs indeed integer values? Are they persistent or are they meaningful
only for a particular OS session?<br>
<br>
I have also considered maintaining my own internal, persistent mapping
between string based contexts and an integer representation, the
mapping being stored/indexed inside the DBMS. This gives me a small
storage overhead with a fixed size.<br>
<br>
Any answers, pointers to documentation, or other help would be greatly
appreciated!<br>
<br>
Andy Warner<br>
<br>
</font>
</body>
</html>

--------------010200060207060006040407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
