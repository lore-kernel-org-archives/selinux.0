Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06397
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 09:45:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA06655
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:44:12 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA06651
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:44:12 GMT
Date: Fri, 22 Mar 2002 09:44:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
In-Reply-To: <20020322140833.GD2123@vnl.com>
Message-ID: <Pine.GSO.4.33.0203220934580.29643-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 22 Mar 2002, Dale Amon wrote:

> Perhaps a 'setfiles --dump > file_contexts' capability is in order?

Yes, automatically updating the file contexts configuration based on the
filesystem state would be useful, although it may not be
completely straightforward.  If you simply want an exhaustive listing of
files and their contexts, you can use the modified find program.  But
the file contexts configuration is much more concise, as it uses
pathname regular expressions.  To update the file contexts configuration,
you would likely want setfiles to read an existing configuration and only
output entries for files whose security contexts are not consistent with
the existing configuration.  This isn't that different from using
setfiles -vn to show what files would be relabeled without actually
performing any relabeling, except that the output format would be
different.  Ideally, setfiles would also perform some degree of
intelligent filtering, e.g. coalescing new entries that can be captured by
a single pathname regular expression.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
