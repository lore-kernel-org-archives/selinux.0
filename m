Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB8HULRb017542
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 12:30:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB8HTblU010703
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 17:29:37 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id hB8HTaSX010700
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 17:29:37 GMT
Subject: policy problem with nfs mounting
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1070904612.15475.7.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Mon, 08 Dec 2003 11:30:12 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was merging in the 1.4 policy changes into the Gentoo policy, when I
experienced some odd nfs breakage.  NFS wouldn't mount on my 2.6 machine
(cant try on 2.4, since its PPC):

nfs warning: mount version older than kernel
SELinux: initialized (dev , type rpc_pipefs), not configured for labeling
avc:  denied  { mount } for  pid=3123 exe=/bin/mount name=/ dev= ino=3189
scontext=system_u:system_r:mount_t tcontext=system_u:object_r:unlabeled_t tclass=filesystem
 
avc:  denied  { search } for  pid=3123 exe=/bin/mount dev= ino=3189
scontext=system_u:system_r:mount_t tcontext=system_u:object_r:unlabeled_t tclass=dir
SELinux: initialized (dev 0:b, type nfs), uses genfs_contexts

At first I thought it was NFS itself, but it turns out to be rpc_pipefs,
as there are no denials on successive NFS mounts.  I set rpc_pipefs to
be nfs_t in genfscon, and then the denials are cleared.  However, I'm
not sure if this is the best choice of type.  Comments?

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
