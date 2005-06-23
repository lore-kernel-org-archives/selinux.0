Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NCH1gA025576
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 08:17:01 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NC7ENa005518
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 12:07:14 GMT
Subject: Re: sshd policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200506231632.32753.russell@coker.com.au>
References: <200506231632.32753.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 08:09:40 -0400
Message-Id: <1119528580.17098.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:32 +1000, Russell Coker wrote:
> I have attached the source files and the diff for a change to the way sshd 
> works.
> 
> Recent versions of OpenSSH by default will re-exec the sshd as part of the 
> login process.  This means that there is no need for one process to have all 
> the permissions that sshd is usually granted.  So I have split up the sshd 
> policy into two domains, one of which listens on the port and the other does 
> most of the sshd work.

> can_network_server($1_launcher_t)

Protocol? Port?

> allow $1_launcher_t self:unix_dgram_socket create_socket_perms;
> allow $1_launcher_t self:unix_stream_socket
create_stream_socket_perms;
...
> allow $1_t $1_launcher_t:tcp_socket rw_socket_perms;
> allow $1_t $1_launcher_t:unix_stream_socket rw_socket_perms;

Should launcher be able to rw the dgram socket as well?
Should those rules be put together, or am I misunderstanding how
it works?

> # do not allow statfs()
> dontaudit $1_t fs_type:filesystem getattr;

Is this sufficient? Can you look and see if samba needs this as well?
In particular, after mounting SMB filesystem, df generates denials,
and that's a bugzilla currently. However, I think fs_type didn't
quite work for that case - I was seeing denials on the top level
directory, whether it was fs_type or not. Related rules are
also in gnome-vfs-daemon.te (not sure if that's merged).

> allow $1_t port_type:tcp_socket name_connect;

Protocol? Port?

> allow $1_t { home_root_t home_dir_type }:dir { search getattr };
> if (use_nfs_home_dirs) {
> allow $1_t autofs_t:dir { search getattr };
> allow $1_t nfs_t:dir { search getattr };
> allow $1_t nfs_t:file { getattr read };
> }

> if (use_samba_home_dirs) {
> allow $1_t cifs_t:dir { search getattr };
> allow $1_t cifs_t:file { getattr read };
> }

Please no more NFS/CIFS block of this kind - I specifically tried to
macro-ize this. Also, why is this necessary? Why is sshd reading
the home directories? 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
