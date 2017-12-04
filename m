Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB4GUIj9005136
 for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2017 11:30:18 -0500
Received: by mail-pf0-f178.google.com with SMTP id p84so8895565pfd.3
 for <selinux@tycho.nsa.gov>; Mon, 04 Dec 2017 08:30:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGH-Kgv+Nj2fpR+3SjnKJk1KMBZqqm9CwD2UAMau539nxtpU4g@mail.gmail.com>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <1512395025.20988.3.camel@tycho.nsa.gov>
 <CACT4Y+Z50TGJj8PhJczMt4zF8aMyr5586GsJ7LAmS-Bf-QkXiw@mail.gmail.com>
 <CAGH-Kgv+Nj2fpR+3SjnKJk1KMBZqqm9CwD2UAMau539nxtpU4g@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 4 Dec 2017 17:29:49 +0100
Message-ID: <CACT4Y+bKC5d135iFAP0qdU7EG+11n7HeCm2d54KwqNfCLMGrpA@mail.gmail.com>
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

On Mon, Dec 4, 2017 at 2:59 PM, Paul Moore <pmoore@redhat.com> wrote:
>>>> > ==================================================================
>>>> > BUG: KASAN: slab-out-of-bounds in strcmp+0x96/0xb0 lib/string.c:328
>>>> > Read of size 1 at addr ffff8801cd99d2c1 by task
>>>> > syzkaller242593/3087
>>>> >
>>>> > CPU: 0 PID: 3087 Comm: syzkaller242593 Not tainted 4.15.0-rc1-next-
>>>> > 20171201+ #57
>>>> > Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>> > BIOS Google 01/01/2011
>>>> > Call Trace:
>>>> >  __dump_stack lib/dump_stack.c:17 [inline]
>>>> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
>>>> >  print_address_description+0x73/0x250 mm/kasan/report.c:252
>>>> >  kasan_report_error mm/kasan/report.c:351 [inline]
>>>> >  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>>>> >  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:427
>>>> >  strcmp+0x96/0xb0 lib/string.c:328
>>>>
>>>> This seems to be out of bound read for "scontext" at
>>>>
>>>>       for (i = 1; i < SECINITSID_NUM; i++) {
>>>>               if (!strcmp(initial_sid_to_string[i], scontext)) {
>>>>                       *sid = i;
>>>>                       return 0;
>>>>               }
>>>>       }
>>>>
>>>> because "initial_sid_to_string[i]" is "const char *".
>>>>
>>>> >  security_context_to_sid_core+0x437/0x620
>>>> > security/selinux/ss/services.c:1420
>>>> >  security_context_to_sid+0x32/0x40
>>>> > security/selinux/ss/services.c:1479
>>>> >  selinux_setprocattr+0x51c/0xb50 security/selinux/hooks.c:5986
>>>> >  security_setprocattr+0x85/0xc0 security/security.c:1264
>>>>
>>>> If "value" does not terminate with '\0' or '\n', "value" and
>>>> "size" are as-is passed to "scontext" and "scontext_len" above
>>>>
>>>>       /* Obtain a SID for the context, if one was specified. */
>>>>       if (size && str[0] && str[0] != '\n') {
>>>>               if (str[size-1] == '\n') {
>>>>                       str[size-1] = 0;
>>>>                       size--;
>>>>               }
>>>>               error = security_context_to_sid(value, size, &sid,
>>>> GFP_KERNEL);
>>>>
>>>> which will allow strcmp() to trigger out of bound read when "size" is
>>>> larger than strlen(initial_sid_to_string[i]).
>>>>
>>>> Thus, I guess the simplest fix is to use strncmp() instead of
>>>> strcmp().
>>>
>>> Already fixed by
>>> https://www.spinics.net/lists/selinux/msg23589.html
>>
>>
>> Paul, please also follow this part:
>>
>>> syzbot will keep track of this bug report.
>>> Once a fix for this bug is committed, please reply to this email with:
>>> #syz fix: exact-commit-title
>>> Note: all commands must start from beginning of the line in the email body.
>>
>> This will greatly help to keep overall process running. Thanks.
>
> When is the right time to do this?  The text say to reply when a patch
> has been committed, but where?  My selinux/next branch?  Linus'
> master?  Your docs and the end of the email needs to be more clear on
> this.

Hi Paul,

We are just rolling in the process. Feedback is much appreciated!

The idea is that we need to know the title as it will appear in Linus
tree and in other tested trees. It's also possible to override the
title later, if there is any mess with it. So sending "#syz fix" as
soon as it is merged into any tree looks like the best option (to not
require you to keep in mind that you also need to do that tiny bit in
a month).

Are the following changes look good to you?
For email footer:

-Once a fix for this bug is committed, please reply to this email with:
+Once a fix for this bug is merged into any tree, reply to this email with:
#syz fix: exact-commit-title


And for the https://github.com/google/syzkaller/blob/master/docs/syzbot.md page:

to attach a fixing commit to the bug:
#syz fix: exact-commit-title
+It's enough that the commit is merged into any tree, in particular,
+you don't need to wait for the commit to be merged into upstream tree.
+syzbot only needs to know the title by which it will appear in tested trees.
+In case of an error or a title change, you can override the commit simply
+by sending another #syz fix command.



> For the record, I did see that part of the syzbot mail but I was

Then sorry for pinging. We are trying to establish the process, and
some developers don't notice that part, so I just wanted to make sure.

> waiting until I merged that patch; v2 was posted late in the week and
> I was giving it a few days in case someone saw something
> objectionable.

In such case you can do either way. You can wait, or you can post
commit title as soon as you have enough assurance that that's the
title with which it will appear in trees. We don't want to put too
much burden on developers. As I said, it's possible to override it
later, or we will notice that there is a commit that bot is waiting
for too long.

Thanks
