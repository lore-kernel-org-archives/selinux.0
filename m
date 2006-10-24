Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9OF0VPb019273
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 11:00:31 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9OExiNf001784
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 14:59:45 GMT
Message-ID: <453E2A8C.4070207@redhat.com>
Date: Tue, 24 Oct 2006 11:00:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Diffs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://people.redhat.com/dwalsh/SELinux/policy-20061016.patch


flow_in flow_out changes for labeled networking.  Not sure if these are 
still needed.

Change allow_polyinstatiation into a boolean, since this turns on lots 
of privs.

Added use_lpd_server boolean to eliminate some not needed permissions 
from cups versions of lpr commands.

Added a userdom_executable_file type so that we can change the ability 
to execute all commands in MLS, to only be allowed to execute commands 
that an admin would legitimately like to execute without transition.

Amands needs additon privs

Anaconds should no longer create bootloader_runtime_t files

Remove commented out lines in bootloader.fc

Xen executed netutils and wants to log output.

prelink signals itself and needs to be able to output to the terminal 
and fix executables in homedirs.

Redhat's Fedora Extras apd-get and apt-shell run as rpm.

yum-updatesd runs as rpm and communicates over dbus with an applet 
running mono_t

Need to add rw_faillog to a bunch of domains.  Although this might be 
better in the a global place that handles login apps.

useradd is looking at default context and needs to be able to create 
home_dir_t.

IBM requests javaws and bin under /opt/ibm/java2-ppc64-50/jre be labeled 
java_exec_t


iscsi policy ready to merge.  You can probably start to role in ricci 
and cluster code, although I think only Red Hat is shipping this suff so 
far.

xen has a new device /dev/xen/blktap.*

Avc messages from caused by xsession-errors.log

Hal creats a file in /media directory

Autofs needs to manage symlinks

gfs and gfs2 now support xattrs.  encfs from fuse does also. although it 
is broken.

mv dosfs_t to nfs_t needs to work.

rhgb wants to setattr on a generic devpts_t

Apache scrips want to turn down their priority

httpd needs to be able to rotatelogs

httpd needs to be able to execute bash scripts as cgi.

automount needs to manage non security dirs and handle symlinks.  Also 
wants to open a rawip_socket.

Bluetooth now creates a directory in var as well as files.

Major changes to crontab_t to transition to user_tmp_t.  Why do we have 
a user_crond_t, would just transitioning to user_t make more sense?

crond needs to deal with kernel key ring

multi level cups support

other cups changes


dovecot_auth_t wants to rw utmp

hald needs power management device and manage mnt symlinks for setting 
up media (ipod)

Additional lpr type commands


nm-applet talks to named pipes of networkmanager

Fixed for oddjob_mkhomedir_t

Lots of fixes to get rhgb_t to work correctly

gssd_t needs to read certs

samba wants to rewrite cups configuration

setroubleshoot wants to look at sched because of threads

spamd needs to read netlink_route_socket

squid wants to rw_tmpfs for diskd mode.

add policy for tallylog

hwclock has a fifo_file and needs to search bin

fsadm_t needs to read up for MLS

getty needs sys_admin 

ibm wants all jre libraries and jar files textrel_shlib_t

locallogin keyring support

Auditctl needs aditional privs to look at other parts of the os

mount needs aditional privs


mdadm needs lots more privs

unconfined_t should not transition to so many domains.  Causes to many 
redirection avc messages.

auditadm and secadm need dac_ capabiliies

secadm needs to be able to relabel devices

Additional xen commands and devices

Want to be able to label a fixed_disk_device_t xen_image_t in order to 
allow xen access to raw devices.













--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
