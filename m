Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5GJ9HrT005305
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 15:09:17 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5GJ9Eot008011
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 19:09:14 GMT
Subject: Re: Question about selinux & the new kernel crash exploit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bryan Zeigler <bzeigler@mitre.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200406161843.i5GIhkv23853@smtp-bedford.mitre.org>
References: <200406161843.i5GIhkv23853@smtp-bedford.mitre.org>
Content-Type: text/plain
Message-Id: <1087412950.16125.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 15:09:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-06-16 at 14:43, Bryan Zeigler wrote:
> Hi,
>  
> Based on papers I've read, I understand that one of the goals of SE Linux is
> keeping processes separate.  So what happens in one domain shouldn't affect
> other domains.  I was informed of a short bit of code that can crash the
> kernel (at
> http://reviewed.homelinux.org/news/2004-06-11_kernel_crash/index.html.en ).
> When executing this code as just a normal user, it still completely crashes
> the system.  Shouldn't the crash only be seen by the user that executed the
> code?  It seems some people recommend SE Linux for systems that may not be
> updated so often.  However, in this case, SE Linux doesn't seem to protect
> much more than regular Linux.  Is there anyway to stop these types of things
> using SE Linux policies (short of not allowing it to execute at all)?

SELinux provides mandatory access controls in the kernel that can
confine and protect processes.  It can't counter kernel bugs in general;
in certain cases, it may happen to block exploitation of a particular
kernel bug by preventing the attacker from reaching the relevant flawed
code due to an earlier access denial in the code path, but you can't
expect a kernel security mechanism to counter kernel flaws.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
