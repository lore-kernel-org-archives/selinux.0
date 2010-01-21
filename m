Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0L9afvb001355
	for <selinux@tycho.nsa.gov>; Thu, 21 Jan 2010 04:36:41 -0500
Received: from bay0-omc1-s8.bay0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0L9ackL007265
	for <selinux@tycho.nsa.gov>; Thu, 21 Jan 2010 09:36:38 GMT
Message-ID: <BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_27ff0eb6-4fec-4f36-ace8-a2c4656a2d6f_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: <justinmattock@gmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: Bootup problem with refpolicy-2.20091117 - rules found but
 still can't login
Date: Thu, 21 Jan 2010 09:36:40 +0000
In-Reply-To: <4B550EB9.50806@gmail.com>
References: 
 <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>,<4B53CEB9.3050207@gmail.com>
 <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>,<4B543977.40007@gmail.com>
 <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>,<4B550EB9.50806@gmail.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_27ff0eb6-4fec-4f36-ace8-a2c4656a2d6f_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Justin,

Sorry I respond late, thanks a lot for you to remind to first boot SELinux into Permissive mode then analyze the AVC denied messages and try to supplement necessary rules, I think it is indeed the once-and-for-all solution to any problem of missing SELinux rules.

It took me two days to come up with following rules that may be desirable to the refpolicy-2.20091117: (or to use dontaudit if they are expected redundant behaviors)

+allow crond_t self:capability { dac_override setgid setuid sys_nice dac_read_search audit_control };

+corecmd_bin_domtrans(crond_t)
+hostname_domtrans(crond_t)
+corecmd_getattr_bin_files(crond_t)
+corecmd_exec_bin(crond_t)
+corecmd_manage_bin_files(crond_t)
+fs_search_tmpfs(crond_t)
+fs_manage_tmpfs_sockets(crond_t)

+dontaudit quota_t self:memprotect { mmap_zero} ;

+fs_search_tmpfs(getty_t)

+term_use_console(insmod_t)

+fs_search_tmpfs(iscsid_t)
+fs_manage_tmpfs_sockets(iscsid_t)

+files_rw_lock_dirs(mount_t)
+files_manage_generic_locks(mount_t)

+fs_search_tmpfs(pam_console_t)
+fs_getattr_tmpfs_dirs(pam_console_t)
+fs_manage_tmpfs_dirs(pam_console_t)

+fs_search_tmpfs(portmap_t)

+/root        -d    gen_context(system_u:object_r:user_home_dir_t,s0)
+/root/.+        gen_context(system_u:object_r:user_home_t,s0)

+fs_search_tmpfs(sendmail_t)
+fs_manage_tmpfs_sockets(sendmail_t)

+term_read_console(setfiles_t)

+fs_search_tmpfs(syslogd_t)
+fs_manage_tmpfs_dirs(syslogd_t)
+fs_manage_tmpfs_sockets(syslogd_t)

+fs_search_tmpfs(sysstat_t)

(BTW, why there are so many types that have missed the "search" privilege against tmpfs_t? Any convenient way to solve this problem than invoking fs_search_tmpfs() against each type individually?)

I've tried my best to translate as many AVC denied messages to SELinux rules as possible, however, even with all above additional rules applied, I still can't log in SELinux in Enforcing mode(the console stuck with "INIT: Id "0" respawning too fast: disabled for 5 minutes"), and there is NOT a single AVC denied message I could find any more by dmesg after log in with enforcing=0! I really don't get it :-( 

What could I have missed out? So far all I know is that neither the kernel nor the SELinux tools I used are latest, my kernel is 2.6.27 and SELinux tools are of "Release 2009-04-03". Do I need to update kernel and SElinux tools in order to use refpolicy-2.20091117? What can I do now to solve this problem?

BTW, I've compiled refpolicy-2.20091117 with "TYPE = standard", while I originally wanted to try out the MLS type. I uuss I have to overcome the standard type problem before moving on to the MLS type.

Any comment is greatly appreciated!

Thanks a lot!
Harry


> Date: Mon, 18 Jan 2010 17:45:29 -0800
> From: justinmattock@gmail.com
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Subject: Re: Bootup problem with refpolicy-2.20091117
> 
 > then that could be what your hitting.
> (noticed this a while back over here for some reason or another);
> 
> try booting with both: (boot param)enforcing=0
> and (/etc/selinux/config)SELINUX=permissive
> 
> and see if you boot up.. then define the rules.
> 
> Justin P. Mattock
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
_________________________________________________________________
约会说不清地方？来试试微软地图最新msn互动功能！
http://ditu.live.com/?form=TL&swm=1
--_27ff0eb6-4fec-4f36-ace8-a2c4656a2d6f_
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
Hi Justin,<br><br>Sorry I respond late, thanks a lot for you to remind to first boot SELinux into Permissive mode then analyze the AVC denied messages and try to supplement necessary rules, I think it is indeed the once-and-for-all solution to any problem of missing SELinux rules.<br><br>It took me two days to come up with following rules that may be desirable to the refpolicy-2.20091117: (or to use dontaudit if they are expected redundant behaviors)<br><br>+allow crond_t self:capability { dac_override setgid setuid sys_nice dac_read_search audit_control };<br><br>+corecmd_bin_domtrans(crond_t)<br>+hostname_domtrans(crond_t)<br>+corecmd_getattr_bin_files(crond_t)<br>+corecmd_exec_bin(crond_t)<br>+corecmd_manage_bin_files(crond_t)<br>+fs_search_tmpfs(crond_t)<br>+fs_manage_tmpfs_sockets(crond_t)<br><br>+dontaudit quota_t self:memprotect { mmap_zero} ;<br><br>+fs_search_tmpfs(getty_t)<br><br>+term_use_console(insmod_t)<br><br>+fs_search_tmpfs(iscsid_t)<br>+fs_manage_tmpfs_sock!
 ets(iscsid_t)<br><br>+files_rw_lock_dirs(mount_t)<br>+files_manage_generic_locks(mount_t)<br><br>+fs_search_tmpfs(pam_console_t)<br>+fs_getattr_tmpfs_dirs(pam_console_t)<br>+fs_manage_tmpfs_dirs(pam_console_t)<br><br>+fs_search_tmpfs(portmap_t)<br><br>+/root&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; -d&nbsp;&nbsp;&nbsp; gen_context(system_u:object_r:user_home_dir_t,s0)<br>+/root/.+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gen_context(system_u:object_r:user_home_t,s0)<br><br>+fs_search_tmpfs(sendmail_t)<br>+fs_manage_tmpfs_sockets(sendmail_t)<br><br>+term_read_console(setfiles_t)<br><br>+fs_search_tmpfs(syslogd_t)<br>+fs_manage_tmpfs_dirs(syslogd_t)<br>+fs_manage_tmpfs_sockets(syslogd_t)<br><br>+fs_search_tmpfs(sysstat_t)<br><br>(BTW, why there are so many types that have missed the "search" privilege against tmpfs_t? Any convenient way to solve this problem than invoking fs_search_tmpfs() against each type individually?)<br><br>I've tried my best to translate as many AVC denied mess!
 ages to SELinux rules as possible, however, even with all above additi
onal rules applied, I still can't log in SELinux in Enforcing mode(the console stuck with "INIT: Id "0" respawning too fast: disabled for 5 minutes"), and there is NOT a single AVC denied message I could find any more by dmesg after log in with enforcing=0! I really don't get it :-( <br><br>What could I have missed out? So far all I know is that neither the kernel nor the SELinux tools I used are latest, my kernel is 2.6.27 and SELinux tools are of "Release 2009-04-03". Do I need to update kernel and SElinux tools in order to use refpolicy-2.20091117? What can I do now to solve this problem?<br><br>BTW, I've compiled refpolicy-2.20091117 with "TYPE = standard", while I originally wanted to try out the MLS type. I uuss I have to overcome the standard type problem before moving on to the MLS type.<br><br>Any comment is greatly appreciated!<br><br>Thanks a lot!<br>Harry<br><br><br>&gt; Date: Mon, 18 Jan 2010 17:45:29 -0800<br>&gt; From: justinmattock@gmail.com<br>&gt; To: harry!
 taurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: Re: Bootup problem with refpolicy-2.20091117<br>&gt; <br> &gt; then that could be what your hitting.<br>&gt; (noticed this a while back over here for some reason or another);<br>&gt; <br>&gt; try booting with both: (boot param)enforcing=0<br>&gt; and (/etc/selinux/config)SELINUX=permissive<br>&gt; <br>&gt; and see if you boot up.. then define the rules.<br>&gt; <br>&gt; Justin P. Mattock<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  <br /><hr />更多热辣资讯尽在新版MSN首页！ <a href='http://cn.msn.com/' target='_new'>立刻访问！</a></body>
</html>
--_27ff0eb6-4fec-4f36-ace8-a2c4656a2d6f_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
