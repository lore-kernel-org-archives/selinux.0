Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RFdsgA025040
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 11:39:55 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5RFdNjQ019486
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 15:39:23 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506271508.j5RF7tqc018129@gotham.columbia.tresys.com>
References: <200506271508.j5RF7tqc018129@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 11:36:40 -0400
Message-Id: <1119886600.18293.50.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> An alternative option is to leave the home directory keywords unexpanded and
> have matchpatchcon expand them on demand. This requires knowledge of what is a
> home directory, which is difficult to get. We can either store that information
> somewhere or require the caller to provide, e.g., setfiles could get a flag that
> to allow the admin to specify which directories are home directories.

I disagree that expansions necessarily have to relate to home
directories, and I think it's difficult to predict how expansions will
work in the future. It's hard to come up with a concrete example - this
really depends on what we choose to do with policy in the future.
The point is that we are moving complex logic into a low-level program
such as matchpathcon...and I'm not sure we should do that. It's
a layering issue - where should complexity be placed.

> Anyone else have some insight? It really files like we are over-engineering this
> problem and there is some simple solution once we fully understand the problem.
> I have the gut feeling that pre-expanded file_contexts is the wrong way to go,
> but no clear argument as to why. 

You have a point that we're storing mostly redundant information, but
that's often necessary to achieve speed and simplicity - isn't that
exactly the problem with the in-kernel policy?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
