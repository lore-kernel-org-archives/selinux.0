Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA05606
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2002 16:34:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA12699
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2002 21:33:35 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id VAA12695
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2002 21:33:34 GMT
Date: Fri, 4 Jan 2002 16:33:19 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Christie, Richard" <ChristieR@atsgroup.saic.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Syntax for users for MLS
In-Reply-To: <39C5845092F9D1119AA90008C724FC7C03C18CD6@US-Columbia.mail.saic.com>
Message-ID: <Pine.GSO.4.33.0201041622330.16643-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 4 Jan 2002, Christie, Richard wrote:

> Can someone please tell me the correct syntax for the
> policy/users file to support MLS? I know that entries
> for this file are to take the form of
> user username roles role_set [ranges MLS range_set]
>
> I am unsure of what form the MLS range set syntax is supposed to be.
>
> an example
>
> user mrbean roles {user_r} ranges {u c s ts};

Yes, that should be fine if you want the user to be able to login as a
singlelevel entity at any one of those levels.  If you want the user to be
able to create multilevel shells, then you'll want to specify a range
rather than just a single level, e.g. u-ts.

> Is there better documentation on how to implement MLS somewhere?

Aside from selinux/README.MLS and the brief discussion of the MLS
configuration in the old technical report
(http://www.nsa.gov/selinux/doc/slinux/node18.html), no.  The model of MLS
that is implemented is described in the Flask FTLS, available at
http://www.cs.utah.edu/flux/flask.  As mentioned in the README.MLS, the
MLS policy needs some work to be useable.

The focus of our work to date has been on the RBAC and TE policies, since
these policies are of more general interest to the Linux community.  Of
course, you can always represent a MLS policy as a TE configuration,
although your state space will explode if you have a large number of
levels.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
