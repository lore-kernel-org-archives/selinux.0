Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07188
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:33:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26914
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:31:55 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA26908
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:31:53 GMT
Date: Tue, 27 Aug 2002 10:32:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: FYI: woody startup messages
In-Reply-To: <20020827161633.A23590@lemuria.org>
Message-ID: <Pine.GSO.4.33.0208271028010.14544-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 27 Aug 2002, Tom wrote:

> maybe there is also a bug in the path output? look at this:
>
> Aug 27 16:24:30 nsa kernel: avc:  denied  { getattr } for  pid=614 exe=/bin/ls path=/local/bin dev=03:06 ino=1586155 scontext=tom:user_r:user_t tcontext=system_u:object_r:seuser_exec_t tclass=dir
> Aug 27 16:24:30 nsa kernel: avc:  denied  { read } for  pid=614 exe=/bin/ls path=/local/bin dev=03:06 ino=1586155 scontext=tom:user_r:user_t tcontext=system_u:object_r:seuser_exec_t tclass=dir
>
>
> the command that caused this error was:
>
> tom@nsa:~$ ls /usr/local/bin
>
>
> and this is consistent. everywhere I look, the initial /usr is stripped
> from the path. same for content in /var, but not for /etc. on this
> system, /usr and /var are on their own partitions, /etc is not - is it
> possible that it strips the mount point away?

This isn't a bug, and was asked previously on the list, most recently on
8/20 (http://marc.theaimsgroup.com/?l=selinux&m=102985179503728&w=2).  You
can only reconstruct an "absolute" (no such thing) pathname if you have a
vfsmount and a dentry, and many of the file-related permission checks only
have an inode or a dentry available at the point where they are checked.
As with the port number issue, this merely affects the audit output, not
the permission check.  SELinux is inode-based, not path-based.  The path
information is merely a hint to help understand the audit message and is
not reliable.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
