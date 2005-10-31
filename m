Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9VFcNMA013605
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 10:38:23 -0500 (EST)
Received: from web51513.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j9VFXZmc017408
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 15:33:35 GMT
Message-ID: <20051031153235.87168.qmail@web51513.mail.yahoo.com>
Date: Mon, 31 Oct 2005 07:32:35 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: audit logging & log callback for avc
To: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I have run across a problem as perhaps the only user of the log callback for
avcs. I want to get the correct uid & loginuid of the user receiving the MAC
denial in the message. For example, in dbus, you could get this message:

Oct 6 20:47:39 devsvr01 dbus: Can't send to audit system: USER_AVC
pid=2426 uid=81 loginuid=-1 message=avc: denied { send_msg } for
scontext=root:system_r:unconfined_t tcontext=user_u:system_r:initrc_t
tclass=dbus

loginuid is unset since dbus is a daemon started by init & uid is the dbus
daemon's uid. The log callback function signature is:

void log_callback (const char *fmt, ...);

So, either the callback needs to have the parameters passed for auid & uid or the
message being generated needs to include this info.

Which way is the best to handle this scenario?

Thanks,
-Steve Grubb


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
