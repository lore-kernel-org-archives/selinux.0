Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0BKd9ci016272
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 15:39:12 -0500
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0BKe0xG028110
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 20:40:00 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0BKe0RJ016844
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 15:40:00 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l0BKdUmo297498
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 15:39:55 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0BKdTjT015061
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 15:39:29 -0500
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.63.176])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0BKdTiQ015035
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 15:39:29 -0500
Message-ID: <45A6A064.2040707@us.ibm.com>
Date: Thu, 11 Jan 2007 14:39:00 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [RFC] clarifications for -l to newrole.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Based on some discussion from irc and some complaints I have received, 
I'm proposing this addition (comments or other suggestions welcome) to 
the newrole manage. This example section would slot in right after the 
DESCRIPTION section. Patch below.

EXAMPLE
        Changing sensitivity only:
           # id -Z
           user:role:type:SystemLow-SystemHigh
           # newrole -l Unclassified
           # id -Z
           user:role:type:Unclassified-SystemHigh

        Changing sensitivity and clearance:
           # id -Z
           user:role:type:SystemLow-SystemHigh
           # newrole -l Unclassified-Unclassified
           # id -Z
           user:role:type:Unclassified-Unclassified

Thanks,
Mike

---

--- newrole.1.orig      2007-01-11 14:24:51.000000000 -0600
+++ newrole.1   2007-01-11 14:31:51.000000000 -0600
@@ -57,6 +57,21 @@
  .B --version
  shows the current version of newrole
  .PP
+.SH EXAMPLE
+.br
+Changing sensitivity only:
+   # id -Z
+   user:role:type:SystemLow-SystemHigh
+   # newrole -l Unclassified
+   # id -Z
+   user:role:type:Unclassified-SystemHigh
+.PP
+Changing sensitivity and clearance:
+   # id -Z
+   user:role:type:SystemLow-SystemHigh
+   # newrole -l Unclassified-Unclassified
+   # id -Z
+   user:role:type:Unclassified-Unclassified
  .SH FILES
  /etc/passwd - user account information
  .br



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
