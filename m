Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17754
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 14:24:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24640
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:23:14 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id SAA24636 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:23:13 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Stephen Smalley'" <sds@tislabs.com>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
Date: Thu, 11 Jul 2002 14:24:41 -0400
Message-ID: <00dc01c22908$391e27f0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207111416400.21775-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Should the /dev/tty24 be sysadm_tty_device_t instead of tty_device_t?
Now here's the odd thing, I change /dev/tty24 to tty1, tty2 or tt3 and I
get sysadm_tty_device_t and there's no denied messages

Ed

=> -----Original Message-----
=> From: Stephen Smalley [mailto:sds@tislabs.com]
=> Sent: Thursday, July 11, 2002 2:20 PM
=> To: Ed Street
=> Cc: 'SE Linux'
=> Subject: RE: sysadm_tty_device_t
=> 
=> 
=> On Thu, 11 Jul 2002, Ed Street wrote:
=> 
=> > Hello,
=> >
=> > OK my /etc/syslogd.conf file contains this
=> >
=> > *.*	/dev/tty24
=> >
=> > when I boot or run-init I get this
=> >
=> > allow syslogd_t tty_device_t:chr_file { append };
=> >         #EXE=/sbin/syslogd  PATH=/dev/tty24   :  append
=> >
=> > The avc from kern.log is this
=> >
=> > Jul 11 13:51:17 debian kernel: avc:  denied  { append } for
pid=160
=> > exe=/sbin/syslogd path=/dev/tty24 dev=72:01 ino=2175725
=> > scontext=system_u:system_r:syslogd_t
=> > tcontext=system_u:object_r:tty_device_t tclass=chr_file
=> 
=> Right, this is what I would expect to happen.  What is your question,
=> exactly?  If you want syslogd to be able to write to a tty, you need
to
=> grant syslogd_t the necessary permission.  If you want to ensure that
=> only
=> syslogd can write to the tty, then define a new type, assign it to
the
=> tty
=> in types.fc (or use chcon directly), and grant syslogd_t permission
to
=> the
=> new type.  Otherwise, just allow syslogd_t tty_device_t:chr_file
append;
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
