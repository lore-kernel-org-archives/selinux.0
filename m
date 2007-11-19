Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJFUOfg010711
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 10:30:24 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAJFUMxK006199
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 15:30:23 GMT
Date: Mon, 19 Nov 2007 16:30:18 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] [martin@martinorr.name:  /selinux getattr messages]
Message-ID: <20071119153018.GA10703@bobek.pm.i.cz>
References: <20071116125923.GA25905@bobek.pm.i.cz> <1195482326.16660.19.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1195482326.16660.19.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 19, 2007 at 09:25:26AM -0500, Christopher J. PeBenito wrote:
> On Fri, 2007-11-16 at 13:59 +0100, Václav Ovsík wrote:
> > Hello,
> > I'm trying to stabilize refpolicy-20070928 on Debian Etch.
> > 
> > Repository with some updated selinux packages will be available soon.
> > I took packages from Sid and updated these with 20070928 upstream
> > releases.
> > 
> > I'm SELinux beginer, but my intention is to understand the SELinux
> > finally :) and run targeted and possibly strict policies in production
> > environment on Debian.
> > 
> > Currently I'm booting Xen DomU Debian Etch in permissive mode.
> > 
> > There are two audit messages, and I found solution (attached) in
> > selinux-devel@lists.alioth.debian.org.
> > 
> > audit(1195215260.590:3): avc:  denied  { getattr } for  pid=760
> > comm="mount" name="/" dev=selinuxfs ino=475
> > scontext=system_u:system_r:mo
> > unt_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > 
> > audit(1195215263.626:6): avc:  denied  { getattr } for  pid=1017
> > comm="swapon" name="/" dev=selinuxfs ino=475 scontext=system_u:system_r:
> > fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > 
> > 
> > So after insertion
> > 
> > selinux_get_fs_mount(fsadm_t)
> > -> ./policy/modules/system/fstools.te
> > 
> > selinux_get_fs_mount(mount_t)
> > -> ./policy/modules/system/mount.te
> > 
> > both messages dismiss.
> > 
> > Is such solution ok and acceptable upstream (conditionaly for
> > Debian distro or so)?
> 
> I have added a selinuxutil interface for libselinux-linked domains
> (seutil_libselinux_linked()).  That way its clear why the access is
> needed, and we can change it if the constructor changes.

Fine
Thanks

> The mount change could be for all, as I also see the libblkid linkage on
> my Gentoo system too.  However, I don't see it in Gentoo iptables
> (1.3.8).

I received messages from mount (mount.te) and fsck (fstools.te) wich are
run from init scripts...
I'm not running iptables from init scripts right now.

But

bobek:~# ldd /sbin/iptables
        linux-gate.so.1 =>  (0xb7f2f000)
        libdl.so.2 => /lib/tls/i686/cmov/libdl.so.2 (0xb7f0a000)
        libnsl.so.1 => /lib/tls/i686/cmov/libnsl.so.1 (0xb7ef4000)
        libselinux.so.1 => /lib/libselinux.so.1 (0xb7edb000)
        libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0xb7da7000)
        /lib/ld-linux.so.2 (0xb7f30000)

Running:

etch:/usr/src/selinux-policy-refpolicy-src# run_init iptables -L  
Authenticating root.
Password: 
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Triggers:

Nov 19 16:21:02 etch kernel: audit(1195485662.647:41): avc:  denied  { getattr } for  pid=2882 comm="iptables" name="/" dev=selinuxfs ino=475 scontext=user_u:system_r:iptables_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
Nov 19 16:21:02 etch kernel: ip_tables: (C) 2000-2006 Netfilter Core Team



Binaries with libblkid.so.1:

etch:/usr/src/selinux-policy-refpolicy-src# for x in /bin/* /sbin/*; do objdump -p $x 2>/dev/null|egrep -s 'NEEDED[[:space:]]+libblkid.so.1' >/dev/null&& ls -Z $x; done
-rwsr-xr-x  root root system_u:object_r:mount_exec_t:s0 /bin/mount
-rwsr-xr-x  root root system_u:object_r:mount_exec_t:s0 /bin/umount
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/blkid
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /sbin/debugfs
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/e2fsck
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/e2label
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/findfs
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/fsck
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/fsck.ext2
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/fsck.ext3
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/mke2fs
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/mkfs.ext2
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/mkfs.ext3
lrwxrwxrwx  root root system_u:object_r:bin_t:s0       /sbin/swapoff -> swapon
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/swapon
-rwxr-xr-x  root root system_u:object_r:fsadm_exec_t:s0 /sbin/tune2fs


Binaries with libselinux.so.1:

etch:/usr/src/selinux-policy-refpolicy-src# for x in /bin/* /sbin/*; do objdump -p $x 2>/dev/null|egrep -s 'NEEDED[[:space:]]+libselinux.so.1' >/dev/null&& ls -Z $x; done
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/cp
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/dir
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/ls
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/mkdir
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/mknod
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/mv
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /bin/vdir
-rwxr-xr-x  root root system_u:object_r:init_exec_t:s0 /sbin/init
-rwxr-xr-x  root root system_u:object_r:iptables_exec_t:s0 /sbin/ip6tables
-rwxr-xr-x  root root system_u:object_r:iptables_exec_t:s0 /sbin/ip6tables-restore
-rwxr-xr-x  root root system_u:object_r:iptables_exec_t:s0 /sbin/ip6tables-save
-rwxr-xr-x  root root system_u:object_r:iptables_exec_t:s0 /sbin/iptables
-rwxr-xr-x  root root system_u:object_r:iptables_exec_t:s0 /sbin/iptables-restore
-rwxr-xr-x  root root system_u:object_r:iptables_exec_t:s0 /sbin/iptables-save
lrwxrwxrwx  root root system_u:object_r:bin_t:s0       /sbin/restorecon -> setfiles
lrwxrwxrwx  root root system_u:object_r:bin_t:s0       /sbin/scsi_id -> /lib/udev/scsi_id
-rwxr-xr-x  root root system_u:object_r:setfiles_exec_t:s0 /sbin/setfiles
-rwxr-xr-x  root root system_u:object_r:sulogin_exec_t:s0 /sbin/sulogin
lrwxrwxrwx  root root system_u:object_r:bin_t:s0       /sbin/telinit -> init
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /sbin/udevcontrol
-rwxr-xr-x  root root system_u:object_r:udev_exec_t:s0 /sbin/udevd
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /sbin/udevsettle
-rwxr-xr-x  root root system_u:object_r:bin_t:s0       /sbin/udevtrigger
-r-sr-xr-x  root root system_u:object_r:chkpwd_exec_t:s0 /sbin/unix_chkpwd


> 
> 
> > email message attachment
> > > -------- Forwarded Message --------
> > > From: Martin Orr <martin@martinorr.name>
> > > To: selinux-devel@lists.alioth.debian.org
> > > Subject: [DSE-Dev] /selinux getattr messages
> > > Date: Sat, 23 Jun 2007 12:39:11 +0100
> > > 
> > > I am using the targeted policy in permissive mode.  During boot I
> > > get the
> > > following messages:
> > > audit(1182511335.252:36): avc:  denied  { getattr } for  pid=1249
> > > comm="mount" name="/" dev=selinuxfs ino=318
> > > scontext=system_u:system_r:mount_t:s0
> > > tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > > audit(1182511346.457:47): avc:  denied  { getattr } for  pid=1503
> > > comm="swapon" name="/" dev=selinuxfs ino=318
> > > scontext=system_u:system_r:fsadm_t:s0
> > > tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > > audit(1182511347.644:48): avc:  denied  { getattr } for  pid=1570
> > > comm="iptables" name="/" dev=selinuxfs ino=318
> > > scontext=system_u:system_r:iptables_t:s0
> > > tcontext=system_u:object_r:security_t:s0 tclass=filesystem
> > > 
> > > These come because libblkid and iptables are both linked against
> > > libselinux,
> > > which locates the selinux mount point in a constructor.  When this
> > > was
> > > introduced in libselinux, the selinux_get_fs_mount interface was
> > > added to
> > > the reference policy to allow this.  So mount.te should gain
> > > selinux_get_fs_mount(mount_t)
> > > and fstools.te should gain
> > > selinux_get_fs_mount(fsadm_t)
> > > 
> > > So far as I can see iptables has no need to be linked against
> > > libselinux,
> > > but I will check further.
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
> 

-- 
Zito


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
