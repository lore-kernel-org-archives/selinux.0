Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RBAuWJ028773
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 06:10:57 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RBArvj029965
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 11:10:54 GMT
Date: Wed, 27 Feb 2008 12:10:51 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch rpc
Message-ID: <20080227111051.GA22890@bobek.pm.i.cz>
References: <20080225123830.GA31035@bobek.pm.i.cz> <1203949867.32061.52.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
In-Reply-To: <1203949867.32061.52.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2008 at 09:31:07AM -0500, Christopher J. PeBenito wrote:
>...
> Perhaps we should make sm-notify rpcd_exec_t and allow exec on that?

A new patch attached.
-- 
Zito

--W/nzBZO5zC0uMSeA
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="rpc-2.patch"

Index: policy/modules/services/rpc.fc
===================================================================
--- policy/modules/services/rpc.fc	(revision 2626)
+++ policy/modules/services/rpc.fc	(working copy)
@@ -7,6 +7,7 @@
 # /sbin
 #
 /sbin/rpc\..*		--	gen_context(system_u:object_r:rpcd_exec_t,s0)
+/sbin/sm-notify		--	gen_context(system_u:object_r:rpcd_exec_t,s0)
 
 #
 # /usr
Index: policy/modules/services/rpc.te
===================================================================
--- policy/modules/services/rpc.te	(revision 2626)
+++ policy/modules/services/rpc.te	(working copy)
@@ -60,10 +60,15 @@
 manage_files_pattern(rpcd_t,rpcd_var_run_t,rpcd_var_run_t)
 files_pid_filetrans(rpcd_t,rpcd_var_run_t,file)
 
+# rpc.statd executes sm-notify
+corecmd_search_bin(rpcd_t)
+can_exec(rpcd_t, rpcd_exec_t)
+
 kernel_read_system_state(rpcd_t) 
 kernel_search_network_state(rpcd_t) 
 # for rpc.rquotad
 kernel_read_sysctl(rpcd_t)  
+kernel_rw_fs_sysctls(rpcd_t)
 
 fs_list_rpc(rpcd_t)
 fs_read_rpc_files(rpcd_t)

--W/nzBZO5zC0uMSeA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
