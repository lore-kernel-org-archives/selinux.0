Message-ID: <COL109-W6450505A63B6FB2820C44EAB0D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_53b687bf-8a72-4956-ac07-32b1714b3f6e_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Questions about TE rules in refpolicy-20081210
Date: Wed, 5 Aug 2009 09:11:31 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_53b687bf-8a72-4956-ac07-32b1714b3f6e_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Smalley,

Thank you very much for the selinux kernel patch, after applying it I finally could boot up refpolicy-20081210 uneventfully - all error messages about udevd and mingetty are simply disappeared!

Well, when I play with refpolicy-20081210 with MLS enabled, I run into several issues and I am not clear if they are deliberately designed to be this way or they might be potential problems, I certainly don't want to open any security holes so I would very much like to discuss with you about them, thanks again!

1, after log in, if I do "mount" then it will display nothing, neither "cat /etc/mtab" would show anything;

I think this is due to the mount_t type has no rights to write into /etc/mtab, which is of etc_runtime_t type.
I know we have called files_manage_etc_runtime_files(mount_t) in mount.te, but only after I added files_rw_etc_runtime_files(mount_t) would the mount program be able to write into /etc/mtab. Also, we may have to call files_manage_generic_locks(mount_t) so that mount_t could grab related /var/lock/mtab~ successfully.

The whole scenario is logged below and the patch is attached:

root@d610-2:/root> id -Z
root:sysadm_r:sysadm_t:s0-s15:c0.c255
root@d610-2:/root> semodule -u mount.pp 
semodule: SELinux policy is not managed or store cannot be accessed.
root@d610-2:/root> semodule -l | grep mount
semodule: SELinux policy is not managed or store cannot be accessed.
root@d610-2:/root> newrole -r secadm_r
Password: 
bash: /root/.profile: Permission denied
root@d610-2:~# /usr/sbin/semodule -l | grep mount
automount    1.11.0
mount    1.10.0
root@d610-2:~# /usr/sbin/semodule -u mount.pp 
/usr/sbin/semodule:  Could not read file 'mount.pp': Permission denied
root@d610-2:~# /usr/sbin/getenforce 
Enforcing
root@d610-2:~# /usr/sbin/setenforce 0
root@d610-2:~# /usr/sbin/getenforce 
Permissive
root@d610-2:~# /usr/sbin/semodule -u mount.pp 
root@d610-2:~# /usr/sbin/semodule -l | grep mount
automount    1.11.0
mount    1.10.1        # updated!!!
root@d610-2:~# mount
root@d610-2:~# cat /etc/mtab
root@d610-2:~# /sbin/reboot
(rebooting...)
root@d610-2:/root> id -Z
root:sysadm_r:sysadm_t:s0-s15:c0.c255
root@d610-2:/root> getenforce 
Enforcing
root@d610-2:/root> mount
rootfs on / type rootfs (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw)
tmpfs on /dev/shm type tmpfs (rw)
root@d610-2:/root> cat /etc/mtab
rootfs / rootfs rw 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
devpts /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
root@d610-2:/root> 

2, if log in the root user through serial console, I would be unable to assume another administrator roles(auditadm_r, secadm_r) by the newrole program, the error message says that newrole is unable to relabel the /dev/console device.

So far the contents of the securetty_types file are all about X_tty_device_t, where X could be of any administrator's role or staff or unprivileged user, it would be enough if log in through local /dev/ttyN device by Ctl+Alt+FN. However, if I want to use newrole on the serial console, I think I would have to mark it as secure device by appending its type of console_device_t to the securetty_types file.

Aside from that, I have to call term_relabel_console(newrole_t) so that newrole_t would have necessary permissions to relabelto or relabelfrom the /dev/console.

The patch is attched.

3, The /root/ directory is used to be labeled as "sysadm_home_t" or "sysadm_home_dir_t", but I found them are labeled as default_t now and it seems that only the sysadm_t has read permission to the /root/ directory. If I assume another administrator role such as secadm_r, then secadm_t would have trouble to read or write /root/:

root@d610-2:/root> id -Z
root:sysadm_r:sysadm_t:s0-s15:c0.c255
root@d610-2:/root> newrole -r secadm_r
Password: 
bash: /root/.profile: Permission denied    
root@d610-2:~# id -Z
root:secadm_r:secadm_t:s0-s15:c0.c255
root@d610-2:~# touch 1
touch: cannot touch `1': Permission denied
root@d610-2:~#

Shouldn't secadm_t and auditadm_t also have enough rights to the /root/ directory?

Looking forward to any of your comments!

Best regards,

Harry


_________________________________________________________________
与任何您希望的人分享您的回忆。
http://www.microsoft.com/china/windows/windowslive/products/photos-share.aspx?tab=1
--_53b687bf-8a72-4956-ac07-32b1714b3f6e_
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
Hi Smalley,<br><br>Thank you very much for the selinux kernel patch, after applying it I finally could boot up refpolicy-20081210 uneventfully - all error messages about udevd and mingetty are simply disappeared!<br><br>Well, when I play with refpolicy-20081210 with MLS enabled, I run into several issues and I am not clear if they are deliberately designed to be this way or they might be potential problems, I certainly don't want to open any security holes so I would very much like to discuss with you about them, thanks again!<br><br>1, after log in, if I do "mount" then it will display nothing, neither "cat /etc/mtab" would show anything;<br><br>I think this is due to the mount_t type has no rights to write into /etc/mtab, which is of etc_runtime_t type.<br>I know we have called files_manage_etc_runtime_files(mount_t) in mount.te, but only after I added files_rw_etc_runtime_files(mount_t) would the mount program be able to write into /etc/mtab. Also, we may have to call fil!
 es_manage_generic_locks(mount_t) so that mount_t could grab related /var/lock/mtab~ successfully.<br><br>The whole scenario is logged below and the patch is attached:<br><br>root@d610-2:/root&gt; id -Z<br>root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>root@d610-2:/root&gt; semodule -u mount.pp <br>semodule: SELinux policy is not managed or store cannot be accessed.<br>root@d610-2:/root&gt; semodule -l | grep mount<br>semodule: SELinux policy is not managed or store cannot be accessed.<br>root@d610-2:/root&gt; newrole -r secadm_r<br>Password: <br>bash: /root/.profile: Permission denied<br>root@d610-2:~# /usr/sbin/semodule -l | grep mount<br>automount&nbsp;&nbsp; &nbsp;1.11.0<br>mount&nbsp;&nbsp; &nbsp;1.10.0<br>root@d610-2:~# /usr/sbin/semodule -u mount.pp <br>/usr/sbin/semodule:&nbsp; Could not read file 'mount.pp': Permission denied<br>root@d610-2:~# /usr/sbin/getenforce <br>Enforcing<br>root@d610-2:~# /usr/sbin/setenforce 0<br>root@d610-2:~# /usr/sbin/getenforce <br>Permissive<!
 br>root@d610-2:~# /usr/sbin/semodule -u mount.pp <br>root@d610-2:~# /u
sr/sbin/semodule -l | grep mount<br>automount&nbsp;&nbsp; &nbsp;1.11.0<br>mount&nbsp;&nbsp; &nbsp;1.10.1&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;# updated!!!<br>root@d610-2:~# mount<br>root@d610-2:~# cat /etc/mtab<br>root@d610-2:~# /sbin/reboot<br>(rebooting...)<br>root@d610-2:/root&gt; id -Z<br>root:sysadm_r:sysadm_t:s0-s15:c0.c255<br>root@d610-2:/root&gt; getenforce <br>Enforcing<br>root@d610-2:/root&gt; mount<br>rootfs on / type rootfs (rw)<br>proc on /proc type proc (rw)<br>sysfs on /sys type sysfs (rw)<br>devpts on /dev/pts type devpts (rw)<br>tmpfs on /dev/shm type tmpfs (rw)<br>root@d610-2:/root&gt; cat /etc/mtab<br>rootfs / rootfs rw 0 0<br>proc /proc proc rw 0 0<br>sysfs /sys sysfs rw 0 0<br>devpts /dev/pts devpts rw 0 0<br>tmpfs /dev/shm tmpfs rw 0 0<br>root@d610-2:/root&gt; <br><br>2, if log in the root user through serial console, I would be unable to assume another administrator roles(auditadm_r, secadm_r) by the newrole program, the error message says that newrole!
  is unable to relabel the /dev/console device.<br><br>So far the contents of the securetty_types file are all about X_tty_device_t, where X could be of any administrator's role or staff or unprivileged user, it would be enough if log in through local /dev/ttyN device by Ctl+Alt+FN. However, if I want to use newrole on the serial console, I think I would have to mark it as secure device by appending its type of console_device_t to the securetty_types file.<br><br>Aside from that, I have to call term_relabel_console(newrole_t) so that newrole_t would have necessary permissions to relabelto or relabelfrom the /dev/console.<br><br>The patch is attched.<br><br>3, The /root/ directory is used to be labeled as "sysadm_home_t" or "sysadm_home_dir_t", but I found them are labeled as default_t now and it seems that only the sysadm_t has read permission to the /root/ directory. If I assume another administrator role such as secadm_r, then secadm_t would have trouble to read or write /!
 root/:<br><br>root@d610-2:/root&gt; id -Z<br>root:sysadm_r:sysadm_t:s0
-s15:c0.c255<br>root@d610-2:/root&gt; newrole -r secadm_r<br>Password: <br>bash: /root/.profile: Permission denied&nbsp;&nbsp; &nbsp;<br>root@d610-2:~# id -Z<br>root:secadm_r:secadm_t:s0-s15:c0.c255<br>root@d610-2:~# touch 1<br>touch: cannot touch `1': Permission denied<br>root@d610-2:~#<br><br>Shouldn't secadm_t and auditadm_t also have enough rights to the /root/ directory?<br><br>Looking forward to any of your comments!<br><br>Best regards,<br><br>Harry<br><br><br /><hr />与任何您希望的人分享您的回忆。 <a href='http://www.microsoft.com/china/windows/windowslive/products/photos-share.aspx?tab=1' target='_new'>任何您希望的人。</a></body>
</html>
--_53b687bf-8a72-4956-ac07-32b1714b3f6e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
