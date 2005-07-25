Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PFKRgA023580
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 11:20:29 -0400 (EDT)
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PFEKAP017008
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 15:14:20 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j6PFF5kQ100572
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 11:15:07 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6PFF6NT073496
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 09:15:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j6PFF5xx011130
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 09:15:05 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j6PFF4oV011103
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 09:15:04 -0600
Received: from faith.austin.ibm.com (faith.austin.ibm.com [9.41.94.16])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id j6PFF4Zh025538
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 10:15:04 -0500
Received: from faith.austin.ibm.com (localhost.localdomain [127.0.0.1])
	by faith.austin.ibm.com (8.13.1/8.12.8) with ESMTP id j6PFEDNx003899
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 10:14:13 -0500
Received: (from jml@localhost)
	by faith.austin.ibm.com (8.13.1/8.13.1/Submit) id j6PFEDY3003898
	for selinux@tycho.nsa.gov; Mon, 25 Jul 2005 10:14:13 -0500
Date: Mon, 25 Jul 2005 10:14:13 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200507251514.j6PFEDY3003898@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: SELinux testcase coverage
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A few weeks ago I sent a note about SELinux testcase coverage.
The test matrix was in open office format. I have converted it
to text for easier viewing and have included in this note.
Please let me know if there are any questions or if you are 
interested in increasing coverage.

Regards,
Joy Latten


Testcase Coverage Analysis:
Total number of hooks listed in test matrix = 102
Total number of hooks with testcases =  47
Percentage of completed testcases in LTP = 46%

selinux hook name
object class	| SSID   | TSID   | permission	| testcase	| notes
------------------------------------------------------------------------------
selinux_ptrace	
process		|current | target | ptrace	| ptrace	|	
------------------------------------------------------------------------------
selinux_capget	
------------------------------------------------------------------------------
selinux_capset_check		
------------------------------------------------------------------------------
selinux_sysctl	
file		|current |target  | read	| sysctl	|
file		|current |target  | write	| sysctl	|
------------------------------------------------------------------------------
selinux_capable	
capability	|current |target  | chown	| capable_file	|
		|	 |	  |		| dac_overide	|
		|	 |	  | 		| dac_read_search
capability	|current |target  | fowner	| capable_file	|
capability	|current |target  | fsetid	| capable_file	|
		|	 |	  |		| kill		|
		|	 |	  |		| setgid	|
		|	 |	  |		| setuid	|	
		|	 |	  |		| setpcap	|
		|	 |	  | 		| linux_immutable		
capability	| port	 |socket  | net_bind_service|capable_net|	
		|	 |	  |		|net_broadcast	|
		|	 |	  |		|	        |
capability	|current |target  |net_admin	|capable_net	|
capability	|current |target  |net_raw	|capable_net	|
		| 	 |	  |		|ipc_lock	|	   
		|	 |	  |		|ipc_owner	|
		|	 |	  |		|sys_module	|	  
capability	|current |target  |sys_rawio	|capable_sys	|
capability	|current |target  |sys_chroot	|capable_sys	|
		|	 |	  |		|sys_ptrace	|	   
		|	 |	  |		|sys_pacct	|	   
capability	|current |target  |sys_admin	|		|	
		|	 |	  |		|sys_boot	|	 
capability	|current |target  |sys_nice	|		|
		|	 |	  |		|sys_resource	|
		|	 |	  |		|sys_time	|	  
		|	 |	  |		|sys_ttyconfig	|	 
capability	|current |target  |mknod	|capable_file	|
capability	|current |target  |lease	|capable_file	|
		|	 |	  |		|audit_write	|	 	
		|	 |	  |		|audit_control	|	  
-------------------------------------------------------------------------------
selinux_quotactl
-------------------------------------------------------------------------------
selinux_quota_on
-------------------------------------------------------------------------------
selinux_syslog	
-------------------------------------------------------------------------------
selinux_vm_enough_memory
-------------------------------------------------------------------------------
selinux_netlink_send
-------------------------------------------------------------------------------
selinux_netlink_recv
-------------------------------------------------------------------------------
selinux_bprm_apply_creds
process		|parent	 |new	  |share	|execshare	|
process		|parent  |new	  |ptrace	|exectrace	|
-------------------------------------------------------------------------------
selinux_bprm_post_apply_creds
fd		|new	 |fd	  |use		| inherit	|tests flush_un
		|	 |	  |		|		|authorized_fil
		|	 |	  |		|		|es()
-------------------------------------------------------------------------------
selinux_bprm_set_security
process		|current |new	  |transition	|domain_trans	|
file		|new	 |file	  |entrypoint	|entrypoint	|
file		|current |file	  |execute_no_trans|execute_no_trans|
-------------------------------------------------------------------------------
selinux_bprm_secureexec	
-------------------------------------------------------------------------------
selinux_sb_copy_data		
-------------------------------------------------------------------------------
selinux_sb_kern_mount
-------------------------------------------------------------------------------
selinux_sb_statfs
-------------------------------------------------------------------------------
selinux_sb_mount
-------------------------------------------------------------------------------
selinux_sb_umount
-------------------------------------------------------------------------------
selinux_inode_create
-------------------------------------------------------------------------------
selinux_inode_link
file		|current |file	   |link	|link		|
dir		|current |path	   |search	|link		|
dir		|current |parent   |add_name	|link		|
-------------------------------------------------------------------------------
selinux_inode_unlink
file		|current |file	   |unlink	|link		|
dir		|current |parent   |remove_name	|link		|
dir		|current |path	   |search	|link		|  
-------------------------------------------------------------------------------
selinux_inode_symlink
-------------------------------------------------------------------------------
selinux_inode_mkdir
dir		|current |path	   |search	|mkdir		|
dir		|current |parent   |add_name	|mkdir		|
file		|current |file	   |create	|mkdir		|
-------------------------------------------------------------------------------
selinux_inode_rmdir
-------------------------------------------------------------------------------
selinux_inode_mknod
-------------------------------------------------------------------------------
selinux_inode_rename
dir		|current |oldparent|remove_name	|rename		|
file		|current |file	   |rename	|rename		|
dir		|current |file	   |reparent	|rename		|
dir		|current |newparent|add_name	|rename		|
dir		|current |newparent|remove_name	|rename		|
file		|current |newfile  |unlink	|rename		|
-------------------------------------------------------------------------------
selinux_inode_readlink
lnk_file	|current |file	   |read	|readlink	|
-------------------------------------------------------------------------------
selinux_inode_follow_link
lnk_file	|current |file	   |read	| readlink	|
-------------------------------------------------------------------------------
selinux_inode_permission
file		|current |file	   |read	|open		|
file		|current |file	   |write	|open		|
file		|current |file	   |append	|open		|
dir		|current |dir	   |read	|rxdir		|
dir		|current |path	   |search	|rxdir		|
-------------------------------------------------------------------------------
selinux_inode_setattr
file		|current |file	   |setattr	|setattr	|
-------------------------------------------------------------------------------
selinux_inode_getattr
file		|current |file	   |getattr	|stat		|
-------------------------------------------------------------------------------
selinux_inode_setxattr	
file		|current |file	   |relabelfrom	|relabel	|
file		|current |file	   |relabelto	|relabel	|
-------------------------------------------------------------------------------
selinux_inode_getxattr
-------------------------------------------------------------------------------
selinux_inode_listxattr	
-------------------------------------------------------------------------------
selinux_inode_removexattr
-------------------------------------------------------------------------------
selinux_inode_getsecurity
-------------------------------------------------------------------------------
selinux_inode_setsecurity
-------------------------------------------------------------------------------
selinux_inode_listsecurity
-------------------------------------------------------------------------------
selinux_file_permission
fd		|current |fd	   |use		|file		|
file		|current |file	   |write	|file		|
-------------------------------------------------------------------------------
selinux_file_ioctl
file		|current |file	   |ioctl	|ioctl		|FIOCLEX
file		|current |file	   |getattr	|ioctl		|FIGETBSZ
file		|current |file	   |setattr	|ioctl		|EXT2_IOC_SE
		|	 |	   |		|		|TVERSION
fd		|current |file	   |use		|ioctl		|FIONBIO
capability	|	 | 	   |sys_tty_config |		|
-------------------------------------------------------------------------------
selinux_file_mmap
fd		|current |fd	   |use		|file		|
file		|current |file	   |read	|file		|
file		|current |file	   |write	|file		|
file		|current |file	   |execute	|file		|
-------------------------------------------------------------------------------
selinux_file_mprotect
fd		|current |fd	   |use		|file		|
file		|current |file	   |read	|file		|
-------------------------------------------------------------------------------
selinux_file_lock
fd		|current |fd	   | use	|file		|
file		|current |file	   |lock	|file		|
-------------------------------------------------------------------------------
selinux_file_fcntl
fd		|current |fd	   |use		| file		|
file		|current |file	   |write	| file		|
file		|current |file	   |lock	| file		|
-------------------------------------------------------------------------------
selinux_file_set_fowner
-------------------------------------------------------------------------------
selinux_file_send_sigiotask
process		|parent	 |new	   |signal	|file		|
-------------------------------------------------------------------------------
selinux_file_receive
process		|fd	 |	   |fd		|use		|
-------------------------------------------------------------------------------
selinux_task_create
process		|current |current  |fork	|task_create	|
-------------------------------------------------------------------------------
selinux_task_setuid
-------------------------------------------------------------------------------
selinux_task_setgid
-------------------------------------------------------------------------------
selinux_task_setpgid
process		|current |target   |setpgid	|task_setpgid	|
-------------------------------------------------------------------------------
selinux_task_getpgid
process		|current |target   |getpgid	|task_getpgid	|
-------------------------------------------------------------------------------
selinux_task_getsid
process		|current |target   |getsession	|task_getsid	|
-------------------------------------------------------------------------------
selinux_task_setgroups
-------------------------------------------------------------------------------
selinux_task_setnice
process		|current |target   |setsched	|task_setnice	|
-------------------------------------------------------------------------------
selinux_task_setrlimit
-------------------------------------------------------------------------------
selinux_task_setscheduler
process		|current |target   |setsched 	|task_setscheduler
-------------------------------------------------------------------------------
selinux_task_getscheduler
process		|current |target   |getsched 	|task_getscheduler
-------------------------------------------------------------------------------
selinux_task_kill
process		|current |target   |signal	|sigkill	|
process		|current |target   |signull	|sigkill	|
process		|current |target   |sigstop	|sigkill	|
process		|current |target   |sigkill	|sigkill	|
process		|current |target   |sigchld	|sigkill	|
-------------------------------------------------------------------------------
selinux_task_wait
process		|child	 |current  |sigchld	| wait		|
-------------------------------------------------------------------------------
selinux_task_reparent_to_init
-------------------------------------------------------------------------------
selinux_task_to_inode
-------------------------------------------------------------------------------
selinux_ipc_permission
-------------------------------------------------------------------------------
selinux_msg_queue_alloc_security
msgq		|current |msgq	   |create	|msg		|
-------------------------------------------------------------------------------
selinux_msg_queue_associate
msgq		|current |msgq	   |associate	|msg		|
-------------------------------------------------------------------------------
selinux_msg_queue_msgctl
msgq		|current |msgq	   |getattr	|msg		|
msgq		|current |msgq	   |setattr	|msg		|
msgq		|current |msgq	   |associate	|msg		|
msgq		|current |msgq	   |destroy	|msg		|
-------------------------------------------------------------------------------
selinux_msg_queue_msgsnd
msgq		|current |msgq	   |write	|msg		|
msgq		|msg	 |msgq	   |enqueue	|msg		|
msg		|current |msg	   |send	|msg		|
-------------------------------------------------------------------------------
selinux_msg_queue_msgrcv
msgq		|current |msgq	   |read	|msg		|
msg		|current |msg	   |receive	|msg		|
-------------------------------------------------------------------------------
selinux_shm_alloc_security
shm		|current |shm	   |create	|shm		|
-------------------------------------------------------------------------------
selinux_shm_associate
shm		|current |shm	   |associate	|shm		|
-------------------------------------------------------------------------------
selinux_shm_shmctl
shm		|current |shm	   |getattr	|shm		|
shm		|current |shm	   |setattr	|shm		|
shm 		|current |shm	   |associate	|shm		|
shm		|current |shm	   |lock	|shm		|
shm 		|current |shm	   |destroy	|shm		|
-------------------------------------------------------------------------------
selinux_shm_shmat
shm		|current |shm	   |read	|shm		|
shm		|current |shm	   |write	|shm		|
-------------------------------------------------------------------------------
selinux_sem_alloc_security
semaphore	|current |sem	   |create	|sem		|
-------------------------------------------------------------------------------
selinux_sem_associate
semaphore	|current |sem	   |associate	|sem		|
-------------------------------------------------------------------------------
selinux_sem_semctl	
semaphore	|current |sem	   |getattr	|sem		|
semaphore	|current |sem	   |setattr	|sem		|
semaphore	|current |sem	   |read	|sem		|
semaphore	|current |sem	   |write	|sem		|
semaphore	|current |sem	   |destroy	|sem		|
system		|current |kernel   |ipc_info	|sem		|
-------------------------------------------------------------------------------
selinux_sem_semop
semaphore	|current |sem	   |read	|sem		|
semaphore	|current |sem	   |write	|sem		|
-------------------------------------------------------------------------------
selinux_register_security
-------------------------------------------------------------------------------
selinux_unregister_security
-------------------------------------------------------------------------------
selinux_d_instantiate
-------------------------------------------------------------------------------
selinux_getprocattr
-------------------------------------------------------------------------------
selinux_setprocattr
process		|current |new	   |dyntransition|dyntrans	|
process		|parent	 |new	   |ptrace	|dyntrace	|
-------------------------------------------------------------------------------
selinux_socket_unix_stream_connect				|not ported
-------------------------------------------------------------------------------
selinux_socket_unix_may_send					|not ported
-------------------------------------------------------------------------------
selinux_socket_bind						|not ported
-------------------------------------------------------------------------------
selinux_socket_connect						|not ported
-------------------------------------------------------------------------------
selinux_socket_listen						|not ported
-------------------------------------------------------------------------------
selinux_socket_accept						|not ported
-------------------------------------------------------------------------------
selinux_socket_sendmsg						|not ported
-------------------------------------------------------------------------------
selinux_socket_recvmsg						|not ported
-------------------------------------------------------------------------------
selinux_socket_getsockname					|not ported
-------------------------------------------------------------------------------
selinux_socket_getpeername					|not ported
-------------------------------------------------------------------------------
selinux_socket_getsockopt					|not ported
-------------------------------------------------------------------------------
selinux_socket_setsockopt					|not ported
-------------------------------------------------------------------------------
selinux_socket_shutdown						|not ported
-------------------------------------------------------------------------------
selinux_socket_sock_rcv_skb					|not ported
-------------------------------------------------------------------------------
selinux_socket_getpeersec
-------------------------------------------------------------------------------
selinux_ipv4_postroute_last
-------------------------------------------------------------------------------
selinux_ipv6_postroute_last
-------------------------------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
