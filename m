Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAPKNcIi027164
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 15:23:38 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAPKNe4B028675
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 20:23:41 GMT
Date: Thu, 25 Nov 2004 20:34:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux List <SELinux@tycho.nsa.gov>, 270919@bugs.debian.org
Subject: Re: policy patch
Message-ID: <20041125203421.GC26737@lkcl.net>
References: <200411260027.41899.russell@coker.com.au> <20041125163232.GA26737@lkcl.net> <200411260605.12580.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <200411260605.12580.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 26, 2004 at 06:05:09AM +1100, Russell Coker wrote:
> On Friday 26 November 2004 03:32, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
> wrote:
> > On Fri, Nov 26, 2004 at 12:27:39AM +1100, Russell Coker wrote:
> > > The attached patch makes some trivial policy changes.
> > >
> > > Allows Debian systems to touch /etc from an init script.
> >
> >  i fixed the /etc/init.d script which does the /etc touching,
> >  sent a patch to the maintainer of initscripts.
> 
> Great!  Now when will that patch go into Debian/main?
 
 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=270919

 except duh it looks like i missed the attachment.

 

> >  afaik, this is the only reason for allowing debian init
> >  scripts to write to /etc and it's not a very good one!
> 
> I agree.  But until the script gets fixed I think I have to do this to stop 
> systems failing to correctly boot.
 
 well um i have been installing initscripts se2 version off of
 http://selinux.lemuria.org/newselinux/  .debs and then updating that.

 do i need to do that?  [use the initscripts .deb off lemuria.org]

 l.


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mountvirtfs

#! /bin/sh
#
# mountvirtfs	Mount all the virtual filesystems the kernel
#		provides and that are required by default.
#
#		This script can be called several times without
#		damage; it tries to mount the virtual filesystems
#		only if not mounted yet, and only updates /etc/mtab
#		if it is writable and there is a need to.
#
#		This functionality was previously provided by
#		mountkernfs from the glibc package.

#		lkcl: 2004sep09 - 
#
# Version:	@(#)mountvirtfs  2.85-21  18-Jun-2004  miquels
#

# Script needs to be robust and continue when parts fail,
# so we're not setting the "-e" flag.
#set -e

PATH=/lib/init:/bin:/sbin

TTYGRP=5
TTYMODE=620
if [ -f /etc/default/devpts ]
then
	. /etc/default/devpts
fi

TMPFS_SIZE=
if [ -f /etc/default/tmpfs ]
then
	. /etc/default/tmpfs
fi

KERNEL=`uname -s`
umask 022

dir_writable () {
	if [ -d "$1/" ] && [ -w "$1/" ] && touch -a "$1/" 2>/dev/null
	then
		return 0
	fi
	return 1
}

domount () {

	# Directory present ?
	if [ ! -d $3 ]
	then
		return
	fi

	# Do we support this filesystem type ?
	TYPE=
	if [ $1 = proc ]
	then
		case "$KERNEL" in
			Linux|GNU)
				TYPE=proc
				;;
			*)
				TYPE=procfs
				;;
		esac
	elif egrep -qs "$1\$" /proc/filesystems
	then
		TYPE=$1
	elif egrep -qs "$2\$" /proc/filesystems
	then
		TYPE=$2
	fi
	if [ "$TYPE" = "" ]
	then
		return
	fi

	#
	#	Get the options from /etc/fstab.
	#
	OPTS=
	if [ -f /etc/fstab ]
	then
		exec 9<&0 0</etc/fstab
		while read FDEV FDIR FTYPE FOPTS REST
		do
			case "$FDEV" in
				""|\#*)
					continue
					;;
			esac
			if [ "$3" != "$FDIR" ] || [ "$TYPE" != "$FTYPE" ]
			then
				continue
			fi
			case "$FOPTS" in
				noauto|*,noauto|noauto,*|*,noauto,*)
					return
					;;
				?*)
					OPTS="-o$FOPTS"
					;;
			esac
			break
		done
		exec 0<&9 9<&-
	fi

	# See if anything is mounted yet
	if ! mountpoint -q $3
	then
		# No, do it now
		mount $MOUNT_N -t $TYPE $OPTS $4 $TYPE $3
	else
		# Need to update mtab only ?
		if [ -n "$DO_MTAB" ] &&
		   ! egrep -sq "^([^ ]+) +$3 +" /etc/mtab
		then
				mount -f -t $TYPE $OPTS $4 $TYPE $3
		fi
	fi
}


#
#	If /etc/mtab is a symlink into /proc/
#	then we assume it is not writable.
#
DO_MTAB=
MOUNT_N=-n
MTAB_PATH="`readlink -f /etc/mtab || :`"
case "$MTAB_PATH" in
	/proc/*)
		;;
	/*)
			DO_MTAB=Yes
			MOUNT_N=
		;;
esac

# really important on selinux to restore file context of /etc/mtab
# otherwise mount and other programs will fail.
if [ -n "$DO_MTAB" ] && [ ! -f /etc/mtab ]
then
	:> /etc/mtab
	if [ -x /sbin/restorecon ]; then /sbin/restorecon /etc/mtab; fi
fi

# Mount standard /proc and /sys.
domount proc "" /proc
domount sysfs "" /sys

# Mount /dev/pts. Create master ptmx node if needed.
#
# As of 2.5.68, devpts is not automounted when using devfs. So we
# mount devpts if it is compiled in (older devfs didn't require it
# to be compiled in at all).
#
if [ "$KERNEL" = Linux ]
then
	#
	#	Since kernel 2.5.something, devfs doesn't include
	#	a standard /dev/pts directory anymore. So if devfs
	#	is mounted on /dev we need to create that directory
	#	manually.
	#
	if grep -qs '/dev devfs' /proc/mounts
	then
		if [ ! -d /dev/pts ]
		then
			mkdir /dev/pts
		fi
	fi
	if [ -d /dev/pts ]
	then
		if dir_writable /dev && [ ! -c /dev/ptmx ]
		then
			mknod --mode=666 /dev/ptmx c 5 2
		fi
		umount -l -f devpts
		domount devpts "" /dev/pts -ofscontext=system_u:object_r:devpts_t,gid=$TTYGRP,mode=$TTYMODE
	fi
fi

# Mount tmpfs.
#
# Around kernel version 2.3.3x, a memory based filesystem was
# introduced to support POSIX shared memory, called shmfs. 
# Later this filesystem was extended for general usage -
# provided you set the CONFIG_TMPFS compile option and mount
# it as type tmpfs.
#
# Early in the 2.4 kernel series, shmfs was renamed to tmpfs, but
# you could mount it using both type shmfs and tmpfs. Starting
# at kernel version 2.5.44, the shmfs alias was dropped.
#
# Confusingly, in kernels 2.3.x - 2.5.43 where both shmfs and
# tmpfs are present, disabling CONFIG_TMPFS actually removes
# support for shmfs, but tmpfs is still listed in /proc/filesystems
# to support SYSV and POSIX shared memory, and it should still be
# mounted under /dev/shm.
#
# Recommendation: always enable CONFIG_TMPFS and always mount
# using the tmpfs type. Forget about shmfs.
# 
# Tmpfs can be used as memory filesystem, so you can limit tmpfs
# max size using /etc/default/tmpfs to prevent tmpfs from using
# up all system memory.
#
if [ -n "$TMPFS_SIZE" ]
then
	tmpfs_opt="-osize=${TMPFS_SIZE}"
fi
domount tmpfs shmfs /dev/shm $tmpfs_opt

# Mount usbfs/usbdevfs if /proc/bus/usb is present.
#
# Usbfs/usbdevfs is used for USB related binaries/libraries.
# "usbfs" and "usbdevfs" are the exact same filesystem.
# "usbdevfs" was renamed to "usbfs" by linux usb developers,
# because people sometimes mistook it as a part of devfs. Usbfs
# will be superseded by other filesystems (e.g. sysfs), and when
# it becomes obsolete the mount action below should be removed.
#
if [ -d /proc/bus/usb ]
then
	domount usbfs usbdevfs /proc/bus/usb
fi


--C7zPtVaVf+AK4Oqc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
