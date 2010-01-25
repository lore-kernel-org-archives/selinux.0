Message-ID: <BAY111-W22EC1CF480A00C18111145AB5F0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_9916c639-9eed-432a-9d5a-5f6e59652dad_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <refpolicy@oss1.tresys.com>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 - 3:
 MAKEDEV ok but /var/lock/subsys/ broken
Date: Mon, 25 Jan 2010 09:32:51 +0000
In-Reply-To: <BAY111-W51276CC30B166887BBB33AB5F0@phx.gbl>
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>, ,
 ,,<4B53CEB9.3050207@gmail.com>,<BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>,
 ,
 ,,<4B543977.40007@gmail.com>,<BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>,
 , ,,<4B550EB9.50806@gmail.com>,<BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>,
 ,,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>,,<BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>,,<1264176847.22211.16.camel@moss-pluto.epoch.ncsc.mil>,<BAY111-W51276CC30B166887BBB33AB5F0@phx.gbl>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_9916c639-9eed-432a-9d5a-5f6e59652dad_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen and Justin,

I have got some new findings after I sent out the previous email. The weird error messages about /var/lock/subsys/ turns out to be hard disk inconsistency problem and could be fixed by fsck.ext2, after that, find and touch performed by rc.sysinit or /etc/rc3.d/* would have no problem at all :-)

However, my console still hangs at "INIT: Id "0" respawning too fast: disabled for 5 minutes", although so far I think I have fixed all those obvious problems with SELinux during boot up and I could no longer find fishy AVC denied message except something like:

type=1400 audit(1264435478.992:5): avc:  denied  { rawip_send } for  pid=5 comm="sirq-timer/0" saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3 daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5 scontext=system_u:system_r:kernel_t:s15:c0.c255 tcontext=system_u:object_r:netif_t:s0-s15:c0.c255 tclass=netif
type=1400 audit(1264435478.992:6): avc:  denied  { rawip_send } for  pid=5 comm="sirq-timer/0" saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3 daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5 scontext=system_u:system_r:kernel_t:s15:c0.c255 tcontext=system_u:object_r:node_t:s0-s15:c0.c255 tclass=node

But I don't think they could be the reason /sbin/init would fail to run /sbin/mingetty.

Then I came up with the idea to toggle SELinux state into Permissive mode in the rc.local and finally the console on longer hangs and I could login normally:



	
	
	
	





	
	
	
	

root@cp3020:/root>
cat /proc/cmdline 

root=/dev/sda1
rw console=ttyS0,115200n8 ip=dhcp selinux=1
BOOT_IMAGE=/vlm-boards/12885/qcao/kernel 

root@cp3020:/root>
getenforce 

Permissive

root@cp3020:/root>


root@cp3020:/root>
 cat /var/log/messages
...
Jan
25 16:59:15 cp3020 /etc/rc3.d/S95atd: atd startup - OK

Jan
25 16:59:15 cp3020 boot: Starting cracklibd

Jan
25 16:59:16 cp3020 boot: Starting local

Jan
25 16:59:16 cp3020 kernel: type=1404 audit(1264438756.016:4):
enforcing=0 ol

d_enforcing=1
auid=4294967295 ses=4294967295

...
root@cp3020:/root>





We can see selinux does boot up WITH enforcing=1 but toggled into enforcing=0 at rc.local, which proves that all my left problem focused on /sbin/mingetty
0:2345:respawn:/sbin/mingetty console  (in my /etc/inittab)

Maybe I need to identify the changes from refpolicy-2.20081210 to refpolicy-2.20091117 related with getty_t.

Best regards,
Harry




From: harrytaurus2002@hotmail.com
To: sds@tycho.nsa.gov
Date: Mon, 25 Jan 2010 06:04:16 +0000
CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
Subject: Re: [refpolicy] Bootup problem with refpolicy-2.20091117 - 3: MAKEDEV ok but /var/lock/subsys/ broken








Hi Stephen and Justin,

The OS I am using is very similar to RedHat and I have set DISTRO=redhat. I found this report last weekend: https://bugzilla.redhat.com/show_bug.cgi?id=425832, which confirmed that if the tmpfs mounted on /dev has not been properly labeled once mounted, MAKEDEV -x on /dev would generate following error message:
Start udev: MAKEDEV: mkdir: File exist

Well, this is exactly the same error message I got, and I'd confirmed in my previous email that after log in with enforcing=0, "ls -Z /dev" reveals that /dev has not been labeled, many nodes such as log/stderr etc are still labeled with tmpfs_t.

As suggested by another bug report of http://74.125.153.132/search?q=cache:hTh0mCacXPEJ:bugs.debian.org/564196+restoerecon+-R+/dev&cd=2&hl=en&ct=clnk&client=firefox-a, 
I added "/sbin/restorecon /dev" in /sbin/start_udev after this script mount tmpfs on /dev:

# mount the tmpfs on ${udev_root%/}, if not already done
LANG=C awk "\$2 == \"${udev_root%/}\" && \$3 == \"tmpfs\" { exit 1 }" /proc/moun
ts && {
        if LANG=C fgrep -q "none ${udev_root%/}/pts " /proc/mounts; then
                PTSDIR=$(mktemp -d)
                mount --move $udev_root/pts "$PTSDIR"
        fi
        if LANG=C fgrep -q "none ${udev_root%/}/shm " /proc/mounts; then
                SHMDIR=$(mktemp -d)
                mount --move $udev_root/shm "$SHMDIR"
        fi
        mount -n -o mode=0755 
 -t tmpfs none "$udev_root"
+        if [ -n "$selinuxfs" ]; then
+                /sbin/restorecon /dev > /dev/null 2>&1
+        fi
        mkdir -m 0755 $udev_root/pts
        mkdir -m 0755 $udev_root/shm
        if [ -n "$PTSDIR" ]; then
                mount --move "$PTSDIR" $udev_root/pts
                rmdir "$PTSDIR"
        fi
        if [ -n "$SHMDIR" ]; then
                mount --move 
 "$SHMDIR" $udev_root/shm
                rmdir "$SHMDIR"
        fi

        ret=$[$ret + $?]
}

Then the original MAKEDEV error message disappears, but threw up another error message:
Starting udev: MAKEDEV: error making /dev/loop0: Permission denied

The relevant AVC deneid message implies that initrc_t has no "create" privilege against the fixed_disk_device_t type, so I went on to call storage_tmpfs_filetrans_fixed_disk() interface against initrc_t for the Red Hat distribution:

@@ -477,6 +477,7 @@ ifdef(`distro_redhat',`
        storage_manage_fixed_disk(initrc_t)
        storage_dev_filetrans_fixed_disk(initrc_t)
        storage_getattr_removable_dev(initrc_t)
+  &nbs
 p;    storage_tmpfs_filetrans_fixed_disk(initrc_t)

        # readahead asks for these
        auth_dontaudit_read_shadow(initrc_t)

BTW, this interface has been called against the distro_debian, so I guess we may need to do it for Red Hat too. What would you think?

With the above two changes MAKEDEV could finally run uneventfully. However, I run into some other new error messages:

Start udev: [OK]
...
Enabling local filesystem quotas:  [  OK  ]
find: /var/lock/subsys/ipmi: Stale NFS file handle
find: /var/lock/subsys/portmap: Stale NFS file handle
find: /var/lock/subsys/netfs: Stale NFS file handle
find: /var/lock/subsys/ocfs2: Stale NFS file handle
find: /var/lock/subsys/sshd: Stale NFS file handle
...
find: /var/run/evlnotifyd.pid: Stale NFS file handle
find: /var/run/sm-client.pid: Stale NFS file handle
find: /v
 ar/run/sendmail.pid: Stale NFS file handle
find: /var/run/crond.pid: Stale NFS file handle
find: /var/run/evlactiond.pid: Stale NFS file handle
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
...
Starting portmap: [  OK  ]
touch: cannot touch `/var/lock/subsys/portmap': Stale NFS file handle
touch: cannot touch `/var/lock/subsys/netfs': Stale NFS file handle
Mounting other filesystems:  [  OK  ]
touch: cannot touch `/var/lock/subsys/ocfs2': Stale NFS file handle
touch: cannot touch `/var/lock/subsys/sshd': Stale NFS file handle
...
Starting sm-client: touch: cannot touch `/var/run/sm-client.pid': Stale NFS file handle
chown: cannot access `/var/run/sm-client.pid': Stale NFS file handle
/sbin/restorecon:  lstat(/var/run/sm-client.pid) failed:  Stale NFS file handle
[  OK  ]
touch: cannot touch `/var/lock/subsys/sm-client': Stale NFS file handle
tou
 ch: cannot touch `/var/lock/subsys/boa': Stale NFS file handle
...
Starting crond: [FAILED]
Starting notification action daemon: [  OK  ]
touch: cannot touch `/var/lock/subsys/evlaction': Stale NFS file handle
Starting atd: [FAILED]
touch: cannot touch `/var/lock/subsys/local': Stale NFS file handle
INIT: Id "0" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel
INIT: Id "0" respawning too fast: disabled for 5 minutes
(console hangs ...)


I am booting from local hard disk not NFS rootfs. These strange error messages are thrown by the find command in rc.sysinit when it is trying to clean up /var and /etc/rc3.d/* initscripts when they are trying to touch their lock files under /var/lock/subsys/.

Moreover, after log in with enforcing=0, "ls -Z /var/lock/subsys/" reveals that despite lock files created(in Permissive mode) under /var/lock/subsys/, their DAC attributes, uid/gid, SELinux
  security contexts have not been correctly created, and I am even unable to correct them by restorecon:

root@cp3020:/root> ls -Z /var/lock/subsys/
ls: cannot access /var/lock/subsys/ipmi: Stale NFS file handle
ls: cannot access /var/lock/subsys/portmap: Stale NFS file handle
ls: cannot access /var/lock/subsys/netfs: Stale NFS file handle
ls: cannot access /var/lock/subsys/ocfs2: Stale NFS file handle
ls: cannot access /var/lock/subsys/sshd: Stale NFS file handle
...
ls: cannot access /var/lock/subsys/local: Stale NFS file handle
-rw-r--r--  root root system_u:object_r:var_lock_t     atd
?---------  ?    ?                                     boa
?---------  ?    ?     &nb
 sp;                               crond
?---------  ?    ?                                     evlaction
?---------  ?    ?                                     evlnotify
-rw-------  root root system_u:object_r:var_lock_t     evlog
-rw-------  root root system_u:object_r:var_lock_t     evlogrmt
?---------  ?    ?       
 ;                              ipmi
?---------  ?    ?                                     iscsid
?---------  ?    ?                                     local
?---------  ?    ?                                     netfs
?---------&n
 bsp; ?    ?                                     ocfs2
?---------  ?    ?                                     portmap
?---------  ?    ?                                     sendmail
?---------  ?    ?                           &nbs
 p;         sm-client
?---------  ?    ?                                     sshd
-rw-------  root root system_u:object_r:var_lock_t     syslog-ng
?---------  ?    ?                                     xinetd
root@cp3020:/root> restorecon -R /var/lock/subsys/
restorecon get context on /var/lock/subsys/ipmi failed: 'Stale NFS file handle'
restorecon get context on /var/lock/subsys/portmap failed: 'Stale NFS file handle'
restorecon get context on /var/lock/subsys/netfs failed: 'Stale NFS file handl
 e'
restorecon get context on /var/lock/subsys/ocfs2 failed: 'Stale NFS file handle'
restorecon get context on /var/lock/subsys/sshd failed: 'Stale NFS file handle'
...
restorecon get context on /var/lock/subsys/local failed: 'Stale NFS file handle'
root@cp3020:/root> 

Any ideas why some lock files are broken while the rest is correct?

Thank you very much!

Best regards,
Harry
 		 	   		  
更多热辣资讯尽在新版MSN首页！ 立刻访问！ 		 	   		  
_________________________________________________________________
SkyDrive电子画册，带你领略精彩照片，分享“美”时“美”刻!
http://www.windowslive.cn/campaigns/e-magazine/ngmchina/?a=c
--_9916c639-9eed-432a-9d5a-5f6e59652dad_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
Hi Stephen and Justin,<br><br>I have got some new findings after I sent out the previous email. The weird error messages about /var/lock/subsys/ turns out to be hard disk inconsistency problem and could be fixed by fsck.ext2, after that, find and touch performed by rc.sysinit or /etc/rc3.d/* would have no problem at all :-)<br><br>However, my console still hangs at "INIT: Id "0" respawning too fast: disabled for 5 minutes", although so far I think I have fixed all those obvious problems with SELinux during boot up and I could no longer find fishy AVC denied message except something like:<br><br>type=1400 audit(1264435478.992:5): avc:&nbsp; denied&nbsp; { rawip_send } for&nbsp; pid=5 comm="sirq-timer/0" saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3 daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5 scontext=system_u:system_r:kernel_t:s15:c0.c255 tcontext=system_u:object_r:netif_t:s0-s15:c0.c255 tclass=netif<br>type=1400 audit(1264435478.992:6): avc:&nbsp; denied&nbsp; {!
  rawip_send } for&nbsp; pid=5 comm="sirq-timer/0" saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3 daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5 scontext=system_u:system_r:kernel_t:s15:c0.c255 tcontext=system_u:object_r:node_t:s0-s15:c0.c255 tclass=node<br><br>But I don't think they could be the reason /sbin/init would fail to run /sbin/mingetty.<br><br>Then I came up with the idea to toggle SELinux state into Permissive mode in the rc.local and finally the console on longer hangs and I could login normally:<br>


	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8">
	<title></title>
	<meta name="GENERATOR" content="OpenOffice.org 2.4  (Linux)">
	<style type="text/css">
	<!--
		@page { size: 21cm 29.7cm; margin: 2cm }
		P { margin-bottom: 0.21cm }
	-->
	</style>

<p style="margin-bottom: 0cm;" align="left"><font style="" color="#000000"><font style="" face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2"><br></font></font></font></p><p style="margin-bottom: 0cm;" align="left">


	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8">
	<title></title>
	<meta name="GENERATOR" content="OpenOffice.org 2.4  (Linux)">
	<style type="text/css">
	<!--
		@page { size: 21cm 29.7cm; margin: 2cm }
		P { margin-bottom: 0.21cm }
	-->
	</style>

<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">root@cp3020:/root&gt;
cat /proc/cmdline 
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">root=/dev/sda1
rw console=ttyS0,115200n8 ip=dhcp selinux=1
BOOT_IMAGE=/vlm-boards/12885/qcao/kernel 
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">root@cp3020:/root&gt;
getenforce 
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">Permissive
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">root@cp3020:/root&gt;
</font></font></font>
</p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">root@cp3020:/root&gt;
 cat /var/log/messages</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">...</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">Jan
25 16:59:15 cp3020 /etc/rc3.d/S95atd: atd startup - OK
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">Jan
25 16:59:15 cp3020 boot: Starting cracklibd
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">Jan
25 16:59:16 cp3020 boot: Starting local
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">Jan
25 16:59:16 cp3020 kernel: type=1404 audit(1264438756.016:4):
enforcing=0 ol
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">d_enforcing=1
auid=4294967295 ses=4294967295
</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">...</font></font></font></p>
<p style="margin-bottom: 0cm;" align="left"><font color="#000000"><font face="文鼎PL细上海宋Uni"><font style="font-size: 10pt;" size="2">root@cp3020:/root&gt;
</font></font></font>
</p>

</p>
<br>We can see selinux does boot up WITH enforcing=1 but toggled into enforcing=0 at rc.local, which proves that all my left problem focused on /sbin/mingetty<br>0:2345:respawn:/sbin/mingetty console&nbsp; (in my /etc/inittab)<br><br>Maybe I need to identify the changes from refpolicy-2.20081210 to refpolicy-2.20091117 related with getty_t.<br><br>Best regards,<br>Harry<br><br><br><br><br><hr id="stopSpelling">From: harrytaurus2002@hotmail.com<br>To: sds@tycho.nsa.gov<br>Date: Mon, 25 Jan 2010 06:04:16 +0000<br>CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov<br>Subject: Re: [refpolicy] Bootup problem with refpolicy-2.20091117 - 3: MAKEDEV ok but /var/lock/subsys/ broken<br><br>



<style>
.ExternalClass .ecxhmmessage P
{padding:0px;}
.ExternalClass body.ecxhmmessage
{font-size:10pt;font-family:Verdana;}
</style>


Hi Stephen and Justin,<br><br>The OS I am using is very similar to RedHat and I have set DISTRO=redhat. I found this report last weekend: https://bugzilla.redhat.com/show_bug.cgi?id=425832, which confirmed that if the tmpfs mounted on /dev has not been properly labeled once mounted, MAKEDEV -x on /dev would generate following error message:<br>Start udev: MAKEDEV: mkdir: File exist<br><br>Well, this is exactly the same error message I got, and I'd confirmed in my previous email that after log in with enforcing=0, "ls -Z /dev" reveals that /dev has not been labeled, many nodes such as log/stderr etc are still labeled with tmpfs_t.<br><br>As suggested by another bug report of http://74.125.153.132/search?q=cache:hTh0mCacXPEJ:bugs.debian.org/564196+restoerecon+-R+/dev&amp;cd=2&amp;hl=en&amp;ct=clnk&amp;client=firefox-a, <br>I added "/sbin/restorecon /dev" in /sbin/start_udev after this script mount tmpfs on /dev:<br><br># mount the tmpfs on ${udev_root%/}, if not already done<b!
 r>LANG=C awk "\$2 == \"${udev_root%/}\" &amp;&amp; \$3 == \"tmpfs\" { exit 1 }" /proc/moun<br>ts &amp;&amp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if LANG=C fgrep -q "none ${udev_root%/}/pts " /proc/mounts; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PTSDIR=$(mktemp -d)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount --move $udev_root/pts "$PTSDIR"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if LANG=C fgrep -q "none ${udev_root%/}/shm " /proc/mounts; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SHMDIR=$(mktemp -d)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount --move $udev_root/shm "$SHMDIR"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount -n -o mode=075!
 5 
 -t tmpfs none "$udev_root"<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -n "$selinuxfs" ]; then<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/restorecon /dev &gt; /dev/null 2&gt;&amp;1<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -m 0755 $udev_root/pts<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -m 0755 $udev_root/shm<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -n "$PTSDIR" ]; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount --move "$PTSDIR" $udev_root/pts<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmdir "$PTSDIR"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -n "$SHMDIR" ]; then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount --move 
 "$SHMDIR" $udev_root/shm<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmdir "$SHMDIR"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=$[$ret + $?]<br>}<br><br>Then the original MAKEDEV error message disappears, but threw up another error message:<br>Starting udev: MAKEDEV: error making /dev/loop0: Permission denied<br><br>The relevant AVC deneid message implies that initrc_t has no "create" privilege against the fixed_disk_device_t type, so I went on to call storage_tmpfs_filetrans_fixed_disk() interface against initrc_t for the Red Hat distribution:<br><br>@@ -477,6 +477,7 @@ ifdef(`distro_redhat',`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; storage_manage_fixed_disk(initrc_t)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; storage_dev_filetrans_fixed_disk(initrc_t)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; storage_getattr_removable_dev(initrc_t)<br>+&nbsp;&nbsp;&am!
 p;nbs
 p;&nbsp;&nbsp;&nbsp; storage_tmpfs_filetrans_fixed_disk(initrc_t)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # readahead asks for these<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_dontaudit_read_shadow(initrc_t)<br><br>BTW, this interface has been called against the distro_debian, so I guess we may need to do it for Red Hat too. What would you think?<br><br>With the above two changes MAKEDEV could finally run uneventfully. However, I run into some other new error messages:<br><br>Start udev: [OK]<br>...<br>Enabling local filesystem quotas:&nbsp; [&nbsp; OK&nbsp; ]<br>find: /var/lock/subsys/ipmi: Stale NFS file handle<br>find: /var/lock/subsys/portmap: Stale NFS file handle<br>find: /var/lock/subsys/netfs: Stale NFS file handle<br>find: /var/lock/subsys/ocfs2: Stale NFS file handle<br>find: /var/lock/subsys/sshd: Stale NFS file handle<br>...<br>find: /var/run/evlnotifyd.pid: Stale NFS file handle<br>find: /var/run/sm-client.pid: Stale NFS file handle<br>find: /v
 ar/run/sendmail.pid: Stale NFS file handle<br>find: /var/run/crond.pid: Stale NFS file handle<br>find: /var/run/evlactiond.pid: Stale NFS file handle<br>Enabling /etc/fstab swaps:&nbsp; [&nbsp; OK&nbsp; ]<br>INIT: Entering runlevel: 3<br>...<br>Starting portmap: [&nbsp; OK&nbsp; ]<br>touch: cannot touch `/var/lock/subsys/portmap': Stale NFS file handle<br>touch: cannot touch `/var/lock/subsys/netfs': Stale NFS file handle<br>Mounting other filesystems:&nbsp; [&nbsp; OK&nbsp; ]<br>touch: cannot touch `/var/lock/subsys/ocfs2': Stale NFS file handle<br>touch: cannot touch `/var/lock/subsys/sshd': Stale NFS file handle<br>...<br>Starting sm-client: touch: cannot touch `/var/run/sm-client.pid': Stale NFS file handle<br>chown: cannot access `/var/run/sm-client.pid': Stale NFS file handle<br>/sbin/restorecon:&nbsp; lstat(/var/run/sm-client.pid) failed:&nbsp; Stale NFS file handle<br>[&nbsp; OK&nbsp; ]<br>touch: cannot touch `/var/lock/subsys/sm-client': Stale NFS file handle<br>tou
 ch: cannot touch `/var/lock/subsys/boa': Stale NFS file handle<br>...<br>Starting crond: [FAILED]<br>Starting notification action daemon: [&nbsp; OK&nbsp; ]<br>touch: cannot touch `/var/lock/subsys/evlaction': Stale NFS file handle<br>Starting atd: [FAILED]<br>touch: cannot touch `/var/lock/subsys/local': Stale NFS file handle<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>INIT: no more processes left in this runlevel<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>(console hangs ...)<br><br><br>I am booting from local hard disk not NFS rootfs. These strange error messages are thrown by the find command in rc.sysinit when it is trying to clean up /var and /etc/rc3.d/* initscripts when they are trying to touch their lock files under /var/lock/subsys/.<br><br>Moreover, after log in with enforcing=0, "ls -Z /var/lock/subsys/" reveals that despite lock files created(in Permissive mode) under /var/lock/subsys/, their DAC attributes, uid/gid, SELinux
  security contexts have not been correctly created, and I am even unable to correct them by restorecon:<br><br>root@cp3020:/root&gt; ls -Z /var/lock/subsys/<br>ls: cannot access /var/lock/subsys/ipmi: Stale NFS file handle<br>ls: cannot access /var/lock/subsys/portmap: Stale NFS file handle<br>ls: cannot access /var/lock/subsys/netfs: Stale NFS file handle<br>ls: cannot access /var/lock/subsys/ocfs2: Stale NFS file handle<br>ls: cannot access /var/lock/subsys/sshd: Stale NFS file handle<br>...<br>ls: cannot access /var/lock/subsys/local: Stale NFS file handle<br>-rw-r--r--&nbsp; root root system_u:object_r:var_lock_t&nbsp;&nbsp;&nbsp;&nbsp; atd<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boa<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&a!
 mp;nb
 sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crond<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evlaction<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evlnotify<br>-rw-------&nbsp; root root system_u:object_r:var_lock_t&nbsp;&nbsp;&nbsp;&nbsp; evlog<br>-rw-------&nbsp; root root system_u:object_r:var_lock_t&nbsp;&nbsp;&nbsp;&nbsp; evlogrmt<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs!
 p;
 ;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipmi<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscsid<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; netfs<br>?---------&!
 amp;n
 bsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ocfs2<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; portmap<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmail<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&am!
 p;nbs
 p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sm-client<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sshd<br>-rw-------&nbsp; root root system_u:object_r:var_lock_t&nbsp;&nbsp;&nbsp;&nbsp; syslog-ng<br>?---------&nbsp; ?&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xinetd<br>root@cp3020:/root&gt; restorecon -R /var/lock/subsys/<br>restorecon get context on /var/lock/subsys/ipmi failed: 'Stale NFS file handle'<br>restorecon get context on /var/lock/subsys/portmap failed: 'Stale NFS file handle'<br>restorecon get context on /var/lock/subsys/netfs failed: 'Stale NFS file handl
 e'<br>restorecon get context on /var/lock/subsys/ocfs2 failed: 'Stale NFS file handle'<br>restorecon get context on /var/lock/subsys/sshd failed: 'Stale NFS file handle'<br>...<br>restorecon get context on /var/lock/subsys/local failed: 'Stale NFS file handle'<br>root@cp3020:/root&gt; <br><br>Any ideas why some lock files are broken while the rest is correct?<br><br>Thank you very much!<br><br>Best regards,<br>Harry<br> 		 	   		  <br><hr>更多热辣资讯尽在新版MSN首页！ <a href="http://cn.msn.com/">立刻访问！</a> 		 	   		  <br /><hr />聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! <a href='http://3g.msn.cn/' target='_new'>立刻下载！</a></body>
</html>
--_9916c639-9eed-432a-9d5a-5f6e59652dad_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
