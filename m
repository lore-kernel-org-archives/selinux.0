Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA27406
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 08:50:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA25448
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:48:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA25442 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:48:45 GMT
Date: Tue, 9 Jul 2002 08:49:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: JW <jw@centraltexasit.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Make relabel problems with rsync and localtime
In-Reply-To: <200207090104.19564.jw@centraltexasit.com>
Message-ID: <Pine.GSO.4.33.0207090843110.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, JW wrote:

> conflicting specifications for /usr/sbin/rsyncd and /usr/bin/rsync, using system_u:object_r:sbin_t.
> conflicting specifications for /usr/share/zoneinfo/US/Central and /etc/localtime, using system_u:object_r:usr_t.
>
> I cna't find _anything_ about rsyncd with grep, and the things I find about
> localtime and Central are just in the src, not in any policy files (at least
> I cna't see if they are).
>
> Does anyone know how to solve these 2 problems?

The problem is that you have multiple hard links to a single file in
directories that being assigned different types (sbin_t vs bin_t and usr_t
vs. etc_t).  Hence, setfiles isn't certain which type to assign to the
inode.  In this case, the default behavior looks ok to me, so you don't
really need to do anything.  To avoid the warnings on future runs, add
explicit entries to your file_contexts/types.fc configuration to remove
the ambiguity, e.g.:

/etc/localtime	system_u:object_r:usr_t
/usr/bin/rsync	system_u:object_r:sbin_t

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
