Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17372
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:54:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA05087
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:53:53 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id RAA05083
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:53:52 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Stephen Smalley'" <sds@tislabs.com>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
Date: Thu, 11 Jul 2002 13:54:27 -0400
Message-ID: <00da01c22903$fff54520$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207111336390.15869-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

OK my /etc/syslogd.conf file contains this

*.*	/dev/tty24

when I boot or run-init I get this

allow syslogd_t tty_device_t:chr_file { append };
        #EXE=/sbin/syslogd  PATH=/dev/tty24   :  append

The avc from kern.log is this

Jul 11 13:51:17 debian kernel: avc:  denied  { append } for  pid=160
exe=/sbin/syslogd path=/dev/tty24 dev=72:01 ino=2175725
scontext=system_u:system_r:syslogd_t
tcontext=system_u:object_r:tty_device_t tclass=chr_file

Syntax is this:
debian:~# id
uid=0(root) gid=0(root) groups=0(root) context=root:sysadm_r:sysadm_t
sid=222

run_init /etc/init.d/sysklogd restart


Also states permission denied for /dev/tty24.  BTW in case anyone is
wondering /dev/tty1-12 is the left alt key, /dev/tty13-24 is the right
alt key.

Ed

=> -----Original Message-----
=> From: Stephen Smalley [mailto:sds@tislabs.com]
=> Sent: Thursday, July 11, 2002 1:39 PM
=> To: Ed Street
=> Cc: 'SE Linux'
=> Subject: RE: sysadm_tty_device_t
=> 
=> 
=> On Thu, 11 Jul 2002, Ed Street wrote:
=> 
=> > And sysadm_tty_device_t?
=> 
=> That was my point.  The ttys start in tty_device_t.  If login or
newrole
=> creates a sysadm_r:sysadm_t shell, then it relabels the tty to
=> sysadm_tty_device_t.  If login or newrole creates a user_r:user_t
shell,
=> then it relabels the tty to user_tty_device_t.  These relabeling
=> operations are based on type_change rules in the policy
configuration.
=> 
=> --
=> Stephen D. Smalley, NAI Labs
=> ssmalley@nai.com
=> 
=> 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
