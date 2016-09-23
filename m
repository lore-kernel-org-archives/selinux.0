Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8N4IKaG030889
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 00:18:20 -0400
Received: by mail-qk0-f175.google.com with SMTP id n185so95937953qke.1
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 21:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
In-Reply-To: <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Fri, 23 Sep 2016 04:18:06 +0000
Message-ID: <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
Subject: Re: Killing The Android libselinux Fork (available)
To: William Roberts <bill.c.roberts@gmail.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 Daniel Cashman <dcashman@android.com>,
 James Carter <jwcart2@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>,
 Janis Danisevskis <jdanis@google.com>
Content-Type: multipart/alternative; boundary=94eb2c0792605be901053d251104
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0792605be901053d251104
Content-Type: text/plain; charset=UTF-8

Remember to test on the Mac build. About a year ago I moved the host side
tools over to upstream libselinux, but had to revert because it broke the
Mac build in multiple places. Since then Richard Haines has done a lot of
work to reduce the diff between upstream and the Android fork. Hopefully
that will reduce your effort.

On Thu, Sep 22, 2016 at 6:39 PM William Roberts <bill.c.roberts@gmail.com>
wrote:

On Thu, Sep 22, 2016 at 6:34 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> So I have been working the last couple of days to understand what it
> would take to kill external/libselinux (the Android Fork) and fixup
> upstream so most of the delta is in. The only thing we would keep on
> the Android side, is android.c and .h. Since those files are self
> contained, we should just be able to merge upstream without concerns
> of conflict. If we really wanted to, we could spin off a separate
> libselinux-android that builds those two files and links to
> libselinux, but that seems overkill IMHO.
>
> The work is available here:
> https://github.com/williamcroberts/selinux/tree/fork-kill
>
> Currently to Build:
> 1. remove external/libselinux
> 2. apply this patch to bionic if not present:
> https://android-review.googlesource.com/#/c/276918
> 3. either set external/selinux to my fork-kill branch or merge selinux
> upstream master into external/selinux and apply the two patches listed
> below:
>
> Patches that matter ( I don't know how to make pretty little git
summaries):
>
> commit e017f48acd2791a6aa62b4ed0c0b44256b26651f
> Author: William Roberts <william.c.roberts@intel.com>
> Date:   Wed Sep 21 16:06:37 2016 -0700
> libselinux: add The Android fork files
>
> commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9
> Author: William Roberts <william.c.roberts@intel.com>
> Date:   Wed Sep 21 16:00:34 2016 -0700
> libselinux: rectify the Android fork
>
> The goal would be to upstream commit f40d7facb and leave
> commit e017f48ac on the Android tree.
>
> I am going to do some further testing tomorrow, and plan on submitting
> the upstream patch f40d7facbc on Monday. If anyone wants to leave
> preliminary feedback, or has a specific thing they want tested, let me
know.
>
> Currently tested on the emulator and checked that the digest mechanism for
> last restorecon value is working.
>
> --
> Respectfully,
>
> William C Roberts

FYI I may rebase that branch at anytime... you have been warned :-P

--94eb2c0792605be901053d251104
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_msg">Remember to test on t=
he Mac build. About a year ago I moved the host side tools over to upstream=
 libselinux, but had to revert because it broke the Mac build in multiple p=
laces. Since then Richard Haines has done a lot of work to reduce the diff =
between upstream and the Android fork. Hopefully that will reduce your effo=
rt.</div><br class=3D"gmail_msg"><div class=3D"gmail_quote gmail_msg"><div =
dir=3D"ltr" class=3D"gmail_msg">On Thu, Sep 22, 2016 at 6:39 PM William Rob=
erts &lt;<a href=3D"mailto:bill.c.roberts@gmail.com" class=3D"gmail_msg" ta=
rget=3D"_blank">bill.c.roberts@gmail.com</a>&gt; wrote:<br class=3D"gmail_m=
sg"></div><blockquote class=3D"gmail_quote gmail_msg" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Sep 22, 2016 at =
6:34 PM, William Roberts<br class=3D"gmail_msg">
&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" class=3D"gmail_msg" target=
=3D"_blank">bill.c.roberts@gmail.com</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; So I have been working the last couple of days to understand what it<b=
r class=3D"gmail_msg">
&gt; would take to kill external/libselinux (the Android Fork) and fixup<br=
 class=3D"gmail_msg">
&gt; upstream so most of the delta is in. The only thing we would keep on<b=
r class=3D"gmail_msg">
&gt; the Android side, is android.c and .h. Since those files are self<br c=
lass=3D"gmail_msg">
&gt; contained, we should just be able to merge upstream without concerns<b=
r class=3D"gmail_msg">
&gt; of conflict. If we really wanted to, we could spin off a separate<br c=
lass=3D"gmail_msg">
&gt; libselinux-android that builds those two files and links to<br class=
=3D"gmail_msg">
&gt; libselinux, but that seems overkill IMHO.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; The work is available here:<br class=3D"gmail_msg">
&gt; <a href=3D"https://github.com/williamcroberts/selinux/tree/fork-kill" =
rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://github.com=
/williamcroberts/selinux/tree/fork-kill</a><br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Currently to Build:<br class=3D"gmail_msg">
&gt; 1. remove external/libselinux<br class=3D"gmail_msg">
&gt; 2. apply this patch to bionic if not present:<br class=3D"gmail_msg">
&gt; <a href=3D"https://android-review.googlesource.com/#/c/276918" rel=3D"=
noreferrer" class=3D"gmail_msg" target=3D"_blank">https://android-review.go=
oglesource.com/#/c/276918</a><br class=3D"gmail_msg">
&gt; 3. either set external/selinux to my fork-kill branch or merge selinux=
<br class=3D"gmail_msg">
&gt; upstream master into external/selinux and apply the two patches listed=
<br class=3D"gmail_msg">
&gt; below:<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Patches that matter ( I don&#39;t know how to make pretty little git s=
ummaries):<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; commit e017f48acd2791a6aa62b4ed0c0b44256b26651f<br class=3D"gmail_msg"=
>
&gt; Author: William Roberts &lt;<a href=3D"mailto:william.c.roberts@intel.=
com" class=3D"gmail_msg" target=3D"_blank">william.c.roberts@intel.com</a>&=
gt;<br class=3D"gmail_msg">
&gt; Date:=C2=A0 =C2=A0Wed Sep 21 16:06:37 2016 -0700<br class=3D"gmail_msg=
">
&gt; libselinux: add The Android fork files<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9<br class=3D"gmail_msg"=
>
&gt; Author: William Roberts &lt;<a href=3D"mailto:william.c.roberts@intel.=
com" class=3D"gmail_msg" target=3D"_blank">william.c.roberts@intel.com</a>&=
gt;<br class=3D"gmail_msg">
&gt; Date:=C2=A0 =C2=A0Wed Sep 21 16:00:34 2016 -0700<br class=3D"gmail_msg=
">
&gt; libselinux: rectify the Android fork<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; The goal would be to upstream commit f40d7facb and leave<br class=3D"g=
mail_msg">
&gt; commit e017f48ac on the Android tree.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; I am going to do some further testing tomorrow, and plan on submitting=
<br class=3D"gmail_msg">
&gt; the upstream patch f40d7facbc on Monday. If anyone wants to leave<br c=
lass=3D"gmail_msg">
&gt; preliminary feedback, or has a specific thing they want tested, let me=
 know.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Currently tested on the emulator and checked that the digest mechanism=
 for<br class=3D"gmail_msg">
&gt; last restorecon value is working.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; --<br class=3D"gmail_msg">
&gt; Respectfully,<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; William C Roberts<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
FYI I may rebase that branch at anytime... you have been warned :-P<br clas=
s=3D"gmail_msg">
</blockquote></div></div>

--94eb2c0792605be901053d251104--
