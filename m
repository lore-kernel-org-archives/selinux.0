Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0I936di026186
	for <selinux@tycho.nsa.gov>; Mon, 18 Jan 2010 04:03:06 -0500
Received: from bay0-omc1-s11.bay0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0I95n0W017732
	for <selinux@tycho.nsa.gov>; Mon, 18 Jan 2010 09:05:49 GMT
Message-ID: <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_0154b121-d2ac-4c34-9674-e98ae1446475_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: <justinmattock@gmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: Bootup problem with refpolicy-2.20091117
Date: Mon, 18 Jan 2010 09:03:04 +0000
In-Reply-To: <4B53CEB9.3050207@gmail.com>
References: 
 <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>,<4B53CEB9.3050207@gmail.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_0154b121-d2ac-4c34-9674-e98ae1446475_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit




> Date: Sun, 17 Jan 2010 19:00:09 -0800
> From: justinmattock@gmail.com
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Subject: Re: Bootup problem with refpolicy-2.20091117
> 
> On 01/17/10 18:40, TaurusHarry wrote:
> > Hi SELinux experts,
> > 
> > This is my very first time to try out the latest refpolicy-2.20091117 
> > and I am unable to boot SELinux up normally, in the very end the console 
> > will hang with messages like:
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > INIT: no more processes left in this runlevel
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > 
> > Aside from this, there are some strange error messages like "Starting 
> > udev: MAKEDEV: mkdir: File exists" and some AVC denied messages 
> > (detailed log is appended at the last).
> > 
> > However, I could boot up SELinux with refpolicy-2.20081210 successfully, 
> > what I do is to first boot Linux kernel into a shell and load SELinux 
> > policy image then label the whole filesystem, second boot into 
> > /sbin/init as normal. The SELinux userspace tools I am using are:
> > libsepol-2.0.36
> > libselinux-2.0.79
> > libsemanage-2.0.31
> > policycoreutils-2.0.62
> > checkpolicy-2.0.19
> > sepolgen-1.0.16
> > 
> > The kernel I am using is! 2.6.27, Stephen kindly pointed out a SELinux 
> > kernel bug six months ago when I had a problem to boot up 
> > refpolicy-2.20081210, which should be fixed by the commit of "SELinux: 
> > check open perms in dentry_open not inode_permission", or bypassed by 
> > diabling the open_perms in policy_capabilities.
> > 
> > The same set of kernel and rootfs work well for refpolicy-2.20081210 but 
> > do not for refpolicy-2.20091117, I wonder what changes could make a 
> > difference? What should I have done in order to use the latest 
> > refpolicy-2.20091117? Any extra SELinux kernel commits I should port 
> > back to 2.6.27, or do I need to update SELinux userspace tools to the 
> > latest as well?
> > 
> > Any comment is greatly appreciated! Thank you very much for your help!
> > 
> > Best regards,
> > Harry
> > 
> > -----------
> > ...
> > VFS: Mounted root (ext2 filesystem).
> > Freeing unused kernel memory: 296k freed
> > type=1404 audit(1263731960.249:2): enforcing=1 old_enforcing=0 
> > auid=4294967295 ses=4294967295
> > type=1403 ! audit(1263731961.676:3): policy loaded auid=4294967295 
> > ses=4294967295< br>INIT: version 2.86 booting
> > type=1400 audit(1263731962.260:4): avc: denied { read } for pid=960 
> > comm="modprobe" name="console" dev=sda1 ino=244841 
> > scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 
> > tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file
> > type=1400 audit(1263731962.307:5): avc: denied { read } for pid=960 
> > comm="modprobe" path="/dev/console" dev=sda1 ino=244841 
> > scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 
> > tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file
> > Starting udev: MAKEDEV: mkdir: File exists
> > [ OK ]
> > Setting hostname cp3020: [ OK ]
> > DM multipath kernel driver not loaded
> > No devices found
> > Checking filesystems
> > Checking all file systems.
> > [ OK ]
> > can't create lock file /var/lock/mtab~2002: Permission denied (use -n 
> > flag to override)
> > Mounting local filesystems: mount: sysfs already mounted or /sys busy
> > mount: devpts a! lready mounted or /dev/pts busy
> > can't create lock file /var/lock/mtab~2007: Permission denied (use -n 
> > flag to override)
> > [FAILED]
> > Enabling local filesystem quotas: [ OK ]
> > 
> > *** Warning -- SELinux wr-strict policy relabel is required.
> > *** Relabeling could take a very long time, depending on file
> > *** system size and speed of hard drives.
> > Enabling /etc/fstab swaps: [ OK ]
> > INIT: Entering runlevel: 3
> > Entering non-interactive startup
> > Starting enterprise event logger: [ OK ]
> > Starting remote event logger: [ OK ]
> > Starting syslog-ng: [FAILED]
> > Starting ipmi drivers: [ OK ]
> > iscsid is stopped
> > iSCSI daemon not running.
> > Starting portmap: [ OK ]
> > Mounting other filesystems: mount: sysfs already mounted or /sys busy
> > mount: devpts already mounted or /dev/pts busy
> > can't create lock file /var/lock/mtab~2158: Permission denied (use -n 
> > flag to overrid! e)
> > [FAILED]
> > Starting sshd: [ OK ]
> > Starting xinetd : [ OK ]
> > Starting iSCSI daemon: [ OK ]
> > [ OK ]
> > Starting enterprise event log notification: [ OK ]
> > Starting sendmail: [ OK ]
> > Starting sm-client: /etc/rc3.d/S80sendmail: line 71: /sbin/restorecon: 
> > No such file or directory
> > [ OK ]
> > Starting boa: [ OK ]
> > Starting crond: [ OK ]
> > Starting notification action daemon: [ OK ]
> > Starting atd: [FAILED]
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > INIT: no more processes left in this runlevel
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > ...
> > ------------------------------------------------------------------------
> > 使用Messenger保护盾2.0，支持多账号登录！ 现在就下载！ 
> > <http://www.windowslive.cn/safe/>
> 
> hmm looking at the boot message the policy
> is already loaded,but errors out with atd.
> (or after)
> and you have bootparams= selinux=1 enforcing=0
> and /etc/selinux/config in permissive?
> 

Hi Justin,

Many thanks for your reply!

No, I'd just specified selinux=1 in kernel bootparams without enforcing=0, and the SELINUX=enforce in my /etc/selinux/config.


> if both are set into permissive(the policy should load), then the
> next best thing todo is a bisect(just grab the latest refpolicy from
> git), this way you can get a better idea of whats causing this.
> 
> if you need help with doing a bisect let me know.


Ok, I will go taste the latest refpolicy from git.

Thanks again!
Harry

> 
> Justin P. Mattock
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
_________________________________________________________________
上Windows Live 中国首页，下载Messenger2009安全版！
http://www.windowslive.cn
--_0154b121-d2ac-4c34-9674-e98ae1446475_
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
<br><br>&gt; Date: Sun, 17 Jan 2010 19:00:09 -0800<br>&gt; From: justinmattock@gmail.com<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: Re: Bootup problem with refpolicy-2.20091117<br>&gt; <br>&gt; On 01/17/10 18:40, TaurusHarry wrote:<br>&gt; &gt; Hi SELinux experts,<br>&gt; &gt; <br>&gt; &gt; This is my very first time to try out the latest refpolicy-2.20091117 <br>&gt; &gt; and I am unable to boot SELinux up normally, in the very end the console <br>&gt; &gt; will hang with messages like:<br>&gt; &gt; INIT: Id "0" respawning too fast: disabled for 5 minutes<br>&gt; &gt; INIT: no more processes left in this runlevel<br>&gt; &gt; INIT: Id "0" respawning too fast: disabled for 5 minutes<br>&gt; &gt; <br>&gt; &gt; Aside from this, there are some strange error messages like "Starting <br>&gt; &gt; udev: MAKEDEV: mkdir: File exists" and some AVC denied messages <br>&gt; &gt; (detailed log is appended at the last).<br>&gt; &gt; <br>&gt!
 ; &gt; However, I could boot up SELinux with refpolicy-2.20081210 successfully, <br>&gt; &gt; what I do is to first boot Linux kernel into a shell and load SELinux <br>&gt; &gt; policy image then label the whole filesystem, second boot into <br>&gt; &gt; /sbin/init as normal. The SELinux userspace tools I am using are:<br>&gt; &gt; libsepol-2.0.36<br>&gt; &gt; libselinux-2.0.79<br>&gt; &gt; libsemanage-2.0.31<br>&gt; &gt; policycoreutils-2.0.62<br>&gt; &gt; checkpolicy-2.0.19<br>&gt; &gt; sepolgen-1.0.16<br>&gt; &gt; <br>&gt; &gt; The kernel I am using is! 2.6.27, Stephen kindly pointed out a SELinux <br>&gt; &gt; kernel bug six months ago when I had a problem to boot up <br>&gt; &gt; refpolicy-2.20081210, which should be fixed by the commit of "SELinux: <br>&gt; &gt; check open perms in dentry_open not inode_permission", or bypassed by <br>&gt; &gt; diabling the open_perms in policy_capabilities.<br>&gt; &gt; <br>&gt; &gt; The same set of kernel and rootfs work well for re!
 fpolicy-2.20081210 but <br>&gt; &gt; do not for refpolicy-2.20091117, 
I wonder what changes could make a <br>&gt; &gt; difference? What should I have done in order to use the latest <br>&gt; &gt; refpolicy-2.20091117? Any extra SELinux kernel commits I should port <br>&gt; &gt; back to 2.6.27, or do I need to update SELinux userspace tools to the <br>&gt; &gt; latest as well?<br>&gt; &gt; <br>&gt; &gt; Any comment is greatly appreciated! Thank you very much for your help!<br>&gt; &gt; <br>&gt; &gt; Best regards,<br>&gt; &gt; Harry<br>&gt; &gt; <br>&gt; &gt; -----------<br>&gt; &gt; ...<br>&gt; &gt; VFS: Mounted root (ext2 filesystem).<br>&gt; &gt; Freeing unused kernel memory: 296k freed<br>&gt; &gt; type=1404 audit(1263731960.249:2): enforcing=1 old_enforcing=0 <br>&gt; &gt; auid=4294967295 ses=4294967295<br>&gt; &gt; type=1403 ! audit(1263731961.676:3): policy loaded auid=4294967295 <br>&gt; &gt; ses=4294967295&lt; br&gt;INIT: version 2.86 booting<br>&gt; &gt; type=1400 audit(1263731962.260:4): avc: denied { read } for pid=960 <br>&gt; &gt; !
 comm="modprobe" name="console" dev=sda1 ino=244841 <br>&gt; &gt; scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 <br>&gt; &gt; tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file<br>&gt; &gt; type=1400 audit(1263731962.307:5): avc: denied { read } for pid=960 <br>&gt; &gt; comm="modprobe" path="/dev/console" dev=sda1 ino=244841 <br>&gt; &gt; scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 <br>&gt; &gt; tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file<br>&gt; &gt; Starting udev: MAKEDEV: mkdir: File exists<br>&gt; &gt; [ OK ]<br>&gt; &gt; Setting hostname cp3020: [ OK ]<br>&gt; &gt; DM multipath kernel driver not loaded<br>&gt; &gt; No devices found<br>&gt; &gt; Checking filesystems<br>&gt; &gt; Checking all file systems.<br>&gt; &gt; [ OK ]<br>&gt; &gt; can't create lock file /var/lock/mtab~2002: Permission denied (use -n <br>&gt; &gt; flag to override)<br>&gt; &gt; Mounting local filesystems: mount: sysfs already mounted or /sys busy<br>&gt; !
 &gt; mount: devpts a! lready mounted or /dev/pts busy<br>&gt; &gt; can
't create lock file /var/lock/mtab~2007: Permission denied (use -n <br>&gt; &gt; flag to override)<br>&gt; &gt; [FAILED]<br>&gt; &gt; Enabling local filesystem quotas: [ OK ]<br>&gt; &gt; <br>&gt; &gt; *** Warning -- SELinux wr-strict policy relabel is required.<br>&gt; &gt; *** Relabeling could take a very long time, depending on file<br>&gt; &gt; *** system size and speed of hard drives.<br>&gt; &gt; Enabling /etc/fstab swaps: [ OK ]<br>&gt; &gt; INIT: Entering runlevel: 3<br>&gt; &gt; Entering non-interactive startup<br>&gt; &gt; Starting enterprise event logger: [ OK ]<br>&gt; &gt; Starting remote event logger: [ OK ]<br>&gt; &gt; Starting syslog-ng: [FAILED]<br>&gt; &gt; Starting ipmi drivers: [ OK ]<br>&gt; &gt; iscsid is stopped<br>&gt; &gt; iSCSI daemon not running.<br>&gt; &gt; Starting portmap: [ OK ]<br>&gt; &gt; Mounting other filesystems: mount: sysfs already mounted or /sys busy<br>&gt; &gt; mount: devpts already mounted or /dev/pts busy<br>&gt; &gt; can't crea!
 te lock file /var/lock/mtab~2158: Permission denied (use -n <br>&gt; &gt; flag to overrid! e)<br>&gt; &gt; [FAILED]<br>&gt; &gt; Starting sshd: [ OK ]<br>&gt; &gt; Starting xinetd : [ OK ]<br>&gt; &gt; Starting iSCSI daemon: [ OK ]<br>&gt; &gt; [ OK ]<br>&gt; &gt; Starting enterprise event log notification: [ OK ]<br>&gt; &gt; Starting sendmail: [ OK ]<br>&gt; &gt; Starting sm-client: /etc/rc3.d/S80sendmail: line 71: /sbin/restorecon: <br>&gt; &gt; No such file or directory<br>&gt; &gt; [ OK ]<br>&gt; &gt; Starting boa: [ OK ]<br>&gt; &gt; Starting crond: [ OK ]<br>&gt; &gt; Starting notification action daemon: [ OK ]<br>&gt; &gt; Starting atd: [FAILED]<br>&gt; &gt; INIT: Id "0" respawning too fast: disabled for 5 minutes<br>&gt; &gt; INIT: no more processes left in this runlevel<br>&gt; &gt; INIT: Id "0" respawning too fast: disabled for 5 minutes<br>&gt; &gt; INIT: Id "0" respawning too fast: disabled for 5 minutes<br>&gt; &gt; INIT: Id "0" respawning too fast: disabled f!
 or 5 minutes<br>&gt; &gt; ...<br>&gt; &gt; ---------------------------
---------------------------------------------<br>&gt; &gt; 使用Messenger保护盾2.0，支持多账号登录！ 现在就下载！ <br>&gt; &gt; &lt;http://www.windowslive.cn/safe/&gt;<br>&gt; <br>&gt; hmm looking at the boot message the policy<br>&gt; is already loaded,but errors out with atd.<br>&gt; (or after)<br>&gt; and you have bootparams= selinux=1 enforcing=0<br>&gt; and /etc/selinux/config in permissive?<br>&gt; <br><br>Hi Justin,<br><br>Many thanks for your reply!<br><br>No, I'd just specified selinux=1 in kernel bootparams without enforcing=0, and the SELINUX=enforce in my /etc/selinux/config.<br><br><br>&gt; if both are set into permissive(the policy should load), then the<br>&gt; next best thing todo is a bisect(just grab the latest refpolicy from<br>&gt; git), this way you can get a better idea of whats causing this.<br>&gt; <br>&gt; if you need help with doing a bisect let me know.<br><br><br>Ok, I will go taste the latest refpolicy from git.<br><br>Thanks again!<br>Harry<br><b!
 r>&gt; <br>&gt; Justin P. Mattock<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  <br /><hr />搜索本应是彩色的,快来体验新一代搜索引擎-必应,精美图片每天换哦! <a href='http://cn.bing.com/?form=CRMADS ' target='_new'>立即试用！</a></body>
</html>
--_0154b121-d2ac-4c34-9674-e98ae1446475_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
