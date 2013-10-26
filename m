Message-ID: <1382788727.3592.16.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Sat, 26 Oct 2013 13:58:47 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

Some other things i noticed:

dontaudit seems to not work ( at least not in the scenario below ):

> (macro domtrans_pattern ((type ARG1) (type ARG2) (type ARG3))
>   (call domain_auto_transition_pattern (ARG1 ARG2 ARG3))
>   (allow ARG3 ARG1 (fd (use)))
>   (allow ARG3 ARG1 (rw_fifo_file_perms))
>   (allow ARG3 ARG1 (process (sigchld))))

> (macro domain_auto_transition_pattern ((type ARG1) (type ARG2) (type ARG3))
>   (call domain_transition_pattern (ARG1 ARG2 ARG3))
>   (typetransition ARG1 ARG2 process "*" ARG3))

> (macro domain_transition_pattern ((type ARG1) (type ARG2) (type ARG3))
>   (allow ARG1 ARG2 (mmap_file_perms))
>   (allow ARG1 ARG3 (process (transition)))
>   (dontaudit ARG1 ARG3 (process (noatsecure siginh rlimitinh))))

> (macro systemd_domtrans_cgroups_agent ((type ARG1))
>   (call domtrans_pattern (ARG1 systemd_cgroups_agent_exec_t
>             systemd_cgroups_agent_t)))

> (optional dependsonsystemd_kernel
> (call systemd_signal (kernel_t))
> (call systemd_sigchld (kernel_t))
> (call systemd_domtrans (kernel_t))
> (call domain_dyntrans_type (kernel_t))
> (call systemd_domtrans_cgroups_agent (kernel_t))
> (call systemd_dyntrans (kernel_t)))

> # sesearch --dontaudit -s kernel_t
> 

> allow kernel_t systemd_cgroups_agent_t:process { siginh rlimitinh noatsecure };
> 

I am also seeing a weird issue where some things are created with a wrong context

for example:

> # ls -alZ /dev/pts/ptmx
> c---------. root root system_u:system_r:kernel_t:s0    /dev/pts/ptmx

there is a type transition rule:

> (macro filesystem_devpts_filetrans ((type ARG1) (class ARG2) (name ARG3)
>             (type ARG4))
>   (call devices_list (ARG1))
>   (call filetrans_pattern (ARG1 devpts_t ARG2 ARG3 ARG4)))

> (macro filetrans_pattern ((type ARG1) (type ARG2) (class ARG3)
>             (name ARG4) (type ARG5))
>   (allow ARG1 ARG2 (rw_dir_perms))
>   (typetransition ARG1 ARG2 ARG3 ARG4 ARG5))

> (macro term_filetrans_ptmx ((type ARG1) (name ARG2))
> (call filesystem_devpts_filetrans (ARG1 chr_file ARG2 ptmx_t))
> (call devices_filetrans (ARG1 chr_file ARG2 ptmx_t)))

> (macro devices_filetrans ((type ARG1) (class ARG2) (name ARG3) (type ARG4))
>   (call filetrans_pattern (ARG1 device_t ARG2 ARG3 ARG4)))

> (call term_filetrans_ptmx (kernel_t "ptmx"))


> # sesearch -ASCT -s kernel_t | grep ptmx
>    allow kernel_t ptmx_t : chr_file { create getattr setattr open } ; 
> type_transition kernel_t device_t : chr_file ptmx_t "ptmx"; 
> type_transition kernel_t devpts_t : chr_file ptmx_t "ptmx";


By the way on a slight unrelated note:

In the filecon() we use symlink, char, block (etc) but elsewhere its lnk_file, chr_file, blk_file (etc)

I prefer consistency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
