Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BEJacQ024012
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 10:19:37 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BEJYEM024105
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 14:19:35 GMT
Message-ID: <461CEE74.1070909@redhat.com>
Date: Wed, 11 Apr 2007 10:19:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: consolekit needs additional privs.
References: <460432E1.5000503@redhat.com> <1176300008.9840.34.camel@sgc.columbia.tresys.com>
In-Reply-To: <1176300008.9840.34.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-03-23 at 16:04 -0400, Daniel J Walsh wrote:
>   
>> consolekit uses a pidfile
>>
>> sends itself signals
>>
>> reads /var/lib/dbus/machine-id
>>     
>
> Should this have its own type?
>
>   
I don't think it is security information, and I guess dbus does not 
write to it.  So adding it's own type would be of limited value, unless 
we are worried about consolekit reading other files labeled var_t.  I 
guess we could label the directory dbus_var_lib_t, if you want.
>> Needs to search and read users environments
>>
>> Uses dbus to communicate with unconfined processes.
>>     
>
> Merged.  Other comments inline:
>
>   
>>
>>
>>
>> differences
>> between files
>> attachment
>> (consolekit.patch), "consolekit.patch"
>>
>> --- nsaserefpolicy/policy/modules/services/consolekit.fc        2007-03-20 09:23:13.000000000 -0400
>> +++ serefpolicy-2.5.10/policy/modules/services/consolekit.fc    2007-03-22 15:06:59.000000000 -0400
>> @@ -1 +1,2 @@
>>  /usr/sbin/console-kit-daemon   --      gen_context(system_u:object_r:consolekit_exec_t,s0)
>> +/var/run/consolekit.pid                --      gen_context(system_u:object_r:consolekit_var_run_t,s0)
>> --- nsaserefpolicy/policy/modules/services/consolekit.te        2007-03-20 23:38:12.000000000 -0400
>> +++ serefpolicy-2.5.10/policy/modules/services/consolekit.te    2007-03-22 15:06:59.000000000 -0400
>> @@ -10,13 +10,16 @@
>>  type consolekit_exec_t;
>>  init_daemon_domain(consolekit_t, consolekit_exec_t)
>>  
>> +# pid files
>> +type consolekit_var_run_t;
>> +files_pid_file(consolekit_var_run_t)
>> +
>>  ########################################
>>  #
>>  # consolekit local policy
>>  #
>> -
>>  allow consolekit_t self:capability { sys_tty_config dac_override sys_nice sys_ptrace };
>> -allow consolekit_t self:process getsched;
>> +allow consolekit_t self:process { getsched signal };
>>  allow consolekit_t self:fifo_file rw_fifo_file_perms;
>>  allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
>>  
>> @@ -27,6 +30,10 @@
>>  domain_use_interactive_fds(consolekit_t)
>>  
>>  files_read_etc_files(consolekit_t)
>> +# needs to read /var/lib/dbus/machine-id
>> +files_read_var_lib_files(consolekit_t)
>> +
>> +
>>  
>>  libs_use_ld_so(consolekit_t)
>>  libs_use_shared_libs(consolekit_t)
>> @@ -38,10 +45,25 @@
>>         term_dontaudit_use_generic_ptys(consolekit_t)
>>  ')
>>  
>> +# pid file
>> +allow consolekit_t consolekit_var_run_t:file manage_file_perms;
>> +allow consolekit_t consolekit_var_run_t:dir rw_dir_perms;
>> +files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)
>>     
>
> fixed to use policy pattern
>
>   
>> +# Init script handling
>> +
>> +
>> +domain_ptrace_all_domains(consolekit_t)
>> +mcs_ptrace_all(consolekit_t)
>>     
>
> are you sure this isn't a dontaudit?
>
>   
No,  consolekit actually looks reads the environment variables 
associated with a process looking for the settings of  
XDG_SESSION_COOKIE, so it needs ptrace.  It might only need it for the 
userdomains though.


>>  optional_policy(`
>>         dbus_system_bus_client_template(consolekit, consolekit_t)
>>         dbus_send_system_bus(consolekit_t)
>>         dbus_connect_system_bus(consolekit_t)
>>  
>>         hal_dbus_chat(consolekit_t)
>> +       unconfined_dbus_chat(consolekit_t)
>>  ')
>> +
>> +term_use_console(consolekit_t)
>> +
>>
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
