Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17047
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 13:44:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA11130
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 18:43:10 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA11126 for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 18:43:08 GMT
Date: Mon, 25 Mar 2002 13:44:05 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Mix and Match 2: relabel problems
In-Reply-To: <20020325111320.CC3632AB@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203251337470.1015-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 25 Mar 2002, Russell Coker wrote:

> One noteworthy thing I've done with the devfsd shared object is made any
> context that doesn't contain a ':' have "system_u:object_r:" be prepended.
>
> I am wondering whether it would make sense to do the same for file_contexts,
> putting in system_u:object_r seems to be just needless typing.

We'd like to minimize the set of code that has any awareness of the
internal format and meaning of the security context, so that people can
easily create their own security servers with their own security models
with no changes to the rest of the kernel and only minimal changes to
userspace.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
