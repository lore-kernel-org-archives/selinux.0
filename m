Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA14375
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 13:59:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA16297
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 17:58:39 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id RAA16292 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 17:58:34 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152436C@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: newrules
Date: Thu, 25 Apr 2002 12:59:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

on Thursday, April 25, 2002 12:44 PM, Russell Coker wrote: 

> > if a program does not need a permission such as lock, poll and ioctl
> > don't grant that permission. As we develop more finer grained access
> > rules program should only be granted the permission they need
> > and nothing else. In security terms only grant what is need.
> 
> I understand the point, however with the current sample 
> policy I'm working on it is already over 10K lines of code.  The 
> more code the harder it is to audit...


You have a very good point, and its only going to get worse. 
We need a program to handle the policies. (To all those lurking
on the list wanting something to do)

Are you going to include apol ?

Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
