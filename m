Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GDwDjl028090
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 09:58:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id b187so38717031wme.1
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 06:58:15 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <20160916133146.GA8294@meriadoc.perfinion.com>
From: Janis Danisevskis <jdanis@google.com>
Date: Fri, 16 Sep 2016 13:58:03 +0000
Message-ID: <CAAdwW5N90VVLf_EdmJhV8F179z4JSeLC4f1_O+rSZyrcS8f73w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: Jason Zaman <jason@perfinion.com>,
 William Roberts <bill.c.roberts@gmail.com>
Cc: Janis Danisevskis <jdanis@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c1302be7c114e053ca05adf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c1302be7c114e053ca05adf
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 16, 2016 at 2:31 PM Jason Zaman <jason@perfinion.com> wrote:

> On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:
> > On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis <jdanis@google.com>
> wrote:
> > > I don't mind. Then before sefcontext_compile -r gets widely adapted we
> > > should change the semantic quickly. I'll prepare a patch.
> >
> > Did I miss something and this was merged? Iv'e been out recovering
> > from a surgery so I haven't been
> > following this as well as I normally would have,
> >
> > If its merged, just leave it.
>
> Its the very latest thing in master yeah, but I do also agree with
> changing it.
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
>
> Also, I think we should add the arch to the version string stored. I
> would rather have false negatives than positives especially since we are
> not 100% sure exactly what part of the arch is important. We can always
> loosen it up later if that gets locked down.
>

Good, I will add an architecture string.
>From the PCRE2 documentation: [1] "The host on which the patterns are
reloaded must be running the same version of PCRE2, with the same code unit
width, and must also have the same endianness, pointer width and PCRE2_SIZE
type."
I will encode these three properties in the arch string.

[1] http://www.pcre.org/current/doc/html/pcre2serialize.html


> Isnt the selinux policy in android stored in the rootfs or /system?
> isnt that all read-only? how would re-compiling on the device work?
> Does android put the fcontext.bin files on /data? that seems insecure.
>

On android file_context.bin is in / and read only. If the patterns are
compiled on the device, they are not stored persistently. AFAIK this
happens only once upon every boot.


>
> -- Jason
>
> > > On Fri, Sep 16, 2016 at 1:35 PM William Roberts <
> bill.c.roberts@gmail.com>
> > > wrote:
> > >>
> > >> <snip>
> > >> >
> > >> >
> > >> > That's just the thing. Without -r the phone _will_ boot because the
> > >> > regexes
> > >> > are compiled on first use. With -r and an arch mismatch we have an
> > >> > undefined
> > >> > behavior, which is bad.
> > >>
> > >> That's just a limitation of the current design.
> > >>
> > >> >
> > >> > See, I don't currently know what part of the architecture is
> important.
> > >> > Will
> > >> > word size and endianess be enough, e.g., will regexes generated on
> > >> > x86_64el
> > >> > work on armv8el (apparently this is what I observed but it could
> change
> > >> > at
> > >> > the whim of the PCRE2 maintainers)? So what will be the encoding?
> If we
> > >> > encode the complete architecture then the typical case for android
> > >> > (build on
> > >> > x86_64 for armv7/armv8) will yield the same result as without the -r
> > >> > option,
> > >> > namely, we rebuild the regexes on the device. If we just encode word
> > >> > size
> > >> > and endianess it may work for a while... I just don't feel
> comfortable
> > >> > enough to make a decision at this point.
> > >>
> > >> Then shelve it and use textual file contexts. The only purpose of the
> > >> binary format is to
> > >> include the pre-compiled regex;s so if you cant use that feature,
> > >> there's no point in
> > >> using binary format.
> > >>
> > >> My thought would be that it has to be an exact match for architecture
> > >> upfront, then
> > >> possibly investigate relaxing the requirement later. But, IIRC, if we
> get
> > >> a 30%
> > >> increase in text file load time, theirs really no point, for the
> > >> binary format on Android.
> > >> Android fic files are smaller, and have much simpler regex's compared
> > >> to our desktop
> > >> brethren.
> > >>
> > >> >
> > >> > My limited understanding is that the automata built by PCRE2 use
> > >> > pointers to
> > >> > link states or other structures. These pointers are symbolized when
> > >> > serialized, but they keep their width, which is why the regexes are
> at
> > >> > least
> > >> > sensitive to the word size.
> > >> >
> > >> > Just a wild Idea:
> > >> > PCRE2 also supports JIT compiling. I did not use this here because
> I did
> > >> > not
> > >> > feel comfortable for libselinux to depend on the execmem
> permission. But
> > >> > this could be developed into pre cross compiling the regexes into
> native
> > >> > code, which can than be linked into a device specific library. But I
> > >> > guess
> > >> > this would require quite some cooperation with the PCRE2 developers.
> > >>
> > >> I was going to ask if the arch dependency was on JIT'd code or just
> > >> something else
> > >> which you elaborated above with word size/endiness, etc.
> > >>
> > >> >
> > >> >>
> > >> >> The other thing is, this is only an issue on binary formated
> > >> >> file_context
> > >> >> files,
> > >> >> this is the ideal reason to move back to text files, since their
> is no
> > >> >> speedup
> > >> >> gained if we have to compile them.
> > >> >
> > >> >
> > >> > Right, or you could see it as an intermediate solution that does not
> > >> > require
> > >> > changes to the build system until we can properly cross compile the
> > >> > regexes.
> > >>
> > >> If you add an option to sefcontext_compile it should be to remove
> > >> them. not add it in.
> > >> This keeps it consistent with teh behavior for PCRE, it would be add
> > >> to say, "make me
> > >> a binary fc, but don't actually embed the regex information", since
> > >> that is currently not
> > >> the default behavior. Changing the Android make recipe is trivial, so
> > >> adding -r shouldn't
> > >> for Android shouldn't be a show stopper.
> > >>
> > >> <snip>
> >
> >
> >
> > --
> > Respectfully,
> >
> > William C Roberts
> > _______________________________________________
> > Seandroid-list mailing list
> > Seandroid-list@tycho.nsa.gov
> > To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>

--94eb2c1302be7c114e053ca05adf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri=
, Sep 16, 2016 at 2:31 PM Jason Zaman &lt;<a href=3D"mailto:jason@perfinion=
.com">jason@perfinion.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On Fri, Sep 16, 2016 at 06:15:01AM -0700, William Roberts wrote:<br c=
lass=3D"gmail_msg">
&gt; On Fri, Sep 16, 2016 at 6:09 AM, Janis Danisevskis &lt;<a href=3D"mail=
to:jdanis@google.com" class=3D"gmail_msg" target=3D"_blank">jdanis@google.c=
om</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; &gt; I don&#39;t mind. Then before sefcontext_compile -r gets widely a=
dapted we<br class=3D"gmail_msg">
&gt; &gt; should change the semantic quickly. I&#39;ll prepare a patch.<br =
class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Did I miss something and this was merged? Iv&#39;e been out recovering=
<br class=3D"gmail_msg">
&gt; from a surgery so I haven&#39;t been<br class=3D"gmail_msg">
&gt; following this as well as I normally would have,<br class=3D"gmail_msg=
">
&gt;<br class=3D"gmail_msg">
&gt; If its merged, just leave it.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Its the very latest thing in master yeah, but I do also agree with changing=
 it.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
I just wanted to add that from a distro perspective, compiling things by<br=
 class=3D"gmail_msg">
default makes more sense. In gentoo, the package post_install runs<br class=
=3D"gmail_msg">
sefcontext_compile. Using the fcontext files happens a lot more than any<br=
 class=3D"gmail_msg">
updates to libselinux (and thus potential format changes) so I&#39;m pretty=
<br class=3D"gmail_msg">
sure most people would prefer to have the speedup.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Gentoo does it on the machine itself, I am not sure about redhat or<br clas=
s=3D"gmail_msg">
debian but I wouldnt be surprised if they do it per-arch at the very<br cla=
ss=3D"gmail_msg">
least so cross-arch probably isnt an issue.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Also, I think we should add the arch to the version string stored. I<br cla=
ss=3D"gmail_msg">
would rather have false negatives than positives especially since we are<br=
 class=3D"gmail_msg">
not 100% sure exactly what part of the arch is important. We can always<br =
class=3D"gmail_msg">
loosen it up later if that gets locked down.<br class=3D"gmail_msg"></block=
quote><div><br></div><div>Good, I will add an architecture string.</div><di=
v>From the PCRE2 documentation: [1] &quot;The host on which the patterns ar=
e reloaded must be running the same version of PCRE2, with the same code un=
it width, and must also have the same endianness, pointer width and PCRE2_S=
IZE type.&quot;</div><div>I will encode these three properties in the arch =
string.</div><div>=C2=A0</div><div>[1]=C2=A0<a href=3D"http://www.pcre.org/=
current/doc/html/pcre2serialize.html">http://www.pcre.org/current/doc/html/=
pcre2serialize.html</a></div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br class=3D"gmail_msg">
Isnt the selinux policy in android stored in the rootfs or /system?<br clas=
s=3D"gmail_msg">
isnt that all read-only? how would re-compiling on the device work?<br clas=
s=3D"gmail_msg">
Does android put the fcontext.bin files on /data? that seems insecure.<br c=
lass=3D"gmail_msg"></blockquote><div><br></div><div>On android file_context=
.bin is in / and read only. If the patterns are compiled on the device, the=
y are not stored persistently. AFAIK this happens only once upon every boot=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br class=3D"gmail_msg">
-- Jason<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; &gt; On Fri, Sep 16, 2016 at 1:35 PM William Roberts &lt;<a href=3D"ma=
ilto:bill.c.roberts@gmail.com" class=3D"gmail_msg" target=3D"_blank">bill.c=
.roberts@gmail.com</a>&gt;<br class=3D"gmail_msg">
&gt; &gt; wrote:<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &lt;snip&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; That&#39;s just the thing. Without -r the phone _will_ b=
oot because the<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; regexes<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; are compiled on first use. With -r and an arch mismatch =
we have an<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; undefined<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; behavior, which is bad.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; That&#39;s just a limitation of the current design.<br class=
=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; See, I don&#39;t currently know what part of the archite=
cture is important.<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; Will<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; word size and endianess be enough, e.g., will regexes ge=
nerated on<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; x86_64el<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; work on armv8el (apparently this is what I observed but =
it could change<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; at<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; the whim of the PCRE2 maintainers)? So what will be the =
encoding? If we<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; encode the complete architecture then the typical case f=
or android<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; (build on<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; x86_64 for armv7/armv8) will yield the same result as wi=
thout the -r<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; option,<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; namely, we rebuild the regexes on the device. If we just=
 encode word<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; size<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; and endianess it may work for a while... I just don&#39;=
t feel comfortable<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; enough to make a decision at this point.<br class=3D"gma=
il_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; Then shelve it and use textual file contexts. The only purpos=
e of the<br class=3D"gmail_msg">
&gt; &gt;&gt; binary format is to<br class=3D"gmail_msg">
&gt; &gt;&gt; include the pre-compiled regex;s so if you cant use that feat=
ure,<br class=3D"gmail_msg">
&gt; &gt;&gt; there&#39;s no point in<br class=3D"gmail_msg">
&gt; &gt;&gt; using binary format.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; My thought would be that it has to be an exact match for arch=
itecture<br class=3D"gmail_msg">
&gt; &gt;&gt; upfront, then<br class=3D"gmail_msg">
&gt; &gt;&gt; possibly investigate relaxing the requirement later. But, IIR=
C, if we get<br class=3D"gmail_msg">
&gt; &gt;&gt; a 30%<br class=3D"gmail_msg">
&gt; &gt;&gt; increase in text file load time, theirs really no point, for =
the<br class=3D"gmail_msg">
&gt; &gt;&gt; binary format on Android.<br class=3D"gmail_msg">
&gt; &gt;&gt; Android fic files are smaller, and have much simpler regex&#3=
9;s compared<br class=3D"gmail_msg">
&gt; &gt;&gt; to our desktop<br class=3D"gmail_msg">
&gt; &gt;&gt; brethren.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; My limited understanding is that the automata built by P=
CRE2 use<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; pointers to<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; link states or other structures. These pointers are symb=
olized when<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; serialized, but they keep their width, which is why the =
regexes are at<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; least<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; sensitive to the word size.<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; Just a wild Idea:<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; PCRE2 also supports JIT compiling. I did not use this he=
re because I did<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; not<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; feel comfortable for libselinux to depend on the execmem=
 permission. But<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; this could be developed into pre cross compiling the reg=
exes into native<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; code, which can than be linked into a device specific li=
brary. But I<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; guess<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; this would require quite some cooperation with the PCRE2=
 developers.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; I was going to ask if the arch dependency was on JIT&#39;d co=
de or just<br class=3D"gmail_msg">
&gt; &gt;&gt; something else<br class=3D"gmail_msg">
&gt; &gt;&gt; which you elaborated above with word size/endiness, etc.<br c=
lass=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt; The other thing is, this is only an issue on binary =
formated<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt; file_context<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt; files,<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt; this is the ideal reason to move back to text files,=
 since their is no<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt; speedup<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;&gt; gained if we have to compile them.<br class=3D"gmail=
_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; Right, or you could see it as an intermediate solution t=
hat does not<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; require<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; changes to the build system until we can properly cross =
compile the<br class=3D"gmail_msg">
&gt; &gt;&gt; &gt; regexes.<br class=3D"gmail_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; If you add an option to sefcontext_compile it should be to re=
move<br class=3D"gmail_msg">
&gt; &gt;&gt; them. not add it in.<br class=3D"gmail_msg">
&gt; &gt;&gt; This keeps it consistent with teh behavior for PCRE, it would=
 be add<br class=3D"gmail_msg">
&gt; &gt;&gt; to say, &quot;make me<br class=3D"gmail_msg">
&gt; &gt;&gt; a binary fc, but don&#39;t actually embed the regex informati=
on&quot;, since<br class=3D"gmail_msg">
&gt; &gt;&gt; that is currently not<br class=3D"gmail_msg">
&gt; &gt;&gt; the default behavior. Changing the Android make recipe is tri=
vial, so<br class=3D"gmail_msg">
&gt; &gt;&gt; adding -r shouldn&#39;t<br class=3D"gmail_msg">
&gt; &gt;&gt; for Android shouldn&#39;t be a show stopper.<br class=3D"gmai=
l_msg">
&gt; &gt;&gt;<br class=3D"gmail_msg">
&gt; &gt;&gt; &lt;snip&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; --<br class=3D"gmail_msg">
&gt; Respectfully,<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; William C Roberts<br class=3D"gmail_msg">
&gt; _______________________________________________<br class=3D"gmail_msg"=
>
&gt; Seandroid-list mailing list<br class=3D"gmail_msg">
&gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov" class=3D"gmail_msg" ta=
rget=3D"_blank">Seandroid-list@tycho.nsa.gov</a><br class=3D"gmail_msg">
&gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@t=
ycho.nsa.gov" class=3D"gmail_msg" target=3D"_blank">Seandroid-list-leave@ty=
cho.nsa.gov</a>.<br class=3D"gmail_msg">
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Seandroid-list-request@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_=
blank">Seandroid-list-request@tycho.nsa.gov</a>.<br class=3D"gmail_msg">
</blockquote></div></div>

--94eb2c1302be7c114e053ca05adf--
