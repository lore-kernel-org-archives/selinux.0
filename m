Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB4Dm6Bh027472
 for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2017 08:48:06 -0500
Received: by mail-pf0-f179.google.com with SMTP id u25so8547015pfg.5
 for <selinux@tycho.nsa.gov>; Mon, 04 Dec 2017 05:47:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512395025.20988.3.camel@tycho.nsa.gov>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <1512395025.20988.3.camel@tycho.nsa.gov>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 4 Dec 2017 14:47:34 +0100
Message-ID: <CACT4Y+Z50TGJj8PhJczMt4zF8aMyr5586GsJ7LAmS-Bf-QkXiw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzbot
 <bot+015afdb01dbf2abb6a6bfdd5430b72e5503fca6d@syzkaller.appspotmail.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 dledford@redhat.com, Matthias Kaehlcke <mka@chromium.org>,
 junil0814.lee@lge.com, kyeongdon kim <kyeongdon.kim@lge.com>,
 Paul Moore <pmoore@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: KASAN: slab-out-of-bounds Read in strcmp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 4, 2017 at 2:43 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2017-12-03 at 20:33 +0900, Tetsuo Handa wrote:
>> On 2017/12/02 3:52, syzbot wrote:
>> > ==================================================================
>> > BUG: KASAN: slab-out-of-bounds in strcmp+0x96/0xb0 lib/string.c:328
>> > Read of size 1 at addr ffff8801cd99d2c1 by task
>> > syzkaller242593/3087
>> >
>> > CPU: 0 PID: 3087 Comm: syzkaller242593 Not tainted 4.15.0-rc1-next-
>> > 20171201+ #57
>> > Hardware name: Google Google Compute Engine/Google Compute Engine,
>> > BIOS Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:17 [inline]
>> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
>> >  print_address_description+0x73/0x250 mm/kasan/report.c:252
>> >  kasan_report_error mm/kasan/report.c:351 [inline]
>> >  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>> >  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:427
>> >  strcmp+0x96/0xb0 lib/string.c:328
>>
>> This seems to be out of bound read for "scontext" at
>>
>>       for (i = 1; i < SECINITSID_NUM; i++) {
>>               if (!strcmp(initial_sid_to_string[i], scontext)) {
>>                       *sid = i;
>>                       return 0;
>>               }
>>       }
>>
>> because "initial_sid_to_string[i]" is "const char *".
>>
>> >  security_context_to_sid_core+0x437/0x620
>> > security/selinux/ss/services.c:1420
>> >  security_context_to_sid+0x32/0x40
>> > security/selinux/ss/services.c:1479
>> >  selinux_setprocattr+0x51c/0xb50 security/selinux/hooks.c:5986
>> >  security_setprocattr+0x85/0xc0 security/security.c:1264
>>
>> If "value" does not terminate with '\0' or '\n', "value" and
>> "size" are as-is passed to "scontext" and "scontext_len" above
>>
>>       /* Obtain a SID for the context, if one was specified. */
>>       if (size && str[0] && str[0] != '\n') {
>>               if (str[size-1] == '\n') {
>>                       str[size-1] = 0;
>>                       size--;
>>               }
>>               error = security_context_to_sid(value, size, &sid,
>> GFP_KERNEL);
>>
>> which will allow strcmp() to trigger out of bound read when "size" is
>> larger than strlen(initial_sid_to_string[i]).
>>
>> Thus, I guess the simplest fix is to use strncmp() instead of
>> strcmp().
>
> Already fixed by
> https://www.spinics.net/lists/selinux/msg23589.html


Paul, please also follow this part:

> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> Note: all commands must start from beginning of the line in the email body.


This will greatly help to keep overall process running. Thanks.
