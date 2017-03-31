Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2VJKn0a030288
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 15:20:49 -0400
Received: by mail-vk0-f50.google.com with SMTP id s68so101882487vke.3
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 12:20:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201703302013.CFF26504.JFOQFSOHtFOMVL@I-love.SAKURA.ne.jp>
References: <1490706772-8013-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1490707796.6046.1.camel@tycho.nsa.gov>
 <201703282308.BHJ95808.MFFHVQLOOtJFOS@I-love.SAKURA.ne.jp>
 <CAHC9VhTxG95_iBy6WMtWj_xR1-=_=meykw1cTxN8-XepP8oo2w@mail.gmail.com>
 <201703302013.CFF26504.JFOQFSOHtFOMVL@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Mar 2017 15:20:46 -0400
Message-ID: <CAHC9VhTMNXtjToD3XmgfkT_sPsRgfRpFzdrgpgM0xrtbqy22pg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use task_alloc hook rather than task_create hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 30, 2017 at 7:13 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Paul Moore wrote:
>> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  security/selinux/hooks.c | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> When are you planning to remove the task_create() hook?
>>
>> I have no objection to this patch, and I plan to merge it, but merging
>> it now would require rebasing the selinux/next and I try to keep from
>> rebasing during the development cycle unless absolutely necessary.  I
>> think this can wait until after the next merge window, what do you
>> think?
>
> Nothing to hurry. SELinux is the only user. We can wait as much as you want.

Okay, I'll leave this in the queue and I'll merge it after the next
merge window.

Thanks.

-- 
paul moore
www.paul-moore.com
