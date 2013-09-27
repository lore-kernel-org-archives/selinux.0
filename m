Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8RIS3lW024032
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2013 14:28:04 -0400
From: Paul Moore <pmoore@redhat.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [selinux-testsuite RFC PATCH 1/4] test_policy: test_global.te fix for Fedora Rawhide (Sept 24th, 2013)
Date: Fri, 27 Sep 2013 14:27:57 -0400
Message-ID: <2005921.GfJLMYTuNC@sifl>
In-Reply-To: <20130927181530.GA18663@mail.hallyn.com>
References: <20130924162401.27393.70353.stgit@localhost> <1766823.fsKzVQ5zMg@sifl> <20130927181530.GA18663@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, September 27, 2013 06:15:30 PM Serge E. Hallyn wrote:
> Quoting Paul Moore (pmoore@redhat.com):
> > On Wednesday, September 25, 2013 09:31:28 PM Serge E. Hallyn wrote:
> > > Quoting Paul Moore (pmoore@redhat.com):
> > > > On Tuesday, September 24, 2013 04:49:25 PM Serge E. Hallyn wrote:
> > > > > Quoting Paul Moore (pmoore@redhat.com):
> > > > > > Signed-off-by: Paul Moore <pmoore@redhat.com>
> > > > > 
> > > > > Thanks, Paul!  This break had been reported to me and I got as far
> > > > > as tracking it to its cause, but I hadn't yet figured out what to
> > > > > replace it by.
> > > > 
> > > > No problem.
> > > > 
> > > > > I assume you're saying it's not strictly necessary :) All the
> > > > > better.
> > > > 
> > > > Well, I guess what I'm trying to say is that I'm not sure if this is
> > > > the
> > > > right fix, but it does at least resolve the build problems I'm seeing.
> > > >  I
> > > > have yet to check to see if it works correctly.
> > > > 
> > > > > Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
> > > > 
> > > > Ack?  I thought you were the one maintaining the test suite?
> > > 
> > > Yes, that's me saying I'll apply that.
> > 
> > Great, thanks.
> 
> Thanks, Paul, all tests passed (on f19) with your patches!

Great, glad they worked for you too.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
