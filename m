Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28410
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 10:13:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA17224
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 15:10:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA17212
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 15:10:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: lrp@xmission.com, CNGUYEN <CNguyen@mykotronx.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Making OPIE/QTOPIA aware of SELinux
Date: Fri, 21 Feb 2003 16:13:19 +0100
References: <FD2221F5E1A8184DB61AFCE064C395F1C91CEF@torexch1.mykotronx.com> <200302210757.56785.lrp@xmission.com>
In-Reply-To: <200302210757.56785.lrp@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302211613.19675.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Feb 2003 15:57, Lamont R. Peterson wrote:
> If I understand the architecture of the kernel (and particularly, how
> SELinux affects the kernel) then I would have to say that your diagram is
> incorrect. SELinux does not sit on top of the kernel; it "IS" the kernel.

Yes, that is a good way to think of it.

SE Linux is part of the kernel, and apart from kernel bugs and programs with 
write access to /dev/kmem (IE an X server) there's no way to bypass SE Linux.

> Qtopia (I don't know OPIE) does not bypass the kernel in order to talk to
> devices directly.  There is nothing (other than compiling SELinux into your
> "embedded" kernel) that needs be done for Qtopia to run securely.
>
> However, if I were to do this, I would write some Qtopia apps to wrap
> around SELinux specific tools such as spasswd, and would explore the
> "login" facility that Qtopia Desktop uses to communicate with Qtopia
> devices.

One problem with embedded devices is that when you link multiple programs into 
one executable (like busybox does) then it's more difficult to arrange 
process domain transitions.

On a desktop or server system running SE Linux it's easy to have the 
administrator shell in the sysadm_t domain transition to the insmod_t domain 
to run "insmod" or "rmmod" as they are different programs.  When you have 
"insmod" and /bin/sh in the same binary with the same type it becomes more 
complex.

I am considering writing a privileged wrapper program which would run in 
sysadm_wrapper_t if run from sysadm_t or user_wrapper_t if run from user_t.  
Then it would look at a configuration file to map the name it was run as to a 
command and a security context.

EG If it was run as "insmod" then it might run "busybox insmod" as insmod_t.  
Of course the SE Linux policy would not permit a transition from 
user_wrapper_t to insmod_t...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
