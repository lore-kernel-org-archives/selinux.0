Subject: Re: [PATCH] libselinux: add support for pcre2
To: Jason Zaman <jason@perfinion.com>,
 William Roberts <bill.c.roberts@gmail.com>
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
Cc: Janis Danisevskis <jdanis@google.com>,
 Janis Danisevskis <jdanis@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <77ceec87-5ce6-c7f6-9620-bf2ac045f21c@tycho.nsa.gov>
Date: Fri, 16 Sep 2016 10:52:54 -0400
MIME-Version: 1.0
In-Reply-To: <20160916133146.GA8294@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2016 09:31 AM, Jason Zaman wrote:
> On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:
>> On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <jdanis@google.com> wrote:
>>> I don't mind. Then before sefcontext_compile -r gets widely adapted we
>>> should change the semantic quickly. I'll prepare a patch.
>>
>> Did I miss something and this was merged? Iv'e been out recovering
>> from a surgery so I haven't been
>> following this as well as I normally would have,
>>
>> If its merged, just leave it.
> 
> Its the very latest thing in master yeah, but I do also agree with changing it.
> 
> I just wanted to add that from a distro perspective, compiling things by
> default makes more sense. In gentoo, the package post_install runs
> sefcontext_compile. Using the fcontext files happens a lot more than any
> updates to libselinux (and thus potential format changes) so I'm pretty
> sure most people would prefer to have the speedup.
> 
> Gentoo does it on the machine itself, I am not sure about redhat or
> debian but I wouldnt be surprised if they do it per-arch at the very
> least so cross-arch probably isnt an issue.

In Red Hat, SELinux policy is noarch, and they switched to precompiling
both policy and file_contexts.bin at build time to minimize the cost at
package install time.  Otherwise, in small VMs, they had issues with
running out of memory during semodule -B.  So file_contexts.bin
presently has to be arch-independent, or we need the arch properties
detection logic and fallback.  That said, none of this matters unless
you build with USE_PCRE2=y, and no one outside of Android is doing that
today.

> Also, I think we should add the arch to the version string stored. I
> would rather have false negatives than positives especially since we are
> not 100% sure exactly what part of the arch is important. We can always
> loosen it up later if that gets locked down.

We don't want the arch string itself, because that would invalidate use
of file_contexts.bin entirely on typical Android use cases (build on
x86_64, install to ARM), but only the relevant properties.  And for
Android, that is fatal - there is no file_contexts text file on which to
fallback anymore.  They only ship file_contexts.bin.
