Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7A72Idx026638
 for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2017 03:02:18 -0400
Date: Thu, 10 Aug 2017 09:02:06 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: mgorman@suse.de, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, selinux@tycho.nsa.gov
Message-ID: <20170810070206.GA23863@dhcp22.suse.cz>
References: <20170803081152.GC12521@dhcp22.suse.cz>
 <5aca0179-3b04-aa1a-58cd-668a04f63ae7@I-love.SAKURA.ne.jp>
 <20170803103337.GH12521@dhcp22.suse.cz>
 <201708031944.JCB39029.SJOOOLHFQFMVFt@I-love.SAKURA.ne.jp>
 <20170803110548.GK12521@dhcp22.suse.cz>
 <CAHC9VhQ_TtFPQL76OEui8_rfvDJ5i6AEdPdYLSHtn1vtWEKTOA@mail.gmail.com>
 <20170804075636.GD26029@dhcp22.suse.cz>
 <CAHC9VhR_SJUg2wkKhoeXHJeLrNFh=KYwSgz-5X57xx0Maa95Mg@mail.gmail.com>
 <20170807065827.GC32434@dhcp22.suse.cz>
 <CAHC9VhRGmBn7EA1iLzHjv2A3nawc5ZtZs+cjdVm4BUX0wGGHVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhRGmBn7EA1iLzHjv2A3nawc5ZtZs+cjdVm4BUX0wGGHVA@mail.gmail.com>
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue 08-08-17 09:34:15, Paul Moore wrote:
> On Mon, Aug 7, 2017 at 2:58 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 04-08-17 13:12:04, Paul Moore wrote:
> >> On Fri, Aug 4, 2017 at 3:56 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > [...]
> >> > Btw. Should I resend the patch or somebody will take it from this email
> >> > thread?
> >>
> >> No, unless your mailer mangled the patch I should be able to pull it
> >> from this thread.  However, I'm probably going to let this sit until
> >> early next week on the odd chance that anyone else wants to comment on
> >> the flag choice.  I'll send another reply once I merge the patch.
> >
> > OK, there is certainly no hurry for merging this. Thanks!
> > --
> > Michal Hocko
> > SUSE Labs
> 
> Merged into selinux/next with this patch description, and your
> sign-off (I had to munge the description a bit based on the thread).
> Are you okay with this, especially your sign-off?

Yes. Thanks!

> 
>   commit 476accbe2f6ef69caeebe99f52a286e12ac35aee
>   Author: Michal Hocko <mhocko@kernel.org>
>   Date:   Thu Aug 3 10:11:52 2017 +0200
> 
>    selinux: use GFP_NOWAIT in the AVC kmem_caches
> 
>    There is a strange __GFP_NOMEMALLOC usage pattern in SELinux,
>    specifically GFP_ATOMIC | __GFP_NOMEMALLOC which doesn't make much
>    sense.  GFP_ATOMIC on its own allows to access memory reserves while
>    __GFP_NOMEMALLOC dictates we cannot use memory reserves.  Replace this
>    with the much more sane GFP_NOWAIT in the AVC code as we can tolerate
>    memory allocation failures in that code.
> 
>    Signed-off-by: Michal Hocko <mhocko@kernel.org>
>    Acked-by: Mel Gorman <mgorman@suse.de>
>    Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> -- 
> paul moore
> www.paul-moore.com

-- 
Michal Hocko
SUSE Labs
