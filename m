Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27908
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 09:33:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA11068
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 13:32:51 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id NAA11064
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 13:32:50 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Stephen Smalley'" <sds@tislabs.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: lsm3 notes
Date: Tue, 9 Jul 2002 09:33:24 -0400
Message-ID: <005401c2274d$33387be0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207090836321.27193-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

=> > I keep seeing /dev/xconsole avc's.
=> > This is from startup
=> > allow initrc_t device_t:fifo_file { setattr };
=> >         #EXE=/bin/chmod  PATH=/dev/xconsole   :  setattr
=> 
=> /dev/xconsole doesn't exist on my systems.  Feel free to define an
=> appropriate type and submit a patch to types/device.te and
=> file_contexts/type.fc, along with a patch to whatever domains require
=> access.  What creates this FIFO?

I'm not 100% sure why it's doing the file_fifo or the xconsole.  It does
warrant further investigation.

=> 
=> > startup as well
=> > allow initrc_t resolv_conf_t:file { setattr };
=> >         #EXE=/bin/chmod  PATH=/etc/resolv.conf   :  setattr
=> 
=> Why are your rc scripts changing the mode on /etc/resolv.conf?
=> In any event, this is probably harmless.

I think at load of services it's looking at /etc/resolv.conf for dns
issues but it eludes me as to why setattr is being issued.  Another good
reason for Selinux, is to see what linux is REALLY doing behind our
backs with out our knowing.

=> 
=> > when I ssh into the box
=> > allow sshd_t sysadm_home_t:dir { search };
=> >         #EXE=/usr/sbin/sshd  PATH=/root   :  search
=> 
=> Do you really need to login directly as root?

No I normally ssh in as a user and su to root.  I also noted that the
path is not being set correctly either.

=> 
=> > when I tried to tail syslog as user_r
=> > allow user_t var_log_t:file { getattr read };
=> >         #EXE=/bin/bash  PATH=/var/log/syslog   :  getattr
=> >         #EXE=/usr/bin/tail  PATH=/var/log/syslog   :  read
=> 
=> Do you really want to permit ordinary users to read your logs?

No, this can be ignored and I should have left it out.  Figured I would
see what it gave in this case.

=> 
=> > Most notably problems with sysklogd, and it's not writing events to
=> > /var/log/syslog
=> 
=> Are klogd and syslogd running in the right domains?

Yes klogd and syslogd is running correctly.  Seems that Selinux is
denying access to both on a restart.  I am in agreement they may not
have the correct label (same issue as raid devices )

IN any case this is definitely turning out to be a very fun project to
be working on.  It's proving some rather insightful views into linux.

Ed


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
