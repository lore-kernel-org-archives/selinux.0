Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89DmcLa029721
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 09:48:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h89DkkLY012281
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 13:46:46 GMT
Received: from mx1.avenit.de (nexus6.avenit.de [80.237.241.2])
	by jazzswing.ncsc.mil  with SMTP id h89DkesG012267
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 13:46:46 GMT
From: "Romix" <romix@php.cd>
To: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 15:47:55 +0200
Message-ID: <006101c376d8$fe52ab30$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200309092312.30592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

first thanks for your help :)

> > yes there are some messages, but i don´t understand them (is that 
> > explained somewhere?):
> >
> > avc:  denied  { read } for  pid=23997 exe=/usr/sbin/sshd 
> > path=socket:[257597] dev=00:00 ino=257597 
> > scontext=root:sysadm_r:sysadm_chkpwd_t
> > tcontext=root:sysadm_r:sysadm_chkpwd_t tclass=unix_stream_socket
> 
> This is wrong.  Either sshd has the wrong type or you started 
> it in the wrong manner.
> 
> Run "ls --context /usr/sbin/sshd" to see the type of the 
> file, it should be sshd_exec_t.

yes it is:
-rwxr-xr-x  root     root     system_u:object_r:sshd_exec_t
/usr/sbin/sshd


> > > Is sshd running in the correct context?  "ps --context | 
> > > grep sshd" 
> > > will show you the context.
> >
> > 23994    243 root:sysadm_r:sysadm_chkpwd_t            grep sshd
> >
> > is sysadm_chkpwd_t the right domain?
> 
> That's the context of the "grep" process, and it's not the 
> right domain for sshd or for grep.

sorry, i posted the wrong line, but sshd was running in the same context:
23618    243 root:sysadm_r:sysadm_chkpwd_t            /usr/sbin/sshd

so i changed it (i executed "/etc/init.d/sshd start" as root from a local
login and not via ssh):
24176    195 root:staff_r:staff_t                     /usr/sbin/sshd

but my user setest still can´t login...

and i still have a lot of avc messages:

avc:  denied  { search } for  pid=24197 exe=/bin/bash path=/sbin dev=03:03
ino=11151 scontext=root:staff_r:staff_chkpwd_t
tcontext=system_u:object_r:sbin_t tclass=dir
avc:  denied  { search } for  pid=24197 exe=/bin/bash path=/opt dev=03:03
ino=11148 scontext=root:staff_r:staff_chkpwd_t
tcontext=system_u:object_r:opt_t tclass=dir
avc:  denied  { syslog_read } for  pid=24205 exe=/bin/dmesg
scontext=root:staff_r:staff_chkpwd_t tcontext=system_u:system_r:kernel_t
tclass=system
avc:  denied  { append } for  pid=24992 exe=/usr/bin/ntpd
path=/var/log/ntpd.log dev=03:03 ino=110570 scontext=root:staff_r:staff_t
tcontext=root:object_r:var_log_t tclass=file
avc:  denied  { getattr } for  pid=24197 exe=/bin/bash path=/bin/ls
dev=03:03 ino=91418 scontext=root:staff_r:staff_chkpwd_t
tcontext=system_u:object_r:ls_exec_t tclass=file
avc:  denied  { execute } for  pid=24208 exe=/bin/bash path=/bin/ls
dev=03:03 ino=91418 scontext=root:staff_r:staff_chkpwd_t
tcontext=system_u:object_r:ls_exec_t tclass=file
avc:  denied  { execute_no_trans } for  pid=24208 exe=/bin/bash path=/bin/ls
dev=03:03 ino=91418 scontext=root:staff_r:staff_chkpwd_t
tcontext=system_u:object_r:ls_exec_t tclass=file
avc:  denied  { read } for  pid=24208 path=/bin/ls dev=03:03 ino=91418
scontext=root:staff_r:staff_chkpwd_t tcontext=system_u:object_r:ls_exec_t
tclass=file
avc:  denied  { read } for  pid=24208 exe=/bin/ls
scontext=root:staff_r:staff_chkpwd_t
tcontext=system_u:object_r:sysctl_kernel_t tclass=file

how do i solve/change this? does someone know a good book/documentation for
selinux? all what i found was not really helpful for someone who is new to
selinux...

regards,
Romain



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
