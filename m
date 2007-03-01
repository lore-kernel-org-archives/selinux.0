Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21HBYIN009396
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 12:11:34 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21HCstV000690
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 17:12:56 GMT
Message-ID: <45E70963.601@redhat.com>
Date: Thu, 01 Mar 2007 12:12:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Added application_exec_type patch
References: <45E5E54F.1@redhat.com> <1172763878.11157.104.camel@sgc.columbia.tresys.com>
In-Reply-To: <1172763878.11157.104.camel@sgc.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------010208030305020200030204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010208030305020200030204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Wed, 2007-02-28 at 15:25 -0500, Daniel J Walsh wrote:
>   
>> This patch  an attribute  of application_exec_type to any executable 
>> that can be executed by a user. 
>>     
>
> The domains also need to be collected (minus the ones that we discussed
> on IRC, like cvs and rsync) into an attribute.  Then we should be able
> to apply that towards fixing the ssh command line/sockets problem (where
> the incoming client has done something like "ssh
> myserver /usr/bin/passwd").
>
>   
>> I have only patched the executables that currently transition to a 
>> domain if run under inetd or init, but do not transition if run by a user.
>>     
>
> The stuff in the apps layer will have to be covered too.  They may have
> policies, but they're still applications.  Their domain transitions will
> still happen.
>
>   
>> Also changed corecommand_exec_any to only execute executables that a 
>> user is supposed to run.  So if sysadm_t tries to execute a dameon 
>> directly it will get a permission denied.
>>     
>
> This interface has to remain the same.  "All executables" actually has
> to mean all executables for the semantics of the interface to be
> maintained.  If we want sysadm's behavior to be the above, it is the one
> that needs to change.
>
>   
How about something like the attached

I have just converted selinuxutil.te for now.

--------------010208030305020200030204
Content-Type: text/x-patch;
 name="newapp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newapp.diff"

--- nsaserefpolicy/policy/modules/system/application.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.7/policy/modules/system/application.fc	2007-03-01 11:40:30.000000000 -0500
@@ -0,0 +1 @@
+# No application file contexts.
--- nsaserefpolicy/policy/modules/system/application.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.7/policy/modules/system/application.if	2007-03-01 12:02:52.000000000 -0500
@@ -0,0 +1,113 @@
+## <summary>Policy for application domains</summary>
+
+########################################
+## <summary>
+##	Make the specified type usable as an application domain.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type to be used as a domain type.
+##	</summary>
+## </param>
+#
+interface(`application_type',`
+	gen_require(`
+		attribute application_type;
+	')
+
+	typeattribute $1 application_type;
+
+	# start with basic domain
+	domain_type($1)
+')
+
+########################################
+## <summary>
+##	Make the specified type usable for files
+##	that are exectuables, such as binary programs.
+##	This does not include shared libraries.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type to be used for files.
+##	</summary>
+## </param>
+#
+interface(`application_executable_file',`
+	gen_require(`
+		attribute application_exec_type;
+	')
+
+	typeattribute $1 application_exec_type;
+
+	corecmd_executable_file($1)
+')
+
+########################################
+## <summary>
+## Execute application executables in the caller domain.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`application_exec',`
+	gen_require(`
+		attribute application_exec_type;
+	')
+
+	can_exec($1, application_exec_type)
+')
+
+########################################
+## <summary>
+##	Execute all executable files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`application_exec_all',`
+       # Need this dontaudit or command completion fires hundreds of avcs
+       corecmd_dontaudit_exec_all_executables($1)
+       corecmd_exec_bin($1)
+       corecmd_exec_sbin($1)
+       corecmd_exec_shell($1)
+       corecmd_exec_ls($1)
+       corecmd_exec_chroot($1)
+       application_exec($1)
+')
+
+########################################
+## <summary>
+##	Create a domain which can be started by users
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Type to be used as a domain.
+##	</summary>
+## </param>
+## <param name="entry_point">
+##	<summary>
+##	Type of the program to be used as an entry point to this domain.
+##	</summary>
+## </param>
+#
+interface(`application_domain',`
+
+	application_type($1)
+	application_executable_file($2)
+	domain_entry_file($1,$2)
+	role system_r types $1;
+
+	optional_policy(`
+		ssh_sigchld($1)
+		ssh_rw_stream_sockets($1)
+	')
+
+')
--- nsaserefpolicy/policy/modules/system/application.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.7/policy/modules/system/application.te	2007-03-01 11:57:33.000000000 -0500
@@ -0,0 +1,9 @@
+
+policy_module(application,1.0.0)
+
+# Attribute of user applications
+attribute application_type;
+
+# Executables to be run by user
+attribute application_exec_type;
+
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.7/policy/modules/system/selinuxutil.te	2007-03-01 12:03:00.000000000 -0500
@@ -26,11 +24,8 @@
 files_type(selinux_config_t)
 
 type checkpolicy_t, can_write_binary_policy;
-domain_type(checkpolicy_t)
-role system_r types checkpolicy_t;
-
 type checkpolicy_exec_t;
-domain_entry_file(checkpolicy_t,checkpolicy_exec_t)
+application_domain(checkpolicy_t, checkpolicy_exec_t)
 
 #
 # default_context_t is the type applied to
@@ -47,20 +42,15 @@
 files_type(file_context_t)
 
 type load_policy_t;
-domain_type(load_policy_t)
-role system_r types load_policy_t;
-
 type load_policy_exec_t;
-domain_entry_file(load_policy_t,load_policy_exec_t)
+application_domain(load_policy_t,load_policy_exec_t)
 
 type newrole_t;
+type newrole_exec_t;
+application_domain(newrole_t,newrole_exec_t)
+domain_interactive_fd(newrole_t)
 domain_role_change_exemption(newrole_t)
 domain_obj_id_change_exemption(newrole_t)
-domain_type(newrole_t)
-domain_interactive_fd(newrole_t)
-
-type newrole_exec_t;
-domain_entry_file(newrole_t,newrole_exec_t)
 
 #
 # policy_config_t is the type of /etc/security/selinux/*
@@ -83,30 +73,34 @@
 type restorecon_exec_t;
 domain_obj_id_change_exemption(restorecon_t)
 init_system_domain(restorecon_t,restorecon_exec_t)
-role system_r types restorecon_t;
+application_type($1)
 
 type restorecond_t;
 type restorecond_exec_t;
 init_daemon_domain(restorecond_t,restorecond_exec_t)
 domain_obj_id_change_exemption(restorecond_t)
-role system_r types restorecond_t;
 
 type restorecond_var_run_t;
 files_pid_file(restorecond_var_run_t)
 
 type run_init_t;
 type run_init_exec_t;
-domain_type(run_init_t)
-domain_entry_file(run_init_t,run_init_exec_t)
+application_domain(run_init_t)
 domain_system_change_exemption(run_init_t)
 
 type semanage_t;
-domain_type(semanage_t)
+type semanage_exec_t;
+application_domain(semanage_t, semanage_exec_t)
 domain_interactive_fd(semanage_t)
 
-type semanage_exec_t;
-domain_entry_file(semanage_t, semanage_exec_t)
-role system_r types semanage_t;
+type semanage_gui_t;
+type semanage_gui_exec_t;
+application_domain(semanage_gui_t, semanage_gui_exec_t)
+domain_interactive_fd(semanage_gui_t)
+
+ifdef(`targeted_policy',`
+init_system_domain(semanage_t, semanage_exec_t)
+')
 
 type semanage_store_t;
 files_type(semanage_store_t)
@@ -121,12 +115,9 @@
 files_type(semanage_trans_lock_t)
 
 type setfiles_t, can_relabelto_binary_policy;
-domain_obj_id_change_exemption(setfiles_t)
-domain_type(setfiles_t)
-role system_r types setfiles_t;
-
 type setfiles_exec_t;
-domain_entry_file(setfiles_t,setfiles_exec_t)
+application_domain(setfiles_t,setfiles_exec_t)
+domain_obj_id_change_exemption(setfiles_t)
 
 ifdef(`distro_redhat',`
 	init_system_domain(setfiles_t,setfiles_exec_t)

--------------010208030305020200030204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
