Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j31KP8Do015073
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 15:25:08 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j31KNaat020948
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 20:23:36 GMT
Message-ID: <424DACD9.9080403@redhat.com>
Date: Fri, 01 Apr 2005 15:19:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: selinux@tycho.nsa.gov
Subject: Re: Cron /null fd:use use denials
References: <1112295607.12948.69.camel@cobra.ivg2.net>
In-Reply-To: <1112295607.12948.69.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>What's causing those?
>
>audit(1112259892.387:9374931): avc:  denied  { use } for  pid=10993
>exe=/usr/sbin/sendmail.sendmail path=/null dev=selinuxfs ino=245
>scontext=system_u:system_r:system_mail_t
>tcontext=system_u:system_r:init_t tclass=fd
>
>audit(1112259892.551:9376543): avc:  denied  { use } for  pid=10996
>exe=/usr/sbin/tmpwatch path=/null dev=selinuxfs ino=245
>scontext=system_u:system_r:tmpreaper_t tcontext=system_u:system_r:init_t
>tclass=fd
>
>audit(1112259892.620:9377236): avc:  denied  { use } for  pid=10999
>exe=/usr/sbin/logrotate path=/null dev=selinuxfs ino=245
>scontext=system_u:system_r:logrotate_t tcontext=system_u:system_r:init_t
>tclass=fd
>
>  
>
I think we have found and fixed this problem.  Happens in the  initrd.  
Basically Sh script
was opening /init and leaving the file descriptor open, which would then 
get picked up
by init when init was execed.  Init would then load policy and hand the 
open file descriptor down ...

This should be fixed in the current rawhide.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
