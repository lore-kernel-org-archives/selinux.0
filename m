MIME-Version: 1.0
In-Reply-To: <CAAdwW5M+qzpzZKqM0vvtCRvv14re_ahTLW_4E+wpezAiK8qqaA@mail.gmail.com>
References: <1473948269-143019-1-git-send-email-jdanis@android.com>
 <25614fcd-20d5-c8ed-2d8a-7f47ae7938de@tycho.nsa.gov>
 <CAFftDdqDF1vC8-JQmZWPd2VZ7HpOQ7S5WagCfuxULtGU6+Q72w@mail.gmail.com>
 <CAAdwW5O6O630ORMOPBd0-2hg7xXGhgX=e6JEA2Poirz=8TFK6g@mail.gmail.com>
 <CAFftDdr+DqYSDOdjE7d5f6uz3++gvQqi2heJX7CJJXaHQQibVA@mail.gmail.com>
 <CAAdwW5PQvft0ZzFuG52Eid2Z=vZtvnmuOLw-_p+0x9bY+GZDGg@mail.gmail.com>
 <CAFftDdpN7Dzmt+5C1rADZh71wyoy+GrYf8eXUhv5GrOS-8_Leg@mail.gmail.com>
 <CAAdwW5M+qzpzZKqM0vvtCRvv14re_ahTLW_4E+wpezAiK8qqaA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 06:15:01 -0700
Message-ID: <CAFftDdodugeHpjiZRvr8J_5_UXQ92+iE+pO7Yq9RDSgPfrLTtw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: Janis Danisevskis <jdanis@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Janis Danisevskis <jdanis@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <jdanis@google.com> wrote:
> I don't mind. Then before sefcontext_compile -r gets widely adapted we
> should change the semantic quickly. I'll prepare a patch.

Did I miss something and this was merged? Iv'e been out recovering
from a surgery so I haven't been
following this as well as I normally would have,

If its merged, just leave it.

>
> On Fri, Sep 16, 2016 at 1:35 PM William Roberts <bill.c.roberts@gmail.com>
> wrote:
>>
>> <snip>
>> >
>> >
>> > That's just the thing. Without -r the phone _will_ boot because the
>> > regexes
>> > are compiled on first use. With -r and an arch mismatch we have an
>> > undefined
>> > behavior, which is bad.
>>
>> That's just a limitation of the current design.
>>
>> >
>> > See, I don't currently know what part of the architecture is important.
>> > Will
>> > word size and endianess be enough, e.g., will regexes generated on
>> > x86_64el
>> > work on armv8el (apparently this is what I observed but it could change
>> > at
>> > the whim of the PCRE2 maintainers)? So what will be the encoding? If we
>> > encode the complete architecture then the typical case for android
>> > (build on
>> > x86_64 for armv7/armv8) will yield the same result as without the -r
>> > option,
>> > namely, we rebuild the regexes on the device. If we just encode word
>> > size
>> > and endianess it may work for a while... I just don't feel comfortable
>> > enough to make a decision at this point.
>>
>> Then shelve it and use textual file contexts. The only purpose of the
>> binary format is to
>> include the pre-compiled regex;s so if you cant use that feature,
>> there's no point in
>> using binary format.
>>
>> My thought would be that it has to be an exact match for architecture
>> upfront, then
>> possibly investigate relaxing the requirement later. But, IIRC, if we get
>> a 30%
>> increase in text file load time, theirs really no point, for the
>> binary format on Android.
>> Android fic files are smaller, and have much simpler regex's compared
>> to our desktop
>> brethren.
>>
>> >
>> > My limited understanding is that the automata built by PCRE2 use
>> > pointers to
>> > link states or other structures. These pointers are symbolized when
>> > serialized, but they keep their width, which is why the regexes are at
>> > least
>> > sensitive to the word size.
>> >
>> > Just a wild Idea:
>> > PCRE2 also supports JIT compiling. I did not use this here because I did
>> > not
>> > feel comfortable for libselinux to depend on the execmem permission. But
>> > this could be developed into pre cross compiling the regexes into native
>> > code, which can than be linked into a device specific library. But I
>> > guess
>> > this would require quite some cooperation with the PCRE2 developers.
>>
>> I was going to ask if the arch dependency was on JIT'd code or just
>> something else
>> which you elaborated above with word size/endiness, etc.
>>
>> >
>> >>
>> >> The other thing is, this is only an issue on binary formated
>> >> file_context
>> >> files,
>> >> this is the ideal reason to move back to text files, since their is no
>> >> speedup
>> >> gained if we have to compile them.
>> >
>> >
>> > Right, or you could see it as an intermediate solution that does not
>> > require
>> > changes to the build system until we can properly cross compile the
>> > regexes.
>>
>> If you add an option to sefcontext_compile it should be to remove
>> them. not add it in.
>> This keeps it consistent with teh behavior for PCRE, it would be add
>> to say, "make me
>> a binary fc, but don't actually embed the regex information", since
>> that is currently not
>> the default behavior. Changing the Android make recipe is trivial, so
>> adding -r shouldn't
>> for Android shouldn't be a show stopper.
>>
>> <snip>



-- 
Respectfully,

William C Roberts
