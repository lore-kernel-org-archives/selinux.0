Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Wed, 17 Feb 2010 08:35:01 -0500
Message-Id: <1266413701.4945.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-16 at 16:30 -0500, Alan Rouse wrote:
> I had been trying various things in this image.  So, just to be sure I have a repeatable state, I've rebuilt my system from scratch as follows:
> 
> 1. standard OpenSuse 11.2 install (using Gnome);  boot; start terminal; su -
> 2.  install packages: 
> 
> selinux-tools 
> selinux-policy 
> libselinux* 
> libsemanage* 
> policycoreutils 
> checkpolicy   
> make 
> m4 
> gcc 
> findutils-locate 
> git
> 
> 3.  add "3 security=selinux selinux=1 enforcing=0" to the grub boot line (boot to runlevel 3 with selinux in permissive mode) and reboot.
> 4.  git clone http://oss.tresys.com/git/refpolicy.git
> 5.  change build.conf:  "DIST = suse"  and "MONOLITHIC = n"
> 6.  make clean; make conf; make; make install-src; 

You didn't do a make install or a make load?
Given that you are doing a modular build, you have to do both to
actually install the modules and link/expand them to kernel policy.
make install-src isn't needed.

In any event, I would suggest trying to use the OpenSUSE-provided policy
first and seeing what issues arise there before you go switching to the
upstream refpolicy.

> 7.  change /etc/refpolicy to point to the just-built policy version, and reboot
> 8.  restorecon -R /; reboot
> 
> sestatus -v gives:
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy
> 
> Process contexts:
> Current context:                system_u:system_r:sysadm_t
> Init context:                   system_u:system_r:init_t
> /sbin/mingetty                  system_u:system_r:sysadm_t
> 
> File contexts:
> Controlling term:               system_u:object_r:tty_device_t
> /etc/passwd                     system_u:object_r:etc_t
> /etc/shadow                     system_u:object_r:shadow_t
> /bin/bash                       system_u:object_r:shell_exec_t
> /bin/login                      system_u:object_r:login_exec_t
> /bin/sh                         system_u:object_r:bin_t -> system_u:object_r:shell_exec_t
> /sbin/agetty                    system_u:object_r:getty_exec_t
> /sbin/init                      system_u:object_r:init_exec_t
> /sbin/mingetty                  system_u:object_r:getty_exec_t
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t
> /lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_r:lib_t
> /lib/ld-linux.so.2              system_u:object_r:lib_t -> system_u:object_r:ld_so_t
> 
> pstree- Z gives:
> init(`system_u:system_r:init_t')
>  |-acpid(`system_u:system_r:sysadm_t')
>  |-auditd(`system_u:system_r:sysadm_t')
>  |  |-audispd(`system_u:system_r:sysadm_t')
>  |  |  `-{audispd}(`system_u:system_r:sysadm_t')
>  |  `-{auditd}(`system_u:system_r:sysadm_t')
>  |-cron(`system_u:system_r:sysadm_t')
>  |-cupsd(`system_u:system_r:sysadm_t')
>  |-dbus-daemon(`system_u:system_r:sysadm_dbusd_t')
>  |  `-{dbus-daemon}(`system_u:system_r:sysadm_dbusd_t')
>  |-dhcpcd(`system_u:system_r:dhcpc_t')
>  |-login(`system_u:system_r:sysadm_t')
>  |  `-bash(`system_u:system_r:sysadm_t')
>  |     `-pstree(`system_u:system_r:sysadm_t')
>  |-master(`system_u:system_r:sysadm_t')
>  |  |-pickup(`system_u:system_r:sysadm_t')
>  |  `-qmgr(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-mingetty(`system_u:system_r:sysadm_t')
>  |-nscd(`system_u:system_r:sysadm_t')
>  |-rpcbind(`system_u:system_r:sysadm_t')
>  |-rsyslogd(`system_u:system_r:sysadm_t')
>  |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |  `-{rsyslogd}(`system_u:system_r:sysadm_t')
>  |-startpar(`system_u:system_r:sysadm_t')
>  |-udevd(`system_u:system_r:sysadm_t')
>  |  |-udevd(`system_u:system_r:sysadm_t')
>  |  `-udevd(`system_u:system_r:sysadm_t')
>  `-vmtoolsd(`system_u:system_r:sysadm_t')
> 
> Now, I tried setsebool -P init_upstart=1.  It gives an error message:
> ----------------
> Libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than 1000 or its log in shell is /sbin/nologin.
> ----------------
> 
> So I did "usermod -s /sbin/nologin nobody" and repeated the setsebool
> (no error message returned, and "getsebool init_upstart" reports that
> it was on.  But after reboot it is off again...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
