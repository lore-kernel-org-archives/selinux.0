Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA01809
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 08:41:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA12842
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 12:39:50 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA12838 for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 12:39:50 GMT
Date: Mon, 24 Jun 2002 08:40:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ichsid
In-Reply-To: <20020613230056.71DDA1F38@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206240833080.10386-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 14 Jun 2002, Russell Coker wrote:

> I believe that we need a program "ichsid" to change the SID of a file by
> Inode instead of by name.
>
> The reason for this is for the mount points of /dev, /proc, /usr, and other
> file systems that are not easily/conveniantly umountable.
>
> Providing this functionality as part of the setfiles ability to change the
> context database directly when running on a non-SE kernel should not be
> difficult, and would provide the minimum functionality for getting SE Linux
> on a machine with a few reboots (boot into SE Linux, see messages such as the
> following, boot into non-SE Linux to run setfiles, then boot SE again) or
> with some debugfs work.
>
> Providing it as part of the kernel interface would be even more useful.

As you mention, providing the functionality in setfiles to directly update
the persistent label mapping based on inode number should be
straightforward, although I'm not sure about the right interface (e.g.
just a command-line invocation or a new form of specification in
file_contexts).  You would need to specify the particular filesystem as
well as the inode number, so you might specify the path of any file
within the filesystem, like statfs, and the particular inode number.

A kernel interface to update the persistent label mapping for an
inode number would likewise be straightforward, although it would bypass
the typical search permission checks on the directories in the path that
are performed by the existing chsid call.  However, finding the in-core
inode (if one exists) so that we can update it with the new SID might pose
a problem for filesystems where the inode number is not sufficient for
finding files, like reiserfs.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
