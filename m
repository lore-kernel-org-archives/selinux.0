Date: Mon, 11 Jun 2001 14:13:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Reiner Sailer <sailer@watson.ibm.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: Root file system over NFS
In-Reply-To: <3B24F822.B55E8098@watson.ibm.com>
Message-ID: <Pine.SOL.3.95.1010611140105.6023G-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 11 Jun 2001, Reiner Sailer wrote:

> we are developing in an embedded environment (Linux / Walnut board).
> At least for development we need to mount the root file system  over
> nfs from a trusted server (no hard-drive, no flash etc.). SELinux is running
> in the embedded PowerPC environment.

SELinux doesn't really support NFS.  It provides some very minimal
support for NFS clients, but it lacks general support for labeling
and controls on NFS.  We did implement labeling and controls for
NFS in a predecessor of SELinux, the DTOS prototype, and we
have a similar design for SELinux.  But that involves modifying
both the NFS client and server code, and it involves an extended
version of the NFS protocol.  And since we're investigating
transferring SELinux into the LSM framework, it doesn't seem
worthwhile to implement that level of support in the current
prototype at this point.

> Possible solutions I think of  in order of preference:
> 
> a) handling nfs as it were a local fs - i.e. no default type
>     (how to label a nfs ?) [ assume we trust the server for the ss_policy
>     file and verify via MACs]

I don't think this is a practical option with the current SELinux
prototype.  It involves changes to both the NFS client and server
code, and an extended NFS protocol.

> b) manually assign contexts on the client after mounting nfs root  and before
>    any program is running (problem: chcon-command for changing contexts
>    also has nfs_t  -> does not work out-of-the-box)
>     -- good: different clients can specify policies independently

This might work for setting the labels on files initially, but 
you'll probably need to make changes to the kernel to deal
with files created during system operation.  You can do a 'make relabel'
in the policy directory after mounting the NFS root to initially
set the labels.  Of course, you'll need a customized policy configuration
to allow bootstrapping and relabeling.  You'll need to modify vfs_create,
vfs_mkdir, etc. in kernel-2.4/fs/namei.c to set the SID on the inode
after file creation.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
