Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9B5fbrT004270
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 01:41:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9B5eOfG018544
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 05:40:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: petre rodan <kaiowas@gentoo.org>
Subject: Re: postfix policy question
Date: Mon, 11 Oct 2004 15:41:26 +1000
Cc: selinux@tycho.nsa.gov
References: <41650B5B.5000903@gentoo.org>
In-Reply-To: <41650B5B.5000903@gentoo.org>
MIME-Version: 1.0
Message-Id: <200410111541.26844.russell@coker.com.au>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G0haBfmNHAUvUnt"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_G0haBfmNHAUvUnt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 7 Oct 2004 19:24, petre rodan <kaiowas@gentoo.org> wrote:
> from postconf(1):
> The  postconf command prints the actual value of parameter (all known
> parameters by default) one parameter per line, changes its value,  or 
> prints  other  information about the Postfix mail system.
>
> so sysadm_t should be able to exec this binary, regardless of the
> 'direct_sysadm_daemon' status

The attached patch makes the postconf program be labelled at sbin_t which 
allows sysadm_t to execute it without issue.  Also I allowed postfix_master_t 
to execute sbin_t as part of this change as postconf is run on postfix start.

As an unrelated change I allowed postfix_master_t to create a 
new /etc/postfix/aliases.db file on Red Hat for system-switch-mail.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_G0haBfmNHAUvUnt
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="postfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="postfix.diff"

--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-10-02 03:36:11.000000000 +1000
+++ domains/program/unused/postfix.te	2004-10-11 15:36:41.000000000 +1000
@@ -94,7 +94,7 @@
 dontaudit postfix_master_t selinux_config_t:dir search;
 can_exec({ sysadm_mail_t system_mail_t }, postfix_master_exec_t)
 ifdef(`distro_redhat', `
-file_type_auto_trans({ sysadm_mail_t system_mail_t }, postfix_etc_t, etc_aliases_t)
+file_type_auto_trans({ sysadm_mail_t system_mail_t postfix_master_t }, postfix_etc_t, etc_aliases_t)
 ', `
 file_type_auto_trans({ sysadm_mail_t system_mail_t }, etc_t, etc_aliases_t)
 ')
@@ -103,7 +103,7 @@
 ifdef(`pppd.te', `
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
-can_exec(postfix_master_t, ls_exec_t)
+can_exec(postfix_master_t, { ls_exec_t sbin_t })
 allow postfix_master_t sysctl_kernel_t:dir r_dir_perms;
 allow postfix_master_t sysctl_kernel_t:file r_file_perms;
 allow postfix_master_t self:fifo_file rw_file_perms;
--- /usr/src/se/policy/file_contexts/program/postfix.fc	2004-09-23 22:31:22.000000000 +1000
+++ file_contexts/program/postfix.fc	2004-10-11 15:35:56.000000000 +1000
@@ -18,7 +18,6 @@
 /usr/lib(exec)?/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
 /usr/sbin/postalias	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postcat	--	system_u:object_r:postfix_master_exec_t
-/usr/sbin/postconf	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postdrop	--	system_u:object_r:postfix_postdrop_exec_t
 /usr/sbin/postfix	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postkick	--	system_u:object_r:postfix_master_exec_t

--Boundary-00=_G0haBfmNHAUvUnt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
