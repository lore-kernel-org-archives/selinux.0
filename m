Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t342axWH027996
 for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2015 22:37:00 -0400
Received: by paboj16 with SMTP id oj16so52680883pab.0
 for <selinux@tycho.nsa.gov>; Fri, 03 Apr 2015 19:36:57 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Date: Sat, 04 Apr 2015 13:36:54 +1100
Message-ID: <14c8249b1d0.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <alpine.LRH.2.11.1504041149070.24778@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <alpine.LRH.2.11.1504022331430.4811@namei.org>
 <3507958.kG4l2LfREA@sifl>
 <alpine.LRH.2.11.1504031344190.16304@namei.org>
 <CAHC9VhSHRWDuA+DKV_XxMq4+b5Q64O2_E6dpPmouoM3OO4rA7Q@mail.gmail.com>
 <alpine.LRH.2.11.1504040206200.15145@namei.org>
 <CAHC9VhRXygXu7UD=rsjsKn5n1UmFozixHmtrhFWohmHbOjijUA@mail.gmail.com>
 <alpine.LRH.2.11.1504041149070.24778@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 4.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'll have to look closer when I'm back in front of a system, perhaps I 
missed it.

More importantly, did you pull from the SELinux upstream branch?

--
paul moore
www.paul-moore.com



On April 4, 2015 11:49:29 AM James Morris <jmorris@namei.org> wrote:

> On Fri, 3 Apr 2015, Paul Moore wrote:
>
> > On Fri, Apr 3, 2015 at 11:07 AM, James Morris <jmorris@namei.org> wrote:
> > > On Fri, 3 Apr 2015, Paul Moore wrote:
> > >
> > >> > Yep, I saw that and some backmerge strangeness.  Did you rebase your 
> tree
> > >> > after I created a fresh branch?
> > >>
> > >> It looks like I'm based off your tree from Feb 1st, the last commit
> > >> from your tree looks to be: 11cd64a234d5a1a7111627ef947beb0e5fad9e71.
> > >>
> > >> Do you need me to rebase?
> > >>
> > >
> > > Yep, see if that fixes things.
> >
> > Okay, try it now; I rebased selinux#upstream against your latest next
> > branch.  The same patches are included, just in a slightly different
> > order, and I included the error code fix for -stable since it isn't in
> > your next branch or Linus' current.
> >
>
> It's in Linus' current as 6436a123a147db51a
>
> --
> James Morris
> <jmorris@namei.org>
>
