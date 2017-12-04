Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB4GeBYa018774
 for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2017 11:40:12 -0500
Received: by mail-pf0-f178.google.com with SMTP id a90so8926966pfk.1
 for <selinux@tycho.nsa.gov>; Mon, 04 Dec 2017 08:40:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGH-Kgv+Nj2fpR+3SjnKJk1KMBZqqm9CwD2UAMau539nxtpU4g@mail.gmail.com>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <1512395025.20988.3.camel@tycho.nsa.gov>
 <CACT4Y+Z50TGJj8PhJczMt4zF8aMyr5586GsJ7LAmS-Bf-QkXiw@mail.gmail.com>
 <CAGH-Kgv+Nj2fpR+3SjnKJk1KMBZqqm9CwD2UAMau539nxtpU4g@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 4 Dec 2017 17:39:46 +0100
Message-ID: <CACT4Y+aWCOxe0xH+bPtchX8OyNE3yVkpHmdE4QQwG443_G4aMg@mail.gmail.com>
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
>>>> On 2017/12/02 3:52, syzbot wrote:
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
>
> For the record, I did see that part of the syzbot mail but I was
> waiting until I merged that patch; v2 was posted late in the week and
> I was giving it a few days in case someone saw something
> objectionable.
>
> Also, while we are on the topic of syzbot, what SELinux policy (if
> any) do you load on the system that is undergoing testing?  Based on
> some of the recent reports it would appear that you are running a
> SELinux enabled kernel but might not be loading a SELinux policy, is
> that correct?


This is good question. The problem is that we are testing almost all
kernel subsystems, but are not experts in most of them. So frequently
we doing some non-sense. And that's where we need you help.
That's what we have for grep SECURITY .config:

CONFIG_EXT4_FS_SECURITY=y
# CONFIG_9P_FS_SECURITY is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
# CONFIG_SECURITYFS is not set
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"


I don't think we do anything else besides that.
To be fair I don't know what is SELinux policy nor how to load it. Can
you suggest a policy that would be good for testing of kernel in
general and SELinux in particular? Obviously, we don't want to
prohibit access to any major parts of kernel APIs entirely (because
then we won't test them). syzkaller also creates a local temp dir per
test process, and the process mostly accesses files there (except for
opening /dev/* and /proc/self/*). Is it possible to selectively
prohibit something there, so that we test both positive and negative
cases?

Thanks
