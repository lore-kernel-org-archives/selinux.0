Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IAhCRb000249
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 06:43:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IAelB2001698
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:40:47 GMT
Received: from hafnium.btinternet.com (hafnium.btinternet.com [194.73.73.121])
	by jazzswing.ncsc.mil  with ESMTP id i4IAelwi001695
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:40:47 GMT
Received: from [81.130.181.235] (helo=lkcl.net)
	by hafnium.btinternet.com with esmtp (Exim 3.22 #25)
	id 1BQ23w-0003rU-00
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 11:43:08 +0100
Received: from highfield ([192.168.0.223]:34030 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQ26i-0007a4-Ox
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:46:00 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQ21M-0006m9-TV
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 10:40:28 +0000
Date: Tue, 18 May 2004 10:40:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518104026.GC24333@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

help, help, i discovered the existence of allow2audit, and _finally_
i now have a tool that i can use to understand avc messages in terms
of audit permissions: hooray!

would someone mind advising me which of these is reasonable/safe
to allow, or should i just bung them all in and see what happens?

i am running with debian/unstable which was built from debian/unstable
packages about a month ago.

from the list, below, i've removed me editing syslog as root without
doing newrole -r system_r :)

from this list, i just get the impression that something's broken,
but haven't the experience yet to tell what it is.

for example, with wdm installed, surely these two shouldn't be
missed, along with the other wdm_config ones?

	allow initrc_t xdm_rw_etc_t:dir { add_name remove_name write };
	allow initrc_t xdm_rw_etc_t:file { create ioctl rename unlink write };

i mean, i see in domains/programs/xdm.te that there _are_
allow initrc_t xdm_rw_etc_t permissions for create (create_file_perms)
and also a comment that init scripts want to check for update
windowmanagerlist so they get getattr and read allowed.

... so what's going on?? why am i getting these messages?

if i am using wdm (the patched version) is there anything i need to
do to get it to work / be accepted?

i'll try removing wdm and installing xdm instead, see what difference
it makes.


allow cupsd_t usbfs_t:dir { search };
allow cupsd_t usbfs_t:file { getattr read };
allow dmesg_t etc_t:file { getattr read };
allow dpkg_t init_t:fd { use };
allow hotplug_t cupsd_t:file { read };
allow hotplug_t dbusd_t:file { read };
allow hotplug_t dbusd_var_run_t:dir { search };
allow hotplug_t dbusd_var_run_t:sock_file { write };
allow hotplug_t etc_runtime_t:file { relabelfrom relabelto };
allow hotplug_t inetd_t:file { read };
allow hotplug_t insmod_t:file { read };
allow hotplug_t klogd_t:file { read };
allow hotplug_t lib_t:file { execute execute_no_trans };
allow hotplug_t portmap_t:file { read };
allow hotplug_t romfs_t:chr_file { ioctl read write };
allow hotplug_t romfs_t:dir { search };
allow hotplug_t sshd_t:file { read };
allow hotplug_t syslogd_t:file { read };
allow initrc_t dbusd_var_run_t:sock_file { write };
allow initrc_t device_t:fifo_file { setattr };
allow initrc_t initrc_t:tcp_socket { ioctl };
allow initrc_t usbfs_t:file { getattr read };
allow initrc_t usr_t:file { execute execute_no_trans };
allow initrc_t xdm_rw_etc_t:dir { add_name remove_name write };
allow initrc_t xdm_rw_etc_t:file { create ioctl rename unlink write };
allow insmod_t romfs_t:chr_file { getattr read write };
allow sshd_t sshd_t:file { getattr };
allow sshd_t staff_home_t:dir { search };
allow staff_chkpwd_t sshd_devpts_t:chr_file { read write };
allow staff_chkpwd_t staff_chkpwd_t:file { getattr };
allow staff_su_t sshd_devpts_t:chr_file { ioctl };
allow staff_su_t sysadm_home_dir_t:dir { search };
allow staff_t sshd_devpts_t:chr_file { ioctl read setattr write };
allow staff_t staff_t:capability { dac_override };
allow staff_t sysadm_home_dir_t:dir { add_name read remove_name write };
allow staff_t sysadm_home_dir_t:file { create getattr read rename setattr unlink write };
allow staff_t var_log_t:dir { add_name getattr read remove_name search write };
allow staff_t var_log_t:file { create getattr read unlink write };
allow syslogd_t device_t:fifo_file { ioctl read write };
allow syslogd_t innd_log_t:file { append ioctl };
allow system_chkpwd_t sshd_t:tcp_socket { read write };
allow system_chkpwd_t sshd_t:unix_stream_socket { read write };
allow system_chkpwd_t system_chkpwd_t:file { getattr };
allow xdm_t memory_device_t:chr_file { read };
allow xdm_xserver_t usr_t:file { getattr read };
allow xdm_xserver_t xdm_var_lib_t:file { write };
allow cupsd_t usbfs_t:dir { search };
	#EXE=/usr/lib/cups/backend/canon   :  search

allow cupsd_t usbfs_t:file { getattr read };
	#EXE=/usr/lib/cups/backend/canon  NAME=devices   :  read
	#EXE=/usr/lib/cups/backend/canon  PATH=/proc/bus/usb/devices   :  getattr

allow dpkg_t init_t:fd { use };
	#EXE=/usr/lib/dpkg/enoent  PATH=/dev/console   :  use

allow hotplug_t cupsd_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t dbusd_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t dbusd_var_run_t:dir { search };
	#EXE=/usr/lib/hal/hal.hotplug  NAME=dbus   :  search

allow hotplug_t dbusd_var_run_t:sock_file { write };
	#EXE=/usr/lib/hal/hal.hotplug  NAME=system_bus_socket   :  write

allow hotplug_t etc_runtime_t:file { relabelfrom relabelto };
	#EXE=/bin/cp  NAME=ifstate.hotplug   :  relabelfrom
	#EXE=/bin/cp  NAME=ifstate.hotplug   :  relabelto

allow hotplug_t inetd_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t insmod_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t klogd_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t lib_t:file { execute execute_no_trans };
	#EXE=/bin/bash  NAME=hal.hotplug   :  execute
	#EXE=/bin/bash  PATH=/usr/lib/hal/hal.hotplug   :  execute_no_trans

allow hotplug_t portmap_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t romfs_t:chr_file { ioctl read write };
	#EXE=/bin/bash  PATH=/initrd/dev/console   :  read write
	#EXE=/bin/bash  PATH=/initrd/dev/console   :  ioctl

allow hotplug_t romfs_t:dir { search };
	#EXE=/bin/bash   :  search

allow hotplug_t sshd_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow hotplug_t syslogd_t:file { read };
	#EXE=/bin/ps  NAME=stat   :  read

allow initrc_t dbusd_var_run_t:sock_file { write };
	#EXE=/usr/sbin/hald  NAME=system_bus_socket   :  write

allow initrc_t initrc_t:tcp_socket { ioctl };
	#EXE=/usr/bin/perl  PATH=socket   :  ioctl

allow initrc_t usbfs_t:file { getattr read };
	#EXE=/usr/sbin/hald  NAME=devices   :  read
	#EXE=/usr/sbin/hald  PATH=/proc/bus/usb/devices   :  getattr

allow initrc_t usr_t:file { execute execute_no_trans };
	#EXE=/sbin/start-stop-daemon  NAME=miniserv.pl   :  execute
	#EXE=/sbin/start-stop-daemon  PATH=/usr/share/webmin/miniserv.pl   :  execute_no_trans

allow initrc_t xdm_rw_etc_t:dir { add_name remove_name write };
	#EXE=/usr/bin/perl  NAME=wdm   :  write
	#EXE=/usr/bin/perl  NAME=wdm-config.new   :  add_name
	#EXE=/usr/bin/perl  NAME=wdm-config.new   :  remove_name

allow initrc_t xdm_rw_etc_t:file { create ioctl rename unlink write };
	#EXE=/usr/bin/perl  PATH=/etc/X11/wdm/wdm-config   :  ioctl
	#EXE=/usr/bin/perl  NAME=wdm-config.new   :  create
	#EXE=/usr/bin/perl  PATH=/etc/X11/wdm/wdm-config.new   :  write
	#EXE=/usr/bin/perl  NAME=wdm-config.new   :  rename
	#EXE=/usr/bin/perl  NAME=wdm-config   :  unlink

allow insmod_t romfs_t:chr_file { getattr read write };
	#EXE=/sbin/modprobe  PATH=/initrd/dev/console   :  read write
	#EXE=/sbin/modprobe  PATH=/initrd/dev/console   :  getattr

allow sshd_t sshd_t:file { getattr };
	#EXE=/usr/sbin/sshd  PATH=/proc/1513/mounts   :  getattr

allow sshd_t staff_home_t:dir { search };
	#EXE=/usr/sbin/sshd  NAME=.ssh   :  search

allow system_chkpwd_t sshd_t:tcp_socket { read write };
	#EXE=/sbin/unix_verify  PATH=socket   :  read write

allow system_chkpwd_t sshd_t:unix_stream_socket { read write };
	#EXE=/sbin/unix_verify  PATH=socket   :  read write

allow system_chkpwd_t system_chkpwd_t:file { getattr };
	#EXE=/sbin/unix_verify  PATH=/proc/1516/mounts   :  getattr
	#EXE=/sbin/unix_verify  PATH=/proc/1540/mounts   :  getattr

allow xdm_t memory_device_t:chr_file { read };
	#EXE=/usr/X11R6/bin/wdm  NAME=mem   :  read

allow xdm_xserver_t usr_t:file { getattr read };
	#EXE=/usr/X11R6/bin/XFree86  PATH=/usr/local/share/fonts/fonts.dir   :  getattr
	#EXE=/usr/X11R6/bin/XFree86  NAME=fonts.dir   :  read

allow xdm_xserver_t xdm_var_lib_t:file { write };
	#EXE=/usr/X11R6/bin/X  PATH=/var/lib/wdm/authdir/authfiles/A:0-rhABmk   :  write

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
