Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13271
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 18:43:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA02101
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 23:40:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA02097
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 23:40:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, selinux@tycho.nsa.gov
Subject: Re: afs domain development under the selinux kernel
Date: Mon, 20 Jan 2003 00:43:11 +0100
Cc: openafs-info@openafs.org
References: <20030119151929.747254b8.fw@fwsystems.com>
In-Reply-To: <20030119151929.747254b8.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301200043.11849.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 19 Jan 2003 21:19, forrest whitcher wrote:
> I've been working on OpenAFS client < selinux kernel for awhile now, and
> have got a first-draft policy working and currently under test. I'm not to
> sure of complete/correct-ness at this point but at least it seems to be
> working, and now I want to go in and make changes to either the kernel, the
> libafs kernel module or afsd to move the data in /afs/* into its own
> domain.

Doesn't genfs work with afs?  If not how does it fail?

> tmpfs_t:* allow statements are specific because for the moment the afs
> cache dir is being created in /tmp -- that's only a kludge because I
> hadn't created any other ext2fs and afsd won't run the cache on aything
> else. Longterm the cachedir should probably have it's own type.

I suspect that you have a mis-labelled startup script if you need to add any 
permissions for run_init_t.

> /afs/* is labeled of course as unlabeled_t, currently I'm using a
> policy which allows user_r unrestricted access to this type. Better
> solutions could involve having type enforcemnt check for valid afs
> tickets and/or assigning a type to this data, however I'm not too
> sure what method might be appropriate for that.

Assigning a type to all of /afs or several types to different sub-directories 
should be easy enough with genfs.

However for full functionality it might be better to have the enforcement done 
on the server and to have the protocol support sending the SE security 
context for the client process over the network to allow the server to make 
SE Linux policy decisions on file access.

> Where can I consider generating / enforcing an afs_t type for data
> in /afs? This mostly is implemented over UDP port 7001. I think
> most things needed for the server parts are done, but I'm not certain
> how much implementation could to be done mostly in the policy config,
> and what things I need to modify to establish the type in either
> the kernel module or the afsd process.

In genfs_contexts something like the following would be needed:
genfscon afs /                         system_u:object_r:afs_t

> SELinux will create a directory in every mounted filesystem named
> '...security' in the root of every filesystem which stores persistent
> SID:inode data. I'm not certain whether the creation of ...security will
> cause problems with a fs used as an afs partition.

It can only be done at the server.  The client can't create it on a network 
share and expect it to work.  There are currently some problems if a machine 
crashes while files are being created and deleted whereby files can get the 
wrong security context.  If SE Linux is changed to use xattr's for the PSID 
then this issue will be solved and some issues related to networking may be 
easier to address.

> domains/program/initrc.te added:
>
> allow run_init_t tmpfs_t:file { read write };

I don't think that is right.  I would like to see the dmesg logs that lead you 
to create that.

> # however this is not sufficient to allow afsd to startup in enforcing mode
> # so for now I'm starting afsd before toggling into enforcing

Please show me some more logs and I'll make some suggestions.

> domains/program/mount.te added:
>
> allow mount_t kernel_t:process { sigkill };
>
> # when /afs is unmounted I assume VFS is providing the magic for the kill
> to # be sent to afsd. Would it be better (possible?) to limit this to only
> killing # the afsd_t process?

I'm not sure what is happening here, please show some logs to make it clear.

> Most of the work is in:
>
> domains/program/afsd.te (also attached to this email)

I've made a few changes below.  Using the daemon_domain() macro makes things a 
bit simpler and easier to read, and also makes sure that you get all the 
common things.  EG the policy you had only appeared to support starting the 
daemon after running newrole, but not when logging in at the console directly 
into sysadm_r...

The unlabeled_t:tcp_socket is an indication of a problem too.

> # Domain for afsd executable
>
> #
> # make afsd_exec_t
>
daemon_domain(afsd)
> allow afsd_t root_t:dir mounton;
>
> allow kernel_t afsd_t:udp_socket { read write };
>
> allow afsd_t afsd_t:capability { sys_admin sys_nice };
> allow afsd_t afsd_t:process setsched;
> allow afsd_t afsd_t:udp_socket { create ioctl write };
> allow afsd_t any_socket_t:udp_socket { sendto };
> allow afsd_t etc_runtime_t:file { append getattr read };
# do you REALLY want to allow it to write most files in /etc?
> allow afsd_t etc_t:file { getattr read write };
> allow afsd_t netif_eth0_t:netif { udp_send };
> allow afsd_t netmsg_eth0_t:udp_socket { recvfrom };
> allow afsd_t node_t:node { udp_send };
> allow afsd_t sysadm_tty_device_t:chr_file { getattr ioctl read write };
> allow afsd_t sysadm_tmp_t:dir { create setattr getattr read search };
> allow afsd_t sysadm_tmp_t:file { create };
>
tmp_domain(afsd)
> allow afsd_t unlabeled_t:filesystem { mount };
> allow afsd_t usr_t:dir { search };
>
>
> #
> # required to give any access to users
> #
>
> allow sysadm_t afsd_t:udp_socket { write };
> allow user_t afsd_t:udp_socket { write };
>
>
> #
> # required for full client access
> #
>
> allow kernel_t unlabeled_t:udp_socket { read write };
>
> allow unlabeled_t any_socket_t:udp_socket { sendto };
> allow unlabeled_t netif_eth0_t:netif { udp_send };
> allow unlabeled_t node_t:node { udp_send };
> allow unlabeled_t netmsg_eth0_t:udp_socket { recvfrom };
>
> allow user_t unlabeled_t:dir { getattr search read write};
> allow user_t unlabeled_t:file { read write setattr getattr execute 
execute_no_trans }; allow user_t unlabeled_t:lnk_file { read write setattr
> getattr };
>
> allow user_t unlabeled_t:udp_socket { read write };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
