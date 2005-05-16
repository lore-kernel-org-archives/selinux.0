Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4GIpNgA022235
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 14:51:23 -0400 (EDT)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4GIlwge029748
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 18:47:58 GMT
Subject: dead types (was: crond_log_t)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: selinux-dev@tresys.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200505170004.58546.russell@coker.com.au>
References: <200505170004.58546.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 16 May 2005 14:49:31 -0400
Message-Id: <1116269371.2883.35.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-17 at 00:04 +1000, Russell Coker wrote:
> What is the point of the type crond_log_t?
> 
> It's been in the policy for ages but I don't recall any time at which it had a 
> purpose.

Speaking of dead types, while looking around, I found that lvm_vg_t has
no rules (other then those implied by it's attributes).  I'm not very
familiar with LVM, but from what I'm guessing, it was used for LVM
volume group device nodes.  However, these are treated in exactly the
same was as fixed_disk_device_t, so at some point the rules were
switched over to fixed_disk_device_t, but lvm_vg_t was not deleted.
There are no file context entries for this type.

Udev_runtime_t seems to be a copy of udev_tbl_t, based on the
description in types/file.te.  Only hotplug and initrc have access to
this type.  It also has no file context entries.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
