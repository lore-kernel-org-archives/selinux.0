Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFpirT027918
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:45 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFovMZ015321
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:50:58 GMT
Date: Tue, 24 Aug 2004 17:01:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, Joshua Brindle <jbrindle@tresys.com>,
   Greg KH <greg@kroah.com>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040824160126.GA19197@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <412A74A6.9070206@tresys.com> <20040824092853.GD25356@lkcl.net> <200408242006.41591.russell@coker.com.au> <20040824141828.GA4698@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <20040824141828.GA4698@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2004 at 03:18:28PM +0100, Luke Kenneth Casson Leighton wrote:
> On Tue, Aug 24, 2004 at 08:06:41PM +1000, Russell Coker wrote:
> > On Tue, 24 Aug 2004 19:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > >  2) it ONLY set the permissions on the inode NOT on any symlinks and NOT
> > >     on any directories or subdirectories created.
> > 
> > This part is OK.  We have moved to using device_t (the default) as the context 
> > for all directories and sym-links under /dev.
>  
>  great, then the policy modifications i've made will be of some
>  value in pointing you in the right direction, i'll endeavour to
>  clean them up, sort them out [dammit i just did that and ended
>  up accidentally deleting it, i _must_ try to stop the habit of
>  reusing filenames f g h x y and z]
> 
>  i'm attaching also my modified /etc/init.d/udev file.
> 
>  as you can see it calls /sbin/restoredevicefiles (sent earlier)
>  after the make_extra_nodes() call has been made.

well you _could_ if i attached it.

okay, also attached the most historically horrible "ItWorksForMe(tm)"
udev-device-t-patch for selinux.

note that there are some awful hacks in here such as

	allow hotplug_t device_t:file { ioctl read write };

the reason for this horrible hack is because, i believe, i am
running /bin/ls from inside my horrible hack script
/sbin/restoredevicefiles.

during the setup phase, no program should endeavour to access
/dev/null.

less obvious ones are:

	allow init_t device_t:fifo_file { getattr read write };

to access /dev/initctl

now, this _could_ be due to a mistake that i made, because strictly
speaking, /dev/initctl should be in /dev as in a _real_ /dev on
a _real_ ext2 persistent filesystem.

stephen's explanation about setfiles not traversing mount points
including --rbind moved mountpoints _could_ explain why i was
having the above difficulties, namely that if /.dev was not being
relabelled, then /.dev/initctl would be as the default device_t
type, such that on an initial boot (prior to /dev getting --rbind
mount moved to /dev by /etc/init.d/udev) the filecontext was
incorrect.

but, like i said earlier, i believe that setfiles was _not_ doing
a proper job of ignoring --rbind mountpoints, and consequently
a make relabel or a setfiles / resulted in /.dev _deliberately_
being set to something it should not have been set to.

which reminds me to suggest that for this reason, it might be
necessary to add /.dev to the make relabel rule in setfiles.

oh, and of course to add in /.?u?dev [or a better regexp] to every
single line in the file contexts thing.

at this point i have to confess that i am getting a little confused
because there is so much that i have just ridden slip-shod over in
the past few weeks and approximately 100 reboots in order to 
get a working system: priority of time and running out of cash.

l.


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=udev

#!/bin/sh -e

PATH="/sbin:/bin"

UDEVSTART=/sbin/udevstart

# default maximum size of the /dev tmpfs
tmpfs_size="1M"

[ -x $UDEVSTART ] || exit 0

. /etc/udev/udev.conf

case "$(uname -r)" in
  2.[012345].*)
    echo "udev requires a 2.6.x kernel, not started."
    exit 0
    ;;
esac

if ! grep -q '[[:space:]]tmpfs$' /proc/filesystems; then
    echo "udev requires tmpfs support, not started."
    exit 0
fi

if [ ! -e /proc/sys/kernel/hotplug ]; then
    echo "udev requires hotplug support, not started."
    exit 0
fi

if [ "$udev_root" != "/dev/" ]; then
    echo "udev_root != /dev/, not started. Please check /etc/udev/udev.conf."
    exit 0
fi

##############################################################################

# we need to unmount /dev/pts/ and remount it later over the tmpfs
unmount_devpts() {
  if mountpoint -q /dev/pts/; then
    umount -l /dev/pts/
  fi

  if mountpoint -q /dev/shm/; then
    umount -l /dev/shm/
  fi
}

# mount a tmpfs over /dev, if somebody did not already do it
mount_tmpfs() {
  if grep -E -q "^[^[:space:]]+ /dev tmpfs" /proc/mounts; then
    return 0
  fi

  # /.dev is used by /sbin/MAKEDEV to access the real /dev directory.
  # if you don't like it just remove it.
  [ -d /.dev ] && mount --bind /dev /.dev

  echo -n "Mounting a tmpfs over /dev..."
  mount -n -o fscontext=system_u:object_r:device_t,size=$tmpfs_size,mode=0755 -t tmpfs none /dev
  echo "done."
}

# I hate this hack.  -- Md
make_extra_nodes () {
  grep '^[^#]' /etc/udev/links.conf | \
  while read type name arg1; do
    [ "$type" -a "$name" -a ! -e "/dev/$name" -a ! -L "/dev/$name" ] ||continue
    case "$type" in
    L)
      ln -s $arg1 /dev/$name
      ;;
    D)
      mkdir -p /dev/$name
      ;;
    M)
      mknod --mode=600 /dev/$name $arg1
      ;;
    *)
      echo "unparseable line ($type $name $arg1)"
      ;;
    esac
  done
}

# When modifying this script, do not forget that between the time that
# the new /dev has been mounted and udevstart has been run there will be
# no /dev/null. This also means that you cannot use the "&" shell command.

##############################################################################
case "$1" in
  start)
    unmount_devpts
    mount_tmpfs
    ACTION=add
    echo -n "Creating initial device nodes..."
    $UDEVSTART
    make_extra_nodes
    # all extra nodes created we must do the security contexts on them, oh dear.
    if [ -x /sbin/restoredevicefiles ]; then
      /sbin/restoredevicefiles
    fi

    echo "done."
    ;;
  remove)
    # I'm not sure this is useful
    ACTION=remove
    echo -n "Removing device nodes..."
    old_synthesize_events
    echo "done."
    ;;
  stop)
    start-stop-daemon --stop --exec /sbin/udevd --oknodo --quiet
    unmount_devpts
    echo -n "Unmounting /dev..."
    # unmounting with -l should never fail
    if umount -l /dev; then
      echo "done."
      umount -l /.dev || true
      /etc/init.d/mountvirtfs start
    else
      echo "failed."
    fi
    ;;
  restart|force-reload)
    echo -n "Recreating device nodes..."
    ACTION=add
    $UDEVSTART
    make_extra_nodes
    echo "done."
    ;;
  *)
    echo "Usage: /etc/init.d/udev {start|stop|restart|force-reload}"
    exit 1
    ;;
esac

exit 0

 

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=udev

diff -Naur 
--- default.1.14/domains/misc/horrible_hacks.te	1970-01-01 01:00:00.000000000 +0100
+++ current/domains/misc/horrible_hacks.te	2004-08-22 18:15:37.000000000 +0100
@@ -0,0 +1,201 @@
+# this is to deal with restorecon devices being associated with udev's
+# mounting of /dev as a fscontext=device_t.  help, help, gloop!
+
+# this is to allow /etc/init.d/udev to do its horrible hacks
+# if it wasn't done in /etc/init.d or it wasn't device_t under which
+# /dev was mounted (mount ... -o fscontext=....device_t) then this
+# would be different or not there:
+
+allow initrc_t device_t:dir { create setattr };
+	#EXE=/bin/mkdir  NAME=pts   :  create
+	#EXE=/bin/touch  NAME=/   :  setattr
+
+allow initrc_t device_t:lnk_file { create };
+	#EXE=/bin/ln  NAME=fd   :  create
+
+allow initrc_t device_t:blk_file { getattr };
+	#EXE=/bin/ls  PATH=/dev/ram0   :  getattr
+
+allow initrc_t device_t:chr_file { getattr read write };
+	#EXE=/bin/bash  NAME=tty   :  read write
+	#EXE=/bin/ls  PATH=/dev/ptmx   :  getattr
+
+# not sure about this one
+
+allow initrc_t fixed_disk_device_t:blk_file { getattr };
+	#EXE=/bin/bash  PATH=/dev/ram0   :  getattr
+
+
+allow init_t device_t:fifo_file { getattr read write };
+	#EXE=/sbin/init  PATH=/dev/initctl   :  getattr
+	#EXE=/sbin/init  NAME=initctl   :  read write
+
+allow hotplug_t device_t:file { ioctl read write };
+	#EXE=/bin/bash  NAME=null   :  read
+	#EXE=/bin/bash  NAME=null   :  write
+	#EXE=/bin/bash  PATH=/dev/null   :  ioctl
+
+allow initrc_t memory_device_t:chr_file { getattr };
+	#EXE=/bin/ls  PATH=/dev/port   :  getattr
+
+allow initrc_t random_device_t:chr_file { getattr };
+	#EXE=/bin/ls  PATH=/dev/random   :  getattr
+
+allow initrc_t romfs_t:dir { search };
+	#EXE=/bin/dash   :  search
+
+allow initrc_t usbfs_t:dir { getattr read search };
+	#EXE=/bin/dash   :  search
+	#EXE=/bin/dash  PATH=/proc/bus/usb   :  getattr
+	#EXE=/bin/ls   :  read
+
+allow udev_t device_t:file { getattr unlink };
+	#EXE=/sbin/udev  PATH=/dev/null   :  getattr
+	#EXE=/sbin/udev  NAME=null   :  unlink
+
+allow udev_t etc_runtime_t:file { relabelfrom relabelto };
+	#EXE=/bin/cp  NAME=ifstate.hotplug   :  relabelfrom
+	#EXE=/bin/cp  NAME=ifstate.hotplug   :  relabelto
+
+allow udev_t self:file { write };
+	#EXE=/sbin/udev  NAME=fscreate   :  write
+
+allow udev_t self:process { setfscreate };
+	#EXE=/sbin/udev   :  setfscreate
+
+
+allow initrc_t usbfs_t:file { getattr read };
+	#EXE=/bin/dash  PATH=/proc/bus/usb/devices   :  getattr
+	#EXE=/bin/grep  NAME=devices   :  read
+
+allow insmod_t hotplug_etc_t:dir { getattr search };
+	#EXE=/bin/dash  PATH=/etc/hotplug   :  getattr
+	#EXE=/bin/dash  NAME=hotplug   :  search
+
+allow device_t device_t:filesystem { associate };
+	#EXE=/bin/bash  NAME=null   :  associate
+	#EXE=/sbin/udev  NAME=snd   :  associate
+
+allow hotplug_t device_t:dir { add_name write };
+	#EXE=/bin/bash   :  write
+	#EXE=/bin/bash  NAME=null   :  add_name
+
+allow hotplug_t device_t:file { create };
+	#EXE=/bin/bash  NAME=null   :  create
+
+allow initctl_t device_t:filesystem { associate };
+	#EXE=/sbin/init  NAME=initctl   :  associate
+
+allow initrc_t root_t:dir { remove_name write };
+	#EXE=/bin/rm   :  write
+	#EXE=/bin/rm  NAME=fastboot   :  remove_name
+
+allow initrc_t root_t:file { unlink };
+	#EXE=/bin/rm  NAME=fastboot   :  unlink
+
+allow initrc_t usbfs_t:file { getattr read };
+	#EXE=/bin/dash  PATH=/proc/bus/usb/devices   :  getattr
+	#EXE=/bin/grep  NAME=devices   :  read
+
+allow initrc_t zero_device_t:chr_file { getattr };
+	#EXE=/bin/ls  PATH=/dev/zero   :  getattr
+
+
+
+
+
+allow udev_tbl_t device_t:filesystem { associate };
+	#EXE=/sbin/udev  NAME=.udev.tdb   :  associate
+
+
+
+
+
+allow mount_t tmpfs_t:filesystem { relabelfrom };
+	#EXE=/bin/mount   :  relabelfrom
+
+
+allow devlog_t device_t:filesystem { associate };
+	#EXE=/sbin/syslogd  NAME=log   :  associate
+
+allow sshd_t device_t:filesystem { getattr };
+	#EXE=/usr/sbin/sshd  NAME=/   :  getattr
+	#EXE=/usr/sbin/sshd  NAME=/   :  getattr
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
diff -Naur 
--- default.1.14/domains/program/init.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/init.te	2004-08-15 15:35:27.000000000 +0100
@@ -131,6 +131,9 @@
 allow init_t devtty_t:chr_file { read write };
 allow init_t ramfs_t:dir search;
 ')
+
 r_dir_file(init_t, sysfs_t)
+r_dir_file(init_t, tmpfs_t)
 
 r_dir_file(init_t, selinux_config_t)
+
diff -Naur 
--- default.1.14/domains/program/initrc.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/initrc.te	2004-08-22 18:09:23.000000000 +0100
@@ -312,3 +312,27 @@
 #
 allow initrc_t security_t:dir { getattr search };
 allow initrc_t security_t:file { getattr read };
+
+allow initrc_t device_t:filesystem { getattr };
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
diff -Naur 
--- default.1.14/domains/program/mount.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/mount.te	2004-08-21 19:12:19.000000000 +0100
@@ -16,7 +16,7 @@
 role sysadm_r types mount_t;
 role system_r types mount_t;
 
-allow mount_t { initrc_devpts_t console_device_t }:chr_file { read write };
+allow mount_t { initrc_devpts_t console_device_t tty_device_t }:chr_file { read write };
 
 domain_auto_trans(initrc_t, mount_exec_t, mount_t)
 allow mount_t init_t:fd use;
@@ -49,11 +49,12 @@
 allow mount_t usbdevfs_t:dir mounton;
 allow mount_t sysfs_t:dir { mounton };
 allow mount_t nfs_t:dir mounton;
+allow mount_t security_t:dir mounton;
 allow mount_t nfs_t:dir { search };
 # nfsv4 has a filesystem to mount for its userspace daemons
 allow mount_t var_lib_nfs_t:dir { mounton };
 
-# On some RedHat systems, /boot is a mount point
+# On some RedHat and Debian systems, /boot is a mount point
 allow mount_t boot_t:dir mounton;
 allow mount_t device_t:dir mounton;
 # mount binfmt_misc on /proc/sys/fs/binfmt_misc
diff -Naur 
--- default.1.14/domains/program/restorecon.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/restorecon.te	2004-08-06 15:54:12.000000000 +0100
@@ -59,3 +59,6 @@
 r_dir_file(restorecon_t, selinux_config_t)
 r_dir_file(restorecon_t, file_context_t)
 
+allow restorecon_t udev_tbl_t:file { read write };
+	#EXE=/sbin/restorecon  PATH=/dev/.udev.tdb   :  read write
+
diff -Naur 
--- default.1.14/domains/program/udev.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/udev.te	2004-08-06 19:20:29.000000000 +0100
@@ -18,6 +18,7 @@
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
 r_dir_file(udev_t, udev_helper_exec_t)
 can_exec(udev_t, udev_helper_exec_t)
+#domain_auto_trans(udev_t, udev_helper_exec_t, hotplug_t)
 
 #
 # Rules used for udev
@@ -33,6 +34,7 @@
 allow udev_t device_t:chr_file create_file_perms;
 allow udev_t device_t:sock_file create_file_perms;
 allow udev_t device_t:lnk_file create_file_perms;
+allow udev_t device_t:dir create_dir_perms;
 allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t bin_t:lnk_file read;
@@ -70,6 +72,8 @@
 
 ifdef(`hotplug.te', `
 r_dir_file(udev_t, hotplug_etc_t)
+domain_auto_trans(udev_t, hotplug_exec_t, hotplug_t)
+can_exec(udev_t, hotplug_exec_t)
 ')
 allow udev_t var_log_t:dir { search };
 
@@ -79,3 +83,15 @@
 domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
 
 dontaudit udev_t file_t:dir search;
+
+# hacked stuff...
+
+can_ps(udev_t, domain)
+
+# for /etc/dev.d/net/hotplug.dev
+
+allow udev_t etc_runtime_t:file { append lock write };
+can_exec(udev_t hotplug_etc_t)
+
+
+r_dir_file(udev_t, selinux_config_t)
diff -Naur 
--- default.1.14/file_contexts/program/udev.fc	2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/program/udev.fc	2004-08-06 15:18:35.000000000 +0100
@@ -4,5 +4,8 @@
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /etc/dev.d(/.*)? 	system_u:object_r:udev_helper_exec_t
 /etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
+/etc/udev/cdsymlinks.sh		system_u:object_r:udev_helper_exec_t
+/etc/udev/ide-devfs.sh		system_u:object_r:udev_helper_exec_t
+/etc/udev/scsi-devfs.sh		system_u:object_r:udev_helper_exec_t
 /dev/udev.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
diff -Naur 
--- default.1.14/macros/base_user_macros.te	2004-08-02 08:28:37.000000000 +0100
+++ current/macros/base_user_macros.te	2004-08-14 22:59:48.000000000 +0100
@@ -80,6 +80,16 @@
 allow $1_t privfd:fd use;
 allow $1_t $1_tty_device_t:chr_file { setattr rw_file_perms };
 
+
+
+
+# needed for udev-mounted (/dev) tmpfs
+allow $1_tty_device_t device_t:filesystem { associate };
+
+# to allow users to run df on udev-mounted (/dev) tmpfs
+allow $1_t device_t:filesystem { getattr };
+	#EXE=/bin/df  NAME=/   :  getattr
+
 # Use the type when relabeling terminal devices.
 type_change $1_t tty_device_t:chr_file $1_tty_device_t;
 
diff -Naur 
--- default.1.14/types/file.te	2004-08-02 08:28:37.000000000 +0100
+++ current/types/file.te	2004-08-09 19:52:49.000000000 +0100
@@ -259,12 +259,23 @@
 #
 allow { file_type device_type } fs_t:filesystem associate;
 
+#
+# Allow device types to be associated with a udev-mounted
+# file system where the -o mount option "fscontext=....device_t"
+# has been added.  if it was fscontext=...something_else_t
+# then it would be allow .... something_else_t:filesystem here:
+#
+allow { device_type } device_t:filesystem associate;
+
 # Allow the pty to be associated with the file system.
 allow devpts_t devpts_t:filesystem associate;
 
 type tmpfs_t, file_type, sysadmfile, fs_type, root_dir_type;
 allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
 
+
+
+
 type usbdevfs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
 allow usbdevfs_t usbdevfs_t:filesystem associate;
 

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
