Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5289seJ029000
	for <selinux@tycho.nsa.gov>; Tue, 2 Jun 2009 04:09:54 -0400
Received: from smtp2.bt.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5289jU7010231
	for <selinux@tycho.nsa.gov>; Tue, 2 Jun 2009 08:09:46 GMT
Received: from host81-146-55-25.btremoteinternet-dsl.bt.net ([81.146.55.25] helo=victor.cwb.uk)
	by insmtp21 with esmtp (Exim 4.50)
	id 1MBP4A-0002fZ-Ll
	for selinux@tycho.nsa.gov; Tue, 02 Jun 2009 09:09:51 +0100
Message-ID: <4A24DE4E.80003@btconnect.com>
Date: Tue, 02 Jun 2009 09:09:50 +0100
From: Nigel Rumens <wooky@btconnect.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: A little more sctp and selinux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just for information this is a first attempt (using standard 
system-config-selinux and audit2allow) at creating a policy for feng 
streaming server that will allow it to use sctp, as well as tcp and udp.

When I get a little time I will try again probably with SLIDE (when I 
get it installed) as it could probably do with some improvements. But it 
does actually work and allow me to stream over sctp.

Any comments/suggestions welcome

Nigel

feng.te
policy_module(feng,1.0.0)

########################################
#
# Declarations
#

type feng_t;
type feng_exec_t;
init_daemon_domain(feng_t, feng_exec_t)

permissive feng_t;

type feng_initrc_exec_t;
init_script_file(feng_initrc_exec_t)

type feng_rw_t;
files_type(feng_rw_t)

########################################
#
# feng local policy
#

# Init script handling
domain_use_interactive_fds(feng_t)

# internal communication is often done using fifo and unix sockets.
allow feng_t self:fifo_file rw_file_perms;
allow feng_t self:unix_stream_socket create_stream_socket_perms;

files_read_etc_files(feng_t)

miscfiles_read_localization(feng_t)


allow feng_t feng_rw_t:file manage_file_perms;
allow feng_t feng_rw_t:dir create_dir_perms;

sysnet_dns_name_resolve(feng_t)
corenet_all_recvfrom_unlabeled(feng_t)

allow feng_t self:tcp_socket create_stream_socket_perms;
corenet_tcp_sendrecv_all_if(feng_t)
corenet_tcp_sendrecv_all_nodes(feng_t)
corenet_tcp_sendrecv_all_ports(feng_t)
corenet_tcp_bind_all_nodes(feng_t)
corenet_tcp_bind_all_ports(feng_t)
corenet_tcp_connect_all_ports(feng_t)

allow feng_t self:udp_socket { create_socket_perms listen };
corenet_udp_sendrecv_all_if(feng_t)
corenet_udp_sendrecv_all_nodes(feng_t)
corenet_udp_sendrecv_all_ports(feng_t)
corenet_udp_bind_all_nodes(feng_t)
corenet_udp_bind_all_unreserved_ports(feng_t)


require {
         type feng_t;
         type port_t;
         class process { execstack execmem getsched };
         class capability { setuid setgid };
         class rawip_socket { name_bind getattr setopt bind create listen };
}

#============= feng_t ==============
allow feng_t port_t:rawip_socket name_bind;
allow feng_t self:capability { setuid setgid };
allow feng_t self:process { execstack execmem getsched };
allow feng_t self:rawip_socket { getattr bind create setopt listen };
corenet_raw_bind_generic_node(feng_t)
files_manage_usr_files(feng_t)
fs_rw_anon_inodefs_files(feng_t)

require {
         type unlabeled_t;
         type feng_t;
         type feng_rw_t;
         type port_t;
         class process { execstack execmem getsched };
         class capability { setuid setgid };
         class unix_dgram_socket { write read create sendto };
         class dir search;
         class rawip_socket { name_bind setopt read bind create accept 
write getattr listen };
}

#============= feng_t ==============
allow feng_t feng_rw_t:dir search;
allow feng_t port_t:rawip_socket name_bind;
allow feng_t self:capability { setuid setgid };
allow feng_t self:process { execstack execmem getsched };
allow feng_t self:rawip_socket { getattr setopt bind create accept listen };
allow feng_t self:unix_dgram_socket { write read create sendto };
allow feng_t unlabeled_t:rawip_socket { read write getattr };
corenet_raw_bind_generic_node(feng_t)
dev_read_urand(feng_t)
files_manage_usr_files(feng_t)
fs_rw_anon_inodefs_files(feng_t)

require {
         type feng_rw_t;
         type feng_t;
         class lnk_file read;
}

#============= feng_t ==============
allow feng_t feng_rw_t:lnk_file read;
apache_read_sys_content(feng_t)
apache_search_sys_content(feng_t)
kernel_read_system_state(feng_t)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
