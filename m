Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7FEn6rT002895
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 10:49:06 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7FEn47E022799
	for <selinux@tycho.nsa.gov>; Sun, 15 Aug 2004 14:49:04 GMT
Date: Sun, 15 Aug 2004 15:59:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: udev (0.030) doesn't remount devpts
Message-ID: <20040815145900.GJ11256@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

anyone wishing to use udev 0.030 with selinux may come across this
problem, which is reported to have been resolved (under debian
bugreport 258214)

if you are running with enforcing=1, devpts either does not get
unmounted (by /etc/init.d/udev) or somehow does not get remounted.

what is clear is that your system will end up in a partially unusable
state unless you add /etc/init.d/mountvirtfs start to /etc/init.d/udev's
"start" case, just like there is in the "stop" case of /etc/init.d/udev.

to make absolutely certain that the problem went away i also
modified /etc/init.d/mountvirtfs to force a "umount -lf devpts"
just before the mount devpts ...
which may or may not be the correct thing to do.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--tsOsTdHNUZQcU9Ye
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

#if [ "$udev_root" != "/dev/" ]; then
#    echo "udev_root != /dev/, not started. Please check /etc/udev/udev.conf."
#    exit 0
#fi

##############################################################################

# we need to unmount /dev/pts/ and remount it later over the tmpfs
unmount_devpts() {
  if mountpoint -q /dev/pts/; then
    umount -l -f /dev/pts/
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
  #mount -n -o size=$tmpfs_size,mode=0755 -t tmpfs none /dev
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

    /etc/init.d/mountvirtfs start

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

 

--tsOsTdHNUZQcU9Ye--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
