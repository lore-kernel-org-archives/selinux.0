Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07918
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2001 11:45:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA27250
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2001 16:45:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil  with ESMTP id QAA27246
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2001 16:45:26 GMT
Date: Mon, 19 Mar 2001 11:45:23 -0500 (EST)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200103191645.LAA08103@coalstove.epoch.ncsc.mil>
To: kmrussel@hsc.vcu.edu
Subject: Re: SELinux compatible with XFS?
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A labeled file system is necessary to do anything usefull with
SELinux.  We have not currently done any work to provide labels in
XFS.  Echoing Stephen Smalley's note to Mark Lucas on Friday about
ReiserFS, we provide general support for all file systems for mapping
persistent security identifiers (PSIDs) to security contexts in
fs/psid.c, so each file system type only needs to implement support for
binding a PSID to each on-disk inode.  With ext2, we were able to use
an unused field in the on-disk inode to store the PSID.

While I'm not completely familiar with XFS, my understanding is that
one of its advantages is that it stores extended attributes with the
files.  So, it should, hopefully, be relatively easy to add a PSID to the
extended file attributes.  That said, it isn't one of NSA's priorities
to add that support.  If someone else wants it enough to do the work,
we'd certainly like to see the results made available.

K Mitchell Russell writes: 
>
> Is the SELinux patch for 2.4.2 kernel usable with an existing Linux
> (SGI) XFS filesystem?  Or does it require the ext2 filesystem for
> labelling.  Just thought I would check with other's experiences before
> embarking down this tortuous path.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
