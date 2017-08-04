Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v74L9S7Z031737
 for <selinux@tycho.nsa.gov>; Fri, 4 Aug 2017 17:09:28 -0400
Date: Fri, 4 Aug 2017 09:56:36 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, mgorman@suse.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, selinux@tycho.nsa.gov
Message-ID: <20170804075636.GD26029@dhcp22.suse.cz>
References: <20170802105018.GA2529@dhcp22.suse.cz>
 <CAGH-Kgt_9So8bDe=yDF3yLZHDfDgeXsnBEu_X6uE_nQnoi=5Vg@mail.gmail.com>
 <20170803081152.GC12521@dhcp22.suse.cz>
 <5aca0179-3b04-aa1a-58cd-668a04f63ae7@I-love.SAKURA.ne.jp>
 <20170803103337.GH12521@dhcp22.suse.cz>
 <201708031944.JCB39029.SJOOOLHFQFMVFt@I-love.SAKURA.ne.jp>
 <20170803110548.GK12521@dhcp22.suse.cz>
 <CAHC9VhQ_TtFPQL76OEui8_rfvDJ5i6AEdPdYLSHtn1vtWEKTOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhQ_TtFPQL76OEui8_rfvDJ5i6AEdPdYLSHtn1vtWEKTOA@mail.gmail.com>
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu 03-08-17 14:17:26, Paul Moore wrote:
> On Thu, Aug 3, 2017 at 7:05 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Thu 03-08-17 19:44:46, Tetsuo Handa wrote:
[...]
> >> When allocating thread is selected as an OOM victim, it gets TIF_MEMDIE.
> >> Since that function might be called from !in_interrupt() context, it is
> >> possible that gfp_pfmemalloc_allowed() returns true due to TIF_MEMDIE and
> >> the OOM victim will dip into memory reserves even when allocation failure
> >> is not a problem.
> >
> > Yes this is possible but I do not see any major problem with that.
> > I wouldn't add __GFP_NOMEMALLOC unless there is a real runaway of some
> > sort that could be abused.
> 
> Adding __GFP_NOMEMALLOC would not hurt anything would it?

I is not harmfull but I fail to see how it would be useful either and as
such it just adds a pointless gfp flag and confusion to whoever tries to
modify the code in future. Really the main purpose of __GFP_NOMEMALLOC
is to override the process scope PF_MEMALLOC. As such it is quite a hack
and the fewer users we have the better.

Btw. Should I resend the patch or somebody will take it from this email
thread?
-- 
Michal Hocko
SUSE Labs
