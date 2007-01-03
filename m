Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03Gs12B001833
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 11:54:02 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l03GsiG7021554
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 16:54:45 GMT
Message-ID: <459BDFD4.7080903@redhat.com>
Date: Wed, 03 Jan 2007 11:54:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After one hell of a merge.  :^(

Spent Christmas vacation week getting Strict policy into shape.

Here are a bunch of changes as well as fixes for targeted and mls policy

http://people.redhat.com/dwalsh/SELinux/policy.diff

----------------------------------------------------------------------------------

Had to add system_u:system_u to seusers to get cron to work correctly.  
Cron calls getseusers with parameter of "system_u" if this seuser does 
not exist it fails over to user_u and everything blows up.

Added booleans

allow_ftpd_full_access -  Allows users to use ftp and read any file on 
the system.  Pretty close to disable_trans, but you still have some 
network controls.


Changes allow_mount_anyfile to only allow files
added allow_mounton_anydir to allow admin to mount on any directory but 
not read files

allow_daemons_dump_core - Allow daemons to create corefiles in /

use_lpd_server boolean removes lots of not needed privs from lpr on cups 
platforms.

allow_unconfined_execmem_dyntrans is only used on ia64 platforms to run 
32 bit applications.  kernel does some funny stuff and rexecs 
unconfined_t programs but needs execmem and execstack.  Otherwise ia64 
has to run all apps with execmem execstack.


The MLS constraints are really screwed up.  Need to come to some kind of 
agreement between you, klaus and tcs.

usedom_executable_file is still in there.  I believe we need to separate 
out the executables that are expected to be run by a user and those 
expected to be run by the system.  This helps prevent accidently running 
of applications under sysadm_t.

mkinitrd should not be confined and should not be labeled 
bootloader_exec_t.  This just causes too many problems and little benifit.

I do not want consoletype and hostname transitioning to their domains 
unless they need the privs,  Having them transition from an init script 
is broken, because you end up with tons of denials when applications 
redirect stdin/stdout

Hal restarts the network which has a transition to consoletype and thus 
we get denials.

logwatch looks for files under /var

quota needed major rework to work correctly in MLS environment

Certain tools have rpm libraries built into them and these end up 
calling the transition rules and getting denials.  I want to allow 
unconfined_t to transition to rpm_script_t

rpm execs prelink and chats with hal, also needs to kill processes 
running at different sensitivity levels


Added a tzdata domain to allow proper context of /etc/localtime

sudo reads netlink_route_socket,  wants to look at the kernel key ring, 
stores a token in the pam_pid directory, and needs to getattr on all 
"user" executables.

Some changes to su in order to handle key rings,  Needs 
mls_file_write_down.  Need to be able to su from different domains, and 
pam_rootok causes some selinux_compute_access checks.


usermanage was changed to allow useradd to automatically label the 
homedirs correctly.  useradd now has a -s qualifier that allows it to 
select the selinux user.  It also then labels the directory correctly.  
Critical for MLS and Strict policy to work.

Lots of fixes to get evolution, mozilla, thunderbird, gnome, mplayer to 
work with strict policy.

evolution still needs work.  (I mainly use thunderbird...)

Fixes to get gpg secret created correctly

Added java_domtrans_user_javaplugin to get transition from 
staff_mozilla_t -> staff_javaplugin_t to work.

java wants to dbus chat with unconfined domains and init domains.

Not sure why you want if targeted_policy in loadkeys_run?

Fixes for slocate on MLS

userhelper role line is wrong
userhelper_exec so sysadm_t can run userhelper without transitioning.

webalizer wants to getattr fs_t

Label some executables stored in wierd places.

Still want break out of hi_reserved_port_t from reserved_port_t.

genfscon for ntfs-3g

handles for unlabled_t packets

fixes for kernel_unconfined

httpd_t wants to write to snmp_var_lib_t files.  Dontaudit.

Several domains want to run telinit.  Added init_exec.

Remove anacron_exec_t.   Just run in crond_t.

Remove automount_etc_t - Useless.

clamd wants to read kernel sysctl


Lots of fixes to get cron to work and to use polyinstantiation.

cups changes to run in MLS

dbus needs to ptrance itself.

Needs new interface to connect to user bus.

ftp needs to write to faillog

Hal transitions to some other domains, but needs to have it's fds and 
fifo_files dontaudited

fixes to allow inetd to run on mls

irqbalance needs additional privs

kerberos libraries now try to read krb6kdc_conf_t,  Should be dontaudited.

Lots of fixes to get ypxfr/ypserv to work correctly

Dont want dontaudit var_yp_t:dir search line since this prevents 
setroubleshoot from realizing you are on an NIS box.

nscd needs auth_use_nsswitch

Added policy for pcscd

Lots of fixes to get rhgb to work correctly in a strict enforcing mode.

rlogind needs nsswitch

sendmail wants to read clamav_libs

userspace connects to setroubleshoot unix_stream_socket

fsdaemon needs mls_write_down

spamassisin needs to read /var/lib/spamassisin directory

ssh_agent leaks fds by design.

sshd wants to look at kernel key ring


relabel ICE-UNIX to xdm_tmp_t, since we can not get transition to work 
correcrtly.  Hopefully alot of these other communications paths are 
being eliminated by gnome.

Lots of fixes to get xserver working with strict policy


fixes for authlogin handling of keyrings and mls, as well as pcscd

hwclock wants to read system state.

mkswap should not run as fsadm.  Should be labeled sbin_t.

Fixes for initrc to run in strict

fixes for iptbales to use nscd

local_login needs additional privs

lvm needs privs for multipath

/usr/share/X11/locale needs a label.

initrc replace localization files using cp -A to preserve context.  This 
causes many avc messages.

modutils fixes for strict policy

Need correct labels for genhomedircon and system-config-selinux to 
create context correctly.

Lots of fixes for polyinstatiation on MLS

Lots of updates to allow userdomain to work correctly in strict policy







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
