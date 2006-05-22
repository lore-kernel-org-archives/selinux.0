Subject: Re: is it a newbie'sh question?: where is the log for violated
	access ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4471F07A.1000409@gmail.com>
References: <4471F07A.1000409@gmail.com>
Content-Type: text/plain
Date: Mon, 22 May 2006 13:36:11 -0400
Message-Id: <1148319371.24463.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-23 at 02:10 +0900, Tetsuji Maverick Rai wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all,
> 
> I thought when an access violation occurs, it's logged in
> /var/log/audit.log or messages, but it doesn't look so.
> 
> For example, If I invoke "su apache -c "cat /etc/passwd" as root which
> will cause access error because apache user isn't allowed to use cat,
> but I cannot find any violation log in any of the log files above.
> 
> Actually it's prohibited by selinux: ie.
> as a root "su apache -c 'cat /etc/passwd'" will say nothing, while
> "su maverick -c 'cat /etc/passwd'" (maverick is a normal user) displays
> contents of /etc/passwd.  I think it's a form of access violation but
> this isn't logged anywhere.   Will anyone tell me why or where it's logged?
> 
> Thanks in advance.

If running auditd, then it is audit.log.  Otherwise, it is messages.
Cases where there is no audit message include:
a) The syscall failed before reaching the SELinux hook, e.g. a DAC
denial or some other error condition,
b) SELinux denied access but policy has a dontaudit rule to silence the
audit message for that particular (domain, type, class, permission)
tuple to avoid flooding the logs with common patterns of access.

Note that su didn't originally change SELinux security context at all
(only the Linux uid) - we intentionally kept changing Linux uid separate
from changing SELinux security context.  Later, during Fedora SELinux
integration, pam_selinux was inserted into su's pam config in an attempt
to unify them, but that caused more problems than it solved, ultimately
leading to its removal again in the latest Fedora.  So su'ing to
apache's uid has no bearing on the SELinux security context.  Use runcon
-t httpd_t to run a process in apache's domain (although it will likely
fail immediately on the transition or entrypoint checks).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
