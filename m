To: paul@paul-moore.com
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selinux: Use task_alloc hook rather than task_create hook
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <1490706772-8013-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1490707796.6046.1.camel@tycho.nsa.gov>
 <201703282308.BHJ95808.MFFHVQLOOtJFOS@I-love.SAKURA.ne.jp>
 <CAHC9VhTxG95_iBy6WMtWj_xR1-=_=meykw1cTxN8-XepP8oo2w@mail.gmail.com>
In-Reply-To: <CAHC9VhTxG95_iBy6WMtWj_xR1-=_=meykw1cTxN8-XepP8oo2w@mail.gmail.com>
Message-Id: <201703302013.CFF26504.JFOQFSOHtFOMVL@I-love.SAKURA.ne.jp>
Date: Thu, 30 Mar 2017 20:13:04 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore wrote:
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/hooks.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> When are you planning to remove the task_create() hook?
> 
> I have no objection to this patch, and I plan to merge it, but merging
> it now would require rebasing the selinux/next and I try to keep from
> rebasing during the development cycle unless absolutely necessary.  I
> think this can wait until after the next merge window, what do you
> think?

Nothing to hurry. SELinux is the only user. We can wait as much as you want.
