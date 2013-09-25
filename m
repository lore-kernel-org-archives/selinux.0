Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PLVVrD028533
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 17:31:31 -0400
Date: Wed, 25 Sep 2013 21:31:28 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <pmoore@redhat.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov
Subject: Re: [selinux-testsuite RFC PATCH 1/4] test_policy: test_global.te
 fix for Fedora Rawhide (Sept 24th, 2013)
Message-ID: <20130925213128.GA20734@mail.hallyn.com>
References: <20130924162401.27393.70353.stgit@localhost>
 <20130924163321.27393.64105.stgit@localhost>
 <20130924164925.GA8126@mail.hallyn.com>
 <5683488.YDqq1IeJBx@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5683488.YDqq1IeJBx@sifl>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Moore (pmoore@redhat.com):
> On Tuesday, September 24, 2013 04:49:25 PM Serge E. Hallyn wrote:
> > Quoting Paul Moore (pmoore@redhat.com):
> > > Signed-off-by: Paul Moore <pmoore@redhat.com>
> > 
> > Thanks, Paul!  This break had been reported to me and I got as far
> > as tracking it to its cause, but I hadn't yet figured out what to
> > replace it by.
> 
> No problem.
> 
> > I assume you're saying it's not strictly necessary :) All the better.
> 
> Well, I guess what I'm trying to say is that I'm not sure if this is the right 
> fix, but it does at least resolve the build problems I'm seeing.  I have yet 
> to check to see if it works correctly.
> 
> > Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
> 
> Ack?  I thought you were the one maintaining the test suite?

Yes, that's me saying I'll apply that.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
