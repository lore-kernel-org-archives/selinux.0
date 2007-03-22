Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2MDfD57008228
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 09:41:14 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2MDfCcm001577
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 13:41:12 GMT
Subject: Re: Added application_exec_type patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E8554B.2080903@redhat.com>
References: <45E5E54F.1@redhat.com>
	 <1172763878.11157.104.camel@sgc.columbia.tresys.com>
	 <45E70963.601@redhat.com>
	 <1172851610.19169.89.camel@sgc.columbia.tresys.com>
	 <45E8554B.2080903@redhat.com>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 13:41:45 +0000
Message-Id: <1174570905.19924.32.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think this is fine, it can move forward as is.

On Fri, 2007-03-02 at 11:48 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/system/application.fc 1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.7/policy/modules/system/application.fc      2007-03-01 18:10:08.000000000 -0500
> @@ -0,0 +1 @@
> +# No application file contexts.
> --- nsaserefpolicy/policy/modules/system/application.if 1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.7/policy/modules/system/application.if      2007-03-02 11:44:19.000000000 -0500
> @@ -0,0 +1,106 @@
> +## <summary>Policy for application domains</summary>
> +
> +########################################
> +## <summary>
> +##     Make the specified type usable as an application domain.
> +## </summary>
> +## <param name="type">
> +##     <summary>
> +##     Type to be used as a domain type.
> +##     </summary>
> +## </param>
> +#
> +interface(`application_type',`
> +       gen_require(`
> +               attribute application_domain_type;
> +       ')
> +
> +       typeattribute $1 application_domain_type;
> +
> +       # start with basic domain
> +       domain_type($1)
> +')
> +
> +########################################
> +## <summary>
> +##     Make the specified type usable for files
> +##     that are exectuables, such as binary programs.
> +##     This does not include shared libraries.
> +## </summary>
> +## <param name="type">
> +##     <summary>
> +##     Type to be used for files.
> +##     </summary>
> +## </param>
> +#
> +interface(`application_executable_file',`
> +       gen_require(`
> +               attribute application_exec_type;
> +       ')
> +
> +       typeattribute $1 application_exec_type;
> +
> +       corecmd_executable_file($1)
> +')
> +
> +########################################
> +## <summary>
> +## Execute application executables in the caller domain.
> +## </summary>
> +## <param name="type">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`application_exec',`
> +       gen_require(`
> +               attribute application_exec_type;
> +       ')
> +
> +       can_exec($1, application_exec_type)
> +')
> +
> +########################################
> +## <summary>
> +##     Execute all executable files.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`application_exec_all',`
> +       # Need this dontaudit or command completion fires hundreds of avcs
> +       corecmd_dontaudit_exec_all_executables($1)
> +       corecmd_exec_bin($1)
> +       corecmd_exec_sbin($1)
> +       corecmd_exec_shell($1)
> +       corecmd_exec_ls($1)
> +       corecmd_exec_chroot($1)
> +       application_exec($1)
> +')
> +
> +########################################
> +## <summary>
> +##     Create a domain which can be started by users
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Type to be used as a domain.
> +##     </summary>
> +## </param>
> +## <param name="entry_point">
> +##     <summary>
> +##     Type of the program to be used as an entry point to this domain.
> +##     </summary>
> +## </param>
> +#
> +interface(`application_domain',`
> +
> +       application_type($1)
> +       application_executable_file($2)
> +       domain_entry_file($1,$2)
> +')
> --- nsaserefpolicy/policy/modules/system/application.te 1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.7/policy/modules/system/application.te      2007-03-02 11:39:09.000000000 -0500
> @@ -0,0 +1,14 @@
> +
> +policy_module(application,1.0.0)
> +
> +# Attribute of user applications
> +attribute application_domain_type;
> +
> +# Executables to be run by user
> +attribute application_exec_type;
> +
> +optional_policy(`
> +       ssh_sigchld(application_doman_type)
> +       ssh_rw_stream_sockets(application_domain_type)
> +')
> +
> --- nsaserefpolicy/policy/modules/system/selinuxutil.te 2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.7/policy/modules/system/selinuxutil.te      2007-03-02 11:45:02.000000000 -0500
> @@ -26,11 +24,9 @@
>  files_type(selinux_config_t)
>  
>  type checkpolicy_t, can_write_binary_policy;
> -domain_type(checkpolicy_t)
> -role system_r types checkpolicy_t;
> -
>  type checkpolicy_exec_t;
> -domain_entry_file(checkpolicy_t,checkpolicy_exec_t)
> +application_domain(checkpolicy_t, checkpolicy_exec_t)
> +role system_r types checkpolicy_t;
>  
>  #
>  # default_context_t is the type applied to
> @@ -47,21 +43,18 @@
>  files_type(file_context_t)
>  
>  type load_policy_t;
> -domain_type(load_policy_t)
> -role system_r types load_policy_t;
> -
>  type load_policy_exec_t;
> -domain_entry_file(load_policy_t,load_policy_exec_t)
> +application_domain(load_policy_t,load_policy_exec_t)
> +role system_r types load_policy_t;
>  
>  type newrole_t;
> +type newrole_exec_t;
> +application_domain(newrole_t,newrole_exec_t)
> +role system_r types newrole_t;
>  domain_role_change_exemption(newrole_t)
>  domain_obj_id_change_exemption(newrole_t)
> -domain_type(newrole_t)
>  domain_interactive_fd(newrole_t)
>  
> -type newrole_exec_t;
> -domain_entry_file(newrole_t,newrole_exec_t)
> -
>  #
>  # policy_config_t is the type of /etc/security/selinux/*
>  # the security server policy configuration.
> @@ -83,31 +76,39 @@
>  type restorecon_exec_t;
>  domain_obj_id_change_exemption(restorecon_t)
>  init_system_domain(restorecon_t,restorecon_exec_t)
> +application_domain(restorecon_t,restorecon_exec_t)
>  role system_r types restorecon_t;
>  
>  type restorecond_t;
>  type restorecond_exec_t;
>  init_daemon_domain(restorecond_t,restorecond_exec_t)
>  domain_obj_id_change_exemption(restorecond_t)
> -role system_r types restorecond_t;
>  
>  type restorecond_var_run_t;
>  files_pid_file(restorecond_var_run_t)
>  
>  type run_init_t;
>  type run_init_exec_t;
> -domain_type(run_init_t)
> -domain_entry_file(run_init_t,run_init_exec_t)
> +application_domain(run_init_t, run_init_exec_t)
>  domain_system_change_exemption(run_init_t)
> +role system_r types run_init_t;
>  
>  type semanage_t;
> -domain_type(semanage_t)
> -domain_interactive_fd(semanage_t)
> -
>  type semanage_exec_t;
> -domain_entry_file(semanage_t, semanage_exec_t)
> +application_domain(semanage_t, semanage_exec_t)
> +domain_interactive_fd(semanage_t)
>  role system_r types semanage_t;
>  
> +type semanage_gui_t;
> +type semanage_gui_exec_t;
> +application_domain(semanage_gui_t, semanage_gui_exec_t)
> +domain_interactive_fd(semanage_gui_t)
> +role system_r types semanage_gui_t;
> +
> +ifdef(`targeted_policy',`
> +init_system_domain(semanage_t, semanage_exec_t)
> +')
> +
>  type semanage_store_t;
>  files_type(semanage_store_t)
>  
> @@ -121,12 +122,10 @@
>  files_type(semanage_trans_lock_t)
>  
>  type setfiles_t, can_relabelto_binary_policy;
> -domain_obj_id_change_exemption(setfiles_t)
> -domain_type(setfiles_t)
> -role system_r types setfiles_t;
> -
>  type setfiles_exec_t;
> -domain_entry_file(setfiles_t,setfiles_exec_t)
> +application_domain(setfiles_t,setfiles_exec_t)
> +role system_r types setfiles_t;
> +domain_obj_id_change_exemption(setfiles_t)
>  
>  ifdef(`distro_redhat',`
>         init_system_domain(setfiles_t,setfiles_exec_t)
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
