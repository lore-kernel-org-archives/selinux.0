Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v73Ak7s1015170
 for <selinux@tycho.nsa.gov>; Thu, 3 Aug 2017 06:46:07 -0400
To: mhocko@kernel.org
Cc: pmoore@redhat.com, jeffv@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, mgorman@suse.de
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20170802105018.GA2529@dhcp22.suse.cz>
 <CAGH-Kgt_9So8bDe=yDF3yLZHDfDgeXsnBEu_X6uE_nQnoi=5Vg@mail.gmail.com>
 <20170803081152.GC12521@dhcp22.suse.cz>
 <5aca0179-3b04-aa1a-58cd-668a04f63ae7@I-love.SAKURA.ne.jp>
 <20170803103337.GH12521@dhcp22.suse.cz>
In-Reply-To: <20170803103337.GH12521@dhcp22.suse.cz>
Message-Id: <201708031944.JCB39029.SJOOOLHFQFMVFt@I-love.SAKURA.ne.jp>
Date: Thu, 3 Aug 2017 19:44:46 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Michal Hocko wrote:
> On Thu 03-08-17 19:02:57, Tetsuo Handa wrote:
> > On 2017/08/03 17:11, Michal Hocko wrote:
> > > [CC Mel]
> > > 
> > > On Wed 02-08-17 17:45:56, Paul Moore wrote:
> > >> On Wed, Aug 2, 2017 at 6:50 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > >>> Hi,
> > >>> while doing something completely unrelated to selinux I've noticed a
> > >>> really strange __GFP_NOMEMALLOC usage pattern in selinux, especially
> > >>> GFP_ATOMIC | __GFP_NOMEMALLOC doesn't make much sense to me. GFP_ATOMIC
> > >>> on its own allows to access memory reserves while the later flag tells
> > >>> we cannot use memory reserves at all. The primary usecase for
> > >>> __GFP_NOMEMALLOC is to override a global PF_MEMALLOC should there be a
> > >>> need.
> > >>>
> > >>> It all leads to fa1aa143ac4a ("selinux: extended permissions for
> > >>> ioctls") which doesn't explain this aspect so let me ask. Why is the
> > >>> flag used at all? Moreover shouldn't GFP_ATOMIC be actually GFP_NOWAIT.
> > >>> What makes this path important to access memory reserves?
> > >>
> > >> [NOTE: added the SELinux list to the CC line, please include that list
> > >> when asking SELinux questions]
> > > 
> > > Sorry about that. Will keep it in mind for next posts
> > >  
> > >> The GFP_ATOMIC|__GFP_NOMEMALLOC use in SELinux appears to be limited
> > >> to security/selinux/avc.c, and digging a bit, I'm guessing commit
> > >> fa1aa143ac4a copied the combination from 6290c2c43973 ("selinux: tag
> > >> avc cache alloc as non-critical") and the avc_alloc_node() function.
> > > 
> > > Thanks for the pointer. That makes much more sense now. Back in 2012 we
> > > really didn't have a good way to distinguish non sleeping and atomic
> > > with reserves allocations.
> > >  
> > >> I can't say that I'm an expert at the vm subsystem and the variety of
> > >> different GFP_* flags, but your suggestion of moving to GFP_NOWAIT in
> > >> security/selinux/avc.c seems reasonable and in keeping with the idea
> > >> behind commit 6290c2c43973.
> > > 
> > > What do you think about the following? I haven't tested it but it should
> > > be rather straightforward.
> > 
> > Why not at least __GFP_NOWARN ?
> 
> This would require an additional justification.

If allocation failure is not a problem, printing allocation failure messages
is nothing but noisy.

> 
> > And why not also __GFP_NOMEMALLOC ?
> 
> What would be the purpose of __GFP_NOMEMALLOC? In other words which
> context would set PF_NOMEMALLOC so that the flag would override it?
> 

When allocating thread is selected as an OOM victim, it gets TIF_MEMDIE.
Since that function might be called from !in_interrupt() context, it is
possible that gfp_pfmemalloc_allowed() returns true due to TIF_MEMDIE and
the OOM victim will dip into memory reserves even when allocation failure
is not a problem.

Thus, I think that majority of plain GFP_NOWAIT users want to use
GFP_NOWAIT | __GFP_NOWARN | __GFP_NOMEMALLOC.
