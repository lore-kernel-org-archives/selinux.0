Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GJk29D002657
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 15:46:02 -0400
Received: by mail-qk0-f175.google.com with SMTP id t7so98544226qkh.2
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 12:45:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <70dee52e-86e7-0a88-ec56-fa45fa172b69@tycho.nsa.gov>
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
 <CA+xTVEvzmjqOtKRKiapx-xfMKDRcKQV6JkFdV3eM9R1we6Jdqg@mail.gmail.com>
 <70dee52e-86e7-0a88-ec56-fa45fa172b69@tycho.nsa.gov>
From: Janis Danisevskis <jdanis@android.com>
Date: Fri, 16 Sep 2016 20:45:55 +0100
Message-ID: <CA+xTVEsOdAw+v9zwP1Qp6hR0zauV8dot8tWC4gfCkfnGTGwBfg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add support for pcre2
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c0578d0fcd580053ca535c3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0578d0fcd580053ca535c3
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 16, 2016 at 8:06 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/16/2016 02:57 PM, Janis Danisevskis wrote:
> > I have started implementing an arch string patch. Unfortunately, i did
> > not manage to finish it before I had to leave the office today.
> > In essence I did this:
> > The regex_arch_string has three components: the pointer width determined
> > by sizeof(void*), PCRE2_SIZE width determined by sizeof(), and
> > endianess determined by
> > __BYTE_ORDER__==__ORDER_BIG/LITTEL_ENDIAN__
> >
> > For example, the resulting string for x86_64 and aarch64el should look
> like
> > this: "8-8-el".
> >
> > I bumped the compiled context version number and added the string
> > right after the version in the output.
> > Comments?
>
> What's the error handling when the versions do not match?  Just ignore
> the compiled regexes in file_contexts.bin?
>
>
> Yes, If the version and arch match attempt to load the compiled regexes
from the file. Otherwise, skip the corresponding regions of the file and
leave the regex field NULL, so that they will be compiled on first use.

--94eb2c0578d0fcd580053ca535c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 16, 2016 at 8:06 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 09/16=
/2016 02:57 PM, Janis Danisevskis wrote:<br>
&gt; I have started implementing an arch string patch. Unfortunately, i did=
<br>
&gt; not manage to finish it before I had to leave the office today.<br>
&gt; In essence I did this:<br>
&gt; The regex_arch_string has three components: the pointer width determin=
ed<br>
&gt; by sizeof(void*), PCRE2_SIZE width determined by sizeof(), and<br>
&gt; endianess determined by<br>
&gt; __BYTE_ORDER__=3D=3D__ORDER_BIG/<wbr>LITTEL_ENDIAN__<br>
&gt;<br>
&gt; For example, the resulting string for x86_64 and aarch64el should look=
 like<br>
&gt; this: &quot;8-8-el&quot;.<br>
&gt;<br>
&gt; I bumped the compiled context version number and added the string<br>
&gt; right after the version in the output.<br>
&gt; Comments?<br>
<br>
</span>What&#39;s the error handling when the versions do not match?=C2=A0 =
Just ignore<br>
the compiled regexes in file_contexts.bin?<br>
<br>
<br></blockquote><div>Yes, If the version and arch match attempt to load th=
e compiled regexes</div><div>from the file. Otherwise, skip the correspondi=
ng regions of the file and</div><div>leave the regex field NULL, so that th=
ey will be compiled on first use.=C2=A0</div></div><br></div></div>

--94eb2c0578d0fcd580053ca535c3--
