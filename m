Message-ID: <536A85CF.7030902@tycho.nsa.gov>
Date: Wed, 07 May 2014 15:13:19 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petre Rodan <petre.rodan@simplex.ro>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] add module for the entropy key daemon
References: <1399486880-12744-1-git-send-email-petre.rodan@simplex.ro>
In-Reply-To: <1399486880-12744-1-git-send-email-petre.rodan@simplex.ro>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks, but refpolicy patches go to the refpolicy mailing list these days,
http://oss.tresys.com/mailman/listinfo/refpolicy
http://oss.tresys.com/projects/refpolicy/wiki/HowToContribute
http://oss.tresys.com/projects/refpolicy/wiki/RepositoryCheckout

On 05/07/2014 02:21 PM, Petre Rodan wrote:
> Signed-off-by: Petre Rodan <petre.rodan@simplex.ro>
> ---
> 
> policy module for http://www.entropykey.co.uk/download/
> gentoo package name: app-crypt/ekeyd
> 
> 
>  ekeyd.fc | 12 ++++++++++
>  ekeyd.if | 45 +++++++++++++++++++++++++++++++++++
>  ekeyd.te | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 ekeyd.fc
>  create mode 100644 ekeyd.if
>  create mode 100644 ekeyd.te
> 
> diff --git a/ekeyd.fc b/ekeyd.fc
> new file mode 100644
> index 0000000..0e166af
> --- /dev/null
> +++ b/ekeyd.fc
> @@ -0,0 +1,12 @@
> +
> +/etc/entropykey(/.*)?       gen_context(system_u:object_r:ekey_etc_t,s0)
> +
> +/usr/libexec/ekeyd      --  gen_context(system_u:object_r:ekeyd_exec_t,s0)
> +/usr/libexec/ekey-egd-linux     --  gen_context(system_u:object_r:ekey_egd_exec_t,s0)
> +
> +/usr/sbin/ekey-setkey   --  gen_context(system_u:object_r:ekey_tool_exec_t,s0)
> +/usr/sbin/ekey-rekey    --  gen_context(system_u:object_r:ekey_tool_exec_t,s0)
> +/usr/sbin/ekeydctl      --  gen_context(system_u:object_r:ekey_tool_exec_t,s0)
> +
> +/var/run/ekeyd.sock		-s	gen_context(system_u:object_r:ekey_var_run_t,s0)
> +
> diff --git a/ekeyd.if b/ekeyd.if
> new file mode 100644
> index 0000000..4c004d4
> --- /dev/null
> +++ b/ekeyd.if
> @@ -0,0 +1,45 @@
> +## <summary>Entropy Key daemon</summary>
> +
> +########################################
> +## <summary>
> +##	Execute entropy key tools in the ekey_tool domain.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed to transition.
> +##	</summary>
> +## </param>
> +#
> +interface(`ekey_tool_domtrans',`
> +	gen_require(`
> +		type ekey_tool_t, ekey_tool_exec_t;
> +	')
> +
> +	corecmd_search_bin($1)
> +	domtrans_pattern($1, ekey_tool_exec_t, ekey_tool_t)
> +')
> +
> +############################################################
> +## <summary>
> +##	Role access for the entropy key tools.
> +## </summary>
> +## <param name="role">
> +##	<summary>
> +##	Role allowed access.
> +##	</summary>
> +## </param>
> +## <param name="domain">
> +##	<summary>
> +##	User domain for the role.
> +##	</summary>
> +## </param>
> +#
> +interface(`ekey_tool_run',`
> +	gen_require(`
> +		type ekey_tool_t;
> +	')
> +
> +	ekey_tool_domtrans($1)
> +	role $2 types ekey_tool_t;
> +')
> +
> diff --git a/ekeyd.te b/ekeyd.te
> new file mode 100644
> index 0000000..d2efb55
> --- /dev/null
> +++ b/ekeyd.te
> @@ -0,0 +1,82 @@
> +policy_module(ekeyd, 1.0.0)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type ekeyd_t;
> +type ekeyd_exec_t;
> +init_daemon_domain(ekeyd_t, ekeyd_exec_t)
> +
> +type ekey_egd_t;
> +type ekey_egd_exec_t;
> +init_daemon_domain(ekey_egd_t, ekey_egd_exec_t)
> +
> +type ekey_tool_t;
> +type ekey_tool_exec_t;
> +init_system_domain(ekey_tool_t, ekey_tool_exec_t)
> +
> +type ekey_etc_t;
> +files_config_file(ekey_etc_t)
> +
> +type ekey_var_run_t;
> +files_pid_file(ekey_var_run_t)
> +
> +require {
> +	type unreserved_port_t;
> +}
> +
> +########################################
> +#
> +# Local policy
> +#
> +
> +# ekeyd - the Entropy Key Daemon
> +
> +allow ekeyd_t self:tcp_socket create_stream_socket_perms;
> +allow ekeyd_t self:unix_dgram_socket create_socket_perms;
> +allow ekeyd_t unreserved_port_t:tcp_socket name_connect;
> +
> +read_files_pattern(ekeyd_t, ekey_etc_t, ekey_etc_t)
> +manage_sock_files_pattern(ekeyd_t, ekey_var_run_t, ekey_var_run_t)
> +corenet_tcp_bind_generic_node(ekeyd_t)
> +term_use_unallocated_ttys(ekeyd_t)
> +logging_send_syslog_msg(ekeyd_t)
> +miscfiles_read_localization(ekeyd_t)
> +files_read_usr_files(ekeyd_t)
> +files_pid_filetrans(ekeyd_t, ekey_var_run_t, sock_file)
> +
> +# tools
> +allow ekey_tool_t self:fifo_file rw_fifo_file_perms;
> +allow ekey_tool_t ekeyd_t:unix_stream_socket connectto;
> +
> +manage_files_pattern(ekey_tool_t, ekey_etc_t, ekey_etc_t)
> +manage_sock_files_pattern(ekey_tool_t, ekey_var_run_t, ekey_var_run_t)
> +corecmd_exec_shell(ekey_tool_t)
> +can_exec(ekey_tool_t, ekey_tool_exec_t)
> +corecmd_exec_bin(ekey_tool_t)
> +userdom_use_user_terminals(ekey_tool_t)
> +miscfiles_read_localization(ekey_tool_t)
> +seutil_use_newrole_fds(ekey_tool_t)
> +files_read_usr_files(ekey_tool_t)
> +kernel_read_system_state(ekey_tool_t)
> +dev_read_sysfs(ekey_tool_t)
> +term_use_unallocated_ttys(ekey_tool_t)
> +
> +# ekey-egd-linux - the EGD Entropy Daemon
> +
> +allow ekey_egd_t self:netlink_route_socket create_netlink_socket_perms;
> +allow ekey_egd_t self:tcp_socket create_socket_perms;
> +allow ekey_egd_t self:unix_dgram_socket create_socket_perms;
> +allow ekey_egd_t unreserved_port_t:tcp_socket name_connect;
> +
> +dev_write_rand(ekey_egd_t)
> +miscfiles_read_localization(ekey_egd_t)
> +logging_send_syslog_msg(ekey_egd_t)
> +
> +optional_policy(`
> +	daemontools_service_domain(ekeyd_t, ekeyd_exec_t)
> +	daemontools_service_domain(ekey_egd_t, ekey_egd_exec_t)
> +')
> +
> 
