Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA08197
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 21:21:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA01208
	for <selinux@tycho.nsa.gov>; Sat, 20 Jul 2002 01:20:27 GMT
Received: from imo-d10.mx.aol.com (imo-d10.mx.aol.com [205.188.157.42])
        by jazzband.ncsc.mil  with ESMTP id BAA01204 for <selinux@tycho.nsa.gov>; Sat, 20 Jul 2002 01:20:27 GMT
Message-ID: <3D388424.2050506@netscape.net>
Date: Fri, 19 Jul 2002 17:27:00 -0400
From: "Charles R. Fuller" <charlesrfuller@netscape.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: booting problem
References: <Pine.GSO.4.33.0207111336390.15869-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

I am having a problem of booting selinux on my machine.  I have modified 
the kernel and finished off with a the quick install command.

The specific error is a kernel panic on boot of the selinux kernel and 
an error point to correcting the referrence for "ROOT="

The reference "ROOT=" is the same for the none linux kernels.  Thanks 
for the help in advance.

Also I originally used GRUB as the boot loader the first time I ran 
Redhat 7.2 with SE-linux.  If you know how to change the boot loader  
from lilo to GRUB that could be one option.


Charles R. Fuller




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
