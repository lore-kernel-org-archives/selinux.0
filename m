Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27210
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 09:27:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA00012
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 13:25:55 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA00008
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 13:25:55 GMT
Date: Mon, 29 Apr 2002 09:26:50 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: f980215 <f980215@mailandnews.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: how to hide one file or one directory 
In-Reply-To: <002401c1ef4f$907499a0$780aa8c0@r213>
Message-ID: <Pine.GSO.4.33.0204290911150.19520-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Apr 2002, f980215 wrote:

> I install selinux-2.4.18 rpm packages on rh7.2
>
> How to hide one file or one directory from everyone , even root ?
>
> BTW: using LIDS, I can hide file or directory.

SELinux doesn't try to hide individual filenames within a directory.
You can prevent all accesses to a file, including stat'ing it, but the
ability to see a filename is based on the directory's protections, since
the filename is part of the directory's state.  If a process has read
permission to a directory, it can see all names in that directory.  Hiding
filenames would be possible by filtering directory reads, as is done in
some other systems like LIDS, but it isn't clear that this functionality
is worth the cost.  Even if you hide names, you still need to control all
attempted accesses to the file, and a process can still probe for the
existence of a file by trying to create a file with the same name.

At present, LSM does not provide a hook for filtering directory reads,
since this functionality is not within the scope of LSM.  Hence, I don't
think that the LSM-based LIDS provides this feature either.

Multi-Level Secure (MLS) systems frequently provide a partitioned
directory mechanism known as multi-level directories for things like
/tmp, where a process is transparently redirected to a dynamically
created subdirectory of /tmp based on its security level.  The SELinux
architecture includes support for a generalization of this idea, but we
haven't implemented the corresponding mechanism in the filesystem.  See
the discussion of polyinstantiation and security union directories in the
Flask paper.  This hasn't been a high priority for us yet.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
