Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA19372
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 12:42:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA12510
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 17:39:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id RAA12506
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 17:39:51 GMT
Message-Id: <200302101750.MAA08335@moss-shockers.ncsc.mil>
Date: Mon, 10 Feb 2003 12:50:09 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: File labeling issue
To: selinux@tycho.nsa.gov, Kelly_Djahandari@nai.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> While testing xinetd, I ran into a problem with the build of the
> file_contexts file. Because file_contexts is a concatenation of files in
> alphabetical order, inetd.fc can override labeling of /usr/sbin/in.*d files
> if the fc file is alphabetically before inetd.fc.

The general issue has come up before on the list; it was originally
mentioned as a concern when the file contexts configuration was
partitioned into multiple files.  The setfiles logic needs to be
revised to use the best matching specification.

> The default type for files in /usr/sbin is system_u:object_r:sbin_t. If
> services started by xinetd are labeled sbin_t, they are run in the inetd_t
> domain--not good. 

Yes, which is why there is a default labeling rule to put them into
inetd_child_t.  Of course, if inetd_t doesn't need execute access to
sbin_t at all, then you could simply remove the execute permission to
it and possibly to any type that doesn't cause a domain transition.

> Talkd is an example of a service which does not have a fc
> file and would be labeled with the default inetd.fc labeling
> (inetd_child_exec_t).

Yes, the inetd_child_exec_t labeling is intended to put such daemons
into a default domain.

> Is it reasonable to request that all services started by inetd have a .fc
> file and a corresponding .te file and remove the default inetd labeling in
> inetd.fc? 

IMHO, no.

> Or should we keep the default inetd labeling and figure out some
> other way to not overwrite specific labeling? Since this could be a problem
> not just of inetd.fc, but with any wildcard usage, we may need to think of a
> more general solution. 

Yes, we should investigate revisions to the setfiles logic.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
