Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13561
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:00:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA10527
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 16:57:12 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id QAA10523
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 16:57:11 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h1JH0JK31964
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:00:19 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h1JH0Ja26730
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:00:19 -0500
Received: from redhat.com (redsox.boston.redhat.com [172.16.65.225])
	by mail.boston.redhat.com (8.11.6/8.11.6) with ESMTP id h1JH0HA14224
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:00:17 -0500
Message-ID: <3E53B822.8060603@redhat.com>
Date: Wed, 19 Feb 2003 12:00:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Ok what am I doing wrong?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I did a make quickinstall and added support for ext3 and networking.
I have never gotten newrole to work correctly.  Is there some step that 
I am missing?

[root@pxe src]# id
uid=0(root) gid=0(root) 
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) 
context=root:user_r:user_t sid=324
[root@pxe src]# newrole -r sysadmin_r
Couldn't get default type.
[root@pxe src]# newrole -r sysadmin_r -t sysadmin_t
Authenticating root.
Password:
root:sysadmin_r:sysadmin_t is not a valid context



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
