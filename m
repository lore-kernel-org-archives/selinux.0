Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7KMcbSa025438
	for <selinux@tycho.nsa.gov>; Thu, 20 Aug 2009 18:38:37 -0400
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7KMdjNa028616
	for <selinux@tycho.nsa.gov>; Thu, 20 Aug 2009 22:39:45 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: SELinux policy for the new TUN hooks
Date: Thu, 20 Aug 2009 18:38:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200908201838.29478.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First off, my apologies for posting to both the SELinux and refpolicy lists, 
but I think this is a topic that bears a bit wider audience than just 
refpolicy ...

As you may have seen on the various lists, there is a problem where network 
traffic sent via a TUN device is not labeled correctly due to missing hooks in 
the TUN driver.  I believe we've reached a point where the LSM hooks are 
relatively sorted so now it is time to start thinking about the SELinux policy 
to go behind the hooks.

My current approach has been to label the individual TUN device (actually the 
sock associated with the TUN device) based on the domain which has attached 
itself to the device (only one process can attach to a device at any given 
time).  This has the conceptual advantage that packets sent from the device 
are labeled based on the domain but the disadvantage that attaching to a 
persistent TUN device requires a relabel operation.  With the current patches, 
the basic policy for creating and attaching to a TUN device are shown below:

	# create a new tun device
	allow foo_t self:tun_socket { create };

	# attach to an existing persistent tun device
	allow bar_t foo_t:tun_socket { relabel_from };
	allow bar_t self:tun_socket { relabel_to };

My first question is does this policy still sound reasonable?  My second 
question is what refpolicy changes do we want to see?  As it stands I'm 
thinking of the following refpolicy changes:

1. Add a new socket class, "tun_socket", which inherits from the socket class.
2. Create a new interface, "corenet_create_tun_tap_dev($1)", which would grant 
the given domain the tun_socket/create permission.
3. Another new interface to grant permission for a domain to attach itself to 
an existing persistent TUN device.

Step #3 is where I seem to be having problems.  If we only allow one argument, 
the requesting domain, we are forced to allow it to attach to _all_ TUN 
devices.  If we allow two arguments, both the requesting domain and the type 
of the persistent TUN device, doesn't that pose a problem with directly 
accessing the persistent TUN device type?  We could also go with another 
option that would introduce another interface to assign persistent TUN devices 
an attribute which would allow them to be attached later with a single 
argument attach interface.  Thoughts?

NOTE: the kernel patches can be found at the following git tree

	* git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
