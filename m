Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEKhiRb027185
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 15:43:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAEKhhqY018917
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 20:43:43 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAEKhg0o018914 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 20:43:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: insmod
Date: Sat, 15 Nov 2003 07:43:24 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200311050757.54690.russell@coker.com.au> <1068839961.18402.178.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1068839961.18402.178.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311150743.24869.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 15 Nov 2003 06:59, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2003-11-04 at 15:57, Russell Coker wrote:
> > So it seems that we need have insmod run in kernel_t and have modprobe
> > run in it's own domain modprobe_t.
>
> There should be no userland entrypoints into kernel_t.  Grant insmod_t
> additional permissions if necessary, but keep it separate from kernel_t.

If we do that then insmod_t will require all capabilities, ability to create 
all types of socket, and full access to sysfs and other resources.  Kernel 
code will run as insmod_t.  When the kernel code can't do what it wants an 
Oops is to be expected and a module load failure is the best result you can 
hope for (it seems that most kernel code does not correctly handle all 
possible error conditions).

The distinction between kernel_t and insmod_t seems artificial with the way 
things work at the moment.

Are there plans to change the kernel code related to module loading to have 
the kernel code run as kernel_t?  Without kernel changes there does not seem 
to be any benefit in a insmod_t/kernel_t split.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
