Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04238
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 13:20:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBGIK5I14260
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 18:20:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id gBGIK5f14255 for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 18:20:05 GMT
Message-Id: <200212161827.NAA00650@moss-shockers.ncsc.mil>
Date: Mon, 16 Dec 2002 13:27:18 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: new kernel patch
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Bevy_of_Otters_362_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Bevy_of_Otters_362_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: 1fsdfwp0/MqPaYvxWlydog==


> The new version seems to have a bug related to file labelling that affects
> devfs.
<snip>
> You can see the log entry below, it does not log the action, and it claims
> that there is a file named /dev/floppy which is bogus.  There can be
> no file under /dev on a devfs system so any reference to tclass=file and
> dev=00:06 means a kernel bug.  Without reading the kernel code in question
> I guess that file is the default tclass (defined to 0?).
<snip>
> avc:  denied  { } for  pid=65 exe=/sbin/devfsd path=/floppy dev=00:06 ino=527 
scontext=system_u:system_r:devfsd_t tcontext=system_u:object_r:unlabeled_t 
tclass=file

When an inode is allocated, its SID is initialized to the unlabeled
initial SID (=> system_u:object_r:unlabeled_t), and its security class
is initialized to the file class by default.  This log message indicates
that a devfs inode reached a permission check without first being
initialized by inode_doinit, likely due to a race between 
selinux_inode_post_lookup and a cached lookup.  The empty permission
set is due to an inability to map the requested permission (likely search)
to a permission in the file class.

As a short term fix, I'd suggest the attached patch.  A proper fix requires
adjusting the inode_init call in d_instantiate and the SELinux hook function
to properly handle filesystems that rely on genfs_contexts.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Bevy_of_Otters_362_000
Content-Type: TEXT/plain; name="perminit.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: perminit.patch
Content-MD5: CqVpnnaZAd/igBl1iadKzA==

Index: lsm-2.4/security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/security/selinux/hooks.c,v
retrieving revision 1.23
diff -u -r1.23 hooks.c
--- lsm-2.4/security/selinux/hooks.c	4 Dec 2002 17:54:52 -0000	1.23
+++ lsm-2.4/security/selinux/hooks.c	16 Dec 2002 17:19:42 -0000
@@ -2033,6 +2033,8 @@
 		return 0;
 	}
 
+	inode_doinit(inode);
+
 	return inode_has_perm(current, inode, 
 			       file_mask_to_av(inode->i_mode, mask), NULL, NULL);
 }

--Bevy_of_Otters_362_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
