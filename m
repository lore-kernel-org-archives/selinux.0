Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26030
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 14:46:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA24196
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 18:45:44 GMT
Received: from zai.com (zeta2.zai.com [12.47.112.34])
	by jazzswing.ncsc.mil  with ESMTP id SAA24191
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 18:45:43 GMT
Received: from [192.168.196.195] (zetaATTfw.zai.com [12.47.112.36])
	by zai.com (8.12.1/8.12.1) with ESMTP id g62Ij7B7002080
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 14:45:08 -0400 (EDT)
Subject: SELinux fresh out of the box problems...
From: Warren Lerner <wdl@zai.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="=-uvmxwJ/71aY6IjqgxBYK"
Date: 02 Jul 2002 14:48:30 -0400
Message-Id: <1025635710.1253.12.camel@montyburns>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uvmxwJ/71aY6IjqgxBYK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have recently done a fresh install of Red Hat 7.2.  At the conclusion
of this install, I did a fresh install of SELinux utilizing the "make
quickinstall" method.  After installation, I reboot and receive many AVC
messages.  Here is a small sample:

 kernel: avc:  denied  { execute } for  pid=1 exe=/sbin/init
path=/lib/i686/libc-2.2.5.so dev=03:42 ino=737295
scontext=system_u:system_r:init_t tcontext=system_u:object_r:writeable_t
tclass=file
 kernel: 
kernel: avc:  denied  { write } for  pid=1 exe=/sbin/init dev=00:08
ino=1 scontext=system_u:system_r:init_t
tcontext=system_u:object_r:devfs_t tclass=dir
kernel: 
kernel: avc:  denied  { add_name } for  pid=1 exe=/sbin/init
path=/initctl scontext=system_u:system_r:init_t
tcontext=system_u:object_r:devfs_t tclass=dir
kernel: 
kernel: avc:  denied  { create } for  pid=1 exe=/sbin/init path=/initctl
scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t
tclass=fifo_file
kernel: 
kernel: avc:  denied  { read write } for  pid=1 exe=/sbin/init
path=/initctl dev=00:08 ino=434 scontext=system_u:system_r:init_t
tcontext=system_u:object_r:devfs_t tclass=fifo_file
kernel: 
kernel: avc:  denied  { getattr } for  pid=1 exe=/sbin/init
path=/initctl dev=00:08 ino=434 scontext=system_u:system_r:init_t
tcontext=system_u:object_r:devfs_t tclass=fifo_file
kernel: 
kernel: avc:  denied  { execute } for  pid=11 exe=/sbin/init
path=/lib/ld-2.2.5.so dev=03:42 ino=1067699
scontext=system_u:system_r:init_t tcontext=system_u:object_r:file_t
tclass=file
kernel: 
kernel: avc:  denied  { execute } for  pid=11 exe=/bin/bash
path=/lib/i686/libc-2.2.5.so dev=03:42 ino=737295
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:writeable_t tclass=file

These messages are received after executing the "avc_toggle".  I made no
modifications to any SELinux files.  SELinux seems to generate many AVC
messages right out of the box, so to speak.

Here is what I would like to know:

1.  Can I install SELiunx with no modifications do an avc_toggle and
have a working system?
2.  Why do I receive AVC messages from SELinux before I have done an
avc_toggle?
3.  Is there a basic policy available for download that addresses the
"average" user's security    needs?
4.  Is there a GUI available for policy.conf modification that makes
understanding the file easier?  
5.  What is the minimum that must be done in order to have SELinux
function as intended?

Thank you for your time and consideration


-- 
Warren D. Lerner
Associate
Zeta Associates
10302 Eaton Place, Suite 500
Fairfax, Virginia 22030
(703)-279-5387

--=-uvmxwJ/71aY6IjqgxBYK
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/1.0.2">
</HEAD>
<BODY>
I have recently done a fresh install of Red Hat 7.2.&nbsp; At the conclusion of this install, I did a fresh install of SELinux utilizing the &quot;make quickinstall&quot; method.&nbsp; After installation, I reboot and receive many AVC messages.&nbsp; Here is a small sample:
<BR>

<BR>
 kernel: avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=1 exe=/sbin/init path=/lib/i686/libc-2.2.5.so dev=03:42 ino=737295 scontext=system_u:system_r:init_t tcontext=system_u:object_r:writeable_t tclass=file
<BR>
 kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { write } for&nbsp; pid=1 exe=/sbin/init dev=00:08 ino=1 scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t tclass=dir
<BR>
kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { add_name } for&nbsp; pid=1 exe=/sbin/init path=/initctl scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t tclass=dir
<BR>
kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { create } for&nbsp; pid=1 exe=/sbin/init path=/initctl scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t tclass=fifo_file
<BR>
kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { read write } for&nbsp; pid=1 exe=/sbin/init path=/initctl dev=00:08 ino=434 scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t tclass=fifo_file
<BR>
kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { getattr } for&nbsp; pid=1 exe=/sbin/init path=/initctl dev=00:08 ino=434 scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t tclass=fifo_file
<BR>
kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=11 exe=/sbin/init path=/lib/ld-2.2.5.so dev=03:42 ino=1067699 scontext=system_u:system_r:init_t tcontext=system_u:object_r:file_t tclass=file
<BR>
kernel: 
<BR>
kernel: avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=11 exe=/bin/bash path=/lib/i686/libc-2.2.5.so dev=03:42 ino=737295 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:writeable_t tclass=file
<BR>

<BR>
These messages are received after executing the &quot;avc_toggle&quot;.&nbsp; I made no modifications to any SELinux files.&nbsp; SELinux seems to generate many AVC messages right out of the box, so to speak.
<BR>

<BR>
Here is what I would like to know:
<BR>

<BR>
1.&nbsp; Can I install SELiunx with no modifications do an avc_toggle and have a working system?
<BR>
2.&nbsp; Why do I receive AVC messages from SELinux before I have done an avc_toggle?
<BR>
3.&nbsp; Is there a basic policy available for download that addresses the &quot;average&quot; user's security&nbsp;&nbsp;&nbsp; needs?
<BR>
4.&nbsp; Is there a GUI available for policy.conf modification that makes understanding the file easier?&nbsp; 
<BR>
5.&nbsp; What is the minimum that must be done in order to have SELinux function as intended?
<BR>

<BR>
Thank you for your time and consideration
<BR>

<BR>

<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>-- 
Warren D. Lerner
Associate
Zeta Associates
10302 Eaton Place, Suite 500
Fairfax, Virginia 22030
(703)-279-5387</PRE>
</TD>
</TR>
</TABLE>

</BODY>
</HTML>

--=-uvmxwJ/71aY6IjqgxBYK--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
