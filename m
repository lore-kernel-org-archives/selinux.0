Message-ID: <52B07D69.70209@tycho.nsa.gov>
Date: Tue, 17 Dec 2013 11:35:53 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jay Corrales <jscorrales1122@gmail.com>, SELinux@tycho.nsa.gov
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
In-Reply-To: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/17/2013 11:23 AM, Jay Corrales wrote:
> Folks,
> 
> We're running RedHat Enterprise Linux 5 (rhel5) with selinux strict and
> enforcing mode, and finding that something in our configuration prevents a
> simple shell script from domain transitioning from user_t to awips_t
> context. If we run a test virtual machine with a new install of rhel5, it
> does run OK, but something in our current configuration prevents this
> result. Wondering if it makes sense to run a tool like apol to find any
> clues as to why? The audit log (/var/log/audit/audit.log) shows an AVC
> requiring execute_no_trans for user_t (no listed here). I can send as a
> follow up along with strace outputs if desired.

Yes, send the avc message.

> 
> Thanks
> 
> [jay@localhost ~]$ /awips/fxa/bin/test.sh
> /bin/bash: Bad interpreter: Permission denied.
> 
> [root@localhost ~]# ps faxZ
> 
> 
> 
> LABEL                             PID TTY      STAT   TIME COMMAND
> 
> system_u:system_r:sshd_t:SystemLow-SystemHigh 3953 ? Ss   0:00  \_ sshd:
> jay [priv]
> 
> system_u:system_r:sshd_t:SystemLow-SystemHigh 3958 ? S   0:00  |   \_ sshd:
> jay@pts/1
> 
> user_u:user_r:user_t             3959 pts/1    Ss     0:00  |       \_ -bash
> 
> ...
> 
> 
> [jay@localhost ~]$ cat /awips/fxa/bin/test.sh
> #!/bin/bash
> while /bin/true; do
>  id -Z sleep 10
> done
> [root@localhost ~]# sesearch -a -s user_t -t awips_exec_t -c file -p
> execute
> 
> 
> 
> Found 1 av rules:
> 
>    allow user_t awips_exec_t : file { ioctl read getattr lock execute };
> 
> 
> 
> 
> 
> Found 9 role allow rules:
> 
>    allow staff_r sysadm_r ;
> 
>    allow sysadm_r staff_r ;
> 
>    allow sysadm_r user_r ;
> 
>    allow system_r user_r ;
> 
>    allow system_r staff_r ;
> 
>    allow system_r sysadm_r ;
> 
>    allow system_r gadmin_r ;
> 
>    allow system_r guest_r ;
> 
>    allow sysadm_r system_r ;
> 
> 
> 
> [root@localhost ~]# sesearch -a -s awips_t -t awips_exec_t -c file -p
> entrypoint Found 1 av rules:
>    allow awips_t awips_exec_t : file { ioctl read getattr lock execute
> entrypoint };
> ...
> 
> [root@localhost ~]# sesearch -a -s user_t -t awips_t -c process -p
> transition Found 1 av rules:
>    allow user_t awips_t : process { transition sigkill signal };
> ...
> 
> 
> 
> File: awips.te
> 
>       1 policy_module(awips,1.0.0)
> 
>       2
> 
>       3 require {
> 
>       4   type user_t;
> 
>       5   type initrc_devpts_t;
> 
>       6   type devpts_t;
> 
>       7   type user_devpts_t;
> 
>       8 }
> 
>       9
> 
>      10 type awips_t;
> 
>      11 type awips_exec_t;
> 
>      12
> 
>      13 domain_type(awips_t)
> 
>      14 domain_entry_file(awips_t,awips_exec_t)
> 
>      15
> 
>      16 role user_r types awips_t;
> 
>      17
> 
>      18 domain_auto_trans(user_t,awips_exec_t,awips_t)
> 
>      19
> 
>      20 allow awips_t user_t:fd use;
> 
>      21 allow awips_t user_t:fifo_file rw_file_perms;
> 
>      22 allow awips_t user_t:process sigchld;
> 
>      23
> 
>      24 # AWIPS scripts run shell scripts
> 
>      25 corecmd_exec_bin(awips_t)
> 
>      26 corecmd_exec_shell(awips_t)
> 
>      27
> 
>      28 # must have execute rights on shell script
> 
>      29 allow user_t awips_exec_t:file rx_file_perms;
> 
>      30
> 
>      31 # output to terminal
> 
>      32 allow awips_t initrc_devpts_t:chr_file { read write };
> 
>      33 allow awips_t devpts_t:dir { getattr search };
> 
>      34 allow awips_t user_devpts_t:chr_file { read write getattr };
> 
>      35
> 
>      36 # load shared libs
> 
>      37 libs_use_ld_so(awips_t);
> 
>      38 libs_use_shared_libs(awips_t);
> 
>      39
> 
>      40 # respond to ctrl-c
> 
>      41 allow user_t awips_t:process { signal sigkill };
> 
>      42 allow awips_t self:process signal;
> 
> 
> 
> 
> 
> File: awips.fc
> 
>       1 # default to read-only access
> 
>       2 /awips(/.*)?    gen_context(system_u:object_r:bin_t,s0)
> 
>       3
> 
>       4 # script files and app that calls a script
> 
>       5 /awips/fxa/bin -d gen_context(system_u:object_r:bin_t,s0)
> 
>       6 /awips/fxa/bin/test.sh --
> gen_context(system_u:object_r:awips_exec_t,s0)
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
