Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6LJ1UO4025032
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 15:01:30 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6LJ1T3P023028
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 19:01:30 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
Date: Sat, 21 Jul 2007 15:01:25 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588DE1B1E@exchange.columbia.tresys.com>
In-Reply-To: <Line.LNX.4.64.0707211354410.5867@d.namei>
References: <C2C7258F.36C9%dwindsor@gmail.com> <46A22C37.5030004@codemonkey.ws> <Line.LNX.4.64.0707211354410.5867@d.namei>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "James Morris" <jmorris@namei.org>,
        "Anthony Liguori" <anthony@codemonkey.ws>
Cc: "David Windsor" <dwindsor@gmail.com>,
        "kvm-devel" <kvm-devel@lists.sourceforge.net>,
        "David Windsor" <dwindsor@tresys.com>,
        "selinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Sat, 21 Jul 2007, Anthony Liguori wrote:
> 
>> Can you already write an selinux policy that changes the label of a
>> process when it open()s a different file?
> 
> No, and you normally want to do this over an exec anyway, to
> ensure the new execution state is clean.
> 

This is correct and the object model being proposed isn't just about
opening files. 

Anthony - There are several userspace object managers for SELinux,
basically they manage resources that are too abstract for the kernel to
manage. These include DBUS connections, X windows/pixmaps/cursors/etc,
postgresql tables and rows, etc. SELinux is designed to designed to have
non-centralized enforcement of the policy (but centralized decision
making). In this case the object model isn't just about opening a file,
its about lauching and restricting a vm based on an abstract resource,
in this case a virtual disk file, that the kernel can't differenciate
from any other file.

The reason for this abstraction is simple, think about all the files
that qemu has to open that aren't disk files. For example, if you have 3
vm's, unclass, secret, top secret, those qemu processes still have to
share resources, library files, configuration files, devices,
potentially log, pid etc. If someone could manage to get a top secret
disk labeled lib_t they could boot any of those vm's with that disk
image (using snapshot or some feature to prevent write attempts on it),
and disclose top secret data where it shouldn't be disclosed. 

With David's object model this kind of attack can be prevented because
virtual disk files aren't 'just files' to qemu, they are an abstract
resource that means more than just a regular file, just like a database
file is more than just a regular file for SE-Postgresql.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
