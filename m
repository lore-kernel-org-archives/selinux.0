Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05125
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 07:56:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA27789
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 11:54:55 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA27785 for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 11:54:54 GMT
Date: Wed, 10 Jul 2002 07:55:50 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: audit bug in fd handling
In-Reply-To: <20020710074550.C3E6D106@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207100750250.26546-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Jul 2002, Russell Coker wrote:

> It seems that when a file handle open read/write is inherited by a domain
> that is permitted read access only, an error about write access will be
> logged - even if there is a dontaudit rule!

Congratulations, you've found a bug.  It isn't limited to file descriptor
inheritance - it occurs whenever multiple permissions are checked
simultaneously and at least one of the permissions is allowed.  A
workaround would be to specify the full set of permissions in the
dontaudit rule, e.g. 'dontaudit system_mail_t system_crond_tmp_t:file {
read write };'.  I'll post a patch for the SELinux module shortly.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
