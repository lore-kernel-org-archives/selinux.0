Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA17161
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 11:28:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA01963
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 15:26:53 GMT
Received: from stingray.missi.ncsc.mil (stingray.missi.ncsc.mil [144.51.50.20])
        by jazzband.ncsc.mil  with ESMTP id PAA01959 for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 15:26:53 GMT
Message-ID: <200204081527.g38FRGL00155@stingray.missi.ncsc.mil>
From: "McFarland, David M." <DMMcFa2@missi.ncsc.mil>
To: "'Westerman, Mark'" <Mark.Westerman@csoconline.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: SELinux in VMWare
Date: Mon, 8 Apr 2002 11:27:15 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The base install I am using is RedHat 7.1 so no ext3. The VM is supposedly
virtualizing a Mylex (Buslogic) BT-958 
SCSI controller, but adding the driver into the kernel produces the same
results. The base 7.1 kernel detects the SCSI controller fine so I know it
has the drivers somewhere. I even tried a blanket build where I included all
the SCSI drivers but still got the same results. 

Dave McFarland

-----Original Message-----
From: Westerman, Mark [mailto:Mark.Westerman@csoconline.com]
Sent: Monday, April 08, 2002 11:21 AM
To: 'McFarland, David M.'; 'selinux@tycho.nsa.gov'
Subject: RE: SELinux in VMWare


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
