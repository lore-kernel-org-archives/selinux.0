Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA17100
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 11:20:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA12907
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 15:18:50 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id PAA12903
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 15:18:49 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524333@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'McFarland, David M.'" <DMMcFa2@missi.ncsc.mil>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: SELinux in VMWare
Date: Mon, 8 Apr 2002 10:20:35 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been using VMware with selinux for over a year now.
Try:
	In a standard Redhat Install it uses ext3 for the file
	systems. The make quickinstall does not set ext3 for the
	kernel build. You Must set the ext3 file system manual. 
		File Systems
			Ext3 journaling file system support.

Also:
	VMware 3.0 and above uses the SCSI driver for the 
	default file system,  Make sure you have the 
	right SCSI driver built into the kernel.


Mark Westerman


> -----Original Message-----
> From: McFarland, David M. [mailto:DMMcFa2@missi.ncsc.mil]
> Sent: Monday, April 08, 2002 9:56 AM
> To: 'selinux@tycho.nsa.gov'
> Subject: SELinux in VMWare
> 
> 
> Hello,
> 
> 	I was wondering if anyone had been successfull in 
> getting SELinux to
> run in a VMWare virtual machine(VM)? Not wanting to screw up 
> a whole system
> if I set it up wrong I tried it in a VM, make quickinstall 
> goes fine with no
> errors. Upon trying to boot to the kernel though I always get 
> a kernel panic
> stating that it can't mount the root fs. Anyone have any 
> experience with
> this?
> 
> Dave McFarland
> 
> --
> You have received this message because you are subscribed to 
> the selinux list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
