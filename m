Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0K9dxvO022946
	for <selinux@tycho.nsa.gov>; Sat, 20 Jan 2007 04:39:59 -0500
Received: from vsmtp3.tin.it (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0K9eset012170
	for <selinux@tycho.nsa.gov>; Sat, 20 Jan 2007 09:40:55 GMT
Received: from [192.168.0.3] (87.11.84.53) by vsmtp3.tin.it (7.2.072.1)
        id 4589478000C1427C for selinux@tycho.nsa.gov; Sat, 20 Jan 2007 10:40:49 +0100
Subject: SELinux and kernel 2.6.19.2
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 20 Jan 2007 10:40:48 +0100
Message-Id: <1169286048.7552.14.camel@zeroKnowledge>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, like i said i had no problems to load SeLinux with a 2.6.14.5
kernel. 

So today i decided to upgrade to the latest 2.6.19.2. I built the kernel
succesfully but under "Security Options" i can't see the old "NSA
SELinux Support". Where is it ? How can i give to my system full support
with this kernel? I added Security Hooks support and security labels
too.

So i tried to add in my .config the following lines:

CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

But nothing happened. I still have no SELinux support.

Maybe this is a dumb question, sorry, but i never tried to add the
SELinux support to one of the latest kernels. And i think there's
something that i still don't know about this.

Any help would be appreciated. Thank you!

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix - <www.netwosix.org>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
