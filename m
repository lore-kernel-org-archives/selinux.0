Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06910
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 07:07:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA07804
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 11:05:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA07800 for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 11:05:31 GMT
Date: Thu, 25 Jul 2002 07:06:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: directory write denied messages
In-Reply-To: <20020725104048.BB95C163@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207250648530.10347-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Jul 2002, Russell Coker wrote:

> Could the kernel message log messages for denied write access to a directory
> be changed to give the path of the file that the process is attempting to
> create or rename?

This information isn't available in the relevant hook function or its
immediate caller from the kernel.  Looking at lsm-2.4/fs/namei.c, you'll
see that vfs_create() calls may_create() with both the directory and the
child dentry, but may_create() calls permission() with just the directory.
permission() then calls the inode_permission() hook
[selinux_inode_permission when using SELinux].  This is what performs the
write permission check.

Now, it is true that vfs_create() subsequently calls the inode_create()
hook with both the directory and the child dentry [selinux_inode_create
when using SELinux].  SELinux uses this hook to perform the finer-grained
checks of add_name permission to the directory, create permission to the
new file, and associate permission between the file and the filesystem.
For these permission checks, the child dentry is used for auditing.

To provide what you want, we would have to disable directory write
checking in selinux_inode_permission, deferring it to the appropriate
finer-grained hook where we know the child dentry.  If we were certain
that every directory modification is and always will be covered by a
finer-grained LSM hook, then this would be reasonable.  However, I'm
hesitant to make such an assumption.  Notice that this issue is discussed
in the module technical report as one of the changes from the original
SELinux kernel patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
