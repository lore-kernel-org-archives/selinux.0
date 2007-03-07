Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27FdouD021968
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 10:39:50 -0500
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l27FfGDR000889
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 15:41:17 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <48DF9C2F-73CF-4657-91AD-A6E1F3BD4A2E@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: radvd policy changes
Date: Wed, 7 Mar 2007 16:41:06 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

radvd needs ioctl perms for the configfile (/etc/radvd.conf)

< allow radvd_t radvd_etc_t:file { getattr read };
---
 > read_files_pattern(radvd_t,etc_t,radvd_etc_t)


Another problem may only concern to Debian distributions. The init- 
script for radvd cleans a file (/var/run/radvd/saved-settings) and  
needs special privileges to do the work. audit2allow output:

allow initrc_t radvd_var_run_t:dir add_name;
allow initrc_t radvd_var_run_t:file { append create };

What is the suggested SELinux way to handle such a situation? Deny  
and don't care? A "ifdef(`distro_debian'" and allow init to do the job?


Regards,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
