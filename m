Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GIvIrJ029499
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 14:57:20 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so97108921qkc.3
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 11:57:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <77ceec87-5ce6-c7f6-9620-bf2ac045f21c@tycho.nsa.gov>
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
 <77ceec87-5ce6-c7f6-9620-bf2ac045f21c@tycho.nsa.gov>
From: Janis Danisevskis <jdanis@android.com>
Date: Fri, 16 Sep 2016 19:57:15 +0100
Message-ID: <CA+xTVEvzmjqOtKRKiapx-xfMKDRcKQV6JkFdV3eM9R1we6Jdqg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jason Zaman <jason@perfinion.com>,
 William Roberts <bill.c.roberts@gmail.com>,
 Janis Danisevskis <jdanis@google.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11488a42e6c70c053ca48775
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11488a42e6c70c053ca48775
Content-Type: text/plain; charset=UTF-8

I have started implementing an arch string patch. Unfortunately, i did
not manage to finish it before I had to leave the office today.
In essence I did this:
The regex_arch_string has three components: the pointer width determined
by sizeof(void*), PCRE2_SIZE width determined by sizeof(), and
endianess determined by
__BYTE_ORDER__==__ORDER_BIG/LITTEL_ENDIAN__

For example, the resulting string for x86_64 and aarch64el should look like
this: "8-8-el".

I bumped the compiled context version number and added the string
right after the version in the output.
Comments?


On Fri, Sep 16, 2016 at 3:52 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/16/2016 09:31 AM, Jason Zaman wrote:
> > On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:
> >> On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <jdanis@google.com>
> wrote:
> >>> I don't mind. Then before sefcontext_compile -r gets widely adapted we
> >>> should change the semantic quickly. I'll prepare a patch.
> >>
> >> Did I miss something and this was merged? Iv'e been out recovering
> >> from a surgery so I haven't been
> >> following this as well as I normally would have,
> >>
> >> If its merged, just leave it.
> >
> > Its the very latest thing in master yeah, but I do also agree with
> changing it.
> >
> > I just wanted to add that from a distro perspective, compiling things by
> > default makes more sense. In gentoo, the package post_install runs
> > sefcontext_compile. Using the fcontext files happens a lot more than any
> > updates to libselinux (and thus potential format changes) so I'm pretty
> > sure most people would prefer to have the speedup.
> >
> > Gentoo does it on the machine itself, I am not sure about redhat or
> > debian but I wouldnt be surprised if they do it per-arch at the very
> > least so cross-arch probably isnt an issue.
>
> In Red Hat, SELinux policy is noarch, and they switched to precompiling
> both policy and file_contexts.bin at build time to minimize the cost at
> package install time.  Otherwise, in small VMs, they had issues with
> running out of memory during semodule -B.  So file_contexts.bin
> presently has to be arch-independent, or we need the arch properties
> detection logic and fallback.  That said, none of this matters unless
> you build with USE_PCRE2=y, and no one outside of Android is doing that
> today.
>
> > Also, I think we should add the arch to the version string stored. I
> > would rather have false negatives than positives especially since we are
> > not 100% sure exactly what part of the arch is important. We can always
> > loosen it up later if that gets locked down.
>
> We don't want the arch string itself, because that would invalidate use
> of file_contexts.bin entirely on typical Android use cases (build on
> x86_64, install to ARM), but only the relevant properties.  And for
> Android, that is fatal - there is no file_contexts text file on which to
> fallback anymore.  They only ship file_contexts.bin.
>
>

--001a11488a42e6c70c053ca48775
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have started implementing an arch string patch. Unfortun=
ately, i did<div>not manage to finish it before I had to leave the office t=
oday.</div><div>In essence I did this:</div><div>The regex_arch_string has =
three components: the pointer width determined</div><div>by sizeof(void*), =
PCRE2_SIZE width determined by sizeof(), and</div><div>endianess determined=
 by</div><div>__BYTE_ORDER__=3D=3D__ORDER_BIG/LITTEL_ENDIAN__</div><div><br=
></div><div>For example, the resulting string for x86_64 and aarch64el shou=
ld look like</div><div>this: &quot;8-8-el&quot;.</div><div><br></div><div>I=
 bumped the compiled context version number and added the string</div><div>=
right after the version in the output.</div><div>Comments?</div><div><br></=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri,=
 Sep 16, 2016 at 3:52 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"=
mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 09/16/2016 0=
9:31 AM, Jason Zaman wrote:<br>
&gt; On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:<br>
&gt;&gt; On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis &lt;<a href=3D"=
mailto:jdanis@google.com">jdanis@google.com</a>&gt; wrote:<br>
&gt;&gt;&gt; I don&#39;t mind. Then before sefcontext_compile -r gets widel=
y adapted we<br>
&gt;&gt;&gt; should change the semantic quickly. I&#39;ll prepare a patch.<=
br>
&gt;&gt;<br>
&gt;&gt; Did I miss something and this was merged? Iv&#39;e been out recove=
ring<br>
&gt;&gt; from a surgery so I haven&#39;t been<br>
&gt;&gt; following this as well as I normally would have,<br>
&gt;&gt;<br>
&gt;&gt; If its merged, just leave it.<br>
&gt;<br>
&gt; Its the very latest thing in master yeah, but I do also agree with cha=
nging it.<br>
&gt;<br>
&gt; I just wanted to add that from a distro perspective, compiling things =
by<br>
&gt; default makes more sense. In gentoo, the package post_install runs<br>
&gt; sefcontext_compile. Using the fcontext files happens a lot more than a=
ny<br>
&gt; updates to libselinux (and thus potential format changes) so I&#39;m p=
retty<br>
&gt; sure most people would prefer to have the speedup.<br>
&gt;<br>
&gt; Gentoo does it on the machine itself, I am not sure about redhat or<br=
>
&gt; debian but I wouldnt be surprised if they do it per-arch at the very<b=
r>
&gt; least so cross-arch probably isnt an issue.<br>
<br>
</span>In Red Hat, SELinux policy is noarch, and they switched to precompil=
ing<br>
both policy and file_contexts.bin at build time to minimize the cost at<br>
package install time.=C2=A0 Otherwise, in small VMs, they had issues with<b=
r>
running out of memory during semodule -B.=C2=A0 So file_contexts.bin<br>
presently has to be arch-independent, or we need the arch properties<br>
detection logic and fallback.=C2=A0 That said, none of this matters unless<=
br>
you build with USE_PCRE2=3Dy, and no one outside of Android is doing that<b=
r>
today.<br>
<span class=3D""><br>
&gt; Also, I think we should add the arch to the version string stored. I<b=
r>
&gt; would rather have false negatives than positives especially since we a=
re<br>
&gt; not 100% sure exactly what part of the arch is important. We can alway=
s<br>
&gt; loosen it up later if that gets locked down.<br>
<br>
</span>We don&#39;t want the arch string itself, because that would invalid=
ate use<br>
of file_contexts.bin entirely on typical Android use cases (build on<br>
x86_64, install to ARM), but only the relevant properties.=C2=A0 And for<br=
>
Android, that is fatal - there is no file_contexts text file on which to<br=
>
fallback anymore.=C2=A0 They only ship file_contexts.bin.<br>
<br>
</blockquote></div><br></div>

--001a11488a42e6c70c053ca48775--
