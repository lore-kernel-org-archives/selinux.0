From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Tue, 16 Feb 2010 14:19:05 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"sestatus -v" reports the following:

SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        refpolicy

Process contexts:
Current context:                system_u:system_r:sysadm_t
Init context:                   system_u:system_r:init_t
/sbin/mingetty                  system_u:system_r:sysadm_t

File contexts:
Controlling term:               system_u:object_r:tty_device_t
/etc/passwd                     system_u:object_r:etc_t
/etc/shadow                     system_u:object_r:shadow_t
/bin/bash                       system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t -> system_u:object_r:shell_exec_t
/sbin/agetty                    system_u:object_r:getty_exec_t
/sbin/init                      system_u:object_r:init_exec_t
/sbin/mingetty                  system_u:object_r:getty_exec_t
/usr/sbin/sshd                  system_u:object_r:sshd_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_r:lib_t
/lib/ld-linux.so.2              system_u:object_r:lib_t -> system_u:object_r:ld_so_t

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, February 16, 2010 2:10 PM
To: Alan Rouse
Cc: 'selinux@tycho.nsa.gov'
Subject: Re: SELinux Policy in OpenSUSE 11.2

On Tue, 2010-02-16 at 09:55 -0500, Alan Rouse wrote:
> I've been trying to get SELinux working in OpenSUSE 11.2.  So far I 
> can get to runlevel 3 with enforcing=0.  Before I start tinkering with 
> audit2allow, I thought I should get some advice.
>  
> The 11.2 repository gives me these policy rpms:
>  
> http://download.opensuse.org/repositories/openSUSE:/11.2/standard/noar
> ch/selinux-policy-2.20081210-3.1.noarch.rpm
> http://download.opensuse.org/repositories/openSUSE:/11.2/standard/src/
> selinux-policy-2.20081210-3.1.src.rpm
>  
> But that version of policy has some issues in OpenSUSE:
>  
> 1) failure to allow the graphical desktop to load (even with
> enforcing=0) .   The following message appears in the console during
> boot:
>  
> ** (gdm:1073): WARNING **: Couldn't connect to system bus: A SELinux 
> policy prevents this sender from sending this message to this 
> recipient (rejected message had sender "(unset)" interface 
> "org.freedesktop.DBus" member "Hello" erro name "(unset)" destination
> "org.freedesktop.DBus") startproc: exit status of parent of 
> /usr/sbin/gdm: 1
>  
> Since enforcing is off, I'm surprised to see a message like that.
> SELinux shouldn't be preventing anything, so I don't see how modifying 
> policy will solve that.  Ideas?
>  
> 2) Attempting to boot to runlevel 5 with kernel parms 
> "security=selinux selinux=1 enforcing=0", I'm dropped off in runlevel
> 3 instead. I'm getting a couple of pages of AVC errors after boot (see 
> below).
>  
> I've tried several other versions of the policy without luck: 
> - the version included in Fedora 12  (refpolicy-2.2009117
> - the latest release from Tresys
> - the latest from the repository at Tresys
>  
> They all give basically the same problems.  Any advice would be 
> appreciated.

What does sestatus -v report?

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
