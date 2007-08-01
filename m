Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71218LI026986
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 22:01:08 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71216Dj022833
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 02:01:06 GMT
Received: by rv-out-0910.google.com with SMTP id k15so44471rvb
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 19:01:05 -0700 (PDT)
Message-ID: <46AFE917.5080107@gmail.com>
Date: Wed, 01 Aug 2007 09:59:51 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH RFC] soundserver policy modification
References: <46AEFFBF.2030008@gmail.com>
In-Reply-To: <46AEFFBF.2030008@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020409030706050207020107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020409030706050207020107
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 7bit

Ken YANG wrote:
> hi all,
> 
> i add some policy for nas(network audio system),
> the drive of this modification is:
> 
> http://marc.info/?l=fedora-selinux-list&m=118493958413746&w=2
> 
> i post the modification to fedora-selinux-list
> at last Saturday. Considering that fedora rawhide
> policy now is merged version(strict and targeted),
> which is somewhat different from the upstream policy,
> so i post to that list:
> 
> http://marc.info/?l=fedora-selinux-list&m=118561164825982&w=2
> 
> but there wasnt reply about this patch until now,
> so i think i post to the wrong place, then i "diff" with
> the upstream policy(2377).
> 
> please review this patch.

sorry, in last patch, i forgot add some targeted_policy
rules, which had been removed from the merged-version
policy(selinux-policy>3.0)

additionally, the new patch based on 2383 version

> 
> 
> thanks in advance.
> 
> 
> 


--------------020409030706050207020107
Content-Type: text/x-patch;
 name="soundserver-2383.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="soundserver-2383.patch"

diff -Nur svn/policy/modules/services/soundserver.fc svn-soundserver/policy/modules/services/soundserver.fc
--- svn/policy/modules/services/soundserver.fc	2007-04-16 14:55:31.000000000 +0800
+++ svn-soundserver/policy/modules/services/soundserver.fc	2007-08-01 09:50:22.000000000 +0800
@@ -1,10 +1,28 @@
-/etc/nas(/.*)?			gen_context(system_u:object_r:soundd_etc_t,s0)
 /etc/yiff(/.*)?			gen_context(system_u:object_r:soundd_etc_t,s0)
-
-/usr/bin/nasd		--	gen_context(system_u:object_r:soundd_exec_t,s0)
 /usr/bin/gpe-soundserver --	gen_context(system_u:object_r:soundd_exec_t,s0)
-
 /usr/sbin/yiff		--	gen_context(system_u:object_r:soundd_exec_t,s0)
-
 /var/run/yiff-[0-9]+\.pid --	gen_context(system_u:object_r:soundd_var_run_t,s0)
 /var/state/yiff(/.*)?		gen_context(system_u:object_r:soundd_state_t,s0)
+
+
+#
+# Following is for nas
+
+#
+# /usr/bin
+#
+
+/usr/bin/nasd		--	gen_context(system_u:object_r:soundd_exec_t,s0)
+
+
+# 
+# /tmp
+#
+/tmp/\.sockets		-d	gen_context(system_u:object_r:soundd_tmp_t,s0)
+/tmp/\.sockets/.*	-s	<<none>>
+
+#
+# /etc
+#
+/etc/nas(/.*)?			gen_context(system_u:object_r:soundd_etc_t,s0)
+
diff -Nur svn/policy/modules/services/soundserver.if svn-soundserver/policy/modules/services/soundserver.if
--- svn/policy/modules/services/soundserver.if	2007-04-16 14:55:35.000000000 +0800
+++ svn-soundserver/policy/modules/services/soundserver.if	2007-08-01 09:50:22.000000000 +0800
@@ -13,3 +13,64 @@
 interface(`soundserver_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+
+########################################
+## <summary>
+##	Execute a domain transition to run soundserver.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`soundserver_domtrans',`
+	gen_require(`
+		type soundd_t, soundd_exec_t;
+	')
+
+	domain_auto_trans($1,soundd_exec_t,soundd_t)
+
+	allow soundd_t $1:fd use;
+	allow soundd_t $1:fifo_file rw_file_perms;
+	allow soundd_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Do not audit attempts to read, 
+##	soundserver tmp files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`soundserver_dontaudit_read_tmp_files',`
+	gen_require(`
+		type soundd_tmp_t;
+	')
+
+	dontaudit $1 soundd_tmp_t:file r_file_perms;
+')
+
+########################################
+## <summary>
+##	Allow domain to read, soundserver tmp files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`soundserver_read_tmp_files',`
+	gen_require(`
+		type soundd_tmp_t;
+	')
+
+	dontaudit $1 soundd_tmp_t:file r_file_perms;
+')
+
diff -Nur svn/policy/modules/services/soundserver.te svn-soundserver/policy/modules/services/soundserver.te
--- svn/policy/modules/services/soundserver.te	2007-07-03 15:26:28.000000000 +0800
+++ svn-soundserver/policy/modules/services/soundserver.te	2007-08-01 09:51:59.000000000 +0800
@@ -1,5 +1,5 @@
 
-policy_module(soundserver,1.3.0)
+policy_module(soundserver,1.3.1)
 
 ########################################
 #
@@ -8,10 +8,13 @@
 
 type soundd_t;
 type soundd_exec_t;
+domain_type(soundd_t)
+domain_entry_file(soundd_t,soundd_exec_t)
 init_daemon_domain(soundd_t,soundd_exec_t)
 
 type soundd_etc_t alias etc_soundd_t;
-files_type(soundd_etc_t)
+#files_type(soundd_etc_t)
+files_config_file(soundd_etc_t)
 
 type soundd_state_t;
 files_type(soundd_state_t)
@@ -28,13 +31,32 @@
 
 ########################################
 #
-# Declarations
+# sound server local policy
 #
 
 dontaudit soundd_t self:capability sys_tty_config;
 allow soundd_t self:process { setpgid signal_perms };
+
 allow soundd_t self:tcp_socket create_stream_socket_perms;
 allow soundd_t self:udp_socket create_socket_perms;
+
+allow soundd_t self:unix_stream_socket { connectto create_stream_socket_perms };
+manage_sock_files_pattern(soundd_t,soundd_tmp_t,soundd_tmp_t)
+files_tmp_filetrans(soundd_t, soundd_tmp_t, { file dir sock_file })
+
+
+# Remove /tmp/.sockets/audio$n
+delete_files_pattern(soundd_t,soundd_tmp_t,soundd_tmp_t)
+delete_sock_files_pattern(soundd_t,soundd_tmp_t,soundd_tmp_t)
+
+allow soundd_t self:capability { dac_override };
+
+fs_getattr_all_fs(soundd_t)
+
+optional_policy(`
+	alsa_domtrans(soundd_t)
+')
+
 # for yiff
 allow soundd_t self:shm create_shm_perms;
 

--------------020409030706050207020107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
