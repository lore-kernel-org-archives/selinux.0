Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA12936
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 16:44:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0JLiTI14990
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 21:44:29 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
        by jazzband.ncsc.mil  with ESMTP id h0JLiSf14986 for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 21:44:28 GMT
Date: Sun, 19 Jan 2003 16:44:12 -0500
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Cc: lunar@lunar-linux.org
Subject: Selinux on the "Lunar" linux distribution.
Message-Id: <20030119164412.4c7c8ad5.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Summary:

Lunar linux (http://lunar-linux.org) is a source-based distribution which
uses a set of bash scripts to provide package management and build recipes
for various server and client applications. Lunar provides sysV init and
FHS layout and strives for LSB compliance.

SELinux (http://www.nsa.gov/selinux) is a system impementing NSA's FLASK 
model, providing domain and type enforcement and tools for MAC/MLS policy 
development/implementation within the LSM (http://lsm.immunix.org) framework.


I have been running the SELinux kernel in the lunar distribution as a vmware
guest OS for a considerable time. Here are some notes on how to build and
run this kernel on the lunar distribution.

Config:

Lunar installed off of the 1.1.2 cd image. I expect this will work on later 
test images, probably with a couple fewer foibles. The latest work has been done 
runing gcc 3.2.1 and glibc 2.3.1. I'm not running/installing the current lunar
kernel 2.4.20.

SELinux, kernel 2.4.19  version LSM patch and selinux sources. I don't have
a particular need for the .20 kernel, however I think the .20 version of the 
sources will work find (and might not need some of the customizations below).

Generally, I think it's a good practice here to have as complete a setup as 
possible prior to installing the hardened kernel. This is particularly true
of security-related applications or libraries as installation after starting
the SELinux will not install with the correct SID/file contexts, requireing
'make relabel' which may in turn wipe out any changes made by hand to the
setup.

Run 'lunar update' allowing everyting to rebuild *except linux*.

Prior to installing SELinux I installed all of the following (lin(1))

Linux-PAM
krb5
slang (which will force a gcc-rebuild)
tcp_wrappers
sysklogd 

Customizatons:

Set Lunar integrity checking to 'find' and 'ldd' checks only, removing 
md5 checks.

Removed the devfs/devfsd from the configuration. I have not had good luck
getting the selinux policies to work on Lunar with devfsd enabled.

*Remember* to edit /etc/fstab and /etc/lilo.conf to reflect /dev/hda|/dev/sda
naming in place of the devfs names.

Rather than running 'lrm devfsd' I chose to move the configuration files:

/etc/devfsd.conf
/etc/modules.devfs

to backup locations.

Reboot, run 'lin makedev' to fully populate the /dev directory structure.

Required to build the selinux-provided openssh:

in /usr/lib:
ln -s libbsd-compat.a libbsd.a


I would strongly suggest rebuilding glibc *after* building gcc. and before
building/installing SELinux. I had a few things fail due to *not* doing this
which were cleared up by using the current build.


Apply ncurses patches, required to build 'more' in util-linux:

utils_makefile_uselargefile.diff, utils_libncurses.diff see the 
SELinux mailing list archive.

>From this point run 'make quickinstall' in /usr/src/selinux.

Caveats:

set GCCWRAPPERS=off in /etc/lunar/local/config. The GCC wrapper
files have the wrong SID and will generate an avc: denied error
in enforcing mode.

Consider linking ln -s /lib/libncurses.so.5.3 /usr/lib/libncurses.so
The non-standard location used by Lunar causes build failures for
some software.

Lunar, particularly 'lunar update' or 'lunar rebuild' may force update of
modules not in use (e.g. the lunar-customized linux kernel) and may force 
update of components, even components that are 'held'.

I'm making no attempt to build this as an integrated or supported part of
the lunar distribution. SELinux-custom utilities are installed in 
/usr/local/selinux/.


I'm presently running all of the following services:

sshd            0:off   1:off   2:off   3:on    4:on    5:on    6:off
ntp             0:off   1:off   2:off   3:on    4:on    5:on    6:off
klogd           0:off   1:off   2:on    3:on    4:off   5:off   6:off
syslogd         0:off   1:off   2:on    3:on    4:off   5:off   6:off
httpd           0:off   1:off   2:off   3:on    4:on    5:on    6:off
mysqld          0:off   1:off   2:on    3:on    4:on    5:on    6:off
avc             0:off   1:off   2:off   3:on    4:on    5:on    6:off  /* switch to enforcing mode */
afs             0:off   1:off   2:off   3:on    4:on    5:on    6:off  /* afsd client */


New policy changes installed, I needed fewer changes ot enable basic function 
than under Slackware, more than on redhat 7.1:

/etc/security/selinux/src/policy/domains/program/

==> ssh.te <==

# 
# iterative edits
#

allow sshd_t device_t:chr_file { getattr ioctl read write };
allow sshd_t sysadm_tty_device_t:chr_file { getattr ioctl read relabelfrom relabelto setattr write };
allow sshd_t tmpfs_t:file { lock read write };
allow sshd_t tty_device_t:chr_file { getattr ioctl read relabelfrom setattr write };
allow sshd_t user_tty_device_t:chr_file { getattr ioctl read relabelfrom relabelto setattr write };

==> ntpd.te <==

#
# iterative edits
#

allow initrc_t tmpfs_t:file { write };
allow ntpd_t tmpfs_t:dir { search };


==> klogd.te <==

#
# iterative edits
#

allow klogd_t file_t:file { getattr read };
allow klogd_t sysadm_tty_device_t:chr_file { read write };
allow klogd_t tmpfs_t:file { getattr lock read unlink write };


==> syslogd.te <==


#
# iterative edits
#

allow syslogd_t sysadm_tty_device_t:chr_file { read write };
allow syslogd_t tmpfs_t:file { create getattr lock unlink write };


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
