Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NEpDq7030549
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:51:13 -0400
Received: by mail-wm0-f54.google.com with SMTP id l132so36233500wmf.0
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 07:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <883e1b35-467e-e3dd-5baa-1822ab003829@tycho.nsa.gov>
 <CAFftDdqgu0dNoetJXiRCVZ6uK_Qd4U+0xo2jTj=pscQAy48UWw@mail.gmail.com>
 <43a1504f-f8f7-7575-d97b-48412aefea3f@tycho.nsa.gov>
 <93d8efc2-3a4c-48d6-4452-7a9304eb98d7@tycho.nsa.gov>
In-Reply-To: <93d8efc2-3a4c-48d6-4452-7a9304eb98d7@tycho.nsa.gov>
From: Janis Danisevskis <jdanis@google.com>
Date: Fri, 23 Sep 2016 14:50:58 +0000
Message-ID: <CAAdwW5OA8YEYG2qitF_HZh8yniKtE9Z58fM48dAgpUqQY9+Cwg@mail.gmail.com>
Subject: Re: selinux 2.6-rc1 release planned 9/30
To: Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <bill.c.roberts@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1130cb3c9c1eb6053d2de85c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1130cb3c9c1eb6053d2de85c
Content-Type: text/plain; charset=UTF-8

Exactly, the confusing message slipped in with the pcre2 patch.
I will try and submit the arch detection patch on the weekend. I was pretty
occupied this week.

On Wed, Sep 21, 2016 at 5:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/21/2016 11:52 AM, Stephen Smalley wrote:
> > On 09/21/2016 11:40 AM, William Roberts wrote:
> >> I'd like to see the -r flip change in by then, so no official release
> >> is cut with that behavior.
> >>
> >> Also, I was looking at the help output for -r, and its quite
> >> confusing, I cant tell if -r includes or omits, verbatim output:
> >>
> >> -r       Include precompiled regular expressions in the output.
> >>         (PCRE2 only. Compiled PCRE2 regular expressions are
> >>         not portable across architectures. When linked against
> >>         PCRE this flag is ignored)
> >>         Omit precompiled regular expressions (only meaningful
> >>         when using PCRE2 regular expression back-end).
> >> fc_file  The text based file contexts file to be processed.
> >
> > Yes, Janis actually posted a patch to fix that as well, but it presumes
> > the prior patch to change the -r behavior.  So we can take those two
> > patches once we have the arch detection and fallback patch in place.
>
> Actually, I'm wrong: the two patches were two different options, one of
> which switched the default and the other left the default unchanged and
> fixed the usage message.  So I'll apply the latter now until the arch
> detection is in place.
>
>
>

--001a1130cb3c9c1eb6053d2de85c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Exactly, the confusing message slipped in with the pc=
re2 patch.<br></div><div>I will try and submit the arch detection patch on =
the weekend. I was pretty occupied this week.</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr">On Wed, Sep 21, 2016 at 5:39 PM Stephen Small=
ey &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">On 09/21/2016 11:52 AM, Stephen S=
malley wrote:<br class=3D"gmail_msg">
&gt; On 09/21/2016 11:40 AM, William Roberts wrote:<br class=3D"gmail_msg">
&gt;&gt; I&#39;d like to see the -r flip change in by then, so no official =
release<br class=3D"gmail_msg">
&gt;&gt; is cut with that behavior.<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; Also, I was looking at the help output for -r, and its quite<br cl=
ass=3D"gmail_msg">
&gt;&gt; confusing, I cant tell if -r includes or omits, verbatim output:<b=
r class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; -r=C2=A0 =C2=A0 =C2=A0 =C2=A0Include precompiled regular expressio=
ns in the output.<br class=3D"gmail_msg">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(PCRE2 only. Compiled PCRE2 regul=
ar expressions are<br class=3D"gmail_msg">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not portable across architectures=
. When linked against<br class=3D"gmail_msg">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCRE this flag is ignored)<br cla=
ss=3D"gmail_msg">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Omit precompiled regular expressi=
ons (only meaningful<br class=3D"gmail_msg">
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0when using PCRE2 regular expressi=
on back-end).<br class=3D"gmail_msg">
&gt;&gt; fc_file=C2=A0 The text based file contexts file to be processed.<b=
r class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Yes, Janis actually posted a patch to fix that as well, but it presume=
s<br class=3D"gmail_msg">
&gt; the prior patch to change the -r behavior.=C2=A0 So we can take those =
two<br class=3D"gmail_msg">
&gt; patches once we have the arch detection and fallback patch in place.<b=
r class=3D"gmail_msg">
<br class=3D"gmail_msg">
Actually, I&#39;m wrong: the two patches were two different options, one of=
<br class=3D"gmail_msg">
which switched the default and the other left the default unchanged and<br =
class=3D"gmail_msg">
fixed the usage message.=C2=A0 So I&#39;ll apply the latter now until the a=
rch<br class=3D"gmail_msg">
detection is in place.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
</blockquote></div>

--001a1130cb3c9c1eb6053d2de85c--
