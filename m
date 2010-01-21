Date: Thu, 21 Jan 2010 15:28:17 +0300
From: AlannY <m@alanny.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Policy is not managed or store cannot be accessed
Message-ID: <20100121122816.GB13907@alanny-pc.lcl.starlink.ru>
References: <20100120202135.GA6124@alanny-pc.lcl.starlink.ru>
 <1264020386.24133.182.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1264020386.24133.182.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 20, 2010 at 03:46:26PM -0500, Stephen Smalley wrote:
> Hmmm...did you label your filesystems?
> What does sestatus -v show?

SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        refpolicy

Process contexts:
Current context:                root:staff_r:insmod_t
Init context:                   system_u:system_r:kernel_t
/sbin/agetty                    system_u:system_r:kernel_t

File contexts:
Controlling term:               system_u:object_r:ramfs_t
/etc/passwd                     system_u:object_r:etc_t
/etc/shadow                     system_u:object_r:shadow_t
/bin/bash                       system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t -> system_u:object_r:shell_exec_t
/sbin/agetty                    system_u:object_r:getty_exec_t
/sbin/init                      system_u:object_r:init_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_r:lib_t

-- 
   )\._.,--....,'``.
  /,   _.. \   _\  (`._ ,.
 `._.-(,_..'--(,_..'`-.;.' 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
