Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PJcsie025504
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:38:54 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8PJbqAk010278
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 19:37:52 GMT
Subject: Re: Errors with runcon - RHEL4/refpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu>
References: 
	 <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 15:39:34 -0400
Message-Id: <1159213174.3920.238.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 10:09 -0400, Osborn, Justin D. wrote:
>       I'm working on a project to do containment of VMware VMs using
> SELinux policy.  Our system is set up on RHEL4 and I have the
> Reference Policy installed. 
> 
>       We're trying to reuse the VMware policy that was originally
> distributed with the Reference Policy.  Specifically there is a
> per-user-domain template that we modified for our use and instantiate
> from another te file.  The policy compiles and our VMs are properly
> labeled after relabeling.
> 
>      The problem is that when I try to kick off a VM using runcon, I
> get the non-descript "unable to setup security context" error.  The
> command I'm running is: runcon root:system_r:ziplock_vm1_vmware_t
> vmware-cmd start /VMs/foo.vmx.  My bash shell is running as
> root:system_r:unconfined_t.  I added my types to system_r and verified
> with apol.
> 
>      So my questions are:
>      a) Why was the VMware policy renoved from the Reference Policy?

I don't understand the question.  Its in refpolicy, and you said you
were using it...

>      b) What am I missing with the runcon error?  Is there somewhere I
> can look for a more descriptive error message?

It means the setexeccon() failed.  Usually a setexeccon() error means
either the context is invalid or it was denied setexec on the processs.
You're unconfined, so you have setexec, so most likely it is an invalid
context.  Newer versions of runcon have a different message explicitly
saying if the context is invalid.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
