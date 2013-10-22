Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MMumEj028649
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 18:56:58 -0400
Date: Wed, 23 Oct 2013 09:57:10 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux updates for 3.12
In-Reply-To: <1555773.9HG4XCv3Zi@sifl>
Message-ID: <alpine.LRH.2.02.1310230956570.7063@tundra.namei.org>
References: <2307607.HXDCGv9Ccf@sifl> <1587641.zEKSTAkKTO@sifl> <alpine.LRH.2.02.1310222220050.5947@tundra.namei.org> <1555773.9HG4XCv3Zi@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 22 Oct 2013, Paul Moore wrote:

> On Tuesday, October 22, 2013 10:20:38 PM James Morris wrote:
> > On Mon, 21 Oct 2013, Paul Moore wrote:
> > > Why does a branch need to be specified?  The changes live in master and my
> > > understanding was that if a branch was not explicitly listed then master
> > > should be used.
> > 
> > Ok, I'll do that.  I'm not going to assume it.
> > 
> > > > git-pull fails in any case.
> > > 
> > > Can you be more explicit?  It works for me ...
> > 
> > $ git pull git://git.infradead.org/users/pcmoore/selinux
> > You asked to pull from the remote
> > 'git://git.infradead.org/users/pcmoore/selinux', but did not specify
> > a branch. Because this is not the default configured remote
> > for your current branch, you must specify a branch on the command line.
> 
> Looking at your next branch, it looks like you were able to pull successfully 
> from my master branch ... are you set for 3.12?

Yep, thanks.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
