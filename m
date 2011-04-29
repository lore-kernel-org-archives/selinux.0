Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3TFuCUf012834
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 11:56:12 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3TFuB4Y021209
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 15:56:11 GMT
Message-ID: <4DBADF97.1050705@redhat.com>
Date: Fri, 29 Apr 2011 11:56:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Elia Pinto <andronicus.spiros@gmail.com>, selinux@tycho.nsa.gov,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] policy module for atop
References: <1303999436-1548852-1-git-send-email-andronicus.spiros@gmail.com> <4DB97ECE.2090802@gmail.com>
In-Reply-To: <4DB97ECE.2090802@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/28/2011 10:50 AM, Dominick Grift wrote:
> On 04/28/2011 04:03 PM, Elia Pinto wrote:
> 
>> +/usr/bin/atopd                  --      gen_context(system_u:object_r:atopd_exec_t,s0)
>> +/usr/bin/atop                   --      gen_context(system_u:object_r:atopd_exec_t,s0)
> 
> Might want to consider running the daemon and client in seperate domains.
> 
>> +/tmp/atop.d(/.*)?                       gen_context(system_u:object_r:atopd_tmp_t,s0)
> 
> You do not have to specify file contexts for /tmp content because
> fixfiles is not going to restore it anyways.
> 
> 
>> +        domtrans_pattern($1, atopd_exec_t, atopd_t)
> 
> How does a calling domain get to /usr/bin/atop.* in the first place
> without corecmd_search_bin($1)?
> 
> 
>> +##      Allow the specified domain to read atopd's log files.
> 
> Minor personal comment. The "allow the specified domain" is not needed
> in my view.
> 
> "Read atpod log files."
> 
> Or as i prefer it:
> 
> "Read atopd_log_t files."
> 
>> +########################################
>> +## <summary>
>> +##      Allow the specified domain to append
>> +##      atopd log files.
>> +## </summary>
>> +## <param name="domain">
>> +##      <summary>
>> +##      Domain allowed to transition.
>> +##      </summary>
>> +## </param>
>> +#
>> +interface(`atopd_append_log',`
>> +        gen_require(`
>> +                type atopd_log_t;
>> +        ')
>> +
>> +        logging_search_logs($1)
>> +        append_files_pattern($1, atopd_log_t, atopd_log_t)
>> +')
>> +
>> +########################################
>> +## <summary>
>> +##      Allow domain to manage atopd log files
>> +## </summary>
>> +## <param name="domain">
>> +##      <summary>
>> +##      Domain to not audit.
>> +##      </summary>
>> +## </param>
>> +#
>> +interface(`atopd_manage_log',`
>> +        gen_require(`
>> +                type atopd_log_t;
>> +        ')
>> +
>> +        logging_search_logs($1)
>> +        manage_dirs_pattern($1, atopd_log_t, atopd_log_t)
>> +        manage_files_pattern($1, atopd_log_t, atopd_log_t)
>> +        manage_lnk_files_pattern($1, atopd_log_t, atopd_log_t)
>> +')
> 
> These above three do not seem to be used by anyone, so i guess they can
> be removed.
> 
>> +########################################
>> +## <summary>
>> +##      All of the rules required to administrate
>> +##      an atopd environment
>> +## </summary>
>> +## <param name="domain">
>> +##      <summary>
>> +##      Domain allowed access.
>> +##      </summary>
>> +## </param>
>> +## <param name="role">
>> +##      <summary>
>> +##      Role allowed access.
>> +##      </summary>
>> +## </param>
>> +## <rolecap/>
>> +#
>> +interface(`atopd_admin',`
>> +        gen_require(`
>> +                type atopd_t;
>> +                type atopd_log_t;
>> +        ')
>> +
>> +        allow $1 atopd_t:process { ptrace signal_perms };
>> +        ps_process_pattern($1, atopd_t)
>> +
>> +        logging_search_logs($1)
>> +        admin_pattern($1, atopd_log_t)
>> +
>> +')
> 
> This template above allows confined administrators to "manage atopd".
> This is achieved by labelling atopd's init script with a private type.
> 
> Just like you did below.
> 
> but you need to allow "atopd_admin" to start/stop/reload etc the atopd
> init daemon:
> 
> 
> 	init_labeled_script_domtrans($1, atopd_initrc_exec_t)
> 	domain_system_change_exemption($1)
> 	role_transition $2 atopd_initrc_exec_t system_r;
> 	allow $2 system_r;
> 
> might also allow atopd_admin to manage atopd pids, and the i guess the
> tmp file although i suspect the tmp file is created by the atop client
> and so it should maybe not be here in the first place.
> 
>> +########################################
>> +## <summary>
>> +##    Allow domain signal atopd
> 
> "Send generic signals to atopd."
> 
> or i prefer:
> 
> "Send generic signals to atopd_t."
> 
>> +## </summary>
>> +## <param name="domain">
>> +##    <summary>
>> +##    Domain to not audit.
> 
> "Domain allowed access."
> 
>> +##    </summary>
>> +## </param>
>> +#
>> +interface(`atopd_signal',`
>> +    gen_require(`
>> +        type atopd_t;
>> +    ')
>> +
>> +    allow $1 atopd_t:process signal;
>> +')
>> +
>> +
>> diff --git a/policy/modules/services/atopd.te b/policy/modules/services/atopd.te
>> new file mode 100644
>> index 0000000..c53ecda
>> --- /dev/null
>> +++ b/policy/modules/services/atopd.te
>> @@ -0,0 +1,77 @@
>> +policy_module(atopd,1.0.0)
>> +
>> +########################################
>> +#
>> +# Declarations
>> +#
>> +
>> +type atopd_t;
>> +type atopd_exec_t;
>> +init_daemon_domain(atopd_t, atopd_exec_t)
>> +
>> +
>> +type atopd_initrc_exec_t;
>> +init_script_file(atopd_initrc_exec_t)
>> +
>> +
>> +can_exec(atopd_t, atopd_exec_t)
> 
> This is not a declaration. What is executing what here? atopd -> atop?
> or atopd -> atopd?
> 
>> +
>> +type atopd_log_t;
>> +logging_log_file(atopd_log_t)
>> +
>> +type atopd_var_run_t;
>> +files_pid_file(atopd_var_run_t)
>> +
>> +type atopd_tmp_t;
>> +files_tmp_file(atopd_tmp_t)
> 
> I suspect this tmp file is created by the client not the daemon.
> 
>> +
>> +
>> +
>> +########################################
>> +#
>> +# atopd local policy
>> +#
>> +
>> +allow atopd_t self:fifo_file rw_fifo_file_perms;
>> +allow atopd_t self:unix_stream_socket create_stream_socket_perms;
>> +
>> +allow atopd_t self:sem create_sem_perms;
>> +allow atopd_t self:capability { net_admin setuid sys_nice sys_resource sys_ptrace ipc_lock sys_pacct };
>> +allow atopd_t self:process    { setsched sigkill setrlimit };
> 
> Capability and process go on top of the "self" block. What are all these
> for? Might want to allow your domain to signal itself.
> 
>> +
>> +manage_dirs_pattern(atopd_t, atopd_log_t, atopd_log_t)
>> +manage_files_pattern(atopd_t, atopd_log_t, atopd_log_t)
>> +logging_log_filetrans(atopd_t, atopd_log_t, { dir file } )
> 
> i think you can remove the "file" from { dir file }. Its likely storing
> its log file in the dir so no need to type transition for file.
> 
>> +
>> +domain_use_interactive_fds(atopd_t)
>> +
>> +files_read_etc_files(atopd_t)
>> +
>> +miscfiles_read_localization(atopd_t)
> 
> These interface calls go below where the others are.
> 
>> +
>> +# pid files
> 
> We know already its a pid file.
> 
>> +manage_dirs_pattern(atopd_t, atopd_var_run_t, atopd_var_run_t)
>> +manage_files_pattern(atopd_t, atopd_var_run_t, atopd_var_run_t)
>> +files_pid_filetrans(atopd_t, atopd_var_run_t, { dir file  })
> 
> It is not creating any dir in /var/run. And if it does then your fc
> context specifications do not reflect it.
> 
>> +# tmp files
> 
> we know already its a tmp file.
> 
>> +manage_dirs_pattern(atopd_t, atopd_tmp_t, atopd_tmp_t)
>> +manage_files_pattern(atopd_t, atopd_tmp_t, atopd_tmp_t)
>> +files_tmp_filetrans(atopd_t, atopd_tmp_t, { dir file  })
> 
> I suspect you can remove the file from { dir file }. I believe the file
> is created in the dir and so you do not need a type transition for file.
> 
>> +
>> +
>> +
>> +auth_use_nsswitch(atopd_t)
> 
> this goes below
> 
>> +domain_read_all_domains_state(atopd_t)
> 
> this goes below the corecmd call
>> +
>> +kernel_list_proc(atopd_t)
>> +kernel_read_network_state(atopd_t)
>> +kernel_read_system_state(atopd_t)
> 
> kernel interface calls go on top of the external interface calls stack.
> 
>> +
>> +fs_getattr_xattr_fs(atopd_t)
> 
> this goes below the domain call.
> 
>> +
>> +corecmd_exec_bin(atopd_t)
> 
> This goes below the kernel calls. What is it running?
>> +
>> +acct_manage_data(atopd_t)
> 
> I gather this is not optional?
> 
> Policy patches should be sent to refpolicy@oss.tresys.com maillist.
> 

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


I just went into sepolgen templates and fixed some of the comments from
here.

policycoreutils-2.0.86-7.fc16

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2635cACgkQrlYvE4MpobNF/gCgq+HBPniX4kRc+/60h0LAeOGN
MVoAnR+yVmIpTsUxj0O3QTSfA1O/IIun
=FLXp
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
