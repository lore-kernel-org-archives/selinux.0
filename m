Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10405
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 08:36:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA12401
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 13:36:26 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA12397
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 13:36:25 GMT
Date: Fri, 30 Mar 2001 08:35:16 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Simonin, Bradley" <BSimonin@nmda-bubba.nmsu.edu>
cc: "NSA Linux (E-mail)" <selinux@tycho.nsa.gov>
Subject: Re: Can I compile NSA Linux 2.4.2 kernel the same way I do a the norm al 2.4.2 kernel?
In-Reply-To: <B7F6E4A39BE7D111BF2500A0C989BA4795071B@NMDA-BUBBA>
Message-ID: <Pine.SOL.3.95.1010330082748.22613A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


You can compile and install the SELinux kernel in the same way as
an ordinary Linux kernel.  However, you must also install the
binary representation of the security policy configuration into
/ss_policy so that the kernel can load the policy during initialization.
If you look at the tools/install-kernel script, you will see that
in addition to installing the kernel, it also installs the initial
policy configuration.  You can do this by hand by running 'make
initinstall' in the policy directory.  The one other caveat is that
if you want to use an initrd image, you must create an initrd image
that contains the binary representation of the policy configuration so
that the kernel can load it.  In doc/INSTALL, we recommend that you simply
omit an initrd line from your /etc/lilo.conf entry for the SELinux kernel
to avoid this problem.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Thu, 29 Mar 2001, Simonin, Bradley wrote:

> 
> I have read over the installing security enhanced Linux instructions.
> However, if I can, I would like to configure the kernel like I would with
> the normal 2.4.2 kernel instead of using the shell scripts.  I am hoping I
> can do that but I am having some trouble.  
> 
> I copied the context-examples into the /etc/security directory and added
> myself as a sysadm.  From the slinux/kernel directory I uncommented the
> 'export INSTALL_PATH=/boot' in Makefile.  I then do 'make mrproper', 'make
> xconfig', 'make dep; make clean', 'make bzImage', 'make modules', 'make
> modules_install'.  I then copy the bzImage kernel from the
> slinux/kernel/arch/i386/boot to my /boot and run lilo.
> 
> When I reboot I am getting a kernel panic.  The message says:
> Security:  Starting up (compiled Mar 29, 2001)
> Security:  loaded policy configuration from /ss_policy
> Security:  unable to open /ss_policy
> 
> If I check no on the flask security mechanism in xconfig then I am able to
> reboot and kernel 2.4.2-FLASK runs like any other kernel.
> 
> Am I not going to be able to compile the NSA Kernel like I would with a
> normal kernel?
> 
> Thanks in advance,
> 
> Brad Simonin     
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
