Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06BriBJ000469
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 06:53:44 -0500
Received: from rn-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n06Bp4jP023899
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 11:51:04 GMT
Received: by rn-out-0910.google.com with SMTP id k40so5311954rnd.17
        for <selinux@tycho.nsa.gov>; Tue, 06 Jan 2009 03:53:43 -0800 (PST)
Subject: Postfix with domain keys
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2009 10:06:21 -0200
Message-Id: <1231243582.2946.106.camel@kr0sty.livra.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello list!


I'm a little stuck with selinux and postfix, hope you can give me
feedback with it.

We're trying to add domain keys to a postfix server, but it can't open
ports used by dkim to sign the mail. Here is some output of audit.log:


type=AVC msg=audit(1231242373.605:52): avc:  denied  { name_bind } for
pid=5386 comm="master" src=10026
scontext=root:system_r:postfix_master_t:s0
tcontext=system_u:object_r:postfix_master_t:s0 tclass=tcp_socket

type=SYSCALL msg=audit(1231242373.605:52): arch=c000003e syscall=49
success=no exit=-13 a0=11 a1=2b06cdbc46d0 a2=10 a3=7fffe2d2f64c items=0
ppid=1 pid=5386 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
fsgid=0 tty=(none) ses=3 comm="master" exe="/usr/libexec/postfix/master"
subj=root:system_r:postfix_master_t:s0 key=(null)



I've allready added the port to the postfix_master_t domain with:
# semanage port -a -t postfix_master_t -p tcp 10026


Here is the maillog output:

postfix/postfix-script: starting the Postfix mail system
postfix/master[5386]: fatal: bind 127.0.0.1 port 10026: Permission
denied


It's a RHEL 5.2 and kernel 2.6.18-92.1.22.el5.



Any kind of help is appreciated :)


Cheers


Martín


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
