Subject: Re: [ PATCH ] hal - create netlink socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112026129.3040.1.camel@cobra.ivg2.net>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1112026129.3040.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 11:13:01 -0500
Message-Id: <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 11:08 -0500, Ivan Gyurdiev wrote:
> Interesting, I hadn't actually used auditd until now. Is the daemon
> supposed to be on or off by default?

If the daemon is disabled, then the audit messages just get handled by
klogd (-> syslogd -> /var/log/messages) by default.  The important thing
is to enable syscall auditing via the audit=1 kernel boot parameter
or /sbin/auditctl -e 1.  BTW we need policy for auditctl.  Similar to
auditd, but should be able to access the tty (and auditd shouldn't be
allowed to do that).

> type=KERNEL msg=audit(1112025688.522:863505): syscall=102 exit=-13 a0=1
> a1=bfa3acf0 a2=80712ac a3=8075a60 items=0 pid=2512 loginuid=-1 uid=0
> gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
> type=KERNEL msg=audit(1112025688.522:863505): avc:  denied  { create }
> for  pid=2512 exe=/usr/sbin/hald scontext=system_u:system_r:hald_t
> tcontext=system_u:system_r:hald_t tclass=netlink_socket

Ah, we don't get the desired information because it is being passed by
address for the socketcall multiplexer.  Maybe run hald under strace (in
permissive mode, of course).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
