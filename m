Subject: Re: Cannot go to enforcing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100131160542.GA17123@alanny-pc.lcl.starlink.ru>
References: <20100131160542.GA17123@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 09:33:24 -0500
Message-Id: <1265034804.12435.20.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-01-31 at 19:05 +0300, AlannY wrote:
> Hi there. Still tryint to go to enforcing in Archlinux.
> 
> First of all, my sestatus -v
> 
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy
> 
> Process contexts:
> Current context:                user_u:user_r:user_t:s0
> Init context:                   system_u:system_r:init_t:s0
> /sbin/agetty                    system_u:system_r:getty_t:s0
> 
> File contexts:
> Controlling term:               user_u:object_r:user_tty_device_t:s0
> /etc/passwd                     system_u:object_r:etc_t:s0
> /etc/shadow                     system_u:object_r:shadow_t:s0
> /bin/bash                       system_u:object_r:shell_exec_t:s0
> /bin/login                      system_u:object_r:login_exec_t:s0
> /bin/sh                         system_u:object_r:bin_t:s0 -> system_u:object_r:shell_exec_t:s0
> /sbin/agetty                    system_u:object_r:getty_exec_t:s0
> /sbin/init                      system_u:object_r:init_exec_t:s0
> /lib/libc.so.6                  system_u:object_r:lib_t:s0 -> system_u:object_r:lib_t:s0
> 
> I'm using latest refpolicy with build.conf as in Fedora:
> 
> TYPE = mcs
> NAME = refpolicy
> DISTRO = redhat
> UNK_PERMS = allow
> DIRECT_INITRC = y
> MONOLITHIC = n
> UBAC = n
> MCS_CATS = 1024
> 
> I want to make system as Fedora do. But, when I'm in enforcing in Fedora I have:
> 
>     %# id -Z
>     unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> 
> On Archlinux I have:
> 
>     %# id -Z
>     user_u:user_r:user_t:s0
> 
> After
> 
>     %# su
>     %# setenforce
> 
> I cannot
> 
>     %# ls
> 
> Error: Permission denied. With non-root user I can `ls` directory. After `exit` from current user,
> nothing shows (must show another login prompt), system hangs and I can only reboot it and boot in permissive.
> 
>     %# audit2allow -d
> 
> #============= chkpwd_t ==============
> allow chkpwd_t tmpfs_t:dir search;
> 
> #============= getty_t ==============
> allow getty_t tmpfs_t:dir search;
> 
> #============= sysadm_t ==============
> allow sysadm_t file_t:chr_file { read write };
> 
> #============= user_su_t ==============
> allow user_su_t default_context_t:file { read getattr open };
> allow user_su_t init_t:unix_stream_socket connectto;
> allow user_su_t security_t:security compute_user;
> allow user_su_t tmpfs_t:dir search;
> allow user_su_t tmpfs_t:sock_file write;
> 
> #============= user_t ==============
> allow user_t self:capability { sys_ptrace dac_override };
> 
> What should I do next? Repeat: I want SELinux system in Archlinux that works like Fedora.

semanage login -l shows what?

You want to map your users to unconfined_u if you want targeted policy
behavior.  On a stock Fedora system, semanage login -l shows:
Login Name                SELinux User              MLS/MCS Range            

__default__               unconfined_u              s0-s0:c0.c1023           
root                      unconfined_u              s0-s0:c0.c1023           
system_u                  system_u                  s0-s0:c0.c1023   

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
