Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA10685
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 19:01:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA15419
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 22:59:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA15415 for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 22:59:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 82AE892461
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 09:01:06 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 71DDA1F38
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 01:00:56 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ichsid
Date: Fri, 14 Jun 2002 01:00:56 +0200
MIME-Version: 1.0
Message-Id: <20020613230056.71DDA1F38@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe that we need a program "ichsid" to change the SID of a file by 
Inode instead of by name.

The reason for this is for the mount points of /dev, /proc, /usr, and other 
file systems that are not easily/conveniantly umountable.

Providing this functionality as part of the setfiles ability to change the 
context database directly when running on a non-SE kernel should not be 
difficult, and would provide the minimum functionality for getting SE Linux 
on a machine with a few reboots (boot into SE Linux, see messages such as the 
following, boot into non-SE Linux to run setfiles, then boot SE again) or 
with some debugfs work.

Providing it as part of the kernel interface would be even more useful.

avc:  denied  { mounton } for  pid=217 exe=/bin/mount path=/var/cache 
dev=09:01 ino=144930 scontext=system_u:system_r:mount_t 
tcontext=system_u:object_r:var_t tclass=dir

Now if I want to change the SID of /var/cache I'll have to kill squid first...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
