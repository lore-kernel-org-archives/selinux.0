Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14966
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 10:31:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26962
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 14:31:27 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA26958
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 14:31:26 GMT
Date: Thu, 20 Jun 2002 10:31:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new macro in users.te
In-Reply-To: <20020620113520.040AA5B8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206201026150.16259-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 20 Jun 2002, Russell Coker wrote:

> In my policy tree I have the following in users.te:
>
> define(`in_user_role', `
> role user_r types $1;
> #role second_user_r types $1;
> ')
>
> Then I replace this:
> role user_r types foo_t;
> with this:
> in_user_role(foo_t)
>
> I want to have multiple user roles that each have their own primary domain,
> but can change to other domains within their role, but can't access the
> primary domain for other roles.

You might want to put the macro definition in user_macros.te instead of
users.te.  My preference would be to keep all macros (or at least any
macros that are not completely private to a single .te file) in the
separate macros hierarchy.  In this case, ordering shouldn't be a problem,
since users.te is read before any of the program domains, but I'd rather
not rely on such ordering among the domain .te files.

If you permit the different user domains to share program domains (rather
than instantiating separate program domains for each user domain using a
macro), then be careful that you don't end up with unexpected interactions
among the user domains through these shared program domains.

Is the diff for this change available?  I've merged up through your
2002053110-3.diff.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
