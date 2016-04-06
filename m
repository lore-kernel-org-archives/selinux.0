MIME-Version: 1.0
In-Reply-To: <570559FF.1050207@tresys.com>
References: <1459958221.7680.2.camel@gmail.com> <570559FF.1050207@tresys.com>
Date: Wed, 6 Apr 2016 11:55:14 -0700
Message-ID: <CAB9W1A3pcuV14u+kD0rYTQYYoKydocTDdLav4V6Xp1quD_nohw@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: distinguish non-init user namespace
 capability checks
From: Stephen Smalley <stephen.smalley@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 6, 2016 at 11:48 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On 4/6/2016 11:57 AM, Stephen Smalley wrote:
>> Distinguish capability checks against a target associated
>> with the init user namespace versus capability checks against
>> a target associated with a non-init user namespace by defining
>> and using separate security classes for the latter.
>>
>> This is needed to support e.g. Chrome usage of user namespaces
>> for the Chrome sandbox without needing to allow Chrome to also
>> exercise capabilities on targets in the init user namespace.
>
> Is there any reason not to define a new pair of commons (cap, cap2) in
> refpolicy?  This is more of a question of what you did in the below
> hunks vs. the refpolicy patch you had in the other email which didn't
> have commons.

Ah, good point.  Just wasn't thinking very hard about the refpolicy patch ;)
That should work.

>
>
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>> index 8fbd138..1f1f4b2 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -12,6 +12,18 @@
>>  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
>>           "write", "associate", "unix_read", "unix_write"
>>
>> +#define COMMON_CAP_PERMS  "chown", "dac_override", "dac_read_search", \
>> +         "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap", \
>> +         "linux_immutable", "net_bind_service", "net_broadcast", \
>> +         "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module", \
>> +         "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin", \
>> +         "sys_boot", "sys_nice", "sys_resource", "sys_time", \
>> +         "sys_tty_config", "mknod", "lease", "audit_write", \
>> +         "audit_control", "setfcap"
>> +
>> +#define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>> +             "wake_alarm", "block_suspend", "audit_read"
>> +
>>  /*
>>   * Note: The name for any socket class should be suffixed by "socket",
>>   *    and doesn't contain more than one substr of "socket".
>> @@ -34,14 +46,7 @@ struct security_class_mapping secclass_map[] = {
>>         { "ipc_info", "syslog_read", "syslog_mod",
>>           "syslog_console", "module_request", "module_load", NULL } },
>>       { "capability",
>> -       { "chown", "dac_override", "dac_read_search",
>> -         "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap",
>> -         "linux_immutable", "net_bind_service", "net_broadcast",
>> -         "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module",
>> -         "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin",
>> -         "sys_boot", "sys_nice", "sys_resource", "sys_time",
>> -         "sys_tty_config", "mknod", "lease", "audit_write",
>> -         "audit_control", "setfcap", NULL } },
>> +       { COMMON_CAP_PERMS, NULL } },
>>       { "filesystem",
>>         { "mount", "remount", "unmount", "getattr",
>>           "relabelfrom", "relabelto", "associate", "quotamod",
>> @@ -150,12 +155,15 @@ struct security_class_mapping secclass_map[] = {
>>       { "memprotect", { "mmap_zero", NULL } },
>>       { "peer", { "recv", NULL } },
>>       { "capability2",
>> -       { "mac_override", "mac_admin", "syslog", "wake_alarm", "block_suspend",
>> -         "audit_read", NULL } },
>> +       { COMMON_CAP2_PERMS, NULL } },
>>       { "kernel_service", { "use_as_override", "create_files_as", NULL } },
>>       { "tun_socket",
>>         { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>>       { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
>>                     NULL } },
>> +     { "cap_userns",
>> +       { COMMON_CAP_PERMS, NULL } },
>> +     { "cap2_userns",
>> +       { COMMON_CAP2_PERMS, NULL } },
>>       { NULL }
>>    };
>> --
>> 2.8.0
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
