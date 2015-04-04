Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t340nYgm022741
 for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2015 20:49:35 -0400
Date: Sat, 4 Apr 2015 11:49:24 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
In-Reply-To: <CAHC9VhRXygXu7UD=rsjsKn5n1UmFozixHmtrhFWohmHbOjijUA@mail.gmail.com>
Message-ID: <alpine.LRH.2.11.1504041149070.24778@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <alpine.LRH.2.11.1504022331430.4811@namei.org> <3507958.kG4l2LfREA@sifl>
 <alpine.LRH.2.11.1504031344190.16304@namei.org>
 <CAHC9VhSHRWDuA+DKV_XxMq4+b5Q64O2_E6dpPmouoM3OO4rA7Q@mail.gmail.com>
 <alpine.LRH.2.11.1504040206200.15145@namei.org>
 <CAHC9VhRXygXu7UD=rsjsKn5n1UmFozixHmtrhFWohmHbOjijUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 3 Apr 2015, Paul Moore wrote:

> On Fri, Apr 3, 2015 at 11:07 AM, James Morris <jmorris@namei.org> wrote:
> > On Fri, 3 Apr 2015, Paul Moore wrote:
> >
> >> > Yep, I saw that and some backmerge strangeness.  Did you rebase your tree
> >> > after I created a fresh branch?
> >>
> >> It looks like I'm based off your tree from Feb 1st, the last commit
> >> from your tree looks to be: 11cd64a234d5a1a7111627ef947beb0e5fad9e71.
> >>
> >> Do you need me to rebase?
> >>
> >
> > Yep, see if that fixes things.
> 
> Okay, try it now; I rebased selinux#upstream against your latest next
> branch.  The same patches are included, just in a slightly different
> order, and I included the error code fix for -stable since it isn't in
> your next branch or Linus' current.
> 

It's in Linus' current as 6436a123a147db51a

-- 
James Morris
<jmorris@namei.org>
