Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA20498
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 06:47:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA29386
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 10:47:34 GMT
Received: from jsmith.org (pool-141-158-42-213.phil.east.verizon.net [141.158.42.213])
	by jazzswing.ncsc.mil  with ESMTP id KAA29382
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 10:47:33 GMT
Subject: Re: RH 7.3 and NSA Secure Linux
From: Justin Smith <jsmith@mcs.drexel.edu>
To: Dave Nuttall <dnuttall@dnlt.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <NEBBICLICOEMMGDNHPIOGEENDHAA.dnuttall@dnlt.com>
References: <NEBBICLICOEMMGDNHPIOGEENDHAA.dnuttall@dnlt.com>
Content-Type: text/plain
Date: 05 Jun 2002 06:47:26 -0400
Message-Id: <1023274046.2138.7.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2002-06-04 at 17:08, Dave Nuttall wrote:
> Hello,
> I've got a RH 7.3 system that I'm considering as the target for the NSA
> Secure Linux.
> However, the stable version points to utils that are clearly RH 7.2 vintage.
> 
> Would you mind sharing what you did to be able to use 7.3?
> Looks like grabbing the SRPMS, pulling the applicable source and modifying
> some Makefile references is the minimum that would be required.
> 
> My installation is a reduced "Server" install of 7.3.  Does that vary with
> your starting point?
> 
> Thanks for your consideration.
> 
> Dave Nuttall
> San Antonio, TX

I just installed the latest stable version of tarball form of NSA 
SELinux. (I dont' trust the NSA RPMS to install correctly). Apparently,
the 7.2 versions of the crucial utilities do not differ appreciably from
the 7.3 versions.

Several other points:

I originally thought that SELinux crashed on reboot, but it turned out
to be a defect in my installation of RH7.3.

Upgrading from 7.2 to 7.3 is harder than most RH upgrades --- the
standard upgrade process failed for me and I had to do a complete
install. But one must be sure to reformat ALL system directories
(particularly /var) since the process of rebooting the system seems to
have changed in a very significant way from 7.2 to 7.3.

In addition, 7.3 doesn't initialize USB devices automatically. One must
add the lines 

alias usb-controller uhci
alias usbcore uhci
post-install uhci modprobe printer
post-install printer modprobe joydev
post-install joydev modprobe hid

by hand to /etc/modules.conf

After this, everything seems to work OK.
--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
