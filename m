Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAELKKRb027410
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 16:20:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAELJpBb020331
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 21:19:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hAELJo4o020324
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 21:19:50 GMT
Subject: Re: insmod
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Howard Holm <hdholm@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311150743.24869.russell@coker.com.au>
References: <200311050757.54690.russell@coker.com.au>
	 <1068839961.18402.178.camel@moss-spartans.epoch.ncsc.mil>
	 <200311150743.24869.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1068844784.18402.274.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 16:19:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-14 at 15:43, Russell Coker wrote:
> If we do that then insmod_t will require all capabilities, ability to create 
> all types of socket, and full access to sysfs and other resources.  Kernel 
> code will run as insmod_t.  When the kernel code can't do what it wants an 
> Oops is to be expected and a module load failure is the best result you can 
> hope for (it seems that most kernel code does not correctly handle all 
> possible error conditions).
> 
> The distinction between kernel_t and insmod_t seems artificial with the way 
> things work at the moment.
> 
> Are there plans to change the kernel code related to module loading to have 
> the kernel code run as kernel_t?  Without kernel changes there does not seem 
> to be any benefit in a insmod_t/kernel_t split.

It is already the case that any kernel thread that calls
reparent_to_init (or any of its callers, such as daemonize), will be
switched to the kernel SID.  Hence, kernel threads launched by a module
will run with the kernel SID (if they use reparent_to_init, which they
should).  However, that doesn't address module initialization code,
which typically just runs in the context of the process that inserted
the module.

I understand that module initialization code expects full privileges,
and that you may need to grant many permissions to insmod_t. 
Nonetheless, I would still recommend against merging it with kernel_t. 
There are permissions required by kernel_t that are not required by
insmod_t (e.g. ability to load policy, ability to transition to init_t)
and there are permissions required by insmod_t that are not required by
kernel_t.

Also, the domain transition from kernel_t to insmod_t for kernel module
requests has served a useful purpose in the past, as you might recall...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
