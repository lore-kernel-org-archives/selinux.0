Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13758
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 12:42:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA12187
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 16:41:02 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id QAA12181 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 16:41:01 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152436B@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: newrules
Date: Thu, 25 Apr 2002 11:42:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

on Thursday, April 25, 2002 11:20 AM, Russell Coker wrote:

> Also for the newrules.pl, "read" should usually be changed to
r_file_perms 
> and "read write" should usually be changed to rw_file_perms.
> 
This is where we have a difference of option. I don't use the
macros a whole lot. I test and retest the rules and behavior 
of the program I am creating. The newrules.pl will create
a read and as you stated you should change to r_file_perms.
This is where I disagree. Why grant extra permission
such as for r_file_perms { read getattr access lock poll ioctl }
if a program does not need a permission such as lock, poll and ioctl
don't grant that permission. As we develop more finer grained access 
rules program should only be granted the permission they need 
and nothing else. In security terms only grant what is need.
For example in getting a security clearance you are only granted
access to what you need to know.

I can go through all the macros and describe many access that 
are granted, but are needed. 


Mark
 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
