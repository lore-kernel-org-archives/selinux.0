Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26056
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 09:25:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA21843
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 14:25:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA21839
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 14:25:26 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23279
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 09:25:43 -0500 (EST)
Date: Tue, 20 Nov 2001 09:10:39 -0500 (EST)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200111201410.JAA04133@coalpipe.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated release
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated.  The site includes a new release of the
LSM-based SELinux prototype.  This release is based on the
lsm-2001_11_05 patch against kernel 2.4.14.  It fixes a number of bugs,
cleans up some code, and is based on newer versions of the kernel and
utilities.

The following changes should be carefully noted if you have previously
installed SELinux:

1) LSM has renamed all LSM-related configuration options to use a
CONFIG_SECURITY prefix, and we have done likewise for the SELinux
kernel option.  This means that old .config files aren't quite right
anymore.  You can still use them, but you'll need to explicitly enable
the LSM-related (IP Networking hooks, Capabilities) and SELinux options
again when you configure (unless you hand edit your old .config file to
reflect the name changes).

2) A small change was made to the policydb format, so you need to
rebuild checkpolicy and recompile your policy with the updated
checkpolicy program.  Also, if you have customized your policy, you
need to at least pick up a new initial SID definition (sysctl_net_unix)
in the initial_sid_contexts file.

3) The execve_secure system call has been reimplemented via the general
security system call.  Previously, this system call remained as a
separate entrypoint due to the inability to access register state
(needed by execve) from the general security system call, but this was
undesireable because only the security call is reserved in the
mainstream kernel.  We found that we could reimplement the
execve_secure call via the security call by replacing the LSM security
call entrypoint function with our own architecture-specific entrypoint
function that can support both execve_secure and all of our other
calls.  So you must recompile libsecure and relink all applications
that use exec.*_secure against it (runas, newrole, crond, run_init,
sshd, login, Mark Westerman's modified gdm).  This will be a nuisance
for current users, but ensures that you should never have to do so
again, since the security syscall is reserved, unlike the old separate
entrypoint for execve_secure.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
