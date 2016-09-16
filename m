Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GDA4Em023440
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 09:10:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id k186so40723657wmd.0
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 06:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1473948269-143019-1-git-send-email-jdanis@android.com>
 <25614fcd-20d5-c8ed-2d8a-7f47ae7938de@tycho.nsa.gov>
 <CAFftDdqDF1vC8-JQmZWPd2VZ7HpOQ7S5WagCfuxULtGU6+Q72w@mail.gmail.com>
 <CAAdwW5O6O630ORMOPBd0-2hg7xXGhgX=e6JEA2Poirz=8TFK6g@mail.gmail.com>
 <CAFftDdr+DqYSDOdjE7d5f6uz3++gvQqi2heJX7CJJXaHQQibVA@mail.gmail.com>
 <CAAdwW5PQvft0ZzFuG52Eid2Z=vZtvnmuOLw-_p+0x9bY+GZDGg@mail.gmail.com>
 <CAFftDdpN7Dzmt+5C1rADZh71wyoy+GrYf8eXUhv5GrOS-8_Leg@mail.gmail.com>
In-Reply-To: <CAFftDdpN7Dzmt+5C1rADZh71wyoy+GrYf8eXUhv5GrOS-8_Leg@mail.gmail.com>
From: Janis Danisevskis <jdanis@google.com>
Date: Fri, 16 Sep 2016 13:09:15 +0000
Message-ID: <CAAdwW5M+qzpzZKqM0vvtCRvv14re_ahTLW_4E+wpezAiK8qqaA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Janis Danisevskis <jdanis@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7b3a879efd7f2f053c9faba0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b3a879efd7f2f053c9faba0
Content-Type: text/plain; charset=UTF-8

I don't mind. Then before sefcontext_compile -r gets widely adapted we
should change the semantic quickly. I'll prepare a patch.

On Fri, Sep 16, 2016 at 1:35 PM William Roberts <bill.c.roberts@gmail.com>
wrote:

> <snip>
> >
> >
> > That's just the thing. Without -r the phone _will_ boot because the
> regexes
> > are compiled on first use. With -r and an arch mismatch we have an
> undefined
> > behavior, which is bad.
>
> That's just a limitation of the current design.
>
> >
> > See, I don't currently know what part of the architecture is important.
> Will
> > word size and endianess be enough, e.g., will regexes generated on
> x86_64el
> > work on armv8el (apparently this is what I observed but it could change
> at
> > the whim of the PCRE2 maintainers)? So what will be the encoding? If we
> > encode the complete architecture then the typical case for android
> (build on
> > x86_64 for armv7/armv8) will yield the same result as without the -r
> option,
> > namely, we rebuild the regexes on the device. If we just encode word size
> > and endianess it may work for a while... I just don't feel comfortable
> > enough to make a decision at this point.
>
> Then shelve it and use textual file contexts. The only purpose of the
> binary format is to
> include the pre-compiled regex;s so if you cant use that feature,
> there's no point in
> using binary format.
>
> My thought would be that it has to be an exact match for architecture
> upfront, then
> possibly investigate relaxing the requirement later. But, IIRC, if we get
> a 30%
> increase in text file load time, theirs really no point, for the
> binary format on Android.
> Android fic files are smaller, and have much simpler regex's compared
> to our desktop
> brethren.
>
> >
> > My limited understanding is that the automata built by PCRE2 use
> pointers to
> > link states or other structures. These pointers are symbolized when
> > serialized, but they keep their width, which is why the regexes are at
> least
> > sensitive to the word size.
> >
> > Just a wild Idea:
> > PCRE2 also supports JIT compiling. I did not use this here because I did
> not
> > feel comfortable for libselinux to depend on the execmem permission. But
> > this could be developed into pre cross compiling the regexes into native
> > code, which can than be linked into a device specific library. But I
> guess
> > this would require quite some cooperation with the PCRE2 developers.
>
> I was going to ask if the arch dependency was on JIT'd code or just
> something else
> which you elaborated above with word size/endiness, etc.
>
> >
> >>
> >> The other thing is, this is only an issue on binary formated
> file_context
> >> files,
> >> this is the ideal reason to move back to text files, since their is no
> >> speedup
> >> gained if we have to compile them.
> >
> >
> > Right, or you could see it as an intermediate solution that does not
> require
> > changes to the build system until we can properly cross compile the
> regexes.
>
> If you add an option to sefcontext_compile it should be to remove
> them. not add it in.
> This keeps it consistent with teh behavior for PCRE, it would be add
> to say, "make me
> a binary fc, but don't actually embed the regex information", since
> that is currently not
> the default behavior. Changing the Android make recipe is trivial, so
> adding -r shouldn't
> for Android shouldn't be a show stopper.
>
> <snip>
>

--047d7b3a879efd7f2f053c9faba0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t mind. Then before sefcontext_compile -r gets w=
idely adapted we should change the semantic quickly. I&#39;ll prepare a pat=
ch.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Sep 16, 20=
16 at 1:35 PM William Roberts &lt;<a href=3D"mailto:bill.c.roberts@gmail.co=
m">bill.c.roberts@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">&lt;snip&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; That&#39;s just the thing. Without -r the phone _will_ boot because th=
e regexes<br class=3D"gmail_msg">
&gt; are compiled on first use. With -r and an arch mismatch we have an und=
efined<br class=3D"gmail_msg">
&gt; behavior, which is bad.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
That&#39;s just a limitation of the current design.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; See, I don&#39;t currently know what part of the architecture is impor=
tant. Will<br class=3D"gmail_msg">
&gt; word size and endianess be enough, e.g., will regexes generated on x86=
_64el<br class=3D"gmail_msg">
&gt; work on armv8el (apparently this is what I observed but it could chang=
e at<br class=3D"gmail_msg">
&gt; the whim of the PCRE2 maintainers)? So what will be the encoding? If w=
e<br class=3D"gmail_msg">
&gt; encode the complete architecture then the typical case for android (bu=
ild on<br class=3D"gmail_msg">
&gt; x86_64 for armv7/armv8) will yield the same result as without the -r o=
ption,<br class=3D"gmail_msg">
&gt; namely, we rebuild the regexes on the device. If we just encode word s=
ize<br class=3D"gmail_msg">
&gt; and endianess it may work for a while... I just don&#39;t feel comfort=
able<br class=3D"gmail_msg">
&gt; enough to make a decision at this point.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Then shelve it and use textual file contexts. The only purpose of the<br cl=
ass=3D"gmail_msg">
binary format is to<br class=3D"gmail_msg">
include the pre-compiled regex;s so if you cant use that feature,<br class=
=3D"gmail_msg">
there&#39;s no point in<br class=3D"gmail_msg">
using binary format.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
My thought would be that it has to be an exact match for architecture<br cl=
ass=3D"gmail_msg">
upfront, then<br class=3D"gmail_msg">
possibly investigate relaxing the requirement later. But, IIRC, if we get a=
 30%<br class=3D"gmail_msg">
increase in text file load time, theirs really no point, for the<br class=
=3D"gmail_msg">
binary format on Android.<br class=3D"gmail_msg">
Android fic files are smaller, and have much simpler regex&#39;s compared<b=
r class=3D"gmail_msg">
to our desktop<br class=3D"gmail_msg">
brethren.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; My limited understanding is that the automata built by PCRE2 use point=
ers to<br class=3D"gmail_msg">
&gt; link states or other structures. These pointers are symbolized when<br=
 class=3D"gmail_msg">
&gt; serialized, but they keep their width, which is why the regexes are at=
 least<br class=3D"gmail_msg">
&gt; sensitive to the word size.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Just a wild Idea:<br class=3D"gmail_msg">
&gt; PCRE2 also supports JIT compiling. I did not use this here because I d=
id not<br class=3D"gmail_msg">
&gt; feel comfortable for libselinux to depend on the execmem permission. B=
ut<br class=3D"gmail_msg">
&gt; this could be developed into pre cross compiling the regexes into nati=
ve<br class=3D"gmail_msg">
&gt; code, which can than be linked into a device specific library. But I g=
uess<br class=3D"gmail_msg">
&gt; this would require quite some cooperation with the PCRE2 developers.<b=
r class=3D"gmail_msg">
<br class=3D"gmail_msg">
I was going to ask if the arch dependency was on JIT&#39;d code or just<br =
class=3D"gmail_msg">
something else<br class=3D"gmail_msg">
which you elaborated above with word size/endiness, etc.<br class=3D"gmail_=
msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; The other thing is, this is only an issue on binary formated file_=
context<br class=3D"gmail_msg">
&gt;&gt; files,<br class=3D"gmail_msg">
&gt;&gt; this is the ideal reason to move back to text files, since their i=
s no<br class=3D"gmail_msg">
&gt;&gt; speedup<br class=3D"gmail_msg">
&gt;&gt; gained if we have to compile them.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Right, or you could see it as an intermediate solution that does not r=
equire<br class=3D"gmail_msg">
&gt; changes to the build system until we can properly cross compile the re=
gexes.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
If you add an option to sefcontext_compile it should be to remove<br class=
=3D"gmail_msg">
them. not add it in.<br class=3D"gmail_msg">
This keeps it consistent with teh behavior for PCRE, it would be add<br cla=
ss=3D"gmail_msg">
to say, &quot;make me<br class=3D"gmail_msg">
a binary fc, but don&#39;t actually embed the regex information&quot;, sinc=
e<br class=3D"gmail_msg">
that is currently not<br class=3D"gmail_msg">
the default behavior. Changing the Android make recipe is trivial, so<br cl=
ass=3D"gmail_msg">
adding -r shouldn&#39;t<br class=3D"gmail_msg">
for Android shouldn&#39;t be a show stopper.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&lt;snip&gt;<br class=3D"gmail_msg">
</blockquote></div>

--047d7b3a879efd7f2f053c9faba0--
