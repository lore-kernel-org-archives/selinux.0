Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA16824
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 13:29:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h14ITbI06090
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 18:29:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h14ITaf06086 for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 18:29:36 GMT
Message-Id: <200302041836.NAA05338@moss-shockers.ncsc.mil>
Date: Tue, 4 Feb 2003 13:36:59 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: tmpfs_t
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> For UML and busy Apache servers using tmpfs as /tmp is common practise.  The 
> current SE Linux setup will force many of the people who run big servers to 
> change their operation in a way that will hurt performance to support running 
> SE Linux.

You can use tmpfs as /tmp, as long as you are ok with the same labeling
behavior and policy for /tmp and for System V shared memory and shared
anonymous mappings.  That may be reasonable.

> I've experimented with using chcon to set the type after mounting which seems 
> to work OK.
> 
> I believe that the best option is to label the root inode of tmpfs as 
> system_u:object_r:tmp_t via initial_sid_contexts.  I've been looking at the 
> kernel code, is superblock_doinit() the right place to do a change?

Doesn't help.  We already provide labeling for tmpfs (see the tmpfs entry
in policy/fs_use).  There is only an issue if you want to distinguish
different instances of tmpfs mounts.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
