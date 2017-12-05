Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB59dpZr021841
 for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2017 04:39:53 -0500
Received: by mail-pg0-f47.google.com with SMTP id g7so10309735pgs.0
 for <selinux@tycho.nsa.gov>; Tue, 05 Dec 2017 01:39:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGH-KgvjP35Sz=_MO8Mcdpe06j5-z7Jh1pUwJrD+QxyuzWyQAA@mail.gmail.com>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <1512395025.20988.3.camel@tycho.nsa.gov>
 <CACT4Y+Z50TGJj8PhJczMt4zF8aMyr5586GsJ7LAmS-Bf-QkXiw@mail.gmail.com>
 <CAGH-Kgv+Nj2fpR+3SjnKJk1KMBZqqm9CwD2UAMau539nxtpU4g@mail.gmail.com>
 <CACT4Y+bKC5d135iFAP0qdU7EG+11n7HeCm2d54KwqNfCLMGrpA@mail.gmail.com>
 <CAGH-KgvjP35Sz=_MO8Mcdpe06j5-z7Jh1pUwJrD+QxyuzWyQAA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 5 Dec 2017 10:39:25 +0100
Message-ID: <CACT4Y+Y23S4EmiciJwWDk+qpo9ntuggSeujcG6+6wL6x8QoOMw@mail.gmail.com>
To: Paul Moore <pmoore@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzbot
 <bot+015afdb01dbf2abb6a6bfdd5430b72e5503fca6d@syzkaller.appspotmail.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 dledford@redhat.com, Matthias Kaehlcke <mka@chromium.org>,
 junil0814.lee@lge.com, kyeongdon kim <kyeongdon.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: KASAN: slab-out-of-bounds Read in strcmp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 4, 2017 at 10:10 PM, Paul Moore <pmoore@redhat.com> wrote:
>> Hi Paul,
>>
>> We are just rolling in the process. Feedback is much appreciated!
>>
>> The idea is that we need to know the title as it will appear in Linus
>> tree and in other tested trees. It's also possible to override the
>> title later, if there is any mess with it. So sending "#syz fix" as
>> soon as it is merged into any tree looks like the best option (to not
>> require you to keep in mind that you also need to do that tiny bit in
>> a month).
>>
>> Are the following changes look good to you?
>> For email footer:
>>
>> -Once a fix for this bug is committed, please reply to this email with:
>> +Once a fix for this bug is merged into any tree, reply to this email with:
>> #syz fix: exact-commit-title
>>
>> And for the https://github.com/google/syzkaller/blob/master/docs/syzbot.md page:
>>
>> to attach a fixing commit to the bug:
>> #syz fix: exact-commit-title
>> +It's enough that the commit is merged into any tree, in particular,
>> +you don't need to wait for the commit to be merged into upstream tree.
>> +syzbot only needs to know the title by which it will appear in tested trees.
>> +In case of an error or a title change, you can override the commit simply
>> +by sending another #syz fix command.
>
> That is an improvement, yes.  I might also mention that you would
> prefer if the syzkaller-bugs list is CC'd on the commands; that wasn't
> clear to me until I got a message back from syzbot just now.
>
>>> For the record, I did see that part of the syzbot mail but I was
>>
>> Then sorry for pinging. We are trying to establish the process, and
>> some developers don't notice that part, so I just wanted to make sure.
>
> I would *strongly* suggest spending some time trying to find a
> mechanism that doesn't rely on developers needing to send special
> commands to your system to register fixes; that seems prone to failure
> if you want my honest opinion.


I completely agree. I've spent time trying to find such scheme, and
I've talked to other kernel developers, and we were not able to come
up with anything working.
Similar user-space system assume that the target is single-threaded
and deterministic and that they always have a _reliable_ reproducer
and that re-testing is fast; and than they just re-test everything on
every build. Nothing of this is true for kernel: it's highly
concurrent and non-deterministic, we don't always have reproducers,
when we have them they are not reliable and testing takes whole lot of
time. If we try to do the same, we will produce email churn declaring
bugs as fixed and then filing them as new bugs again.

One option that come up, though, is that a different of doing this
could be adding something like:

Syzbot-bug: 015afdb01dbf2abb6a6bfdd5430b72e5503fca6d

tag to commits. But then again, people will miss that, people will
mess that, and we will have to add "#syz fix" tags here and there.

A full-fledged bug tracking system would help, but as far as I
understand kernel bugzilla is ignored by most, and when it's not
ignored, from what I saw, people don't bother even marking fixed bugs
as fixed.

If somebody has other ideas, I am listening.


> At the very least you might consider moving the instructions to the
> top of the message.

Yes, this is probably something we need to consider.

>>> waiting until I merged that patch; v2 was posted late in the week and
>>> I was giving it a few days in case someone saw something
>>> objectionable.
>>
>> In such case you can do either way. You can wait, or you can post
>> commit title as soon as you have enough assurance that that's the
>> title with which it will appear in trees. We don't want to put too
>> much burden on developers. As I said, it's possible to override it
>> later, or we will notice that there is a commit that bot is waiting
>> for too long.
>>
>> Thanks
>
> --
> paul moore
> security @ redhat
