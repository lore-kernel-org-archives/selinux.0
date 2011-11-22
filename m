Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pAMM0XoV004629
	for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2011 17:00:33 -0500
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pAMM0WgN017451
	for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2011 22:00:32 GMT
Message-ID: <4ECC1B7F.4010606@tresys.com>
Date: Tue, 22 Nov 2011 17:00:31 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: CIL/SELinux Userspace Integration
Content-Type: multipart/mixed;
	boundary="------------050501040002010204080700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------050501040002010204080700
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

As many of you may know, we have been working on CIL for a while now.
This has been posted to the list many times before, so we'll just post
the link to the wiki for now [1], but we're happy to answer any questions.

In addition to adding numerous features to CIL since we've last posted
to the list, we've also been working hard at integrating CIL
into SELinux userspace. We now have that in a state that's ready for
comments and review.

Because the changes are so large, I've pushed three branches upstream:
"src-revert", "src-policy", and "integration", each one building on the
other.

src-revert:
   Reverts changes made to master that conflict with the src-policy
   branch (i.e. how paths are handled, enabled/disable modules). This
   also reverts the preserve tunables patch. CIL tunables behave
   differently than in refpolicy, and so we can't easily preserve them,
   so this patchset, unfortunately, cannot be kept.

src-policy:
   This is a rebase of the old src-policy branch onto the src-revert
   branch. This moves the policy store to /var/lib/selinux and adds
   preliminary support for CIL. This was all done about two years ago.

integration:
   This branch builds CIL into libsepol, and updates libsemanage and
   semodule to understand only CIL files. Binary .pp modules will no
   longer work. There is still a lot of binary module code in the tree
   that needs to be removed, but that should be relatively easy to start
   stripping out.

So with these changes, it it is now possible to build CIL into libsepol,
and manage the SELinux policy store using semodule and only CIL files.

Below are the steps to install CIL integrated into SELinux userspace and
install a simple module. We don't yet have a conversion from reference
policy to CIL, so we don't have a real policy that can be installed.
However, I've attached a CIL version of mdp (created by Richard Haines,
with a few tweaks for syntax changes) that should give you an idea of
how it works. And because CIL files are text files, it's pretty trivial
to write new ones and install them and play around with it.

The mdp.cil file is very simple. For some more interesting examples of
what CIL can do, see the wiki [1] or the policy.cil file in the test
directory in the cil repo.

We look forwward to hearing your feedback now that we've reached this
pretty big milestone.

Thanks,
- Steve

[1] http://userspace.selinuxproject.org/trac/wiki/CilDesign


== Installation Steps ==

Note: This will make a lot of changes to your system, including changing
SELinux userspace, moving your policy store to /var/lib/selinux, and
because we don't yet have full policies yet, potentially breaking your
system if you reboot. It's probably wise to use a VM and/or make a
backup first.

1) Checkout the CIL integration branch

   # git clone http://oss.tresys.com/git/cil.git cil
   # cd cil
   # git checkout integration
   # cd ..

2) Checkout the selinux integration branch

   # git clone http://oss.tresys.com/git/selinux.git selinux
   # cd selinux
   # git checkout integration

3) Make a symbolic link in libsepol to the CIL repo

   # cd libsepol
   # ln -s /path/to/cil/repo/cil cil

4) Install selinux userspace (now with CIL included)

   # cd ..
   # make install
   # make swigify
   # make install-pywrap

5) Migrate the current store to the new /var/lib/selinux

   # ./libsemanage/utils/semanage_migrate_etc_to_var.py --clean --norebuild

6) Delete the existing binary modules from the new store, they won't
work with CIL

   # rm -rf /var/lib/selinux/targeted/active/modules/*

7) Check to make sure all modules have been removed

   # semodule --list=full
   No modules.

8) Install the mdp module (attached to this email)

   # semodule --install /path/to/mdp.cil

9) See the new policy

   # semodule --list=full
   400 mdp          cil

   # seinfo
   Statistics for policy file: /etc/selinux/targeted/policy/policy.24
   Policy Version & Type: v.24 (binary, non-mls)

      Classes:            49    Permissions:       163
      Sensitivities:       0    Categories:          1
      Types:               1    Attributes:          0
      Users:               1    Roles:               2
      Booleans:            0    Cond. Expr.:         0
      Allow:              49    Neverallow:          0
      Auditallow:          0    Dontaudit:           0
      Type_trans:          0    Type_change:         0
      Type_member:         0    Role allow:          0
      Role_trans:          0    Range_trans:         0
      Constraints:         0    Validatetrans:       0
      Initial SIDs:       27    Fs_use:             17
      Genfscon:            1    Portcon:             0
      Netifcon:            0    Nodecon:             0
      Permissives:         0    Polcap:              0


--------------050501040002010204080700
Content-Type: text/plain; name="mdp.cil"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mdp.cil"

(category c0)
(categoryorder (c0))
(sensitivity s0)
(dominance (s0))
(sensitivitycategory s0 (c0))
(levelrange default ((s0 (c0)) (s0 (c0))))
(level low (s0 (c0)))

(sid kernel)
(sid security)
(sid unlabeled)
(sid fs)
(sid file)
(sid file_labels)
(sid init)
(sid any_socket)
(sid port)
(sid netif)
(sid netmsg)
(sid node)
(sid igmp_packet)
(sid icmp_socket)
(sid tcp_socket)
(sid sysctl_modprobe)
(sid sysctl)
(sid sysctl_fs)
(sid sysctl_kernel)
(sid sysctl_net)
(sid sysctl_net_unix)
(sid sysctl_vm)
(sid sysctl_dev)
(sid kmod)
(sid policy)
(sid scmp_packet)
(sid devnull)

(class security ( compute_av compute_create compute_member check_context load_policy compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot read_policy))
(class process ( fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate))
(class system ( ipc_info syslog_read syslog_mod syslog_console module_request))
(class capability ( chown dac_override dac_read_search fowner fsetid kill setgid setuid setpcap linux_immutable net_bind_service net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice sys_resource sys_time sys_tty_config mknod lease audit_write audit_control setfcap))
(class filesystem ( mount remount unmount getattr relabelfrom relabelto transition associate quotamod quotaget))
(class file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod execute_no_trans entrypoint))
(class dir ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod add_name remove_name reparent search rmdir))
(class fd ( use))
(class lnk_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod))
(class chr_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod))
(class blk_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod))
(class sock_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod))
(class fifo_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod))
(class socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class tcp_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind connectto newconn acceptfrom node_bind name_connect))
(class udp_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind node_bind))
(class rawip_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind node_bind))
(class node ( tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send recvfrom sendto))
(class netif ( tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send ingress egress))
(class netlink_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class packet_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class key_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class unix_stream_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind connectto newconn acceptfrom))
(class unix_dgram_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class sem ( create destroy getattr setattr read write associate unix_read unix_write))
(class msg ( send receive))
(class msgq ( create destroy getattr setattr read write associate unix_read unix_write enqueue))
(class shm ( create destroy getattr setattr read write associate unix_read unix_write lock))
(class ipc ( create destroy getattr setattr read write associate unix_read unix_write))
(class netlink_route_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write))
(class netlink_firewall_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write))
(class netlink_tcpdiag_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write))
(class netlink_nflog_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class netlink_xfrm_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write))
(class netlink_selinux_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class netlink_audit_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write nlmsg_relay nlmsg_readpriv nlmsg_tty_audit))
(class netlink_ip6fw_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write))
(class netlink_dnrt_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class association ( sendto recvfrom setcontext polmatch))
(class netlink_kobject_uevent_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class appletalk_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))
(class packet ( send recv relabelto forward_in forward_out))
(class key ( view read write search link setattr create))
(class dccp_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind node_bind name_connect))
(class memprotect ( mmap_zero))
(class peer ( recv))
(class capability2 ( mac_override mac_admin syslog))
(class kernel_service ( use_as_override create_files_as))
(class tun_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind))

(type  base_t)
(role  base_r)
(roletype base_r base_t)

(allow  base_t  base_t (security ( compute_av compute_create compute_member check_context load_policy compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot read_policy)))
(allow  base_t  base_t (process ( fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate)))
(allow  base_t  base_t (system ( ipc_info syslog_read syslog_mod syslog_console module_request)))
(allow  base_t  base_t (capability ( chown dac_override dac_read_search fowner fsetid kill setgid setuid setpcap linux_immutable net_bind_service net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice sys_resource sys_time sys_tty_config mknod lease audit_write audit_control setfcap)))
(allow  base_t  base_t (filesystem ( mount remount unmount getattr relabelfrom relabelto transition associate quotamod quotaget)))
(allow  base_t  base_t (file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod execute_no_trans entrypoint)))
(allow  base_t  base_t (dir ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod add_name remove_name reparent search rmdir)))
(allow  base_t  base_t (fd ( use)))
(allow  base_t  base_t (lnk_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod)))
(allow  base_t  base_t (chr_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod)))
(allow  base_t  base_t (blk_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod)))
(allow  base_t  base_t (sock_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod)))
(allow  base_t  base_t (fifo_file ( ioctl read write create getattr setattr lock relabelfrom relabelto append unlink link rename execute swapon quotaon mounton audit_access open execmod)))
(allow  base_t  base_t (socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (tcp_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind connectto newconn acceptfrom node_bind name_connect)))
(allow  base_t  base_t (udp_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind node_bind)))
(allow  base_t  base_t (rawip_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind node_bind)))
(allow  base_t  base_t (node ( tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send recvfrom sendto)))
(allow  base_t  base_t (netif ( tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send ingress egress)))
(allow  base_t  base_t (netlink_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (packet_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (key_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (unix_stream_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind connectto newconn acceptfrom)))
(allow  base_t  base_t (unix_dgram_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (sem ( create destroy getattr setattr read write associate unix_read unix_write)))
(allow  base_t  base_t (msg ( send receive)))
(allow  base_t  base_t (msgq ( create destroy getattr setattr read write associate unix_read unix_write enqueue)))
(allow  base_t  base_t (shm ( create destroy getattr setattr read write associate unix_read unix_write lock)))
(allow  base_t  base_t (ipc ( create destroy getattr setattr read write associate unix_read unix_write)))
(allow  base_t  base_t (netlink_route_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write)))
(allow  base_t  base_t (netlink_firewall_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write)))
(allow  base_t  base_t (netlink_tcpdiag_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write)))
(allow  base_t  base_t (netlink_nflog_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (netlink_xfrm_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write)))
(allow  base_t  base_t (netlink_selinux_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (netlink_audit_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write nlmsg_relay nlmsg_readpriv nlmsg_tty_audit)))
(allow  base_t  base_t (netlink_ip6fw_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind nlmsg_read nlmsg_write)))
(allow  base_t  base_t (netlink_dnrt_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (association ( sendto recvfrom setcontext polmatch)))
(allow  base_t  base_t (netlink_kobject_uevent_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (appletalk_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))
(allow  base_t  base_t (packet ( send recv relabelto forward_in forward_out)))
(allow  base_t  base_t (key ( view read write search link setattr create)))
(allow  base_t  base_t (dccp_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind node_bind name_connect)))
(allow  base_t  base_t (memprotect ( mmap_zero)))
(allow  base_t  base_t (peer ( recv)))
(allow  base_t  base_t (capability2 ( mac_override mac_admin syslog)))
(allow  base_t  base_t (kernel_service ( use_as_override create_files_as)))
(allow  base_t  base_t (tun_socket ( ioctl read write create getattr setattr lock relabelfrom relabelto append bind connect listen accept getopt setopt shutdown recvfrom sendto recv_msg send_msg name_bind)))

(user  user_u)
(userrole  user_u  base_r)

(userrange user_u (low low))
(userlevel user_u low)

(context default_context (user_u base_r base_t default))

(sidcontext kernel default_context)
(sidcontext security default_context)
(sidcontext unlabeled default_context)
(sidcontext fs default_context)
(sidcontext file default_context)
(sidcontext file_labels default_context)
(sidcontext init default_context)
(sidcontext any_socket default_context)
(sidcontext port default_context)
(sidcontext netif default_context)
(sidcontext netmsg default_context)
(sidcontext node default_context)
(sidcontext igmp_packet default_context)
(sidcontext icmp_socket default_context)
(sidcontext tcp_socket default_context)
(sidcontext sysctl_modprobe default_context)
(sidcontext sysctl default_context)
(sidcontext sysctl_fs default_context)
(sidcontext sysctl_kernel default_context)
(sidcontext sysctl_net default_context)
(sidcontext sysctl_net_unix default_context)
(sidcontext sysctl_vm default_context)
(sidcontext sysctl_dev default_context)
(sidcontext kmod default_context)
(sidcontext policy default_context)
(sidcontext scmp_packet default_context)
(sidcontext devnull default_context)

(fsuse xattr ext2 default_context)
(fsuse xattr ext3 default_context)
(fsuse xattr ext4 default_context)
(fsuse xattr jfs default_context)
(fsuse xattr xfs default_context)
(fsuse xattr reiserfs default_context)
(fsuse xattr jffs2 default_context)
(fsuse xattr gfs2 default_context)
(fsuse xattr lustre default_context)
(fsuse task eventpollfs default_context)
(fsuse task pipefs default_context)
(fsuse task sockfs default_context)
(fsuse trans mqueue default_context)
(fsuse trans devpts default_context)
(fsuse trans hugetlbfs default_context)
(fsuse trans tmpfs default_context)
(fsuse trans shm default_context)
(genfscon proc / default_context)

(filecon "/" "" any default_context)
(filecon "/" ".*" any default_context)


--------------050501040002010204080700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
