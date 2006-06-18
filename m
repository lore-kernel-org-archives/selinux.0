Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5IGkoKE027459
	for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2006 12:46:51 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5IGkncr021904
	for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2006 16:46:50 GMT
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A78D4F11-9119-48FD-B62A-FE748DBD9BA2@sf-net.com>
From: Stefan <stefan@sf-net.com>
Subject: policy problems with run_init?
Date: Sun, 18 Jun 2006 18:46:43 +0200
To: SE-Linux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I tried to create a policy for the 3ware controlling daemon tdm and  
went into some serious problems. The daemon loads fine after a reboot  
(enforcing mode is on). So I guess the policy is OK (it's a little  
bit hackisch because I tried to fix the problem with run_init, I will  
review the policy after this problem is solved). But when I try to  
restart the daemon via "run_init /etc/init.d/tdm restart" the script  
runs fine and says that everything is OK but the daemon is NOT loaded  
(enforcing or permissive mode). No AVC messages are generated. The  
strange problem is that when I'm in permissive mode and run the  
command "/etc/init.d/tdm restart" everything works quiet fine!
So I guess that there is a problem with "run_init" or my policy.  
Could anyone help me out? Any ideas?

I'm running Fedora Core 5 (latest updates) with the MLS policy.


Best regards,
Stefan


[tdm.fc]
/usr/sbin/3dm2		--	gen_context(system_u:object_r:tdm2_exec_t,s0)
/etc/3dm2(/.*)?			gen_context(system_u:object_r:tdm2_etc_t,s0)



[tdm.if]
interface(`tdm2_domtrans',`
	gen_requieres(`
		type tdm2_t, tdm2_exec_t;
	')

	domain_auto_trans($1,tdm2_exec_t,tdm2_t)

	allow $1 tdm2_t:fd use;
	allow tdm2_t $1:fd use;
	allow tdm2_t $1:fifo_file rw_file_perms;
	allow tdm2_t $1:process sigchld;
')



[tdm.te]

policy_module(tdm2,1.0.0)

########################################
#
# Declarations
#

type tdm2_t;
type tdm2_exec_t;
domain_type(tdm2_t)
init_daemon_domain(tdm2_t, tdm2_exec_t)

type tdm2_etc_t;
files_config_file(tdm2_etc_t)

########################################
#
# Local policy
#

allow tdm2_t tdm2_etc_t:dir search;
allow tdm2_t tdm2_etc_t:file { getattr read write };

files_read_etc_files(tdm2_t)

kernel_read_kernel_sysctls(tdm2_t)

dev_read_sysfs(tdm2_t)

allow tdm2_t self:process { execmem };

allow tdm2_t proc_t:file { getattr read };

allow tdm2_t device_t:chr_file getattr;

libs_use_ld_so(tdm2_t)
libs_use_shared_libs(tdm2_t)
miscfiles_read_localization(tdm2_t)
## internal communication is often done using fifo and unix sockets.
allow tdm2_t self:fifo_file { read write };
allow tdm2_t self:unix_stream_socket create_stream_socket_perms;

## Networking basics (adjust to your needs!)
sysnet_dns_name_resolve(tdm2_t)
corenet_tcp_sendrecv_all_if(tdm2_t)
corenet_tcp_sendrecv_all_nodes(tdm2_t)
corenet_tcp_sendrecv_all_ports(tdm2_t)
corenet_non_ipsec_sendrecv(tdm2_t)
#corenet_tcp_connect_http_port(tdm2_t)
corenet_tcp_connect_all_ports(tdm2_t)
## if it is a network daemon, consider these:
corenet_tcp_bind_all_ports(tdm2_t)
corenet_tcp_bind_all_nodes(tdm2_t)
allow tdm2_t self:tcp_socket { listen accept };

# Init script handling
init_use_fds(tdm2_t)
init_use_script_ptys(tdm2_t)
domain_use_interactive_fds(tdm2_t)

gen_require(`
	type console_device_t;
	type device_t;
')
allow tdm2_t console_device_t:chr_file { read write };
allow tdm2_t device_t:chr_file { create ioctl read unlink write };
allow tdm2_t device_t:dir { add_name remove_name write };
allow tdm2_t self:capability mknod;
allow tdm2_t self:process signal;

gen_require(`
	type urandom_device_t;
')
allow tdm2_t urandom_device_t:chr_file { getattr read };
#allow tdm2_t var_log_t:dir search;
#allow tdm2_t var_log_t:file { getattr read };



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
