Subject: Re: some policy feedback
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <20030601222359.D31891@lemuria.org>
References: <20030601222359.D31891@lemuria.org>
Content-Type: text/plain
Message-Id: <1054559762.1053.127.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Jun 2003 09:16:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-06-01 at 16:23, Tom wrote:
> 1) su problem
> The default policy seems to have a hole that has potentially serious
> consequences. Root can run su and change to any user account authorized
> for root's current role. That way, root can set up traps for the sysadm
> when he logs into his own account, e.g. by trojaning the .bashrc file
> and having the sysadm execute a fake newrole (which calls the real one
> in the background, possibly a wrapper), capturing his password

Options:
1) Drop the rootok line from the PAM configuration, as suggested by
Russell.  This allows user_t to still use su, but always requires a
password even when run by root.
2) Move the su_domain line from user_macros.te to admin_macros.te, i.e.
only allow sysadm_t and other admin domains to run su.
3) Use different base roles and home directory types to strictly
partition these users, i.e. no shared use of user_t and user_home_*_t by
roles other than user_r or add a new staff_r/staff_t role/domain for the
initial login of admins.
4) Polyinstantiated home directories with transparent redirection (not
yet supported).

> 2) various kernel-level issues
> code from LSD has brought up several interesting points that I could
> not really answer due to lack of in-depth knowledge, especially in the
> kernel operations.
> 
> One question was the usual LKM issue. Would it be possible to overload
> calls of the SELinux patch, in turn disabling it? Or does LSM and/or SE
> have any kind of "self-preservation" behaviour?

For clarity, SELinux is always built-in, LSM isn't based on system call
interposition, and your LSM can mediate access to the kernel module
syscalls as well as to /dev memory nodes.  Naturally, if you can gain
access to a domain that can insert modules or you can trick such a
domain into inserting a trojaned module, then the module is free to do
what it likes; you can't protect against other code in the kernel.

> Another issue was whether it would be possible to trojan a running
> binary. Assuming that a daemon has an exploitable buffer overflow, it
> seems to be possible to change the daemon itself, at runtime. No exec
> would be made, and as I understand it, no system calls that could
> trigger SE. The trojaned daemon would continue to run, with whatever
> changes were made. (obviously, patching binary code while its running
> isn't for the faint of heart, but I've seen several methods for doing
> so in action, and it certainly is possible.)

Yes, it would continue to run, but would be limited to whatever
permissions are granted to its domain.  There are techniques other than
kernel MAC for helping to counter that issue, but that isn't the focus
of SELinux.  You are naturally free to combine SELinux with other
security techniques to provide further security.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
