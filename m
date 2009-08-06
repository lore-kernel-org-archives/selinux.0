Message-ID: <COL109-W428CCBFDBF13325CE2DF0AB0A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8ba04c81-7a4e-4d8b-85e1-47c134eda033_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>, <refpolicy@oss1.tresys.com>
Subject: RE: Questions about TE rules in refpolicy-20081210
Date: Thu, 6 Aug 2009 01:47:36 +0000
In-Reply-To: <1249474790.21455.28.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W6450505A63B6FB2820C44EAB0D0@phx.gbl>
	 <COL109-W39067F81436136C713D091AB0D0@phx.gbl>
 <1249474790.21455.28.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_8ba04c81-7a4e-4d8b-85e1-47c134eda033_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Smalley,

Yeah, I am confused about files_manage_etc_runtime_files() too, from its description I know it would grant enough permission to mount_t to write into any etc_runtime_t files. But how about files_manage_generic_locks(mount_t)? should we also call this interface so that mount_t could grab /var/lock/mtab~ while writing into /etc/mtab?

About console, sorry I have not made myself clear. system console is specified in my /etc/inittab as:
# Run gettys in standard runlevels
1:2345:respawn:/sbin/mingetty console
...
and I have used "console=ttyS0" in the kernel cmdline, so the serial console is mapped with system console, and we have to append system console's type (console_device_t) to securetty_types and grant newrole_t the permission to relabelto and relabelfrom the system console if we want to use newrole program on it.

Best regards,

Harry


> Subject: RE: Questions about TE rules in refpolicy-20081210
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com
> Date: Wed, 5 Aug 2009 08:19:50 -0400
> 
> On Wed, 2009-08-05 at 09:30 +0000, TaurusHarry wrote:
> > Oops I clicked the send button too quickly to attach the patches.
> 
> refpolicy questions and patches should go to the
> refpolicy@oss.tresys.com mailing list after subscribing to it.
> 
> I don't quite follow the first part - files_manage_etc_runtime_files()
> should grant the necessary permissions to mount_t to write to /etc/mtab
> unless your /etc/mtab is mislabeled.
> 
> And serial console for me is usually /dev/ttyS0, not /dev/console.  Do
> you mean the system console?
> 
> > Cheers,
> > 
> > Harry
> > 
> > 
> > ______________________________________________________________________
> > From: harrytaurus2002@hotmail.com
> > To: sds@tycho.nsa.gov
> > CC: selinux@tycho.nsa.gov
> > Subject: Questions about TE rules in refpolicy-20081210
> > Date: Wed, 5 Aug 2009 09:11:31 +0000
> > 
> > Hi Smalley,
> > 
> > Thank you very much for the selinux kernel patch, after applying it I
> > finally could boot up refpolicy-20081210 uneventfully - all error
> > messages about udevd and mingetty are simply disappeared!
> > 
> > Well, when I play with refpolicy-20081210 with MLS enabled, I run into
> > several issues and I am not clear if they are deliberately designed to
> > be this way or they might be potential problems, I certainly don't
> > want to open any security holes so I would very much like to discuss
> > with you about them, thanks again!
> > 
> > 1, after log in, if I do "mount" then it will display nothing, neither
> > "cat /etc/mtab" would show anything;
> > 
> > I think this is due to the mount_t type has no rights to write
> > into /etc/mtab, which is of etc_runtime_t type.
> > I know we have called files_manage_etc_runtime_files(mount_t) in
> > mount.te, but only after I added files_rw_etc_runtime_files(mount_t)
> > would the mount program be able to write into /etc/mtab. Also, we may
> > have to call fil! es_manage_generic_locks(mount_t) so that mount_t
> > could grab related /var/lock/mtab~ successfully.
> > 
> > The whole scenario is logged below and the patch is attached:
> > 
> > root@d610-2:/root> id -Z
> > root:sysadm_r:sysadm_t:s0-s15:c0.c255
> > root@d610-2:/root> semodule -u mount.pp 
> > semodule: SELinux policy is not managed or store cannot be accessed.
> > root@d610-2:/root> semodule -l | grep mount
> > semodule: SELinux policy is not managed or store cannot be accessed.
> > root@d610-2:/root> newrole -r secadm_r
> > Password: 
> > bash: /root/.profile: Permission denied
> > root@d610-2:~# /usr/sbin/semodule -l | grep mount
> > automount    1.11.0
> > mount    1.10.0
> > root@d610-2:~# /usr/sbin/semodule -u mount.pp 
> > /usr/sbin/semodule:  Could not read file 'mount.pp': Permission denied
> > root@d610-2:~# /usr/sbin/getenforce 
> > Enforcing
> > root@d610-2:~# /usr/sbin/setenforce 0
> > root@d610-2:~# /usr/sbin/getenforce 
> > Permissiver! oot@d610-2:~# /usr/sbin/semodule -u mount.pp 
> > root@d610-2:~# /u sr/sbin/semodule -l | grep mount
> > automount    1.11.0
> > mount    1.10.1        # updated!!!
> > root@d610-2:~# mount
> > root@d610-2:~# cat /etc/mtab
> > root@d610-2:~# /sbin/reboot
> > (rebooting...)
> > root@d610-2:/root> id -Z
> > root:sysadm_r:sysadm_t:s0-s15:c0.c255
> > root@d610-2:/root> getenforce 
> > Enforcing
> > root@d610-2:/root> mount
> > rootfs on / type rootfs (rw)
> > proc on /proc type proc (rw)
> > sysfs on /sys type sysfs (rw)
> > devpts on /dev/pts type devpts (rw)
> > tmpfs on /dev/shm type tmpfs (rw)
> > root@d610-2:/root> cat /etc/mtab
> > rootfs / rootfs rw 0 0
> > proc /proc proc rw 0 0
> > sysfs /sys sysfs rw 0 0
> > devpts /dev/pts devpts rw 0 0
> > tmpfs /dev/shm tmpfs rw 0 0
> > root@d610-2:/root> 
> > 
> > 2, if log in the root user through serial console, I would be unable
> > to assume another administrator roles(auditadm_r, secadm_r) by the
> > newrole program, the error message says that newrole! is unable to
> > relabel the /dev/console device.
> > 
> > So far the contents of the securetty_types file are all about
> > X_tty_device_t, where X could be of any administrator's role or staff
> > or unprivileged user, it would be enough if log in through
> > local /dev/ttyN device by Ctl+Alt+FN. However, if I want to use
> > newrole on the serial console, I think I would have to mark it as
> > secure device by appending its type of console_device_t to the
> > securetty_types file.
> > 
> > Aside from that, I have to call term_relabel_console(newrole_t) so
> > that newrole_t would have necessary permissions to relabelto or
> > relabelfrom the /dev/console.
> > 
> > The patch is attched.
> > 
> > 3, The /root/ directory is used to be labeled as "sysadm_home_t" or
> > "sysadm_home_dir_t", but I found them are labeled as default_t now and
> > it seems that only the sysadm_t has read permission to the /root/
> > directory. If I assume another administrator role such as secadm_r,
> > then secadm_t would have trouble to read or write /! root/:
> > 
> > root@d610-2:/root> id -Z
> > root:sysadm_r:sysadm_t:s0 -s15:c0.c255
> > root@d610-2:/root> newrole -r secadm_r
> > Password: 
> > bash: /root/.profile: Permission denied    
> > root@d610-2:~# id -Z
> > root:secadm_r:secadm_t:s0-s15:c0.c255
> > root@d610-2:~# touch 1
> > touch: cannot touch `1': Permission denied
> > root@d610-2:~#
> > 
> > Shouldn't secadm_t and auditadm_t also have enough rights to
> > the /root/ directory?
> > 
> > Looking forward to any of your comments!
> > 
> > Best regards,
> > 
> > Harry
> > 
> > 
> > 
> > ______________________________________________________________________
> > 与任何您希望的人分享您的回忆。 任何您希望的人。
> > 
> > ______________________________________________________________________
> > 与任何您希望的人分享您的回忆。 任何您希望的人。
> -- 
> Stephen Smalley
> National Security Agency
> 

_________________________________________________________________
上Windows Live 中国首页，下载最新版Messenger！
http://www.windowslive.cn
--_8ba04c81-7a4e-4d8b-85e1-47c134eda033_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
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
</style>
</head>
<body class='hmmessage'>
Hi Smalley,<br><br>Yeah, I am confused about files_manage_etc_runtime_files() too, from its description I know it would grant enough permission to mount_t to write into any etc_runtime_t files. But how about files_manage_generic_locks(mount_t)? should we also call this interface so that mount_t could grab /var/lock/mtab~ while writing into /etc/mtab?<br><br>About console, sorry I have not made myself clear. system console is specified in my /etc/inittab as:<br># Run gettys in standard runlevels<br>1:2345:respawn:/sbin/mingetty console<br>...<br>and I have used "console=ttyS0" in the kernel cmdline, so the serial console is mapped with system console, and we have to append system console's type (console_device_t) to securetty_types and grant newrole_t the permission to relabelto and relabelfrom the system console if we want to use newrole program on it.<br><br>Best regards,<br><br>Harry<br><br><br>&gt; Subject: RE: Questions about TE rules in refpolicy-20081210<br>&gt; From: !
 sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com<br>&gt; Date: Wed, 5 Aug 2009 08:19:50 -0400<br>&gt; <br>&gt; On Wed, 2009-08-05 at 09:30 +0000, TaurusHarry wrote:<br>&gt; &gt; Oops I clicked the send button too quickly to attach the patches.<br>&gt; <br>&gt; refpolicy questions and patches should go to the<br>&gt; refpolicy@oss.tresys.com mailing list after subscribing to it.<br>&gt; <br>&gt; I don't quite follow the first part - files_manage_etc_runtime_files()<br>&gt; should grant the necessary permissions to mount_t to write to /etc/mtab<br>&gt; unless your /etc/mtab is mislabeled.<br>&gt; <br>&gt; And serial console for me is usually /dev/ttyS0, not /dev/console.  Do<br>&gt; you mean the system console?<br>&gt; <br>&gt; &gt; Cheers,<br>&gt; &gt; <br>&gt; &gt; Harry<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; ______________________________________________________________________<br>&gt; &gt; From: harry!
 taurus2002@hotmail.com<br>&gt; &gt; To: sds@tycho.nsa.gov<br>&gt; &gt;
 CC: selinux@tycho.nsa.gov<br>&gt; &gt; Subject: Questions about TE rules in refpolicy-20081210<br>&gt; &gt; Date: Wed, 5 Aug 2009 09:11:31 +0000<br>&gt; &gt; <br>&gt; &gt; Hi Smalley,<br>&gt; &gt; <br>&gt; &gt; Thank you very much for the selinux kernel patch, after applying it I<br>&gt; &gt; finally could boot up refpolicy-20081210 uneventfully - all error<br>&gt; &gt; messages about udevd and mingetty are simply disappeared!<br>&gt; &gt; <br>&gt; &gt; Well, when I play with refpolicy-20081210 with MLS enabled, I run into<br>&gt; &gt; several issues and I am not clear if they are deliberately designed to<br>&gt; &gt; be this way or they might be potential problems, I certainly don't<br>&gt; &gt; want to open any security holes so I would very much like to discuss<br>&gt; &gt; with you about them, thanks again!<br>&gt; &gt; <br>&gt; &gt; 1, after log in, if I do "mount" then it will display nothing, neither<br>&gt; &gt; "cat /etc/mtab" would show anything;<br>&gt; &gt; <br>!
 &gt; &gt; I think this is due to the mount_t type has no rights to write<br>&gt; &gt; into /etc/mtab, which is of etc_runtime_t type.<br>&gt; &gt; I know we have called files_manage_etc_runtime_files(mount_t) in<br>&gt; &gt; mount.te, but only after I added files_rw_etc_runtime_files(mount_t)<br>&gt; &gt; would the mount program be able to write into /etc/mtab. Also, we may<br>&gt; &gt; have to call fil! es_manage_generic_locks(mount_t) so that mount_t<br>&gt; &gt; could grab related /var/lock/mtab~ successfully.<br>&gt; &gt; <br>&gt; &gt; The whole scenario is logged below and the patch is attached:<br>&gt; &gt; <br>&gt; &gt; root@d610-2:/root&gt; id -Z<br>&gt; &gt; root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>&gt; &gt; root@d610-2:/root&gt; semodule -u mount.pp <br>&gt; &gt; semodule: SELinux policy is not managed or store cannot be accessed.<br>&gt; &gt; root@d610-2:/root&gt; semodule -l | grep mount<br>&gt; &gt; semodule: SELinux policy is not managed or store cannot be acc!
 essed.<br>&gt; &gt; root@d610-2:/root&gt; newrole -r secadm_r<br>&gt; 
&gt; Password: <br>&gt; &gt; bash: /root/.profile: Permission denied<br>&gt; &gt; root@d610-2:~# /usr/sbin/semodule -l | grep mount<br>&gt; &gt; automount    1.11.0<br>&gt; &gt; mount    1.10.0<br>&gt; &gt; root@d610-2:~# /usr/sbin/semodule -u mount.pp <br>&gt; &gt; /usr/sbin/semodule:  Could not read file 'mount.pp': Permission denied<br>&gt; &gt; root@d610-2:~# /usr/sbin/getenforce <br>&gt; &gt; Enforcing<br>&gt; &gt; root@d610-2:~# /usr/sbin/setenforce 0<br>&gt; &gt; root@d610-2:~# /usr/sbin/getenforce <br>&gt; &gt; Permissiver! oot@d610-2:~# /usr/sbin/semodule -u mount.pp <br>&gt; &gt; root@d610-2:~# /u sr/sbin/semodule -l | grep mount<br>&gt; &gt; automount    1.11.0<br>&gt; &gt; mount    1.10.1        # updated!!!<br>&gt; &gt; root@d610-2:~# mount<br>&gt; &gt; root@d610-2:~# cat /etc/mtab<br>&gt; &gt; root@d610-2:~# /sbin/reboot<br>&gt; &gt; (rebooting...)<br>&gt; &gt; root@d610-2:/root&gt; id -Z<br>&gt; &gt; root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>&gt; &gt; root@d610!
 -2:/root&gt; getenforce <br>&gt; &gt; Enforcing<br>&gt; &gt; root@d610-2:/root&gt; mount<br>&gt; &gt; rootfs on / type rootfs (rw)<br>&gt; &gt; proc on /proc type proc (rw)<br>&gt; &gt; sysfs on /sys type sysfs (rw)<br>&gt; &gt; devpts on /dev/pts type devpts (rw)<br>&gt; &gt; tmpfs on /dev/shm type tmpfs (rw)<br>&gt; &gt; root@d610-2:/root&gt; cat /etc/mtab<br>&gt; &gt; rootfs / rootfs rw 0 0<br>&gt; &gt; proc /proc proc rw 0 0<br>&gt; &gt; sysfs /sys sysfs rw 0 0<br>&gt; &gt; devpts /dev/pts devpts rw 0 0<br>&gt; &gt; tmpfs /dev/shm tmpfs rw 0 0<br>&gt; &gt; root@d610-2:/root&gt; <br>&gt; &gt; <br>&gt; &gt; 2, if log in the root user through serial console, I would be unable<br>&gt; &gt; to assume another administrator roles(auditadm_r, secadm_r) by the<br>&gt; &gt; newrole program, the error message says that newrole! is unable to<br>&gt; &gt; relabel the /dev/console device.<br>&gt; &gt; <br>&gt; &gt; So far the contents of the securetty_types file are all about<br>&gt;!
  &gt; X_tty_device_t, where X could be of any administrator's role or 
staff<br>&gt; &gt; or unprivileged user, it would be enough if log in through<br>&gt; &gt; local /dev/ttyN device by Ctl+Alt+FN. However, if I want to use<br>&gt; &gt; newrole on the serial console, I think I would have to mark it as<br>&gt; &gt; secure device by appending its type of console_device_t to the<br>&gt; &gt; securetty_types file.<br>&gt; &gt; <br>&gt; &gt; Aside from that, I have to call term_relabel_console(newrole_t) so<br>&gt; &gt; that newrole_t would have necessary permissions to relabelto or<br>&gt; &gt; relabelfrom the /dev/console.<br>&gt; &gt; <br>&gt; &gt; The patch is attched.<br>&gt; &gt; <br>&gt; &gt; 3, The /root/ directory is used to be labeled as "sysadm_home_t" or<br>&gt; &gt; "sysadm_home_dir_t", but I found them are labeled as default_t now and<br>&gt; &gt; it seems that only the sysadm_t has read permission to the /root/<br>&gt; &gt; directory. If I assume another administrator role such as secadm_r,<br>&gt; &gt; then secadm_t would have trou!
 ble to read or write /! root/:<br>&gt; &gt; <br>&gt; &gt; root@d610-2:/root&gt; id -Z<br>&gt; &gt; root:sysadm_r:sysadm_t:s0 -s15:c0.c255<br>&gt; &gt; root@d610-2:/root&gt; newrole -r secadm_r<br>&gt; &gt; Password: <br>&gt; &gt; bash: /root/.profile: Permission denied    <br>&gt; &gt; root@d610-2:~# id -Z<br>&gt; &gt; root:secadm_r:secadm_t:s0-s15:c0.c255<br>&gt; &gt; root@d610-2:~# touch 1<br>&gt; &gt; touch: cannot touch `1': Permission denied<br>&gt; &gt; root@d610-2:~#<br>&gt; &gt; <br>&gt; &gt; Shouldn't secadm_t and auditadm_t also have enough rights to<br>&gt; &gt; the /root/ directory?<br>&gt; &gt; <br>&gt; &gt; Looking forward to any of your comments!<br>&gt; &gt; <br>&gt; &gt; Best regards,<br>&gt; &gt; <br>&gt; &gt; Harry<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; ______________________________________________________________________<br>&gt; &gt; 与任何您希望的人分享您的回忆。 任何您希望的人。<br>&gt; &gt; <br>&gt; &gt; ______________________________!
 ________________________________________<br>&gt; &gt; 与任何您希望的人
分享您的回忆。 任何您希望的人。<br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br><br /><hr />搜索本应是快乐的，不是么?  快乐搜索，有问必应！微软隆重推出! <a href='http://bing.com.cn?FORM=M00HCN&Publ=WLHMTAG&Crea=TEXT_Search_Where_You_Are_1X1' target='_new'>立即试用！</a></body>
</html>
--_8ba04c81-7a4e-4d8b-85e1-47c134eda033_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
