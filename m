Date: Mon, 29 Jul 2002 09:19:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?ISO-8859-1?Q?Mark_M=FCller?= <trusted@web.de>
cc: SELinux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: How to make sftp work?
In-Reply-To: <3D42C94D.8000100@web.de>
Message-ID: <Pine.GSO.4.33.0207290915350.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 27 Jul 2002, [ISO-8859-1] Mark Müller wrote:

> avc:  denied  { search } for  pid=3303 exe=/usr/sbin/sshd
> path=/usr/lib/ssh dev=08:09 ino=61510 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:sshd_exec_t tclass=dir

Only the sshd executable should be labeled with sshd_exec_t, since it is
the entrypoint type for the sshd_t domain.  If you want to permit sshd to
execute some helper program without changing domains, then assign a
different type (e.g. sshd_helper_exec_t) to that program and add a
'can_exec(sshd_t, sshd_helper_exec_t)' rule to the sshd.te file.

> avc:  denied  { getattr } for  pid=3452 exe=/usr/lib/ssh/sftp-server
> path=/root/.bash_history dev=08:09 ino=208 scontext=root:user_r:user_t
> tcontext=system_u:object_r:sysadm_home_t tclass=lnk_file

Unless you truly need access to /root for sftp, then I'dd suggest simply
suppressing these audit messages using dontaudit rules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
