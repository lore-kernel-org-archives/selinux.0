Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA07510
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 23:17:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA21727
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 03:17:27 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id DAA21722
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 03:17:27 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: Proposal: install policy.conf
Date: Tue, 28 May 2002 23:21:07 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIMEOMKDAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0205281109490.1315-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> With regard to the issue of using policy.conf as the basis for tools that
> are used to create or change the policy, I'm somewhat concerned by the
> loss in modularity provided by the separation of .te files and the loss in
> higher level abstraction provided by the macros.  I suppose that we could
> extend the base language itself to provide direct constructs for "modules"
> and for some of the higher level abstractions currently expressed via
> macros.

I guess this is the real point.  The make directory structure is one, dare
I say somewhat limited, structure for building policies.  I would hope we
would not force compatibility at that level.

We're writing near-term tools (and others I understand are looking at longer
term tools with richerlanguage semantics).  In either case, I think we will
find
compatibility with the make directory difficult and limiting.  For example,
we
considered adding a role management tab in our seuser tool.  However, given
our
attempt to maintain compatibility with the make directory, and given that
that
directory was recently restructured to scatter the role definitions
throughout the
directory structure (understandably for better management within the make
structure), we gave up on roles.  Users on the other hand are placed in a
single file in
the make directory.

What I would rather do is break backward compatibility with the make
directory,
and maintain separate, local copies of users and role definitions, and as
part of the
policy install/load/update process, put those definitions into policy.conf
directly.

Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
