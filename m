Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA17226
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 09:38:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA08590
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 14:38:31 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA08586
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 14:38:31 GMT
Date: Tue, 20 Feb 2001 09:37:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Mark Slagell <ms@iastate.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: scontext/tcontext/tclass
In-Reply-To: <3A91639D.3BD5A0E6@iastate.edu>
Message-ID: <Pine.SOL.3.95.1010220092233.25753C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


As others have mentioned, scontext is an abbreviation for source security
context, tcontext is an abbreviation for target security context, and
tclass is an abbreviation for target security class.  Each permission
check is based on a pair of security contexts and a security class.
Typically, the source security context corresponds to a subject 
(a process) and the target security context corresponds to an object.
However, some permissions are subject-to-subject in order to control
operations such as signal delivery, and some permissions are
object-to-object in order to control inter-object relationships
such as the relationship between a mount point directory and
the mounted directory.

> avc:  denied { kill } for  pid=14271 exe=/usr/sbin/identd capability=5
>    scontext=system_u:system_r:inetd_child_t
>    tcontext=system_u:system_r:inetd_child_t
>    tclass=capability

We have not yet defined a separate domain for the IDENT daemon,
so it currently runs in the generic domain "inetd_child_t" used
for descendants of inetd that do not have their own individual domains.
You can find the domain definition for inetd_child_t in
policy/domains/system/inetd.te.  If you want to allow identd
to run on your system, you can either define a new domain
for it with the appropriate permissions or you can add
this permission to the inetd_child_t domain, e.g.

allow inetd_child_t self:capability kill;

> avc:  denied  { append } for  pid=27031 exe=/usr/sbin/crond
> path=/var/log/cron dev=03:01 ino=99291
>    scontext=system_u:system_r:crond_t
>    tcontext=system_u:object_r:xfs_tmp_t
>    tclass=file

This message indicates that your /var/log/cron file is incorrectly
labeled with the xfs_tmp_t type.  It should be labeled with the
cron_log_t type.  This might have happened if you booted your
system with an ordinary Linux kernel after initially installing
SELinux, because the file may have been recreated while running
the ordinary Linux kernel.  In that case, its label would not
be set properly.  To be safe, you should run 'rm -f relabel; make relabel'
in your policy directory as root in the sysadm_r role and sysadm_t domain.
This will reset all of your file security contexts to the expected values.
You can also individually set a particular file's security context
by using the chcon program, e.g.

chcon system_u:object_r:cron_log_t /var/log/cron


--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
