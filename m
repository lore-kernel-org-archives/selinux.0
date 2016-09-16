MIME-Version: 1.0
In-Reply-To: <20160916133146.GA8294@meriadoc.perfinion.com>
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
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 06:43:39 -0700
Message-ID: <CAFftDdq1wiYt7Bvs9f2v-CrwY7uMOFhqPg2PSomd93zxmBf9=w@mail.gmail.com>
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

On Fri, Sep 16, 2016 at 6:31 AM, Jason Zaman <jason@perfinion.com> wrote:
> On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:
>> On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <jdanis@google.com> wrote:
>> > I don't mind. Then before sefcontext_compile -r gets widely adapted we
>> > should change the semantic quickly. I'll prepare a patch.
>>
>> Did I miss something and this was merged? Iv'e been out recovering
>> from a surgery so I haven't been
>> following this as well as I normally would have,
>>
>> If its merged, just leave it.
>
> Its the very latest thing in master yeah, but I do also agree with changing it.

I'd prefer it changed myself. Another argument pro-change is that one doesn't
know if its a PCRE2 or PCRE1 compatable version of the libraries, we should
probably have an ability to intergoate that via API so we can print it
out in help
dialogue, that this tool so we at least know what it can support.

The biggest thing that needs to get fixed with this, is that no matter
if it contains the
pre-compiled regexs or not, it should always load and work on Android.
In distros,
it will fall back to file_contexts, but we don't have this in Android.
This ties into the arch
version information below. But if the arch differs, always recompile.
The alternative to
this, is just go back to textual fc file son Android, since we won't
be using any of the
features of binary fc's. Better yet, in the Android build, I would
check to see if host arch
is the same as target arch, or let an OEM set a flag, to do the
compilation. But I would
consider those stretch goals, and just revert android back to textual files.

>
> I just wanted to add that from a distro perspective, compiling things by
> default makes more sense. In gentoo, the package post_install runs
> sefcontext_compile. Using the fcontext files happens a lot more than any
> updates to libselinux (and thus potential format changes) so I'm pretty
> sure most people would prefer to have the speedup.

For the distros it will make sense most of the time from what I can tell.

>
> Gentoo does it on the machine itself, I am not sure about redhat or
> debian but I wouldnt be surprised if they do it per-arch at the very
> least so cross-arch probably isnt an issue.
>
> Also, I think we should add the arch to the version string stored. I
> would rather have false negatives than positives especially since we are
> not 100% sure exactly what part of the arch is important. We can always
> loosen it up later if that gets locked down.

No don't append it onto the PCRE version string, just check the PCRE
version string
and if its greater than X read out the arch field next. This should
work like policy versioning
in libsepol.


>
> Isnt the selinux policy in android stored in the rootfs or /system?
> isnt that all read-only? how would re-compiling on the device work?
> Does android put the fcontext.bin files on /data? that seems insecure.

This is the cross compile aspect, we build on the host and shove it
into the device
rootfs at build time. We typically build on x86_64 and deploy on ARM.
But this is NOT
always the case, just the most common. For instance, with Intel
tablets it probably can
use the pre-compiled regexes.

>
> -- Jason
>
>> > On Fri, Sep 16, 2016 at 1:35 PM William Roberts <bill.c.roberts@gmail.com>
>> > wrote:
>> >>
>> >> <snip>
>> >> >
>> >> >
>> >> > That's just the thing. Without -r the phone _will_ boot because the
>> >> > regexes
>> >> > are compiled on first use. With -r and an arch mismatch we have an
>> >> > undefined
>> >> > behavior, which is bad.
>> >>
>> >> That's just a limitation of the current design.
>> >>
>> >> >
>> >> > See, I don't currently know what part of the architecture is important.
>> >> > Will
>> >> > word size and endianess be enough, e.g., will regexes generated on
>> >> > x86_64el
>> >> > work on armv8el (apparently this is what I observed but it could change
>> >> > at
>> >> > the whim of the PCRE2 maintainers)? So what will be the encoding? If we
>> >> > encode the complete architecture then the typical case for android
>> >> > (build on
>> >> > x86_64 for armv7/armv8) will yield the same result as without the -r
>> >> > option,
>> >> > namely, we rebuild the regexes on the device. If we just encode word
>> >> > size
>> >> > and endianess it may work for a while... I just don't feel comfortable
>> >> > enough to make a decision at this point.
>> >>
>> >> Then shelve it and use textual file contexts. The only purpose of the
>> >> binary format is to
>> >> include the pre-compiled regex;s so if you cant use that feature,
>> >> there's no point in
>> >> using binary format.
>> >>
>> >> My thought would be that it has to be an exact match for architecture
>> >> upfront, then
>> >> possibly investigate relaxing the requirement later. But, IIRC, if we get
>> >> a 30%
>> >> increase in text file load time, theirs really no point, for the
>> >> binary format on Android.
>> >> Android fic files are smaller, and have much simpler regex's compared
>> >> to our desktop
>> >> brethren.
>> >>
>> >> >
>> >> > My limited understanding is that the automata built by PCRE2 use
>> >> > pointers to
>> >> > link states or other structures. These pointers are symbolized when
>> >> > serialized, but they keep their width, which is why the regexes are at
>> >> > least
>> >> > sensitive to the word size.
>> >> >
>> >> > Just a wild Idea:
>> >> > PCRE2 also supports JIT compiling. I did not use this here because I did
>> >> > not
>> >> > feel comfortable for libselinux to depend on the execmem permission. But
>> >> > this could be developed into pre cross compiling the regexes into native
>> >> > code, which can than be linked into a device specific library. But I
>> >> > guess
>> >> > this would require quite some cooperation with the PCRE2 developers.
>> >>
>> >> I was going to ask if the arch dependency was on JIT'd code or just
>> >> something else
>> >> which you elaborated above with word size/endiness, etc.
>> >>
>> >> >
>> >> >>
>> >> >> The other thing is, this is only an issue on binary formated
>> >> >> file_context
>> >> >> files,
>> >> >> this is the ideal reason to move back to text files, since their is no
>> >> >> speedup
>> >> >> gained if we have to compile them.
>> >> >
>> >> >
>> >> > Right, or you could see it as an intermediate solution that does not
>> >> > require
>> >> > changes to the build system until we can properly cross compile the
>> >> > regexes.
>> >>
>> >> If you add an option to sefcontext_compile it should be to remove
>> >> them. not add it in.
>> >> This keeps it consistent with teh behavior for PCRE, it would be add
>> >> to say, "make me
>> >> a binary fc, but don't actually embed the regex information", since
>> >> that is currently not
>> >> the default behavior. Changing the Android make recipe is trivial, so
>> >> adding -r shouldn't
>> >> for Android shouldn't be a show stopper.
>> >>
>> >> <snip>
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>> _______________________________________________
>> Seandroid-list mailing list
>> Seandroid-list@tycho.nsa.gov
>> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Seandroid-list-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
