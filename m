Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TEcgYk006194
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 10:38:42 -0400
Received: from mho-02-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TEcfLa013595
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 14:38:42 GMT
Received: from adsl-71-155-178-116.dsl.austtx.sbcglobal.net ([71.155.178.116] helo=[192.168.20.230])
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1KNqLZ-000H4h-1R
	for selinux@tycho.nsa.gov; Tue, 29 Jul 2008 14:38:41 +0000
Message-Id: <82459273-DA3E-4F80-B1D8-E3A168218B06@nall.com>
From: Joe Nall <joe@nall.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Should /dev/mem be SystemHigh?
Date: Tue, 29 Jul 2008 09:38:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ls -Z /dev/mem
crw-r-----  root kmem system_u:object_r:memory_device_t:SystemHigh / 
dev/mem

In our MLS X policy, we are giving the X server  
mls_file_read_all_levels and mls_file_write_all_levels to be able to  
access the SystemHigh /dev/mem. I would prefer not to give X general  
file MLS override if possible.

Is there a way to assign MLS read up/write up on just one type (i.e.  
allow X to read up only on memory_device_t)?

Is there a potential refactoring of the X server that eliminates the  
need for /dev/mem access? Dan hinted at this at the developer summit  
to allow X to run as the user.

Would it be better to mls_file_write_within_range(memory_device_t)  
(i.e. make it a trusted object) and pull the MLS override out of the X  
policy?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
