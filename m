Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h692BfHa021395
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2003 22:11:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h692AjnJ025140
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 02:10:45 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h692Aihr025137
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 02:10:44 GMT
Subject: Re: context trouble with 2.5 bits
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200307091017.42539.russell@coker.com.au>
References: <1057701768.25921.53.camel@columbia>
	 <200307091017.42539.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1057716690.5878.25.camel@columbia>
Mime-Version: 1.0
Date: 08 Jul 2003 22:11:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-08 at 20:17, Russell Coker wrote:
> On Wed, 9 Jul 2003 08:02, Colin Walters wrote:
> > Warning!  Could not get new context for tty1, not relabeling.
> 
> Which may mean that the original type for the device node is not one that is 
> expected.  Please tell me what "ls --context /dev/tty1" reports.

meta:/var/log# ls --context /dev/tty1
crw-------  root     tty      system_u:object_r:tty_device_t   /dev/tty1
meta:/var/log#

> However this should have nothing to do with the ability to login and run a 
> session in the correct context.

Yeah.

> This is wrong.  There's a domain_auto_trans() rule to transition to user_t for 
> when using a login program that is not aware of SE Linux.  So it looks like 
> the target context is not being set.

Well this is embarassing, but apparently HAVE_SELINUX wasn't getting
defined by my openssh build (the debian/rules file was overriding
CFLAGS).  Now that I've fixed that, I get:

Jul  8 21:41:52 meta sshd[642]: Accepted password for root from ::ffff:192.168.1.100 port 36286 ssh2
Jul  8 21:41:52 meta sshd[642]: fatal: Failed to get default security context for root.

The same thing happens with a normal user.

> Under the new scheme I believe that some file is supposed to be written under 
> /proc for this.  Make sure that the right stuff is mounted under /proc, the 
> file is available, etc.
> 
> Also while in permissive mode do some tests at the command line, do:
> # echo user_u:user_r:user_t > /proc/whatever-it-is
> # id
> 
> Then id should report a context of user_u:user_r:user_t if the context change 
> is working correctly.

Here's what I get:

meta:/var/log# cat /proc/self/attr/current  && echo
system_u:system_r:user_t
meta:/var/log# echo root:system_r:sysadm_r > /proc/self/attr/current
meta:/var/log# cat /proc/self/attr/current  && echo
system_u:system_r:user_t
meta:/var/log#

> Does the NSA supplied patch for 2.5.x do the same things as the patch for 
> 2.4.x?  Maybe there's something new in the NSA tree that's necessary and that 
> merely calling execve_secure() is not enough.

Well, there is no execve_secure() anymore; now you have to call
setexeccon.  But their patch does appear to be doing the right things,
at least according to their PORTING document.

> Does your /etc/security/default_contexts have the right stuff?

It looks like this:

system_r:local_login_t  user_r:user_t staff_r:staff_t
system_r:sshd_t         user_r:user_t staff_r:staff_t
system_r:crond_t        user_r:user_crond_t staff_r:staff_crond_t system_r:system_crond_t


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
