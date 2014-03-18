Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2ICnSNv014637
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2014 08:49:28 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 3.15
Date: Tue, 18 Mar 2014 08:49:07 -0400
Message-ID: <2065464.ftu8fijlua@sifl>
In-Reply-To: <alpine.LRH.2.02.1403181326240.10830@tundra.namei.org>
References: <2794067.Wx0yCIiBrQ@sifl> <1685091.iJm6M33sra@sifl>
 <alpine.LRH.2.02.1403181326240.10830@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, March 18, 2014 01:26:40 PM James Morris wrote:
> On Mon, 17 Mar 2014, Paul Moore wrote:
> > On Monday, March 17, 2014 07:21:59 AM Eric Paris wrote:
> > > You think a security tree based on 3.13-rc7 is good and Paul, who
> > > tested on the actual release of 3.13 is bad?
> > > 
> > > I know you got yelled at for randomly picking fast forward-ish merge
> > > points, but now you've got a crappy merge point.  Apparently, it was
> > > needed it for the Xen/TPM work (not sure why YOU merged it instead of
> > > the TPM people, but that's beside the point).
> > > 
> > > But the problem stands.  You are based on a crummy location.  When are
> > > you going to pick up 3.13?  After 3.14 is out?
> > > 
> > > Seems like Paul's move to include 3.13 made a lot of sense...
> > 
> > This issue with the linux-security tree keeps coming up and I stand by my
> > earlier statements that I would much prefer if the linux-security is based
> > off the latest kernel release, e.g. 3.13 as of today.  This seems to be
> > in keeping with Linus' comments, fits with what Eric was doing back when
> > he managed the SELinux tree, and strikes a nice balance between stability
> > and "newness".  I plan on continuing with this approach for the SELinux
> > tree.
> > 
> > However, I don't want the 3.15 patches to get lost due to these stupid
> > differences so I've created a new branch that has the SELinux 3.15 patches
> > applied on top of linux-security#next.
> > 
> >  * git://git.infradead.org/users/pcmoore/selinux next
> 
> What's the new branch?  That seems to be the same.

My mistake, the new branch is "next-jmorris".

[This is likely a duplicate for some of you, my phone sent a html message last 
time so it was dropped by the list.]

-- 
paul moore
security and virtualization @ redhat
