Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA25819
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 01:33:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA25089
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 05:33:18 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id FAA25085
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 05:33:17 GMT
Received: from ed (ed1 [192.168.1.10])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 3BD3C844054
	for <selinux@tycho.nsa.gov>; Tue,  9 Jul 2002 01:33:51 -0400 (EDT)
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: <selinux@tycho.nsa.gov>
Subject: lsm3 notes
Date: Tue, 9 Jul 2002 01:33:51 -0400
Message-ID: <005301c2270a$350a2a10$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200207082016.36223.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Couple of things I noted about the new lsm3 

I keep seeing /dev/xconsole avc's. 

This is from startup
allow initrc_t device_t:fifo_file { setattr };
        #EXE=/bin/chmod  PATH=/dev/xconsole   :  setattr

startup as well
allow initrc_t resolv_conf_t:file { setattr };
        #EXE=/bin/chmod  PATH=/etc/resolv.conf   :  setattr


when I ssh into the box
allow sshd_t sysadm_home_t:dir { search };
        #EXE=/usr/sbin/sshd  PATH=/root   :  search

when sysklogd starts at boot
allow syslogd_t device_t:fifo_file { read write };
        #EXE=/sbin/syslogd  PATH=/dev/xconsole   :  read write

when I tried to tail syslog as user_r
allow user_t var_log_t:file { getattr read };
        #EXE=/bin/bash  PATH=/var/log/syslog   :  getattr
        #EXE=/usr/bin/tail  PATH=/var/log/syslog   :  read

Most notably problems with sysklogd, and it's not writing events to
/var/log/syslog

Ed


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
