Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7S35GLa015367
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 23:05:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7S35Fet003116
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 03:05:16 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h7S35Elq003108 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 03:05:15 GMT
Message-ID: <3F4D7148.3040201@kam.hitachi-sk.co.jp>
Date: Thu, 28 Aug 2003 12:04:40 +0900
From: UENO Shuichi <ueno@kam.hitachi-sk.co.jp>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: About mkinitrd ...
References: <BAY8-DAV530OUIHNkjg0000040d@hotmail.com>
In-Reply-To: <BAY8-DAV530OUIHNkjg0000040d@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Ripin Natani wrote:
> I am compiling SElinux on  VMWare (VM : rh 9.0 , Host rh 9.0). I am 
...
> "No module BusLogic found for kernel mykernel, aborting mkinitrd failed"

Last night, I compiled new SELinux on VMware and got same message.
I change the BusLogic SCSI comfiguration to 'module'.

CONFIG_SCSI_BUSLOGIC=m

It works fine.

Thanks.

-- 
UENO Shuichi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
