Subject: openssh (run_init messages)
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 26 Aug 2002 12:45:25 -0400
Message-Id: <1030380325.29145.92.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I did have time...


avc:  denied  { transition } for  pid=1125
exe=/usr/local/selinux/sbin/run_init path=/etc/rc.d/init.d/sshd
dev=03:06 ino=18409 scontext=timothy:sysadm_r:sysadm_t
tcontext=system_u:system_r:initrc_t tclass=process


Timothy,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
