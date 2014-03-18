Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2I2FUIA006217
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2014 22:15:30 -0400
Date: Tue, 18 Mar 2014 13:15:38 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.15
In-Reply-To: <1685091.iJm6M33sra@sifl>
Message-ID: <alpine.LRH.2.02.1403181315060.10830@tundra.namei.org>
References: <2794067.Wx0yCIiBrQ@sifl>
 <alpine.LRH.2.02.1403171445570.2002@tundra.namei.org>
 <CACLa4pukOH8TLmRorra4Wh0962y-QF4D2eFzgvr7KSSJnSLKZw@mail.gmail.com>
 <1685091.iJm6M33sra@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 17 Mar 2014, Paul Moore wrote:

> On Monday, March 17, 2014 07:21:59 AM Eric Paris wrote:
> > You think a security tree based on 3.13-rc7 is good and Paul, who
> > tested on the actual release of 3.13 is bad?
> > 
> > I know you got yelled at for randomly picking fast forward-ish merge
> > points, but now you've got a crappy merge point.  Apparently, it was
> > needed it for the Xen/TPM work (not sure why YOU merged it instead of
> > the TPM people, but that's beside the point).
> > 
> > But the problem stands.  You are based on a crummy location.  When are
> > you going to pick up 3.13?  After 3.14 is out?
> > 
> > Seems like Paul's move to include 3.13 made a lot of sense...
> 
> This issue with the linux-security tree keeps coming up and I stand by my 
> earlier statements that I would much prefer if the linux-security is based off 
> the latest kernel release, e.g. 3.13 as of today.  This seems to be in keeping 
> with Linus' comments, fits with what Eric was doing back when he managed the 
> SELinux tree, and strikes a nice balance between stability and "newness".  I 
> plan on continuing with this approach for the SELinux tree.

Ok, I'll try syncing to major releases from 3.14.


> 
> However, I don't want the 3.15 patches to get lost due to these stupid 
> differences so I've created a new branch that has the SELinux 3.15 patches 
> applied on top of linux-security#next.
> 
>  * git://git.infradead.org/users/pcmoore/selinux next
>  
> > On Sun, Mar 16, 2014 at 11:51 PM, James Morris <jmorris@namei.org> wrote:
> > > On Fri, 14 Mar 2014, Paul Moore wrote:
> > >> Hi James,
> > >> 
> > >> Here are the SELinux patches for 3.15.  There are three patches here, the
> > >> first and last are obvious fixes and the middle patch is a
> > >> straightforward
> > >> DAC-before-MAC fix.  They should merge into the linux-security tree
> > >> without
> > >> problem.
> > >> 
> > >> Enjoy,
> > >> -Paul
> > > 
> > > Your tree is ahead of mine wrt Linus.  It doesn't apply.
> 
> -- 
> paul moore
> security and virtualization @ redhat
> 

-- 
James Morris
<jmorris@namei.org>
