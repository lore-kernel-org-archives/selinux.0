Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB7DWUh0029791
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2011 08:32:30 -0500
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pB7DWTHL006661
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2011 13:32:29 GMT
Message-ID: <4EDF6AEC.1070606@tresys.com>
Date: Wed, 7 Dec 2011 08:32:28 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: CIL/SELinux Userspace Integration
References: <1322929819.82046.YahooMailClassic@web87016.mail.ird.yahoo.com>
In-Reply-To: <1322929819.82046.YahooMailClassic@web87016.mail.ird.yahoo.com>
Content-Type: multipart/mixed;
	boundary="------------080803060709070808010707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------080803060709070808010707
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2011 11:30 AM, Richard Haines wrote:
> Steve,
>
> Thanks for this, it seems to work fine with the policy samples I've been
> using. I've had a couple of minor problems though:
>
> 1) A macro does not work with permissionset as one of the parameters (all
>     the other parameters worked okay).
>

Thanks for finding this. Just pushed a commit that fixes this.

> 2) Macro comments are not permitted. I notice they are not present in the
>     test files so has it been dropped.
>

Yep. Macro comments have been dropped. I've updated it on the wiki.

> 3) I could not find a way to generate the policy.conf file. I set the
>     DEBUG=1 in the CIL Makefile like I used to but no file.
>

In selinux userspace, make DEBUG=1 doesn't define the DEBUG macro that 
the CIL code uses to enable debugging. You'll have to add '-DDEBUG' to 
the CFLAGS in the userspace Makefile to enable building of the 
policy.conf file.

> 4) To set deny_unknown in secilc.c required a 'U' in the getopt line:
>           getopt_long(argc, argv, "hvtU:MDc:", .....
>

Thanks, fixed and pushed.

> 5) I could not load a new policy that had a boolean and supporting
>     statements in it. The actual binary policy was fine (using apol), but
>     load_policy had problems. I started with a Fedora 16 base and added
>     the new Integration code with no problems. Is it a known problem as
>     if not I'll check further.
>     The errors I had when running semodule with a boolean were (Note: I
>     had already built a new base policy (SELINUXTYPE=rch-test1) with no
>     problems):

Hmmm, this is interesting. Both seinfo and apol are fine with my 
CIL-generated binary, but fails to load when I add booleans. I also 
generated a similar mdp policy.conf, ran checkpolicy, and that failed to 
load as well. sediff also shows the two binaries to be the same.

I'll look into this more, but because of that, I'm thinking this is a 
kernel bug. If anyone else wants to look at it, I've attached a simple 
file that is the standard mdp.conf with a single boolean defined, and 
single conditional statement using that boolean. This builds a binary 
fine, and apol/seinfo have no problem with it, but fails to load with 
load_policy.

>
>                        ------ Start --------------
> # semodule -i base.cil ext_gateway.cil int_gateway.cil move_file.cil
>
> SELinux:  Could not load policy file /etc/selinux/rch-test1/policy/policy.26:  No such file or directory
> /sbin/load_policy:  Can't load policy:  No such file or directory
> libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
> SELinux:  Could not load policy file /etc/selinux/rch-test1/policy/policy.26:  No such file or directory
> /sbin/load_policy:  Can't load policy:  No such file or directory
> libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
> semodule:  Failed!
>                      ----- End -----------------
>
> Richard
>
>
> --- On Tue, 22/11/11, Steve Lawrence<slawrence@tresys.com>  wrote:
>
>> From: Steve Lawrence<slawrence@tresys.com>
>> Subject: CIL/SELinux Userspace Integration
>> To: "SELinux"<selinux@tycho.nsa.gov>
>> Date: Tuesday, 22 November, 2011, 22:00
>> As many of you may know, we have been
>> working on CIL for a while now.
>> This has been posted to the list many times before, so
>> we'll just post
>> the link to the wiki for now [1], but we're happy to answer
>> any questions.
>>
>> In addition to adding numerous features to CIL since we've
>> last posted
>> to the list, we've also been working hard at integrating
>> CIL
>> into SELinux userspace. We now have that in a state that's
>> ready for
>> comments and review.
>
>


--------------080803060709070808010707
Content-Type: text/plain; name="mdp-bool.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mdp-bool.conf"

class security
class process
class system
class capability
class filesystem
class file
class dir
class fd
class lnk_file
class chr_file
class blk_file
class sock_file
class fifo_file
class socket
class tcp_socket
class udp_socket
class rawip_socket
class node
class netif
class netlink_socket
class packet_socket
class key_socket
class unix_stream_socket
class unix_dgram_socket
class sem
class msg
class msgq
class shm
class ipc
class netlink_route_socket
class netlink_firewall_socket
class netlink_tcpdiag_socket
class netlink_nflog_socket
class netlink_xfrm_socket
class netlink_selinux_socket
class netlink_audit_socket
class netlink_ip6fw_socket
class netlink_dnrt_socket
class association
class netlink_kobject_uevent_socket
class appletalk_socket
class packet
class key
class dccp_socket
class memprotect
class peer
class capability2
class kernel_service
class tun_socket

sid kernel
sid security
sid unlabeled
sid fs
sid file
sid file_labels
sid init
sid any_socket
sid port
sid netif
sid netmsg
sid node
sid igmp_packet
sid icmp_socket
sid tcp_socket
sid sysctl_modprobe
sid sysctl
sid sysctl_fs
sid sysctl_kernel
sid sysctl_net
sid sysctl_net_unix
sid sysctl_vm
sid sysctl_dev
sid kmod
sid policy
sid scmp_packet
sid devnull

class security
{
	compute_av
	compute_create
	compute_member
	check_context
	load_policy
	compute_relabel
	compute_user
	setenforce
	setbool
	setsecparam
	setcheckreqprot
	read_policy
}

class process
{
	fork
	transition
	sigchld
	sigkill
	sigstop
	signull
	signal
	ptrace
	getsched
	setsched
	getsession
	getpgid
	setpgid
	getcap
	setcap
	share
	getattr
	setexec
	setfscreate
	noatsecure
	siginh
	setrlimit
	rlimitinh
	dyntransition
	setcurrent
	execmem
	execstack
	execheap
	setkeycreate
	setsockcreate
}

class system
{
	ipc_info
	syslog_read
	syslog_mod
	syslog_console
	module_request
}

class capability
{
	chown
	dac_override
	dac_read_search
	fowner
	fsetid
	kill
	setgid
	setuid
	setpcap
	linux_immutable
	net_bind_service
	net_broadcast
	net_admin
	net_raw
	ipc_lock
	ipc_owner
	sys_module
	sys_rawio
	sys_chroot
	sys_ptrace
	sys_pacct
	sys_admin
	sys_boot
	sys_nice
	sys_resource
	sys_time
	sys_tty_config
	mknod
	lease
	audit_write
	audit_control
	setfcap
}

class filesystem
{
	mount
	remount
	unmount
	getattr
	relabelfrom
	relabelto
	transition
	associate
	quotamod
	quotaget
}

class file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
	execute_no_trans
	entrypoint
}

class dir
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
	add_name
	remove_name
	reparent
	search
	rmdir
}

class fd
{
	use
}

class lnk_file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
}

class chr_file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
}

class blk_file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
}

class sock_file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
}

class fifo_file
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	unlink
	link
	rename
	execute
	swapon
	quotaon
	mounton
	audit_access
	open
	execmod
}

class socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class tcp_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	connectto
	newconn
	acceptfrom
	node_bind
	name_connect
}

class udp_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	node_bind
}

class rawip_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	node_bind
}

class node
{
	tcp_recv
	tcp_send
	udp_recv
	udp_send
	rawip_recv
	rawip_send
	enforce_dest
	dccp_recv
	dccp_send
	recvfrom
	sendto
}

class netif
{
	tcp_recv
	tcp_send
	udp_recv
	udp_send
	rawip_recv
	rawip_send
	dccp_recv
	dccp_send
	ingress
	egress
}

class netlink_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class packet_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class key_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class unix_stream_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	connectto
	newconn
	acceptfrom
}

class unix_dgram_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class sem
{
	create
	destroy
	getattr
	setattr
	read
	write
	associate
	unix_read
	unix_write
}

class msg
{
	send
	receive
}

class msgq
{
	create
	destroy
	getattr
	setattr
	read
	write
	associate
	unix_read
	unix_write
	enqueue
}

class shm
{
	create
	destroy
	getattr
	setattr
	read
	write
	associate
	unix_read
	unix_write
	lock
}

class ipc
{
	create
	destroy
	getattr
	setattr
	read
	write
	associate
	unix_read
	unix_write
}

class netlink_route_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	nlmsg_read
	nlmsg_write
}

class netlink_firewall_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	nlmsg_read
	nlmsg_write
}

class netlink_tcpdiag_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	nlmsg_read
	nlmsg_write
}

class netlink_nflog_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class netlink_xfrm_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	nlmsg_read
	nlmsg_write
}

class netlink_selinux_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class netlink_audit_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	nlmsg_read
	nlmsg_write
	nlmsg_relay
	nlmsg_readpriv
	nlmsg_tty_audit
}

class netlink_ip6fw_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	nlmsg_read
	nlmsg_write
}

class netlink_dnrt_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class association
{
	sendto
	recvfrom
	setcontext
	polmatch
}

class netlink_kobject_uevent_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class appletalk_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

class packet
{
	send
	recv
	relabelto
	forward_in
	forward_out
}

class key
{
	view
	read
	write
	search
	link
	setattr
	create
}

class dccp_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
	node_bind
	name_connect
}

class memprotect
{
	mmap_zero
}

class peer
{
	recv
}

class capability2
{
	mac_override
	mac_admin
	syslog
}

class kernel_service
{
	use_as_override
	create_files_as
}

class tun_socket
{
	ioctl
	read
	write
	create
	getattr
	setattr
	lock
	relabelfrom
	relabelto
	append
	bind
	connect
	listen
	accept
	getopt
	setopt
	shutdown
	recvfrom
	sendto
	recv_msg
	send_msg
	name_bind
}

type base_t;

role base_r;
role base_r types { base_t };

bool cond true;

if (cond) {
	allow base_t base_t : file *;
}

allow base_t base_t : security *;
allow base_t base_t : process *;
allow base_t base_t : system *;
allow base_t base_t : capability *;
allow base_t base_t : filesystem *;
allow base_t base_t : dir *;
allow base_t base_t : fd *;
allow base_t base_t : lnk_file *;
allow base_t base_t : chr_file *;
allow base_t base_t : blk_file *;
allow base_t base_t : sock_file *;
allow base_t base_t : fifo_file *;
allow base_t base_t : socket *;
allow base_t base_t : tcp_socket *;
allow base_t base_t : udp_socket *;
allow base_t base_t : rawip_socket *;
allow base_t base_t : node *;
allow base_t base_t : netif *;
allow base_t base_t : netlink_socket *;
allow base_t base_t : packet_socket *;
allow base_t base_t : key_socket *;
allow base_t base_t : unix_stream_socket *;
allow base_t base_t : unix_dgram_socket *;
allow base_t base_t : sem *;
allow base_t base_t : msg *;
allow base_t base_t : msgq *;
allow base_t base_t : shm *;
allow base_t base_t : ipc *;
allow base_t base_t : netlink_route_socket *;
allow base_t base_t : netlink_firewall_socket *;
allow base_t base_t : netlink_tcpdiag_socket *;
allow base_t base_t : netlink_nflog_socket *;
allow base_t base_t : netlink_xfrm_socket *;
allow base_t base_t : netlink_selinux_socket *;
allow base_t base_t : netlink_audit_socket *;
allow base_t base_t : netlink_ip6fw_socket *;
allow base_t base_t : netlink_dnrt_socket *;
allow base_t base_t : association *;
allow base_t base_t : netlink_kobject_uevent_socket *;
allow base_t base_t : appletalk_socket *;
allow base_t base_t : packet *;
allow base_t base_t : key *;
allow base_t base_t : dccp_socket *;
allow base_t base_t : memprotect *;
allow base_t base_t : peer *;
allow base_t base_t : capability2 *;
allow base_t base_t : kernel_service *;
allow base_t base_t : tun_socket *;

user user_u roles { base_r };

sid kernel user_u:base_r:base_t
sid security user_u:base_r:base_t
sid unlabeled user_u:base_r:base_t
sid fs user_u:base_r:base_t
sid file user_u:base_r:base_t
sid file_labels user_u:base_r:base_t
sid init user_u:base_r:base_t
sid any_socket user_u:base_r:base_t
sid port user_u:base_r:base_t
sid netif user_u:base_r:base_t
sid netmsg user_u:base_r:base_t
sid node user_u:base_r:base_t
sid igmp_packet user_u:base_r:base_t
sid icmp_socket user_u:base_r:base_t
sid tcp_socket user_u:base_r:base_t
sid sysctl_modprobe user_u:base_r:base_t
sid sysctl user_u:base_r:base_t
sid sysctl_fs user_u:base_r:base_t
sid sysctl_kernel user_u:base_r:base_t
sid sysctl_net user_u:base_r:base_t
sid sysctl_net_unix user_u:base_r:base_t
sid sysctl_vm user_u:base_r:base_t
sid sysctl_dev user_u:base_r:base_t
sid kmod user_u:base_r:base_t
sid policy user_u:base_r:base_t
sid scmp_packet user_u:base_r:base_t
sid devnull user_u:base_r:base_t

fs_use_xattr ext2 user_u:base_r:base_t;
fs_use_xattr ext3 user_u:base_r:base_t;
fs_use_xattr ext4 user_u:base_r:base_t;
fs_use_xattr jfs user_u:base_r:base_t;
fs_use_xattr xfs user_u:base_r:base_t;
fs_use_xattr reiserfs user_u:base_r:base_t;
fs_use_xattr jffs2 user_u:base_r:base_t;
fs_use_xattr gfs2 user_u:base_r:base_t;
fs_use_xattr lustre user_u:base_r:base_t;

fs_use_task eventpollfs user_u:base_r:base_t;
fs_use_task pipefs user_u:base_r:base_t;
fs_use_task sockfs user_u:base_r:base_t;

fs_use_trans mqueue user_u:base_r:base_t;
fs_use_trans devpts user_u:base_r:base_t;
fs_use_trans hugetlbfs user_u:base_r:base_t;
fs_use_trans tmpfs user_u:base_r:base_t;
fs_use_trans shm user_u:base_r:base_t;

genfscon proc / user_u:base_r:base_t


--------------080803060709070808010707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
