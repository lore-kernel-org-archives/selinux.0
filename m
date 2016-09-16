MIME-Version: 1.0
In-Reply-To: <CAFftDdq1wiYt7Bvs9f2v-CrwY7uMOFhqPg2PSomd93zxmBf9=w@mail.gmail.com>
References: <1473948269-143019-1-git-send-email-jdanis@android.com>
 <25614fcd-20d5-c8ed-2d8a-7f47ae7938de@tycho.nsa.gov>
 <CAFftDdqDF1vC8-JQmZWPd2VZ7HpOQ7S5WagCfuxULtGU6+Q72w@mail.gmail.com>
 <CAAdwW5O6O630ORMOPBd0-2hg7xXGhgX=e6JEA2Poirz=8TFK6g@mail.gmail.com>
 <CAFftDdr+DqYSDOdjE7d5f6uz3++gvQqi2heJX7CJJXaHQQibVA@mail.gmail.com>
 <CAAdwW5PQvft0ZzFuG52Eid2Z=vZtvnmuOLw-_p+0x9bY+GZDGg@mail.gmail.com>
 <CAFftDdpN7Dzmt+5C1rADZh71wyoy+GrYf8eXUhv5GrOS-8_Leg@mail.gmail.com>
 <CAAdwW5M+qzpzZKqM0vvtCRvv14re_ahTLW_4E+wpezAiK8qqaA@mail.gmail.com>
 <CAFftDdodugeHpjiZRvr8J_5_UXQ92+iE+pO7Yq9RDSgPfrLTtw@mail.gmail.com>
 <20160916133146.GA8294@meriadoc.perfinion.com>
 <CAFftDdq1wiYt7Bvs9f2v-CrwY7uMOFhqPg2PSomd93zxmBf9=w@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 06:51:25 -0700
Message-ID: <CAFftDdpuJUmvntWZq7TM+cDnr84iT5QBVS1TB2OOj190AV-2Cg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: Jason Zaman <jason@perfinion.com>
Cc: Janis Danisevskis <jdanis@google.com>,
 Janis Danisevskis <jdanis@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 16, 2016 at 6:43 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Sep 16, 2016 at 6:31 AM, Jason Zaman <jason@perfinion.com> wrote:
>> On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:
>>> On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <jdanis@google.com> wrote:
>>> > I don't mind. Then before sefcontext_compile -r gets widely adapted we
>>> > should change the semantic quickly. I'll prepare a patch.
>>>
>>> Did I miss something and this was merged? Iv'e been out recovering
>>> from a surgery so I haven't been
>>> following this as well as I normally would have,
>>>
>>> If its merged, just leave it.
>>
>> Its the very latest thing in master yeah, but I do also agree with changing it.
>
> I'd prefer it changed myself. Another argument pro-change is that one doesn't
> know if its a PCRE2 or PCRE1 compatable version of the libraries, we should
> probably have an ability to intergoate that via API so we can print it
> out in help
> dialogue, that this tool so we at least know what it can support.
>
> The biggest thing that needs to get fixed with this, is that no matter
> if it contains the
> pre-compiled regexs or not, it should always load and work on Android.
> In distros,
> it will fall back to file_contexts, but we don't have this in Android.
> This ties into the arch
> version information below. But if the arch differs, always recompile.
> The alternative to
> this, is just go back to textual fc file son Android, since we won't
> be using any of the
> features of binary fc's. Better yet, in the Android build, I would
> check to see if host arch
> is the same as target arch, or let an OEM set a flag, to do the
> compilation. But I would
> consider those stretch goals, and just revert android back to textual files.

My ramblings might not be clear here. If we just version it with arch
and require
an exact match, we don't need -r, so that option goes away.



<snip>
