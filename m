Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2GIDkRb021441
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 13:13:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2GIC16Q017796
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 18:12:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2GIC05t017793
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 18:12:01 GMT
Subject: Re: newrole failed in enforcing mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200403161839.13748.carstengrohmann@gmx.de>
References: <200403101650.07042.carstengrohmann@gmx.de>
	 <200403161839.13748.carstengrohmann@gmx.de>
Content-Type: text/plain
Message-Id: <1079460805.4583.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 13:13:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-16 at 12:39, Carsten Grohmann wrote:
> Today I used strace to localize my pam problem and I get follow 
> output:
> 2226  execve("/usr/bin/newrole", ["/usr/bin/newrole", "-r", 
> "staff_r"], [/* 20 vars */]) = 0
> 2226  +++ killed by SIGKILL ++
> 
> "killed by SIGKILL" - which process send a sigkill only in the 
> enforcing mode? In the permissive mode it runs and I don't get avc 
> messages.

SELinux controls process tracing across domain transitions, for obvious
reasons.  On a ptrace permission failure during a domain-changing exec,
SELinux will not perform the domain transition and will also send
SIGKILL to the process to abort it, as this is the only way to convey an
error from compute_creds.

> I use strace with various prgrams successfull:
> - strace newrole in permissive mode
> - strace ps ax --context in permissive and enforcing mode
> But an strace of passwd failed in the enforcing mode with an similar 
> output?
> 
> Could it be that the pam libraries are reason of this behavior?
> Have anybody an idea to encircle this problem?

To debug the newrole failure in enforcing mode, do a 'make enableaudit
reload' in policy and then try using newrole, and review the audit
messages.  Some will be noise (and normally suppressed by dontaudit
rules) but some may be relevant.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
