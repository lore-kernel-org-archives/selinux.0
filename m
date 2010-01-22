Message-ID: <BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_53a540be-9cb3-4b37-9c4a-c10fac522296_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <justinmattock@gmail.com>, selinux-mailing-list <selinux@tycho.nsa.gov>,
        <refpolicy@oss1.tresys.com>
Subject: RE: Bootup problem with refpolicy-2.20091117 - rules found but
 still can't login
Date: Fri, 22 Jan 2010 10:13:14 +0000
In-Reply-To: <1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>
References: 
 <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>,,<4B53CEB9.3050207@gmail.com>
 <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>,,<4B543977.40007@gmail.com>
 <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>,,<4B550EB9.50806@gmail.com>
  <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_53a540be-9cb3-4b37-9c4a-c10fac522296_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephan and Justin, 

Thank you very much for you suggestions, please see my further findings embedded below,

Best regards,
Harry

> Subject: RE: Bootup problem with refpolicy-2.20091117 - rules found but still can't login
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: justinmattock@gmail.com; selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com
> Date: Thu, 21 Jan 2010 08:19:55 -0500
> 
> On Thu, 2010-01-21 at 09:36 +0000, TaurusHarry wrote:
> > Hi Justin,
> > 
> > Sorry I respond late, thanks a lot for you to remind to first boot
> > SELinux into Permissive mode then analyze the AVC denied messages and
> > try to supplement necessary rules, I think it is indeed the
> > once-and-for-all solution to any problem of missing SELinux rules.
> > 
> > It took me two days to come up with following rules that may be
> > desirable to the refpolicy-2.20091117: (or to use dontaudit if they
> > are expected redundant behaviors)
> > 
> > +allow crond_t self:capability { dac_override setgid setuid sys_nice
> > dac_read_search audit_control };
> > 
> > +corecmd_bin_domtrans(crond_t)
> > +hostname_domtrans(crond_t)
> > +corecmd_getattr_bin_files(crond_t)
> > +corecmd_exec_bin(crond_t)
> > +corecmd_manage_bin_files(crond_t)
> > +fs_search_tmpfs(crond_t)
> > +fs_manage_tmpfs_sockets(crond_t)
> > 
> > +dontaudit quota_t self:memprotect { mmap_zero} ;
> > 
> > +fs_search_tmpfs(getty_t)
> > 
> > +term_use_console(insmod_t)
> > 
> > +fs_search_tmpfs(iscsid_t)
> > +fs_manage_tmpfs_sock! ets(iscsid_t)
> > 
> > +files_rw_lock_dirs(mount_t)
> > +files_manage_generic_locks(mount_t)
> > 
> > +fs_search_tmpfs(pam_console_t)
> > +fs_getattr_tmpfs_dirs(pam_console_t)
> > +fs_manage_tmpfs_dirs(pam_console_t)
> > 
> > +fs_search_tmpfs(portmap_t)
> > 
> > +/root        -d    gen_context(system_u:object_r:user_home_dir_t,s0)
> > +/root/.+        gen_context(system_u:object_r:user_home_t,s0)
> > 
> > +fs_search_tmpfs(sendmail_t)
> > +fs_manage_tmpfs_sockets(sendmail_t)
> > 
> > +term_read_console(setfiles_t)
> > 
> > +fs_search_tmpfs(syslogd_t)
> > +fs_manage_tmpfs_dirs(syslogd_t)
> > +fs_manage_tmpfs_sockets(syslogd_t)
> > 
> > +fs_search_tmpfs(sysstat_t)
> > 
> > (BTW, why there are so many types that have missed the "search"
> > privilege against tmpfs_t? Any convenient way to solve this problem
> > than invoking fs_search_tmpfs() against each type individually?)
> > 
> > I've tried my best to translate as many AVC denied mess! ages to
> > SELinux rules as possible, however, even with all above additi onal
> > rules applied, I still can't log in SELinux in Enforcing mode(the
> > console stuck with "INIT: Id "0" respawning too fast: disabled for 5
> > minutes"), and there is NOT a single AVC denied message I could find
> > any more by dmesg after log in with enforcing=0! I really don't get
> > it :-( 
> > 
> > What could I have missed out? So far all I know is that neither the
> > kernel nor the SELinux tools I used are latest, my kernel is 2.6.27
> > and SELinux tools are of "Release 2009-04-03". Do I need to update
> > kernel and SElinux tools in order to use refpolicy-2.20091117? What
> > can I do now to solve this problem?
> > 
> > BTW, I've compiled refpolicy-2.20091117 with "TYPE = standard", while
> > I originally wanted to try out the MLS type. I uuss I have to overcome
> > the standard type problem before moving on to the MLS type.
> > 
> > Any comment is greatly appreciated!
> 
> refpolicy questions go to refpolicy@oss.tresys.com (cc'd).
> 
> I would recommend updating your SELinux userspace to the latest released
> version and rebuilding your policy, and also booting permissive and
> performing a complete filesystem relabel.
> 

Yeah, I have updated to the latest SELinux userspace tools of Release 2009-11-23 and do restorecon -R / after loggin in with enforcing=0, but console still hangs if enforcing=1.

> Your tmpfs denials suggest that you have a tmpfs mount that is not being
> properly labeled.  For example, if you are using a tmpfs mount on /dev,
> then it usually needs to have restorecon -R /dev applied during early
> boot (from rc.sysinit in Fedora) or to be mounted with a rootcontext=
> option.  ls -Z /dev would be interesting, as would cat /proc/mounts.
> 

Exactly! Aside from missing necessary TE rules another possible reason program can't run normally is that the file accessed has not been properly labeled. My above findings that many types have no "search" privilege against the tmpfs_t is a good example of this: none of /dev/* should  be labeled as tmpfs_t. From my below findings we can see that tmpfs have been mounted to both /dev and /dev/shm, and after booting with enforcing=0,  /dev/stderr and etc are labeled as tmpfs_t, but after I manually do restorecon -R /dev, they will all reclaim their correct labels:

root@cp3020:/root> cat /proc/cmdline 
root=/dev/sda1 rw console=ttyS0,115200n8 ip=dhcp selinux=1 enforcing=0 BOOT_IMAGE=/vlm-boards/12885/qcao/kernel 
root@cp3020:/root> cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext2 rw,errors=continue 0 0
none /selinux selinuxfs rw 0 0
/proc /proc proc rw 0 0
/sys /sys sysfs rw 0 0
none /dev tmpfs rw,mode=755 0 0
devpts /dev/pts devpts rw,mode=600 0 0
tmpfs /dev/shm tmpfs rw 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0
root@cp3020:/root> ls -Z /dev/ | grep tmpfs_t
lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     MAKEDEV
drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     bsg
lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     core
drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     cpu
drwxr-xr-x  root root system_u:object_r:tmpfs_t:s0     disk
lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     fd
crw-------  root root system_u:object_r:tmpfs_t:s0     ipmi0
srw-rw-rw-  root root system_u:object_r:tmpfs_t:s15:c0.c255 log
drwxrwxrwt  root root system_u:object_r:tmpfs_t:s0     shm
lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     stderr
lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     stdin
lrwxrwxrwx  root root system_u:object_r:tmpfs_t:s0     stdout
root@cp3020:/root> /sbin/restorecon -R /dev
root@cp3020:/root> ls -Z /dev | grep tmpfs_t
root@cp3020:/root> ls -Z /dev | grep -v device_t
prw-------  root root system_u:object_r:initctl_t:s0   initctl
srw-rw-rw-  root root system_u:object_r:devlog_t:s0    log
crw-rw-rw-  root tty  system_u:object_r:ptmx_t:s0      ptmx
drwxr-xr-x  root root system_u:object_r:devpts_t:s0-s15:c0.c255 pts
crw-rw-rw-  root tty  system_u:object_r:devtty_t:s0    tty
root@cp3020:/root>

However, after reboot the console still hangs. I think many files under /dev/ are created by udev on-the-fly so we have to label them after creation. Then I modified rc.sysinit to move "/sbin/restorecon -R /dev" out of the control of the if statement and thus always be conducted, but the problem is still there. I even went on to touch /.autorelabel and changed "/sbin/fixfiles restore > /dev/null 2>&1" to "/sbin/restorecon -R /" in the relabel_selinux() function(so that the whole filesystem is relabeled once again during bootup), but the problem still persists.

Any further comments?

Thanks!
Harry

> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
_________________________________________________________________
MSN十周年庆典，查看MSN注册时间，赢取神秘大奖
http://10.msn.com.cn
--_53a540be-9cb3-4b37-9c4a-c10fac522296_
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
Hi Stephan and Justin, <br><br>Thank you very much for you suggestions, please see my further findings embedded below,<br><br>Best regards,<br>Harry<br><br>&gt; Subject: RE: Bootup problem with refpolicy-2.20091117 - rules found but still can't login<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: justinmattock@gmail.com; selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com<br>&gt; Date: Thu, 21 Jan 2010 08:19:55 -0500<br>&gt; <br>&gt; On Thu, 2010-01-21 at 09:36 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi Justin,<br>&gt; &gt; <br>&gt; &gt; Sorry I respond late, thanks a lot for you to remind to first boot<br>&gt; &gt; SELinux into Permissive mode then analyze the AVC denied messages and<br>&gt; &gt; try to supplement necessary rules, I think it is indeed the<br>&gt; &gt; once-and-for-all solution to any problem of missing SELinux rules.<br>&gt; &gt; <br>&gt; &gt; It took me two days to come up with following rules that may be<br>&gt; &gt; desir!
 able to the refpolicy-2.20091117: (or to use dontaudit if they<br>&gt; &gt; are expected redundant behaviors)<br>&gt; &gt; <br>&gt; &gt; +allow crond_t self:capability { dac_override setgid setuid sys_nice<br>&gt; &gt; dac_read_search audit_control };<br>&gt; &gt; <br>&gt; &gt; +corecmd_bin_domtrans(crond_t)<br>&gt; &gt; +hostname_domtrans(crond_t)<br>&gt; &gt; +corecmd_getattr_bin_files(crond_t)<br>&gt; &gt; +corecmd_exec_bin(crond_t)<br>&gt; &gt; +corecmd_manage_bin_files(crond_t)<br>&gt; &gt; +fs_search_tmpfs(crond_t)<br>&gt; &gt; +fs_manage_tmpfs_sockets(crond_t)<br>&gt; &gt; <br>&gt; &gt; +dontaudit quota_t self:memprotect { mmap_zero} ;<br>&gt; &gt; <br>&gt; &gt; +fs_search_tmpfs(getty_t)<br>&gt; &gt; <br>&gt; &gt; +term_use_console(insmod_t)<br>&gt; &gt; <br>&gt; &gt; +fs_search_tmpfs(iscsid_t)<br>&gt; &gt; +fs_manage_tmpfs_sock! ets(iscsid_t)<br>&gt; &gt; <br>&gt; &gt; +files_rw_lock_dirs(mount_t)<br>&gt; &gt; +files_manage_generic_locks(mount_t)<br>&gt; &gt; <br>&g!
 t; &gt; +fs_search_tmpfs(pam_console_t)<br>&gt; &gt; +fs_getattr_tmpfs
_dirs(pam_console_t)<br>&gt; &gt; +fs_manage_tmpfs_dirs(pam_console_t)<br>&gt; &gt; <br>&gt; &gt; +fs_search_tmpfs(portmap_t)<br>&gt; &gt; <br>&gt; &gt; +/root        -d    gen_context(system_u:object_r:user_home_dir_t,s0)<br>&gt; &gt; +/root/.+        gen_context(system_u:object_r:user_home_t,s0)<br>&gt; &gt; <br>&gt; &gt; +fs_search_tmpfs(sendmail_t)<br>&gt; &gt; +fs_manage_tmpfs_sockets(sendmail_t)<br>&gt; &gt; <br>&gt; &gt; +term_read_console(setfiles_t)<br>&gt; &gt; <br>&gt; &gt; +fs_search_tmpfs(syslogd_t)<br>&gt; &gt; +fs_manage_tmpfs_dirs(syslogd_t)<br>&gt; &gt; +fs_manage_tmpfs_sockets(syslogd_t)<br>&gt; &gt; <br>&gt; &gt; +fs_search_tmpfs(sysstat_t)<br>&gt; &gt; <br>&gt; &gt; (BTW, why there are so many types that have missed the "search"<br>&gt; &gt; privilege against tmpfs_t? Any convenient way to solve this problem<br>&gt; &gt; than invoking fs_search_tmpfs() against each type individually?)<br>&gt; &gt; <br>&gt; &gt; I've tried my best to translate as many AVC !
 denied mess! ages to<br>&gt; &gt; SELinux rules as possible, however, even with all above additi onal<br>&gt; &gt; rules applied, I still can't log in SELinux in Enforcing mode(the<br>&gt; &gt; console stuck with "INIT: Id "0" respawning too fast: disabled for 5<br>&gt; &gt; minutes"), and there is NOT a single AVC denied message I could find<br>&gt; &gt; any more by dmesg after log in with enforcing=0! I really don't get<br>&gt; &gt; it :-( <br>&gt; &gt; <br>&gt; &gt; What could I have missed out? So far all I know is that neither the<br>&gt; &gt; kernel nor the SELinux tools I used are latest, my kernel is 2.6.27<br>&gt; &gt; and SELinux tools are of "Release 2009-04-03". Do I need to update<br>&gt; &gt; kernel and SElinux tools in order to use refpolicy-2.20091117? What<br>&gt; &gt; can I do now to solve this problem?<br>&gt; &gt; <br>&gt; &gt; BTW, I've compiled refpolicy-2.20091117 with "TYPE = standard", while<br>&gt; &gt; I originally wanted to try out the MLS type. !
 I uuss I have to overcome<br>&gt; &gt; the standard type problem befor
e moving on to the MLS type.<br>&gt; &gt; <br>&gt; &gt; Any comment is greatly appreciated!<br>&gt; <br>&gt; refpolicy questions go to refpolicy@oss.tresys.com (cc'd).<br>&gt; <br>&gt; I would recommend updating your SELinux userspace to the latest released<br>&gt; version and rebuilding your policy, and also booting permissive and<br>&gt; performing a complete filesystem relabel.<br>&gt; <br><br>Yeah, I have updated to the latest SELinux userspace tools of Release 2009-11-23 and do restorecon -R / after loggin in with enforcing=0, but console still hangs if enforcing=1.<br><br>&gt; Your tmpfs denials suggest that you have a tmpfs mount that is not being<br>&gt; properly labeled.  For example, if you are using a tmpfs mount on /dev,<br>&gt; then it usually needs to have restorecon -R /dev applied during early<br>&gt; boot (from rc.sysinit in Fedora) or to be mounted with a rootcontext=<br>&gt; option.  ls -Z /dev would be interesting, as would cat /proc/mounts.<br>&gt; <br><!
 br>Exactly! Aside from missing necessary TE rules another possible reason program can't run normally is that the file accessed has not been properly labeled. My above findings that many types have no "search" privilege against the tmpfs_t is a good example of this: none of /dev/* should&nbsp; be labeled as tmpfs_t. From my below findings we can see that tmpfs have been mounted to both /dev and /dev/shm, and after booting with enforcing=0,&nbsp; /dev/stderr and etc are labeled as tmpfs_t, but after I manually do restorecon -R /dev, they will all reclaim their correct labels:<br><br>root@cp3020:/root&gt; cat /proc/cmdline <br>root=/dev/sda1 rw console=ttyS0,115200n8 ip=dhcp selinux=1 enforcing=0 BOOT_IMAGE=/vlm-boards/12885/qcao/kernel <br>root@cp3020:/root&gt; cat /proc/mounts<br>rootfs / rootfs rw 0 0<br>/dev/root / ext2 rw,errors=continue 0 0<br>none /selinux selinuxfs rw 0 0<br>/proc /proc proc rw 0 0<br>/sys /sys sysfs rw 0 0<br>none /dev tmpfs rw,mode=755 0 0<br>devpts !
 /dev/pts devpts rw,mode=600 0 0<br>tmpfs /dev/shm tmpfs rw 0 0<br>none
 /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0<br>root@cp3020:/root&gt; ls -Z /dev/ | grep tmpfs_t<br>lrwxrwxrwx&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; MAKEDEV<br>drwxr-xr-x&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; bsg<br>lrwxrwxrwx&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; core<br>drwxr-xr-x&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; cpu<br>drwxr-xr-x&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; disk<br>lrwxrwxrwx&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; fd<br>crw-------&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; ipmi0<br>srw-rw-rw-&nbsp; root root system_u:object_r:tmpfs_t:s15:c0.c255 log<br>drwxrwxrwt&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; shm<br>lrwxrwxrwx&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; stderr<br>lrwxrwxrwx&nbsp; root ro!
 ot system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; stdin<br>lrwxrwxrwx&nbsp; root root system_u:object_r:tmpfs_t:s0&nbsp;&nbsp;&nbsp;&nbsp; stdout<br>root@cp3020:/root&gt; /sbin/restorecon -R /dev<br>root@cp3020:/root&gt; ls -Z /dev | grep tmpfs_t<br>root@cp3020:/root&gt; ls -Z /dev | grep -v device_t<br>prw-------&nbsp; root root system_u:object_r:initctl_t:s0&nbsp;&nbsp; initctl<br>srw-rw-rw-&nbsp; root root system_u:object_r:devlog_t:s0&nbsp;&nbsp;&nbsp; log<br>crw-rw-rw-&nbsp; root tty&nbsp; system_u:object_r:ptmx_t:s0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptmx<br>drwxr-xr-x&nbsp; root root system_u:object_r:devpts_t:s0-s15:c0.c255 pts<br>crw-rw-rw-&nbsp; root tty&nbsp; system_u:object_r:devtty_t:s0&nbsp;&nbsp;&nbsp; tty<br>root@cp3020:/root&gt;<br><br>However, after reboot the console still hangs. I think many files under /dev/ are created by udev on-the-fly so we have to label them after creation. Then I modified rc.sysinit to move "/sbin/restorecon -R /dev" out of the c!
 ontrol of the if statement and thus always be conducted, but the probl
em is still there. I even went on to touch /.autorelabel and changed "/sbin/fixfiles restore &gt; /dev/null 2&gt;&amp;1" to "/sbin/restorecon -R /" in the relabel_selinux() function(so that the whole filesystem is relabeled once again during bootup), but the problem still persists.<br><br>Any further comments?<br><br>Thanks!<br>Harry<br><br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  <br /><hr />使用Messenger保护盾2.0，支持多账号登录！ <a href='http://www.windowslive.cn/safe/' target='_new'>现在就下载！</a></body>
</html>
--_53a540be-9cb3-4b37-9c4a-c10fac522296_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
