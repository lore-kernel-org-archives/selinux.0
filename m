Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MHD4fG026964
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 13:13:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8MHC2EW029783
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 17:12:03 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45116881.3060406@redhat.com>
References: <45116881.3060406@redhat.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 13:13:16 -0400
Message-Id: <1158945196.3920.131.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
> http://people.redhat.com/dwalsh/SELinux/policy.diff
> 
> Changed to allow 1024 categories.

Not adding this yet.  Waiting for concensus on how high we should go.

> I have a request for a boolean to allow all domains to talk to the ttys in targeted policy.  This would allow a domain to 
> output errors if their is a failure.  Currenly if I screw up my httpd.conf file apache has no easy way of telling me, via 
> the init script.

This sounds like it should be for daemons rather than all domains.

> Don't transition on grubby.  Some one needs to write grubby policy, but it should not be the same as bootloader

Dropping the types for now, until someone writes the policy.

> +	#https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202410
> +	allow bootloader_t boot_runtime_t:file { rw_file_perms unlink };

This bug information is lacking.  Since it doesn't make sense for grub
itself to write its own stage files, I did some deeper looking.  My
guess is that grub-install is being run, and that it is inappropriately
being labeled as bootloader_exec_t.  I'm not very familiar with grubby,
but I suspect that grub-install should also be bootloader_helper_t.

> Add a files_manage_non_secure_dirs for autofs

This seems suspect.

> nfs now uses rpc_pipefs_t:fifo_file

Moved this interface up in filesystem.  Moved the call into the rpc
template.

> Stop using bluetooth_helper_t

Why?

> dhcpd speaks dbus

Moved this hunk up.

> oddjob policy should be added

Why are there two modules?  It seems like they should be merged.

> sendmail should create pid with correct context in targeted policy

Moved this block up.


> xen has a new log directory
> 
> xen needs ptrace
> 
> xen needs to read from removable devices


* There is a removal in corenetwork.te.m4 that you reversed.

* What is the /opt/fortitude stuff in apache?

* xserver_create_ice_tmp_sockets() does not have any callers.

* I don't agree with the selinuxutil change to allow strict semanage_t
to read user files.  This is an insecure source for policy packages.

* The unconfined.te change confuses me; unconfined should already have
these perms.

* I fixed up a change in amanda.fc, since it had a m4 internal function
call (index(/.*)), which made the match not what you thought it was.

On a side note, I looked at the bug noted in the fstools change, and the
user pasted this bit:

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
*** Warning -- SELinux is active
*** Disabling security enforcement for system recovery.
*** Run 'setenforce 1' to reenable.
Give root password for maintenance
(or type Control-D to continue): 

SELinux being in enforcing shouldn't be a warning, if anything it should
be a notice.  "Warning" has a negative spin (at least it does to me).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
