Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA00881
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 20:30:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA24608
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 01:30:25 GMT
Received: from ausmac.net (ausmac.net [203.12.68.15])
	by jazzswing.ncsc.mil  with SMTP id BAA24598
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 01:30:23 GMT
Date: Wed, 21 Nov 2001 12:30:32 +1100 (EST)
From: Grant Bayley <gbayley@ausmac.net>
To: Howard Holm <hdholm@epoch.ncsc.mil>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Updated release
In-Reply-To: <200111201410.JAA04133@coalpipe.epoch.ncsc.mil>
Message-ID: <Pine.BSO.4.33.0111211227150.16751-100000@ausmac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Australian SELinux mirror now updated:

	http://the.wiretapped.net/security/operating-systems/selinux/

(in the LSM-based prototype, we're mirroring the all-in-one tarball and
the two-parts tarballs (no need to mirror the patches separately.  Also
documentation mirror has been updated as well.)

Grant

-------------------------------------------------------
Grant Bayley                         gbayley@ausmac.net
-Admin @ AusMac Archive, Wiretapped.net, 2600 Australia
 www.ausmac.net   www.wiretapped.net   www.2600.org.au
-------------------------------------------------------


On Tue, 20 Nov 2001, Howard Holm wrote:

> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated.  The site includes a new release of the
> LSM-based SELinux prototype.  This release is based on the
> lsm-2001_11_05 patch against kernel 2.4.14.  It fixes a number of bugs,
> cleans up some code, and is based on newer versions of the kernel and
> utilities.
>
> The following changes should be carefully noted if you have previously
> installed SELinux:
>
> 1) LSM has renamed all LSM-related configuration options to use a
> CONFIG_SECURITY prefix, and we have done likewise for the SELinux
> kernel option.  This means that old .config files aren't quite right
> anymore.  You can still use them, but you'll need to explicitly enable
> the LSM-related (IP Networking hooks, Capabilities) and SELinux options
> again when you configure (unless you hand edit your old .config file to
> reflect the name changes).
>
> 2) A small change was made to the policydb format, so you need to
> rebuild checkpolicy and recompile your policy with the updated
> checkpolicy program.  Also, if you have customized your policy, you
> need to at least pick up a new initial SID definition (sysctl_net_unix)
> in the initial_sid_contexts file.
>
> 3) The execve_secure system call has been reimplemented via the general
> security system call.  Previously, this system call remained as a
> separate entrypoint due to the inability to access register state
> (needed by execve) from the general security system call, but this was
> undesireable because only the security call is reserved in the
> mainstream kernel.  We found that we could reimplement the
> execve_secure call via the security call by replacing the LSM security
> call entrypoint function with our own architecture-specific entrypoint
> function that can support both execve_secure and all of our other
> calls.  So you must recompile libsecure and relink all applications
> that use exec.*_secure against it (runas, newrole, crond, run_init,
> sshd, login, Mark Westerman's modified gdm).  This will be a nuisance
> for current users, but ensures that you should never have to do so
> again, since the security syscall is reserved, unlike the old separate
> entrypoint for execve_secure.
>
> --
> Howard Holm <hdholm@epoch.ncsc.mil>
> Secure Systems Research Office
> National Security Agency
>
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
