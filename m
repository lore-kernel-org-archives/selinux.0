Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2KKS79S003128
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:28:07 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2KKS5uO014857
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 20:28:05 GMT
Message-ID: <460043CD.1060700@redhat.com>
Date: Tue, 20 Mar 2007 16:27:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New fail2ban policy
References: <45F01D96.1010806@redhat.com> <1174420865.16552.3.camel@sgc>
In-Reply-To: <1174420865.16552.3.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------040107090905040200020102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040107090905040200020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Thu, 2007-03-08 at 09:28 -0500, Daniel J Walsh wrote:
>
> This seems to have rules similar to iptables:
>
>   
>> +allow fail2ban_t self : capability { net_admin net_raw };
>> +allow fail2ban_t self : rawip_socket { getopt create setopt };
>>     
>
>   
> But also transitions to iptables?
>
>   
Yes remove these
>> +optional_policy(`
>> +       iptables_domtrans(fail2ban_t)
>> +')
>>     
>
> This also seems out of place:
>
>   
>> +selinux_get_fs_mount(fail2ban_t)
>>     
>
>   
Not sure, but retesting now it did not complain so remove.

Also seems to need

kernel_read_system_state(fail2ban_t)



--------------040107090905040200020102
Content-Type: text/plain;
 name="fail2ban.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fail2ban.te"

policy_module(fail2ban,1.0.0)

########################################
#
# Declarations
#

type fail2ban_t;
type fail2ban_exec_t;
domain_type(fail2ban_t)
init_daemon_domain(fail2ban_t, fail2ban_exec_t)

# log files
type fail2ban_log_t;
logging_log_file(fail2ban_log_t)

# pid files
type fail2ban_var_run_t;
files_pid_file(fail2ban_var_run_t)

########################################
#
# fail2ban local policy
#

allow fail2ban_t self : process signal;

# Init script handling
init_use_fds(fail2ban_t)
init_use_script_ptys(fail2ban_t)
domain_use_interactive_fds(fail2ban_t)

## internal communication is often done using fifo and unix sockets.
allow fail2ban_t self:fifo_file rw_file_perms;
allow fail2ban_t self:unix_stream_socket create_stream_socket_perms;

# Some common macros (you might be able to remove some)
files_read_etc_files(fail2ban_t)

kernel_read_system_state(fail2ban_t)

libs_use_ld_so(fail2ban_t)
libs_use_shared_libs(fail2ban_t)

miscfiles_read_localization(fail2ban_t)

# log files
allow fail2ban_t fail2ban_log_t:file manage_file_perms;
allow fail2ban_t fail2ban_log_t:dir { rw_dir_perms setattr };
logging_log_filetrans(fail2ban_t,fail2ban_log_t,{ file dir })

# pid file
allow fail2ban_t fail2ban_var_run_t:file manage_file_perms;
allow fail2ban_t fail2ban_var_run_t:dir rw_dir_perms;
files_pid_filetrans(fail2ban_t,fail2ban_var_run_t, file)

corecmd_search_sbin(fail2ban_t)
corecmd_exec_bin(fail2ban_t)
corecmd_exec_shell(fail2ban_t)

dev_read_urand(fail2ban_t)

files_read_usr_files(fail2ban_t)

logging_read_generic_logs(fail2ban_t)

optional_policy(`
	iptables_domtrans(fail2ban_t)
')

ifdef(`targeted_policy',`
	term_dontaudit_use_unallocated_ttys(fail2ban_t)
	term_dontaudit_use_generic_ptys(fail2ban_t)
')

--------------040107090905040200020102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
