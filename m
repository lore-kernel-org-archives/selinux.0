Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13884
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 09:29:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA27626
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 13:28:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA27622
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 13:28:48 GMT
Date: Tue, 4 Jun 2002 09:28:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: auditdeny is painful
In-Reply-To: <20020603223026.44BC568D@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206040908440.3949-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 4 Jun 2002, Russell Coker wrote:

> I think that auditdeny is misdesigned.  Having to specify that we want to
> audit the opposite of what we don't want to audit is really confusing when
> you first start, and even with some practise it can result in results other
> than what you expect.  Consider the situation where you want to specify in
> one file to not audit getattr while in another file you want to specify not
> to audit search (this has seemed to be impossible in my tests).

The auditdeny access vector specifies what permission denials should be
audited.  If no auditdeny access vector is specified for a particular
(type, type, class) triple, then all permission denials are audited for
that triple, since you typically want to audit all denials by default.
When you specify an auditdeny rule, you are indicating that only a
particular subset of permission denials should be audited for that (type,
type, class) triple.   You can either specify that subset of permission
denials positively, listing the set of permissions that you want audited,
or negatively, specifying the complement (~) of a set of permissions that
you don't want audited, as with other rules.  When multiple auditdeny
rules are specified for a single (type, type, class) triple, the union of
the permission sets is used, as with other rules.

I suppose that we could introduce a dontaudit rule that automatically
generates auditdeny access vectors with the complement of the specified
set of permissions, and that uses the intersection of the permission sets
when multiple rules are specified for a single (type, type, class) triple.
This would likely be more suited to what a human would expect.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
