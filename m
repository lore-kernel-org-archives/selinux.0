From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: selinux@tycho.nsa.gov
Subject: [1/4] Labeling only policy for fireflier
Date: Mon, 1 May 2006 19:17:54 +0300
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604262113.01211.edwin@gurde.com> <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605011917.54954.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
[I have split this mail in several parts for easier reading.]

I have create a stripped down policy for use with fireflier. 
(for those who didn't read the entire thread: the purpose of this policy is to 
provide labels for sockets, to be used with skfilter/secmark)

This policy doesn't intend to protect from the actions of root (since as 
Stephen Smalley suggested that would eventually lead me closer to the strict 
policy).

So I made many types aliases, but I left the flask classess, initial sids, 
genfs intact.

If a user is not root is he able to override the security context of a 
process/file/socket? (relabel, or otherwise change context)

Furthermore, if a user is not root, load_policy/restorecon/setfiles won't 
function, am I right? Even if the user recompiles them (to remove any uid==0 
checks)?

I've also seen a capability named dac_override, it is needed when root needs 
to override dac (creating a file in the user's home directory, for example), 
but a user can't gain that capability, right? (IOW if DAC denies something, 
selinux won't allow it either)

So if I intend to provide no protection from root, I could use an even simpler 
base policy?

fireflier_base.conf:
-----------
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
class passwd			# userspace
class drawable			# userspace
class window			# userspace
class gc			# userspace
class font			# userspace
class colormap			# userspace
class property			# userspace
class cursor			# userspace
class xclient			# userspace
class xinput			# userspace
class xserver			# userspace
class xextension		# userspace
class pax
class netlink_route_socket
class netlink_firewall_socket
class netlink_tcpdiag_socket
class netlink_nflog_socket
class netlink_xfrm_socket
class netlink_selinux_socket
class netlink_audit_socket
class netlink_ip6fw_socket
class netlink_dnrt_socket
class dbus			# userspace
class nscd			# userspace
class association
class netlink_kobject_uevent_socket
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
common file
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
}
common socket
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
common ipc
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
class dir
inherits file
{
	add_name
	remove_name
	reparent
	search
	rmdir
}
class file
inherits file
{
	execute_no_trans
	entrypoint
	execmod
}
class lnk_file
inherits file
class chr_file
inherits file
{
	execute_no_trans
	entrypoint
	execmod
}
class blk_file
inherits file
class sock_file
inherits file
class fifo_file
inherits file
class fd
{
	use
}
class socket
inherits socket
class tcp_socket
inherits socket
{
	connectto
	newconn
	acceptfrom
	node_bind
	name_connect
}
class udp_socket
inherits socket
{
	node_bind
}
class rawip_socket
inherits socket
{
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
}
class netif
{
	tcp_recv
	tcp_send
	udp_recv
	udp_send
	rawip_recv
	rawip_send
}
class netlink_socket
inherits socket
class packet_socket
inherits socket
class key_socket
inherits socket
class unix_stream_socket
inherits socket
{
	connectto
	newconn
	acceptfrom
}
class unix_dgram_socket
inherits socket
class process
{
	fork
	transition
	sigchld # commonly granted from child to parent
	sigkill # cannot be caught or ignored
	sigstop # cannot be caught or ignored
	signull # for kill(pid, 0)
	signal  # all other signals
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
}
class ipc
inherits ipc
class sem
inherits ipc
class msgq
inherits ipc
{
	enqueue
}
class msg
{
	send
	receive
}
class shm
inherits ipc
{
	lock
}
class security
{
	compute_av
	compute_create
	compute_member
	check_context
	load_policy
	compute_relabel
	compute_user
	setenforce     # was avc_toggle in system class
	setbool
	setsecparam
	setcheckreqprot
}
class system
{
	ipc_info
	syslog_read  
	syslog_mod
	syslog_console
}
class capability
{
	# The capabilities are defined in include/linux/capability.h
	# Care should be taken to ensure that these are consistent with
	# those definitions. (Order matters)
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
}
class passwd
{
	passwd	# change another user passwd
	chfn	# change another user finger info
	chsh	# change another user shell
	rootok  # pam_rootok check (skip auth)
	crontab # crontab on another user
}
class drawable
{
	create
	destroy
	draw
	copy
	getattr
}
class gc
{
	create
	free
	getattr
	setattr
}
class window 
{
	addchild
	create
	destroy
	map
	unmap
	chstack
	chproplist
	chprop	
	listprop
	getattr
	setattr
	setfocus
	move
	chselection
	chparent
	ctrllife
	enumerate
	transparent
	mousemotion
	clientcomevent
	inputevent
	drawevent
	windowchangeevent
	windowchangerequest
	serverchangeevent
	extensionevent
}
class font
{
	load
	free
	getattr
	use
}
class colormap
{
	create
	free
	install
	uninstall
	list
	read
	store
	getattr
	setattr
}
class property
{
	create
	free
	read
	write
}
class cursor
{
	create
	createglyph
	free
	assign
	setattr
}
class xclient
{
	kill
}
class xinput
{
	lookup
	getattr
	setattr
	setfocus
	warppointer
	activegrab
	passivegrab
	ungrab
	bell
	mousemotion
	relabelinput
}
class xserver
{
	screensaver
	gethostlist
	sethostlist
	getfontpath
	setfontpath
	getattr
	grab
	ungrab
}
class xextension
{
	query
	use
}
class pax
{
	pageexec	# Paging based non-executable pages
	emutramp	# Emulate trampolines
	mprotect	# Restrict mprotect()
	randmmap	# Randomize mmap() base
	randexec	# Randomize ET_EXEC base
	segmexec	# Segmentation based non-executable pages
}
class netlink_route_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}
class netlink_firewall_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}
class netlink_tcpdiag_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}
class netlink_nflog_socket
inherits socket
class netlink_xfrm_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}
class netlink_selinux_socket
inherits socket
class netlink_audit_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
	nlmsg_relay
	nlmsg_readpriv
}
class netlink_ip6fw_socket
inherits socket
{
	nlmsg_read
	nlmsg_write
}
class netlink_dnrt_socket
inherits socket
class dbus
{
	acquire_svc
	send_msg
}
class nscd
{
	getpwd
	getgrp
	gethost
	getstat
	admin
	shmempwd
	shmemgrp
	shmemhost
}
class association
{
	sendto
	recvfrom
	setcontext
}
class netlink_kobject_uevent_socket
inherits socket
 # 8118 is for privoxy
attribute device_node;
attribute memory_raw_read;
attribute memory_raw_write;
attribute domain;
attribute unconfined_domain_type;
attribute set_curr_context;
attribute entry_type;
attribute privfd;
attribute can_change_process_identity;
attribute can_change_process_role;
attribute can_change_object_identity;
attribute can_system_change;
attribute process_user_target;
attribute cron_source_domain;
attribute cron_job_domain;
attribute process_uncond_exempt;	# add userhelperdomain to this one
attribute file_type;
attribute lockfile;
attribute mountpoint;
attribute pidfile;
attribute polydir;
attribute usercanread;
attribute polyparent;
attribute polymember;
attribute security_file_type;
attribute tmpfile;
attribute tmpfsfile;
attribute filesystem_type;
attribute noxattrfs;
attribute can_load_kernmodule;
attribute can_receive_kernel_messages;
attribute kern_unconfined;
attribute proc_type;
attribute sysctl_type;
attribute mcskillall;
attribute mlsfileread;
attribute mlsfilereadtoclr;
attribute mlsfilewrite;
attribute mlsfilewritetoclr;
attribute mlsfileupgrade;
attribute mlsfiledowngrade;
attribute mlsnetread;
attribute mlsnetreadtoclr;
attribute mlsnetwrite;
attribute mlsnetwritetoclr;
attribute mlsnetupgrade;
attribute mlsnetdowngrade;
attribute mlsnetrecvall;
attribute mlsipcread;
attribute mlsipcreadtoclr;
attribute mlsipcwrite;
attribute mlsipcwritetoclr;
attribute mlsprocread;
attribute mlsprocreadtoclr;
attribute mlsprocwrite;
attribute mlsprocwritetoclr;
attribute mlsprocsetsl;
attribute mlsxwinread;
attribute mlsxwinreadtoclr;
attribute mlsxwinwrite;
attribute mlsxwinwritetoclr;
attribute mlsxwinreadproperty;
attribute mlsxwinwriteproperty;
attribute mlsxwinreadcolormap;
attribute mlsxwinwritecolormap;
attribute mlsxwinwritexinput;
attribute mlstrustedobject;
attribute privrangetrans;
attribute mlsrangetrans;
attribute can_load_policy;
attribute can_setenforce;
attribute can_setsecparam;
attribute ttynode;
attribute ptynode;
attribute server_ptynode;
attribute serial_device;
attribute netif_type;
attribute node_type;
attribute port_type;
attribute reserved_port_type;

type selinux_config_t;
type init_t,domain;
type unconfined_t,domain;
type file_t alias {bin_t sbin_t}, file_type;
type default_t, file_type,mountpoint,filesystem_type;
type device_t alias {mtrr_device_t null_device_t bdev_t console_device_t 
zero_device_t devtty_t}, device_node;
type fs_t alias {sysfs_t usbfs_t usbdevfs_t debugfs_t root_t binfmt_misc_fs_t 
capifs_t configfs_t eventpollfs_t futexfs_t hugetlbfs_t inotifyfs_t nfsd_fs_t 
ramfs_t romfs_t rpc_pipefs_t autofs_t cifs_t dosfs_t iso9660_t nfs_t tmpfs_t 
devpts_t}, file_type,filesystem_type;
type kernel_t, can_load_kernmodule, file_type;
type proc_t alias {proc_mdstat_t proc_net_t} , proc_type, file_type;
type proc_kmsg_t , proc_type,file_type;
type proc_kcore_t, proc_type,file_type;
type sysctl_t alias {sysctl_irq_t sysctl_rpc_t sysctl_fs_t sysctl_kernel_t 
sysctl_modprobe_t sysctl_hotplug_t sysctl_net_t sysctl_net_unix_t sysctl_vm_t 
sysctl_dev_t}, sysctl_type,file_type;
type unlabeled_t;
type security_t,file_type;
type port_t, port_type,file_type;
type node_t, node_type,file_type;
type netif_t, netif_type,file_type;

bool secure_mode false;
bool secure_mode_insmod false;
bool secure_mode_policyload false;

typeattribute kernel_t can_change_process_identity;

allow device_t tmpfs_t:filesystem associate;
allow device_t fs_t:filesystem associate;
allow device_t noxattrfs:filesystem associate;


allow kernel_t file_t:dir mounton;
allow kernel_t root_t:dir mounton;
allow kernel_t self:dir { read getattr lock search ioctl };
allow kernel_t self:lnk_file { read getattr lock ioctl };
allow kernel_t self:file { getattr read write append ioctl lock };
# allow kernel_t to create child processes in this domain
allow kernel_t self:process { fork sigchld };
allow kernel_t self:capability *;
allow kernel_t unlabeled_t:dir mounton;
allow kernel_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit 
execmem execstack execheap };
allow kernel_t self:shm { associate getattr setattr create destroy read write 
lock unix_read unix_write };
allow kernel_t self:sem { associate getattr setattr create destroy read write 
unix_read unix_write };
allow kernel_t self:msg { send receive };
allow kernel_t self:msgq { associate getattr setattr create destroy read write 
enqueue unix_read unix_write };
allow kernel_t self:unix_dgram_socket { create { ioctl read getattr write 
setattr append bind connect getopt setopt shutdown } };
allow kernel_t self:unix_stream_socket { { create { ioctl read getattr write 
setattr append bind connect getopt setopt shutdown } } listen accept };
allow kernel_t self:unix_dgram_socket sendto;
allow kernel_t self:unix_stream_socket connectto;
allow kernel_t self:fifo_file { getattr read write append ioctl lock };
allow kernel_t self:sock_file { read getattr lock ioctl };
allow kernel_t self:fd use;
allow kernel_t proc_t:dir { read getattr lock search ioctl };
allow kernel_t proc_t:{ lnk_file file } { read getattr lock ioctl };
allow kernel_t proc_net_t:dir { read getattr lock search ioctl };
allow kernel_t proc_net_t:file { read getattr lock ioctl };
allow kernel_t proc_mdstat_t:file { read getattr lock ioctl };
allow kernel_t proc_kcore_t:file getattr;
allow kernel_t proc_kmsg_t:file getattr;
allow kernel_t sysctl_t:dir { read getattr lock search ioctl };
allow kernel_t sysctl_kernel_t:dir { read getattr lock search ioctl };
allow kernel_t sysctl_kernel_t:file { read getattr lock ioctl };
allow kernel_t unlabeled_t:fifo_file { getattr read write append ioctl lock };
allow kernel_t unlabeled_t:association { sendto recvfrom };
allow kernel_t netif_type:netif rawip_send;
#allow kernel_t self:capability net_raw;
allow kernel_t netif_type:netif rawip_recv;
allow kernel_t node_type:node rawip_send;
allow kernel_t node_type:node rawip_recv;
allow kernel_t netif_t:netif rawip_send;
#allow kernel_t self:capability net_raw;
allow kernel_t netif_type:netif { tcp_send tcp_recv };
allow kernel_t node_type:node { tcp_send tcp_recv };
allow kernel_t node_t:node rawip_send;
allow kernel_t sysfs_t:dir { read getattr lock search ioctl };
allow kernel_t sysfs_t:{ file lnk_file } { read getattr lock ioctl };
allow kernel_t usbfs_t:dir search;
allow kernel_t filesystem_type:filesystem mount;
allow kernel_t security_t:dir { read search getattr };
allow kernel_t security_t:file { getattr read write };
allow kernel_t security_t:security load_policy;
auditallow kernel_t security_t:security load_policy;
allow kernel_t device_t:dir { read getattr lock search ioctl };
allow kernel_t device_t:lnk_file { getattr read };
allow kernel_t console_device_t:chr_file { getattr read write append ioctl 
lock };
allow kernel_t bin_t:dir { read getattr lock search ioctl };
allow kernel_t bin_t:lnk_file { read getattr lock ioctl };
allow kernel_t sbin_t:dir { read getattr lock search ioctl };
allow kernel_t bin_t:dir { read getattr lock search ioctl };
allow kernel_t bin_t:lnk_file { read getattr lock ioctl };
allow kernel_t bin_t:file { { read getattr lock execute ioctl } 
execute_no_trans };
allow kernel_t domain:process signal;
allow kernel_t proc_t:dir search;
allow kernel_t domain:dir search;
allow kernel_t root_t:dir { read getattr lock search ioctl };
allow kernel_t root_t:lnk_file { read getattr lock ioctl };
allow kernel_t self:capability *;
allow kernel_t self:fifo_file { create ioctl read getattr lock write setattr 
append link unlink rename };
allow kernel_t self:process transition;
allow kernel_t self:file { getattr read write append ioctl lock };
allow kernel_t self:nscd *;
allow kernel_t self:dbus *;
allow kernel_t self:passwd *;
allow kernel_t proc_type:{ dir file } *;
allow kernel_t sysctl_t:{ dir file } *;
allow kernel_t kernel_t:system *;
allow kernel_t unlabeled_t:{ dir file lnk_file sock_file fifo_file chr_file 
blk_file } *;
allow kernel_t unlabeled_t:filesystem *;
allow kernel_t unlabeled_t:association *;
allow kernel_t { proc_t proc_net_t }:dir search;
allow kernel_t sysctl_type:dir { read getattr lock search ioctl };
allow kernel_t sysctl_type:file { { getattr read write append ioctl lock } 
setattr };
allow kernel_t node_type:node *;
allow kernel_t netif_type:netif *;
allow kernel_t port_type:tcp_socket { send_msg recv_msg name_connect };
allow kernel_t port_type:udp_socket { send_msg recv_msg };
allow kernel_t port_type:{ tcp_socket udp_socket rawip_socket } name_bind;
allow kernel_t node_type:{ tcp_socket udp_socket rawip_socket } node_bind;
allow kernel_t unlabeled_t:association { sendto recvfrom };
allow kernel_t device_node:{ chr_file blk_file } *;
allow kernel_t mtrr_device_t:{ dir file } *;
allow kernel_t self:capability sys_rawio;
allow kernel_t domain:{ { tcp_socket udp_socket rawip_socket netlink_socket 
packet_socket unix_stream_socket unix_dgram_socket netlink_route_socket 
netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket 
netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket 
netlink_ip6fw_socket netlink_dnrt_socket netlink_kobject_uevent_socket } 
socket key_socket } *;
allow kernel_t domain:fd use;
allow kernel_t domain:fifo_file { getattr read write append ioctl lock };
allow kernel_t domain:process ~{ transition dyntransition execmem execstack 
execheap };
allow kernel_t domain:{ sem msgq shm } *;
allow kernel_t domain:msg { send receive };
allow kernel_t domain:dir { read getattr lock search ioctl };
allow kernel_t domain:file { read getattr lock ioctl };
allow kernel_t domain:lnk_file { read getattr lock ioctl };
allow kernel_t file_type:{ file chr_file } ~execmod;
allow kernel_t file_type:{ dir lnk_file sock_file fifo_file blk_file } *;
allow kernel_t file_type:filesystem *;
allow kernel_t file_type:{ unix_stream_socket unix_dgram_socket } name_bind;
allow kernel_t file_type:file execmod;
allow kernel_t filesystem_type:filesystem *;
allow kernel_t filesystem_type:{ dir file lnk_file sock_file fifo_file 
chr_file blk_file } *;
allow kernel_t security_t:dir { getattr search read };
allow kernel_t security_t:file { getattr read write };
allow kernel_t security_t:security *;
auditallow kernel_t security_t:security { load_policy setenforce setbool };
allow kernel_t self:process execheap;
allow kernel_t self:process execmem;
allow kernel_t self:process execstack;
auditallow kernel_t self:process execstack;
auditallow kernel_t self:process execheap;
auditallow kernel_t self:process execmem;

allow kernel_t unlabeled_t:dir mounton;
allow kernel_t unlabeled_t:fifo_file { getattr read write append ioctl lock };
allow kernel_t unlabeled_t:association { sendto recvfrom };
allow kernel_t unlabeled_t:{ dir file lnk_file sock_file fifo_file chr_file 
blk_file } *;
allow kernel_t unlabeled_t:filesystem *;
allow kernel_t unlabeled_t:association *;
allow kernel_t unlabeled_t:association { sendto recvfrom };

allow kernel_t default_t:dir { read getattr lock search ioctl };
allow kernel_t default_t:file { read getattr lock ioctl };
allow kernel_t default_t:lnk_file { read getattr lock ioctl };
allow kernel_t default_t:sock_file { read getattr lock ioctl };
allow kernel_t default_t:fifo_file { read getattr lock ioctl };

allow file_type self:filesystem associate;
allow file_t fs_t:filesystem associate;
allow file_t noxattrfs:filesystem associate;

allow filesystem_type fs_t:filesystem associate;
allow filesystem_type noxattrfs:filesystem associate;

allow proc_t self:filesystem associate;

allow sysctl_t fs_t:filesystem associate;


allow unlabeled_t self:filesystem associate;

allow kernel_t security_t:dir { read search getattr };
allow kernel_t security_t:file { getattr read write };
typeattribute kernel_t can_load_policy;
if(!secure_mode_policyload) {
	allow kernel_t security_t:security load_policy;
	auditallow kernel_t security_t:security load_policy;
}
allow kernel_t security_t:dir { getattr search read };
allow kernel_t security_t:file { getattr read write };
typeattribute kernel_t can_load_policy, can_setenforce, can_setsecparam;
if(!secure_mode_policyload) {
	# Access the security API.
	allow kernel_t security_t:security *;
	auditallow kernel_t security_t:security { load_policy setenforce setbool };
}
typeattribute security_t filesystem_type;
allow security_t self:filesystem associate;
neverallow ~can_load_policy security_t:security load_policy;
neverallow ~can_load_kernmodule self:capability sys_module;
neverallow ~can_setenforce security_t:security setenforce;
neverallow ~can_setsecparam security_t:security setsecparam;


role system_r;
role user_r;
role system_r types kernel_t;
user system_u roles { system_r };
user user_u roles { user_r system_r };
user root roles { user_r system_r };

constrain process transition
	( u1 == u2
	or t1 == can_change_process_identity
);
constrain process transition 
	( r1 == r2
	or t1 == can_change_process_role
);
constrain process dyntransition
	( u1 == u2 and r1 == r2 );
constrain { dir file lnk_file sock_file fifo_file chr_file blk_file } { create 
relabelto relabelfrom } 
	( u1 == u2 or t1 == can_change_object_identity );
constrain { tcp_socket udp_socket rawip_socket netlink_socket packet_socket 
unix_stream_socket unix_dgram_socket netlink_route_socket 
netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket 
netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket 
netlink_ip6fw_socket netlink_dnrt_socket netlink_kobject_uevent_socket } { 
create relabelto relabelfrom } 
	( u1 == u2 or t1 == can_change_object_identity );

sid devnull system_u:object_r:null_device_t
sid file system_u:object_r:file_t
sid fs system_u:object_r:fs_t
sid kernel system_u:system_r:kernel_t
sid sysctl system_u:object_r:sysctl_t
sid unlabeled system_u:object_r:unlabeled_t
sid any_socket		system_u:object_r:unlabeled_t
sid file_labels		system_u:object_r:unlabeled_t
sid icmp_socket		system_u:object_r:unlabeled_t
sid igmp_packet		system_u:object_r:unlabeled_t
sid init			system_u:object_r:unlabeled_t
sid kmod			system_u:object_r:unlabeled_t
sid netmsg		system_u:object_r:unlabeled_t
sid policy		system_u:object_r:unlabeled_t
sid scmp_packet		system_u:object_r:unlabeled_t
sid sysctl_modprobe 	system_u:object_r:unlabeled_t
sid sysctl_fs		system_u:object_r:unlabeled_t
sid sysctl_kernel	system_u:object_r:unlabeled_t
sid sysctl_net		system_u:object_r:unlabeled_t
sid sysctl_net_unix	system_u:object_r:unlabeled_t
sid sysctl_vm		system_u:object_r:unlabeled_t
sid sysctl_dev		system_u:object_r:unlabeled_t
sid tcp_socket		system_u:object_r:unlabeled_t
sid security system_u:object_r:security_t
sid port system_u:object_r:port_t
sid node system_u:object_r:node_t
sid netif system_u:object_r:netif_t

fs_use_xattr ext2 system_u:object_r:fs_t;
fs_use_xattr ext3 system_u:object_r:fs_t;
fs_use_xattr gfs system_u:object_r:fs_t;
fs_use_xattr jfs system_u:object_r:fs_t;
fs_use_xattr reiserfs system_u:object_r:fs_t;
fs_use_xattr xfs system_u:object_r:fs_t;
fs_use_task sockfs system_u:object_r:fs_t;
fs_use_trans mqueue system_u:object_r:tmpfs_t;
fs_use_trans shm system_u:object_r:tmpfs_t;
fs_use_trans tmpfs system_u:object_r:tmpfs_t;
fs_use_trans devpts system_u:object_r:devpts_t;

genfscon proc /mtrr system_u:object_r:mtrr_device_t
genfscon sysfs / system_u:object_r:sysfs_t
genfscon usbfs / system_u:object_r:usbfs_t
genfscon usbdevfs / system_u:object_r:usbfs_t
genfscon rootfs / system_u:object_r:root_t
genfscon bdev / system_u:object_r:bdev_t
genfscon binfmt_misc / system_u:object_r:binfmt_misc_fs_t
genfscon capifs / system_u:object_r:capifs_t
genfscon configfs / system_u:object_r:configfs_t
genfscon eventpollfs / system_u:object_r:eventpollfs_t
genfscon futexfs / system_u:object_r:futexfs_t
genfscon hugetlbfs / system_u:object_r:hugetlbfs_t
genfscon inotifyfs / system_u:object_r:inotifyfs_t
genfscon nfsd / system_u:object_r:nfsd_fs_t
genfscon ramfs / system_u:object_r:ramfs_t
genfscon romfs / system_u:object_r:romfs_t
genfscon cramfs / system_u:object_r:romfs_t
genfscon rpc_pipefs / system_u:object_r:rpc_pipefs_t
genfscon autofs / system_u:object_r:autofs_t
genfscon automount / system_u:object_r:autofs_t
genfscon cifs / system_u:object_r:cifs_t
genfscon smbfs / system_u:object_r:cifs_t
genfscon fat / system_u:object_r:dosfs_t
genfscon msdos / system_u:object_r:dosfs_t
genfscon ntfs / system_u:object_r:dosfs_t
genfscon vfat / system_u:object_r:dosfs_t
genfscon iso9660 / system_u:object_r:iso9660_t
genfscon udf / system_u:object_r:iso9660_t
genfscon nfs / system_u:object_r:nfs_t
genfscon nfs4 / system_u:object_r:nfs_t
genfscon afs / system_u:object_r:nfs_t
genfscon debugfs / system_u:object_r:debugfs_t
genfscon proc / system_u:object_r:proc_t
genfscon proc /sysvipc system_u:object_r:proc_t
genfscon proc /kmsg system_u:object_r:proc_kmsg_t
genfscon proc /kcore system_u:object_r:proc_kcore_t
genfscon proc /mdstat system_u:object_r:proc_mdstat_t
genfscon proc /net system_u:object_r:proc_net_t
genfscon proc /sys system_u:object_r:sysctl_t
genfscon proc /irq system_u:object_r:sysctl_irq_t
genfscon proc /net/rpc system_u:object_r:sysctl_rpc_t
genfscon proc /sys/fs system_u:object_r:sysctl_fs_t
genfscon proc /sys/kernel system_u:object_r:sysctl_kernel_t
genfscon proc /sys/kernel/modprobe system_u:object_r:sysctl_modprobe_t
genfscon proc /sys/kernel/hotplug system_u:object_r:sysctl_hotplug_t
genfscon proc /sys/net system_u:object_r:sysctl_net_t
genfscon proc /sys/net/unix system_u:object_r:sysctl_net_unix_t
genfscon proc /sys/vm system_u:object_r:sysctl_vm_t
genfscon proc /sys/dev system_u:object_r:sysctl_dev_t
genfscon selinuxfs / system_u:object_r:security_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
