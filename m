Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB8ImiRb018157
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 13:48:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB8ImhRV023255
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 18:48:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB8Imgta023252 for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 18:48:42 GMT
Subject: Re: policy problem with nfs mounting
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <1070904612.15475.7.camel@chris.pebenito.net>
References: <1070904612.15475.7.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1070909315.7949.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 08 Dec 2003 13:48:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-08 at 12:30, Chris PeBenito wrote:
> I was merging in the 1.4 policy changes into the Gentoo policy, when I
> experienced some odd nfs breakage.  NFS wouldn't mount on my 2.6 machine
> (cant try on 2.4, since its PPC):
> 
> nfs warning: mount version older than kernel
> SELinux: initialized (dev , type rpc_pipefs), not configured for labeling
> avc:  denied  { mount } for  pid=3123 exe=/bin/mount name=/ dev= ino=3189
> scontext=system_u:system_r:mount_t tcontext=system_u:object_r:unlabeled_t tclass=filesystem
>  
> avc:  denied  { search } for  pid=3123 exe=/bin/mount dev= ino=3189
> scontext=system_u:system_r:mount_t tcontext=system_u:object_r:unlabeled_t tclass=dir
> SELinux: initialized (dev 0:b, type nfs), uses genfs_contexts
> 
> At first I thought it was NFS itself, but it turns out to be rpc_pipefs,
> as there are no denials on successive NFS mounts.  I set rpc_pipefs to
> be nfs_t in genfscon, and then the denials are cleared.  However, I'm
> not sure if this is the best choice of type.  Comments?

I'd expect that you would want a different type for rpc_pipefs, as you
likely want to control access to this userland/kernel interface
differently than to the files on the NFS filesystem.  It may even be
desirable to support finer-grained labeling for rpc_pipefs, to support
least privilege for userspace access to it, but we haven't looked into
that yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
