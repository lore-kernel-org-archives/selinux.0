Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BDxX6O022879
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 09:59:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BDxVp1023242
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:59:31 GMT
Subject: Re: consolekit needs additional privs.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460432E1.5000503@redhat.com>
References: <460432E1.5000503@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 14:00:08 +0000
Message-Id: <1176300008.9840.34.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:04 -0400, Daniel J Walsh wrote:
> consolekit uses a pidfile
> 
> sends itself signals
> 
> reads /var/lib/dbus/machine-id

Should this have its own type?

> Needs to search and read users environments
> 
> Uses dbus to communicate with unconfined processes.

Merged.  Other comments inline:

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (consolekit.patch), "consolekit.patch"
> 
> --- nsaserefpolicy/policy/modules/services/consolekit.fc        2007-03-20 09:23:13.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/consolekit.fc    2007-03-22 15:06:59.000000000 -0400
> @@ -1 +1,2 @@
>  /usr/sbin/console-kit-daemon   --      gen_context(system_u:object_r:consolekit_exec_t,s0)
> +/var/run/consolekit.pid                --      gen_context(system_u:object_r:consolekit_var_run_t,s0)
> --- nsaserefpolicy/policy/modules/services/consolekit.te        2007-03-20 23:38:12.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/consolekit.te    2007-03-22 15:06:59.000000000 -0400
> @@ -10,13 +10,16 @@
>  type consolekit_exec_t;
>  init_daemon_domain(consolekit_t, consolekit_exec_t)
>  
> +# pid files
> +type consolekit_var_run_t;
> +files_pid_file(consolekit_var_run_t)
> +
>  ########################################
>  #
>  # consolekit local policy
>  #
> -
>  allow consolekit_t self:capability { sys_tty_config dac_override sys_nice sys_ptrace };
> -allow consolekit_t self:process getsched;
> +allow consolekit_t self:process { getsched signal };
>  allow consolekit_t self:fifo_file rw_fifo_file_perms;
>  allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
>  
> @@ -27,6 +30,10 @@
>  domain_use_interactive_fds(consolekit_t)
>  
>  files_read_etc_files(consolekit_t)
> +# needs to read /var/lib/dbus/machine-id
> +files_read_var_lib_files(consolekit_t)
> +
> +
>  
>  libs_use_ld_so(consolekit_t)
>  libs_use_shared_libs(consolekit_t)
> @@ -38,10 +45,25 @@
>         term_dontaudit_use_generic_ptys(consolekit_t)
>  ')
>  
> +# pid file
> +allow consolekit_t consolekit_var_run_t:file manage_file_perms;
> +allow consolekit_t consolekit_var_run_t:dir rw_dir_perms;
> +files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)

fixed to use policy pattern

> +# Init script handling
> +
> +
> +domain_ptrace_all_domains(consolekit_t)
> +mcs_ptrace_all(consolekit_t)

are you sure this isn't a dontaudit?

>  optional_policy(`
>         dbus_system_bus_client_template(consolekit, consolekit_t)
>         dbus_send_system_bus(consolekit_t)
>         dbus_connect_system_bus(consolekit_t)
>  
>         hal_dbus_chat(consolekit_t)
> +       unconfined_dbus_chat(consolekit_t)
>  ')
> +
> +term_use_console(consolekit_t)
> +
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
