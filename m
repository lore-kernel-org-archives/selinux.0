Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA26215
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 12:53:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA21408
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 17:51:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id RAA21404
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 17:51:04 GMT
Message-Id: <200211071800.NAA07215@moss-shockers.ncsc.mil>
Date: Thu, 7 Nov 2002 13:00:20 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux source
To: selinux@tycho.nsa.gov, sailorn@attglobal.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I have question about SELinux source.  I have downloaded the entire package 
for 2.4.19 (which includes Linux source).
> Is this source modified for SELinux or is it the same as what I download from 
http://www.kernel.org? 

It is modified for SELinux, but derived from the original sources from
kernel.org.  If you prefer, you can use one of the other download options
to just download the patches and apply them yourself to the kernel.org sources.

> After extracting the compressed file, there are 2 directories.  One is LSM-2.4 
and the other is SELINUX.  The LSM-2.4 tree looks
> similar to what I usually download from the kernel.org site.

Yes, the lsm-2.4 tree is a patched copy of the kernel sources.  LSM stands
for Linux Security Modules (lsm.immunix.org), a general kernel patch jointly 
developed by several security projects to replace the individual 
project-specific kernel patches.

> If it is similar, can I use "make xconfig" to configure SELinux?  (I am 
>assuming X will work normally in SELinux).

Yes, you can use 'make xconfig'.  But first, you need to apply an additional 
patch from selinux/module/selinux-2.4.patch.  See the instructions in 
selinux/README.

> Is the compilation process different for the source in SELINUX directory? Will 
>"make bzImage" take care of the source in SELINUX directory?                                                                                                                

The selinux directory contains a number of components, including an additional
kernel patch, a policy configuration, and userland components.  See 
selinux/README for full instructions.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
