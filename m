Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MCYddW022194
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 07:34:39 -0500 (EST)
Received: from mail.ardley.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MCWKZE022886
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 12:32:22 GMT
Received: from [203.31.40.3] (ws3.electrosilk.net [203.31.40.3])
	by mail.ardley.org (Postfix) with ESMTP id 03D48608001
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 20:32:20 +0800 (WST)
Message-ID: <421B2654.4000305@ardley.org>
Date: Tue, 22 Feb 2005 20:32:20 +0800
From: Jeremy Ardley <jeremy@ardley.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: squirrelmail, Fedora Core 3, Apache, mail not sent
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have recently installed Fedora Core 3 and enabled squirrelmail under 
apache. I am using postfix as my mail agent

Everything I have done has been straight out of the FC3 install kit.

My squirrelmail works to read mail but when I send mail, the mail is 
listed as sent but just disappears. When I check /var/log/messages I see 
entries like

Feb 22 13:46:26 mail kernel: audit(1109051186.061:0): avc:  denied  { 
search } for  pid=12910 exe=/usr/sbin/httpd name=spool dev=dm-0 
ino=4030501 scontext=root:system_r:httpd_t Feb 22 13:45:01 mail kernel: 
audit(1109051101.245:0): avc:  denied  { search } for  pid=12831 
exe=/usr/sbin/httpd name=spool dev=dm-0 ino=4030501 
scontext=root:system_r:httpd_t tcontext=system_u:object_r:var_spool_t 
tclass=dir
Feb 22 13:45:01 mail kernel: audit(1109051101.285:0): avc:  denied  { 
search } for  pid=12831 exe=/usr/sbin/httpd name=spool dev=dm-0 
ino=4030501 scontext=root:system_r:httpd_t 
tcontext=system_u:object_r:var_spool_t tclass=dir
Feb 22 13:46:14 mail kernel: audit(1109051174.991:0): avc:  denied  { 
getattr } for  pid=12908 exe=/usr/sbin/httpd path=/var/spool dev=dm-0 
ino=4030501 scontext=root:system_r:httpd_t 
tcontext=system_u:object_r:var_spool_t tclass=dir
Feb 22 13:46:14 mail kernel: audit(1109051174.991:0): avc:  denied  { 
search } for  pid=12908 exe=/usr/sbin/httpd name=spool dev=dm-0 
ino=4030501 scontext=root:system_r:httpd_t 
tcontext=system_u:object_r:var_spool_t tclass=dir
Feb 22 13:46:15 mail kernel: audit(1109051175.511:0): avc:  denied  { 
search } for  pid=12909 exe=/usr/sbin/httpd name=spool dev=dm-0 
ino=4030501 scontext=root:system_r:httpd_t 
tcontext=system_u:object_r:var_spool_t tclass=dir

I strongly suspect selinux. What do I need to do to make squirrelmail work?

Thanks

Jeremy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
