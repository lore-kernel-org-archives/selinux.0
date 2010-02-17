Message-ID: <4B7B643B.6020009@gmail.com>
Date: Tue, 16 Feb 2010 19:36:27 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Alan Rouse <alan.rouse@ericsson.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se> <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil> <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se> <4B7B21A2.3080006@gmail.com>
In-Reply-To: <4B7B21A2.3080006@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/16/2010 02:52 PM, Dominick Grift wrote:
> On 02/16/2010 10:30 PM, Alan Rouse wrote:
>> I had been trying various things in this image.  So, just to be sure I have a repeatable state, I've rebuilt my system from scratch as follows:
>>
>> 1. standard OpenSuse 11.2 install (using Gnome);  boot; start terminal; su -
>> 2.  install packages:
>>
>> selinux-tools
>> selinux-policy
>> libselinux*
>> libsemanage*
>> policycoreutils
>> checkpolicy
>> make
>> m4
>> gcc
>> findutils-locate
>> git
>>
>> 3.  add "3 security=selinux selinux=1 enforcing=0" to the grub boot line (boot to runlevel 3 with selinux in permissive mode) and reboot.
>> 4.  git clone http://oss.tresys.com/git/refpolicy.git
>> 5.  change build.conf:  "DIST = suse"  and "MONOLITHIC = n"
>> 6.  make clean; make conf; make; make install-src;
>> 7.  change /etc/refpolicy to point to the just-built policy version, and reboot
>> 8.  restorecon -R /; reboot
>>
>> sestatus -v gives:
>> SELinux status:                 enabled
>> SELinuxfs mount:                /selinux
>> Current mode:                   permissive
>> Mode from config file:          permissive
>> Policy version:                 24
>> Policy from config file:        refpolicy
>>
>> Process contexts:
>> Current context:                system_u:system_r:sysadm_t
>> Init context:                   system_u:system_r:init_t
>> /sbin/mingetty                  system_u:system_r:sysadm_t
>>
>> File contexts:
>> Controlling term:               system_u:object_r:tty_device_t
>> /etc/passwd                     system_u:object_r:etc_t
>> /etc/shadow                     system_u:object_r:shadow_t
>> /bin/bash                       system_u:object_r:shell_exec_t
>> /bin/login                      system_u:object_r:login_exec_t
>> /bin/sh                         system_u:object_r:bin_t ->  system_u:object_r:shell_exec_t
>> /sbin/agetty                    system_u:object_r:getty_exec_t
>> /sbin/init                      system_u:object_r:init_exec_t
>> /sbin/mingetty                  system_u:object_r:getty_exec_t
>> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t
>> /lib/libc.so.6                  system_u:object_r:lib_t ->  system_u:object_r:lib_t
>> /lib/ld-linux.so.2              system_u:object_r:lib_t ->  system_u:object_r:ld_so_t
>>
>> pstree- Z gives:
>> init(`system_u:system_r:init_t')
>>   |-acpid(`system_u:system_r:sysadm_t')
>>   |-auditd(`system_u:system_r:sysadm_t')
>>   |  |-audispd(`system_u:system_r:sysadm_t')
>>   |  |  `-{audispd}(`system_u:system_r:sysadm_t')
>>   |  `-{auditd}(`system_u:system_r:sysadm_t')
>>   |-cron(`system_u:system_r:sysadm_t')
>>   |-cupsd(`system_u:system_r:sysadm_t')
>>   |-dbus-daemon(`system_u:system_r:sysadm_dbusd_t')
>>   |  `-{dbus-daemon}(`system_u:system_r:sysadm_dbusd_t')
>>   |-dhcpcd(`system_u:system_r:dhcpc_t')
>>   |-login(`system_u:system_r:sysadm_t')
>>   |  `-bash(`system_u:system_r:sysadm_t')
>>   |     `-pstree(`system_u:system_r:sysadm_t')
>>   |-master(`system_u:system_r:sysadm_t')
>>   |  |-pickup(`system_u:system_r:sysadm_t')
>>   |  `-qmgr(`system_u:system_r:sysadm_t')
>>   |-mingetty(`system_u:system_r:sysadm_t')
>>   |-mingetty(`system_u:system_r:sysadm_t')
>>   |-mingetty(`system_u:system_r:sysadm_t')
>>   |-mingetty(`system_u:system_r:sysadm_t')
>>   |-mingetty(`system_u:system_r:sysadm_t')
>>   |-nscd(`system_u:system_r:sysadm_t')
>>   |-rpcbind(`system_u:system_r:sysadm_t')
>>   |-rsyslogd(`system_u:system_r:sysadm_t')
>>   |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>>   |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>>   |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
>>   |  `-{rsyslogd}(`system_u:system_r:sysadm_t')
>>   |-startpar(`system_u:system_r:sysadm_t')
>>   |-udevd(`system_u:system_r:sysadm_t')
>>   |  |-udevd(`system_u:system_r:sysadm_t')
>>   |  `-udevd(`system_u:system_r:sysadm_t')
>>   `-vmtoolsd(`system_u:system_r:sysadm_t')
>>
>> Now, I tried setsebool -P init_upstart=1.  It gives an error message:
>> ----------------
>> Libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than 1000 or its log in shell is /sbin/nologin.
>> ----------------
>>
>> So I did "usermod -s /sbin/nologin nobody" and repeated the setsebool (no error message returned, and "getsebool init_upstart" reports that it was on.  But after reboot it is off again...
>
> If you used the -P option with setsebool than the settings should be
> persistent across reboots.
>
>> -----Original Message-----
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>> Sent: Tuesday, February 16, 2010 2:39 PM
>> To: Alan Rouse
>> Cc: 'selinux@tycho.nsa.gov'
>> Subject: RE: SELinux Policy in OpenSUSE 11.2
>>
>> On Tue, 2010-02-16 at 14:19 -0500, Alan Rouse wrote:
>>> "sestatus -v" reports the following:
>>>
>>> SELinux status:                 enabled
>>> SELinuxfs mount:                /selinux
>>> Current mode:                   permissive
>>> Mode from config file:          permissive
>>> Policy version:                 24
>>> Policy from config file:        refpolicy
>>>
>>> Process contexts:
>>> Current context:                system_u:system_r:sysadm_t
>>> Init context:                   system_u:system_r:init_t
>>> /sbin/mingetty                  system_u:system_r:sysadm_t
>>
>> Ok, so init is in the right security context, but getty is not.
>> refpolicy has a rule that says if init runs a shell, transition to sysadm_t - that is for single-user mode.  But that gets disabled if using upstart since upstart runs everything via a shell.
>>
>> Try:
>> setsebool -P init_upstart=1
>> reboot
>>
>> pstree -Z output might also be interesting.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>
>


o.k. after thinking I decided to load up suse 11.2
to see if this was there policy, or if this was from git.
(I couldn't remember).

So after a simple install, and just using all the SELinux
packages they supply(x86_64), I can confirm that this
thing does crash and burn when going into the xserver, and gdm.
(on my other system I've been able to change policies, without user
logins, or names, and file labels completely wrong so I know file labels
and such don't make a difference(unless setting in full enforcement)).
but you never know.

Now to see/find the area of this cause.
my guess the last time I looked at this was some build switch
for SELinux in either one of the main gnome libs
or something else(dbus,hal etc(but could be wrong))...

I'll look at this and see what I can find.
(if building all of the gnome libs is what's going to
get this working I can do(just backbreaking work)).

Justin P. mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
