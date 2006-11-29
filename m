Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATM6GAa003089
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 17:06:16 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATM5YBO011367
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 22:05:35 GMT
Message-ID: <456E0470.3010500@redhat.com>
Date: Wed, 29 Nov 2006 17:06:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Diffs 11/29
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://people.redhat.com/dwalsh/SELinux/diff

new booleans

prelink needs to manage execs created by amanda

amanda wants netlink_route

hal execs grub with a redirection of stdout, stderr

firstboot_write_pipes should be rw_pipes

logwatch wants to search sysfs

prelink wants to read symlinks

quota fixes for MLS

rpm execs prelink

rpm dbus chats with hal

Remove a bunch of cruft under TODO in rpm.

groupadd and useradd ask for sys_tty_config, work fine without it.

Why does loadkeys built this way.  Trying this interface blew up in 
targeted policy.

slocate fix for MLS

I think the hi_reserved_port_t change is good.

A few new devices and a change for MLS

We have a goal in RHEL 5 to eliminate all avc, so bogus ones caused by 
xsession-errors should be dontaudited.

Fixes for mount commands

Fixes for polyinstatiated needs rmdir

new interfaces for quota

Need fs_associate_noxattr(noxattrfs)

Xen has new tty_device_t  xvc

new cache directory for apache

Lots of fixes for apache.

Avahi has a unix_stream_socket that nsswitch uses

new named_conf_t file

clamd wants to read kernel sysctl

Cron handling of keyring

Cups changes for MLS

dbus dir mounted on named chroot, causes problems with tools checking 
file context.

ftpd wants to update utmp file

hal has a new writable directory /var/lib/hal

Add ocsp port and allow kerberos to communicate with it.

Lots of fixes for kerberos

update mta.if to eliminate avc message on mqueue_spool_t

ypxfr has moved and needs policy fixes

Dont want to dontaudit searches of var_yp_t so setroubleshoot will work 
correctly.

Oddjob needs to signal itself.

postfix uses uucp, and cyrus

procmail on cifs and nfs

gssd needs to getshed

samba interfaces need to be able to search_dir_perms on samba_etc_t

nmbd_t needs to be able to unlink log files

Fixes for swat

snmp wants to getattr additional places

spamd causes random avc messages on connecting to ports used by other apps

telnetd wants to look at netlink_route

tftpd uses ypbind

Added policy for uux

mkswap should not be fsadm_exec_t, it is SELinux aware.

xen execs hostname which causes avc when hostname tries to append to xen 
log files

init needs to exec initrc_exec_t when going to single user mode

more textrel_shlib_t changes

I have removed some hide_broken_symptoms thinking they are all fixed, 
but do you  want these around for RHEL4?

var_log_t is sometimes a mount point

lvm has a new directory /var/lib/multipath

clvmd needs lots of additional access.

locale files in /usr/share/X11/locale

depmod deletes kernel modules

mount wants to read netlink_route

mount commands sometimes execs other mount commands

allow mount to mounton any directory controlled by boolean
allow mount to bind mount andy file controlled by boolean

mdadm creates fixed disks

Added policy for system-config-selinux, basically a superset of 
semanage_t, currently unconfined, but need transition rules to maintain 
context in /etc/selinux/TYPE directories.

Additional rules for to get load_policy to work with MLS

Fix RealPlayer file specification, additional unconfined_execmem_exec_t 
domains.

Missing gen_require from userdomain.if

Change home_dir_t:dir search to search_dir_perms

Allow secadm to read audit_config,

secadm needs to run aide.

xen fixes, new images directory

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
