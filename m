Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA08099
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 17:55:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA14186
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 22:54:52 GMT
Received: from nmda-bubba.NMSU.EDU ([128.123.134.231])
	by jazzswing.ncsc.mil  with ESMTP id WAA14182
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 22:54:52 GMT
Message-ID: <B7F6E4A39BE7D111BF2500A0C989BA4795071B@NMDA-BUBBA>
From: "Simonin, Bradley" <BSimonin@nmda-bubba.nmsu.edu>
To: "NSA Linux (E-mail)" <selinux@tycho.nsa.gov>
Subject: Can I compile NSA Linux 2.4.2 kernel the same way I do a the norm
	al 2.4.2 kernel?
Date: Thu, 29 Mar 2001 15:53:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have read over the installing security enhanced Linux instructions.
However, if I can, I would like to configure the kernel like I would with
the normal 2.4.2 kernel instead of using the shell scripts.  I am hoping I
can do that but I am having some trouble.  

I copied the context-examples into the /etc/security directory and added
myself as a sysadm.  From the slinux/kernel directory I uncommented the
'export INSTALL_PATH=/boot' in Makefile.  I then do 'make mrproper', 'make
xconfig', 'make dep; make clean', 'make bzImage', 'make modules', 'make
modules_install'.  I then copy the bzImage kernel from the
slinux/kernel/arch/i386/boot to my /boot and run lilo.

When I reboot I am getting a kernel panic.  The message says:
Security:  Starting up (compiled Mar 29, 2001)
Security:  loaded policy configuration from /ss_policy
Security:  unable to open /ss_policy

If I check no on the flask security mechanism in xconfig then I am able to
reboot and kernel 2.4.2-FLASK runs like any other kernel.

Am I not going to be able to compile the NSA Kernel like I would with a
normal kernel?

Thanks in advance,

Brad Simonin     

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
