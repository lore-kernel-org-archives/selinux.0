Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA12191
	for <selinux@tycho.nsa.gov>; Tue, 31 Dec 2002 16:55:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBVLtII14670
	for <selinux@tycho.nsa.gov>; Tue, 31 Dec 2002 21:55:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBVLtFf14666 for <selinux@tycho.nsa.gov>; Tue, 31 Dec 2002 21:55:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Kerry Thompson <kerry@crypt.gen.nz>, selinux@tycho.nsa.gov
Subject: Re: SELinux To Do list
Date: Tue, 31 Dec 2002 22:54:57 +0100
References: <200212302044.PAA08457@moss-shockers.ncsc.mil> <200301010843.23759.kerry@crypt.gen.nz>
In-Reply-To: <200301010843.23759.kerry@crypt.gen.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200212312254.57368.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 31 Dec 2002 20:43, Kerry Thompson wrote:
> I've made a start on a technical-level FAQ, currently at
>
> http://www.crypt.gen.nz/selinux/faq.html

SE Linux is as well suited to large servers as to small servers.  I suspect 
that the NSA people were thinking more of large servers than small servers 
when designing it.

If you take it to an extreme, if you have small servers that only run a single 
service each with read-only media (EG CD-ROM) for files that don't change 
then for many services (DNS, DHCP, and other simple services) SE Linux will 
not provide any benefit.  Think about a machine running only BIND where all 
files are on CD-ROM apart from /var/cache/bind which is on a ram disk, in 
that case SE Linux offers no extra benefit.

The fact that almost no-one runs such trivially small servers makes SE Linux 
useful for almost everyone IMHO.

One major difference that I percieve between the ideas that the NSA people 
have and the ideas that I and others have is the amount of customisation work 
that a typical user will perform.  The NSA people seem to regard it as 
typical for an administrator to write their own security policy.  My 
experience is that administrators typically don't know how their servers 
really work and therefore are incapable of doing much in the way of changes 
to security policy.  Therefore SE Linux is more usable by most people for 
small servers (when you can just install the default policy and have it work) 
than for complex servers (where writing policy is required).


For loading policy, "make load" will load the policy into the kernel if it 
believes that the policy needs to be loaded (IE is different from what is 
already in the kernel).  "make reload" will load the policy regardless.  This 
is useful if you have loaded a policy from some other file and wish to revert 
to the policy in /etc/security/selinux/ .


Just using newrules to make policy as you suggest results in bad policy.  It's 
best to carefully analyse what you want to do and write policy accordingly.

EG if you decide to deny an application access to a directory then you don't 
need any special policy for the files in that directory (remember it's a 
default of no access in SE Linux).  If you were to use newrules without any 
thought then you would inevitably grant access that is not desired.  If you 
use it with little thought then you would convert large numbers of "allow" 
rules in the newrules output to "dontaudit" and result in "dontaudit" 
messages for files in unreadable directories.

If an application is denied access to a directory then you don't want a 
"dontaudit" rule for files in that directory as an attempted access to such 
files may indicate another problem (such as a file handle leak from a calling 
program).


Regarding the issue of making it impossible to leave enforcing more, in 
domains/admin.te there is the following line:
auditallow admin kernel_t:system avc_toggle;
And there is a similar one in domains/program/initrc.te .  Remove those lines 
and it will not be possible to toggle back from enforcing mode (not without 
changing policy at least, and you can block that through policy too).

Note that denying avc_toggle does not stop you from entering enforcing mode if 
you boot in permissive mode (for obvious reasons ;).

Actually now that I consider this, it doesn't seem to make much sense to 
compile a kernel that doesn't support switching between enforcing and 
permissive modes.  It would make more sense to compile a kernel to default to 
enforcing (without needing a parameter).  Steve, what do you think?


Regarding upgrading the kernel and having errors booting, you don't need to 
"reload" the policy before booting, you just need to install it.  Also if you 
install a kernel with a new policy version then you need a matching policy 
and utilities, in which case running "make load" on the old kernel will fail 
(old kernel can't accept new policy), so "make install" is what you want.


Apart from those issues the FAQ is good work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
