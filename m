Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00300
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 08:57:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA17157
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 13:54:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id NAA17153
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 13:54:39 GMT
Message-Id: <200303031405.JAA18259@moss-shockers.ncsc.mil>
Date: Mon, 3 Mar 2003 09:05:21 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux and ReiserFS
To: selinux@tycho.nsa.gov, fw@fwsystems.com
Cc: ShermanB@clh.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> BTW, as JFS is now incorporated into the mainline kernel it'd be
> great to see that incorporated into the SEL patches (maybe it already
> is, I'm still working with the 2.4.19 SEL kernel).

The use of the persistent label mapping is configurable, so you can
specify additional filesystem types in your policy/fs_use
configuration.  Otherwise, the only thing you need to do is modify your
policy/Makefile relabel and reset targets to include jfs.  No change is
needed to the SELinux kernel.  I suppose we could include those changes
in the example policy.

On the other hand, I think that JFS supports extended attributes, so you
might want to look into using EAs for storing file security contexts
rather than using the persistent label mapping for JFS.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
