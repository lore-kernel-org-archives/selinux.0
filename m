Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7ADnV6R010261
 for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2017 09:49:32 -0400
Received: by mail-lf0-f48.google.com with SMTP id d17so3855479lfe.0
 for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2017 06:49:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170810070206.GA23863@dhcp22.suse.cz>
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
 <20170810070206.GA23863@dhcp22.suse.cz>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Aug 2017 09:49:11 -0400
Message-ID: <CAHC9VhRnV8ME3XoWmkSNpWZz0DSOpW8tt5Doa1N08bSz0ws9=A@mail.gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: mgorman@suse.de, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: suspicious __GFP_NOMEMALLOC in selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 10, 2017 at 3:02 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Tue 08-08-17 09:34:15, Paul Moore wrote:
>> On Mon, Aug 7, 2017 at 2:58 AM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Fri 04-08-17 13:12:04, Paul Moore wrote:
>> >> On Fri, Aug 4, 2017 at 3:56 AM, Michal Hocko <mhocko@kernel.org> wrote:
>> > [...]
>> >> > Btw. Should I resend the patch or somebody will take it from this email
>> >> > thread?
>> >>
>> >> No, unless your mailer mangled the patch I should be able to pull it
>> >> from this thread.  However, I'm probably going to let this sit until
>> >> early next week on the odd chance that anyone else wants to comment on
>> >> the flag choice.  I'll send another reply once I merge the patch.
>> >
>> > OK, there is certainly no hurry for merging this. Thanks!
>> > --
>> > Michal Hocko
>> > SUSE Labs
>>
>> Merged into selinux/next with this patch description, and your
>> sign-off (I had to munge the description a bit based on the thread).
>> Are you okay with this, especially your sign-off?
>
> Yes. Thanks!

Great, thanks for the confirmation.  I'll send this up during the next
merge window.

-- 
paul moore
www.paul-moore.com
