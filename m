Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OLdXcn015067
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 17:39:33 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OLdWJc011164
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 21:39:32 GMT
Subject: Re: [PATCH 25/33] libsemanage: policy server database hooks
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070423213744.959901000@tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213744.959901000@tresys.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 17:39:31 -0400
Message-Id: <1177450771.3428.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 17:35 -0400, jbrindle@tresys.com wrote:
> plain text document attachment (semanage.ps_api.diff)
> Implements all database functions for a policy server backend.

Any thoughts on how this should be merged? I'm concerned about merging
without a working policy server that has been reviewed as well.

* What are your plans for the policy server - will it be proposed for
inclusion upstream?

* What is the timeline for completion of the policy server?

* Are their any docs at all about the protocol?

* Any progress on the exec-based policy server instead of the long
running daemon?

Basically - this patch set is too large to review, there have been no
ongoing design discussions, there is no way to review large portions of
the patch set due to external dependencies, and I have seen no proposed
plan for merging.

I have voiced these concerns previously and without at least some of the
above I'm opposed merging at this time.

I would suggest as an alternative plan you do a depth-first submission
instead of the breadth-first approach that you are currently attempting.
That would allow a review of the end-to-end design with a relatively
small amount of code. From that point expanding the coverage would only
require a quick review that the patch continues on the already accepted
approach.

That steps that I suggest are:

* Choose a _single_ and _simple_ semanage operation to control.
Something like adding a role to a user.

* Post a minimal policy server that can control this operation
(preferably exec-based).

* Post the libsemange code to communicate with the server _only_ that
single operation.

* Create an example policy that controls this operation that can be used
to test and demonstrate the functionality.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
