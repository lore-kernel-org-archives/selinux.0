Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA02370
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 22:07:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA00521
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 03:06:59 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id DAA00517
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 03:06:57 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: USB device labelling
Date: Sat, 9 Feb 2002 12:47:40 +1000
Cc: bhards@bigpond.net.au
MIME-Version: 1.0
Message-Id: <20020209030840.31A273A6AA0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been talking with Brad Hards regarding SE Linux device labelling for 
USB devices.

A file system of type usbdevfs is mounted somewhere suitable (usually 
/proc/bus/usb - many programs won't work if you mount elsewhere).  Here are 
an example of the files in this file system:
./devices
./drivers
./001
./001/001

The ./devices and ./drivers files always exist and should probably be of 
system_u:object_r:sysctl_t.

The directory ./001 represents the USB controller hardware in my computer, 
the file ./001/001 is a USB device attached to the USB controller (which 
happens to be a USB hub).  When I plug a USB device (EG a mouse) into this 
hub then a new file ./001/002 will be created.

We want to change the security context BEFORE a user-space program can get 
access to the file.

Firstly we want HID type devices (Human Interface - keyboard, mouse, and UPS) 
to have very restrictive permissions because they also get device nodes which 
can be assigned permissions through "make relabel" or through devfs depending 
on whether you use devfs or not.

Setting the rest of the files is more difficult.

One way of doing this would make all files default to restrictive permissions 
and then allow /sbin/hotplug to change them back to more usable permissions.  
/sbin/hotplug is run every time a device node is installed anyway, giving it 
permission to relabel files from usb_unlabeled_t to something else and 
changing it's code so it knows how to do so.

Another way of doing it would be to have the kernel assign the permissions.  
When you compile a kernel with USB device drivers as modules the depmod 
program will build a map file of device IDs to device driver names.  We could 
then have a configuration file specifying a match between device driver names
and security contexts.  Then checkpolicy can take this file as well as a copy 
of modules.usbmap (NOT the one on the running kernel - the running kernel may 
have the USB device drivers statically linked not as modules) as part of it's 
input towards generating policy.conf.


What do you think?


-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
