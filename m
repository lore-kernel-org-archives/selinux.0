Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19746
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:26:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA07555
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:26:02 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA07551
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:26:02 GMT
Date: Fri, 24 May 2002 11:25:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: signal permissions
In-Reply-To: <20020523080857.BB39948E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205241124180.23057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 23 May 2002, Russell Coker wrote:

> Why is it possible to specify sigstop but not sigcont in the permissions?
> Surely it would make sense to be able to control starting in the same way as
> controlling stopping?  If you allow "signal" access to get the sigcont then
> you are also allowing sigusr*, sigsegv, etc.
>
> Also what about sighup?

Distinct permissions are provided for signals that cannot be caught or
ignored (sigkill, sigstop), since they may have different security
implications.  A distinct permission is also provided for sigchld, since it
is commonly granted between a child and its parent without wanting to grant
other signal permissions.

It would be easy to provide a distinct permission for every signal, but it
isn't clear that whether such distinctions would be worthwhile.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
