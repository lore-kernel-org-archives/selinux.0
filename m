Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA18639
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 16:02:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA17566
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 20:00:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA17558
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 20:00:49 GMT
Date: Wed, 28 Aug 2002 16:01:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Mark =?iso-8859-1?q?M=FCller?= <trusted@web.de>, <selinux@tycho.nsa.gov>
Subject: Re: Direct logins (via local and ssh) as httpd_admin_r?
In-Reply-To: <20020828132838.134948FDA@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208281556070.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, Russell Coker wrote:

> I think that the SE Linux log messages should be more verbose in such
> situations, they should mention when it's a constraint or role issue rather
> than the usual domain/type issues.

This has come up previously.  Unfortunately, it isn't that simple.  The
AVC has no knowledge of the policy logic.  It only knows that a particular
permission for a particular (SID, SID, class) triple wasn't set in the
allowed access vector cached from the security server.  In the common case
where the access vector is already in the cache due to a prior check on
the same (SID, SID, class) triple, the security server is not involved at
all in the permission check processing.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
