Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OLTnsj029954
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 16:29:49 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0OLRasm026154
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 21:27:42 GMT
Subject: OpenOffice Problems with Strict Policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   Steve Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1106601818.3298.56.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 16:23:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

OpenOffice will not run with the current strict policy that is in CVS. 
It needs: 
allow $1_t dri_device_t:chr_file { getattr read write ioctl };

Any ideas when it stopped working?  Any suggestions?  
I would prefer not to give everyone rw access.

Short history of rules in the base_user_domain macro:
allow $1_t dri_device_t:chr_file getattr; - Added in November 04
dontaudit $1_t dri_device_t:chr_file rw_file_perms; - Added in April 04

Related messages from dmesg when trying to start OpenOffice:
audit(1106599201.710:0): avc:  denied  { read write } for  pid=4792
exe=/usr/lib/ooo-1.1/program/soffice.bin name=card0 dev=tmpfs ino=9677
scontext=user_u:user_r:user_t tcontext=system_u:object_r:dri_device_t
tclass=chr_file
audit(1106599201.710:0): avc:  denied  { read write } for  pid=4792
exe=/usr/lib/ooo-1.1/program/soffice.bin name=card0 dev=tmpfs ino=9677
scontext=user_u:user_r:user_t tcontext=system_u:object_r:dri_device_t
tclass=chr_file

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
