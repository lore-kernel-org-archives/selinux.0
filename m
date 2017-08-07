Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v776wdxU006626
 for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2017 02:58:39 -0400
Date: Mon, 7 Aug 2017 08:58:27 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, mgorman@suse.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, selinux@tycho.nsa.gov
Message-ID: <20170807065827.GC32434@dhcp22.suse.cz>
References: <20170802105018.GA2529@dhcp22.suse.cz>
 <CAGH-Kgt_9So8bDe=yDF3yLZHDfDgeXsnBEu_X6uE_nQnoi=5Vg@mail.gmail.com>
 <20170803081152.GC12521@dhcp22.suse.cz>
 <5aca0179-3b04-aa1a-58cd-668a04f63ae7@I-love.SAKURA.ne.jp>
 <20170803103337.GH12521@dhcp22.suse.cz>
 <201708031944.JCB39029.SJOOOLHFQFMVFt@I-love.SAKURA.ne.jp>
 <20170803110548.GK12521@dhcp22.suse.cz>
 <CAHC9VhQ_TtFPQL76OEui8_rfvDJ5i6AEdPdYLSHtn1vtWEKTOA@mail.gmail.com>
 <20170804075636.GD26029@dhcp22.suse.cz>
 <CAHC9VhR_SJUg2wkKhoeXHJeLrNFh=KYwSgz-5X57xx0Maa95Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhR_SJUg2wkKhoeXHJeLrNFh=KYwSgz-5X57xx0Maa95Mg@mail.gmail.com>
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri 04-08-17 13:12:04, Paul Moore wrote:
> On Fri, Aug 4, 2017 at 3:56 AM, Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > Btw. Should I resend the patch or somebody will take it from this email
> > thread?
> 
> No, unless your mailer mangled the patch I should be able to pull it
> from this thread.  However, I'm probably going to let this sit until
> early next week on the odd chance that anyone else wants to comment on
> the flag choice.  I'll send another reply once I merge the patch.

OK, there is certainly no hurry for merging this. Thanks!
-- 
Michal Hocko
SUSE Labs
