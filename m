Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2B39AVK025284
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2010 22:09:10 -0500
Received: from bay0-omc3-s19.bay0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2B39cxq013279
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 03:09:39 GMT
Message-ID: <BAY111-W4135C26BB0FE9E495A6E2FAB320@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_5cb3021f-d1a3-4cc9-b2fd-2d103bcf8742_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: How to address USER_AUTH PAM authentication failure?
Date: Thu, 11 Mar 2010 03:09:09 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_5cb3021f-d1a3-4cc9-b2fd-2d103bcf8742_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi SELinux experts,

Thank you for reading my email, I am trying to write a SELinux pp for the vlock program(Virtual Console Locking program), so far I gets no more AVC denied messages in permissive mode and only one USER_AUTH failure message in Enforcing mode, what interface should I have added for the vlock_t domain?

   [root/sysadm_r/s0@cp3020 ~]# date +%T
   23:24:07 
   [root/sysadm_r/s0@cp3020 ~]# vlock
   [root/sysadm_r/s0@cp3020 ~]# newrole -r auditadm_r -l s15:c0.c255 -p -- -c "ausearch -sv no -ts 23:24:07 -se vlock_t"
   Password: 
   ----
   time->Wed Mar 10 23:24:54 2010
   type=USER_AUTH msg=audit(1268263494.640:13155): user pid=3758 uid=0 auid=501 ses=3 subj=staff_u:sysadm_r:vlock_t:s0-s15:c0.c255 msg='op=PAM:authentication acct="root" exe="/usr/bin/vlock" (hostname=?, addr=?, terminal=? res=failed)'
   ----
   time->Wed Mar 10 23:24:54 2010
   type=USER_AUTH msg=audit(1268263494.644:13159): user pid=3758 uid=0 auid=501 ses=3 subj=staff_u:sysadm_r:vlock_t:s0-s15:c0.c255 msg='op=PAM:authentication acct="root" exe="/usr/bin/vlock" (hostname=?, addr=?, terminal=? res=failed)'
   [root/sysadm_r/s0@cp3020 ~]# 

As you can see, in Enforcing mode the vlock just exits silently. If in permissive mode, the vlock program could be run successfully like below:

   [root/sysadm_r/s0@cp3020 ~]# vlock
    *** This tty is not a VC (virtual console). ***
    *** It may not be securely locked. ***
   
   This TTY is now locked.
   Please enter the password to unlock.
   root's Password: 
   [root/sysadm_r/s0@cp3020 ~]#

So the problem must be rooted in my vlock.pp, the .te file is attached at the bottom, how should I address above USER_AUTH failure?

Thanks again!

Best regards,
Harry


----------


policy_module(vlock, 1.0.0)

########################################
#
# Declarations
#

type vlock_t;
type vlock_exec_t;
application_domain(vlock_t,vlock_exec_t)


########################################
#
# Vlock local policy
#

allow vlock_t self:fd use;
allow vlock_t self:fifo_file rw_fifo_file_perms;
allow vlock_t self:unix_dgram_socket { create connect };
allow vlock_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };

kernel_read_system_state(vlock_t)

corecmd_list_bin(vlock_t)
corecmd_read_bin_symlinks(vlock_t)

files_read_etc_files(vlock_t)
files_read_var_files(vlock_t)
files_read_var_symlinks(vlock_t)

term_use_all_user_ttys(vlock_t)
term_use_all_user_ptys(vlock_t)

auth_domtrans_chk_passwd(vlock_t)

miscfiles_read_localization(vlock_t)

logging_send_syslog_msg(vlock_t)

selinux_getattr_fs(vlock_t)

 		 	   		  
_________________________________________________________________
MSN十年回馈，每位用户可免费获得价值25元的卡巴斯基反病毒软件2010激活码，快来领取！
http://kaba.msn.com.cn/?k=1
--_5cb3021f-d1a3-4cc9-b2fd-2d103bcf8742_
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
Hi SELinux experts,<br><br>Thank you for reading my email, I am trying to write a SELinux pp for the vlock program(Virtual Console Locking program), so far I gets no more AVC denied messages in permissive mode and only one USER_AUTH failure message in Enforcing mode, what interface should I have added for the vlock_t domain?<br><br>&nbsp;&nbsp; [root/sysadm_r/s0@cp3020 ~]# date +%T<br>&nbsp;&nbsp; 23:24:07 <br>&nbsp;&nbsp; [root/sysadm_r/s0@cp3020 ~]# vlock<br>&nbsp;&nbsp; [root/sysadm_r/s0@cp3020 ~]# newrole -r auditadm_r -l s15:c0.c255 -p -- -c "ausearch -sv no -ts 23:24:07 -se vlock_t"<br>&nbsp;&nbsp; Password: <br>&nbsp;&nbsp; ----<br>&nbsp;&nbsp; time-&gt;Wed Mar 10 23:24:54 2010<br>&nbsp;&nbsp; type=USER_AUTH msg=audit(1268263494.640:13155): user pid=3758 uid=0 auid=501 ses=3 subj=staff_u:sysadm_r:vlock_t:s0-s15:c0.c255 msg='op=PAM:authentication acct="root" exe="/usr/bin/vlock" (hostname=?, addr=?, terminal=? res=failed)'<br>&nbsp;&nbsp; ----<br>&nbsp;&nbsp; time-&gt;!
 Wed Mar 10 23:24:54 2010<br>&nbsp;&nbsp; type=USER_AUTH msg=audit(1268263494.644:13159): user pid=3758 uid=0 auid=501 ses=3 subj=staff_u:sysadm_r:vlock_t:s0-s15:c0.c255 msg='op=PAM:authentication acct="root" exe="/usr/bin/vlock" (hostname=?, addr=?, terminal=? res=failed)'<br>&nbsp;&nbsp; [root/sysadm_r/s0@cp3020 ~]# <br><br>As you can see, in Enforcing mode the vlock just exits silently. If in permissive mode, the vlock program could be run successfully like below:<br><br>&nbsp;&nbsp; [root/sysadm_r/s0@cp3020 ~]# vlock<br>&nbsp;&nbsp;&nbsp; *** This tty is not a VC (virtual console). ***<br>&nbsp;&nbsp;&nbsp; *** It may not be securely locked. ***<br>&nbsp; &nbsp;<br>&nbsp;&nbsp; This TTY is now locked.<br>&nbsp;&nbsp; Please enter the password to unlock.<br>&nbsp;&nbsp; root's Password: <br>&nbsp;&nbsp; [root/sysadm_r/s0@cp3020 ~]#<br><br>So the problem must be rooted in my vlock.pp, the .te file is attached at the bottom, how should I address above USER_AUTH failure?<br>!
 <br>Thanks again!<br><br>Best regards,<br>Harry<br><br><br>----------<
br><br><br>policy_module(vlock, 1.0.0)<br><br>########################################<br>#<br># Declarations<br>#<br><br>type vlock_t;<br>type vlock_exec_t;<br>application_domain(vlock_t,vlock_exec_t)<br><br><br>########################################<br>#<br># Vlock local policy<br>#<br><br>allow vlock_t self:fd use;<br>allow vlock_t self:fifo_file rw_fifo_file_perms;<br>allow vlock_t self:unix_dgram_socket { create connect };<br>allow vlock_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };<br><br>kernel_read_system_state(vlock_t)<br><br>corecmd_list_bin(vlock_t)<br>corecmd_read_bin_symlinks(vlock_t)<br><br>files_read_etc_files(vlock_t)<br>files_read_var_files(vlock_t)<br>files_read_var_symlinks(vlock_t)<br><br>term_use_all_user_ttys(vlock_t)<br>term_use_all_user_ptys(vlock_t)<br><br>auth_domtrans_chk_passwd(vlock_t)<br><br>miscfiles_read_localization(vlock_t)<br><br>logging_send_syslog_msg(vlock_t)<br><br>selinux_getattr_fs(vlock_t)<br><br> 		 	   !
 		  <br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://www.windowslive.cn/messenger/' target='_new'>立刻下载！</a></body>
</html>
--_5cb3021f-d1a3-4cc9-b2fd-2d103bcf8742_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
