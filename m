Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA08025
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 11:15:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA20336
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 16:13:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA20332
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 16:13:04 GMT
Message-Id: <200212031622.LAA26077@moss-shockers.ncsc.mil>
Date: Tue, 3 Dec 2002 11:22:12 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Systrace
To: selinux@tycho.nsa.gov, jsmith@mcs.drexel.edu
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I came across the Systrace site
> 
> http://www.citi.umich.edu/u/provos/systrace/
> 
> and it strikes me as somewhat similar to SELinux: although it lacks
> roles, it does intercept system calls and file accesses and apply access
> criteria. It seems to me that the most significant difference between
> systrace and SELinux is the lack of domains for running processes. On
> the other hand, one can specify which programs to monitor.

I think that systrace is based on system call interception and relies
on pathnames to make access decisions, neither of which is true for SELinux 
and both of which are considered harmful for real security.  See the
Flask paper for a discussion of why system call interception is fundamentally
inadequate.  systrace also doesn't seem oriented toward enforcing
a system security policy over all processes, just sandboxing particular
applications.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
