Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93HS36s015468
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 13:28:03 -0400
Received: by mail-yw0-f178.google.com with SMTP id i129so112525510ywb.0
 for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 10:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
 <f213e1a4-5a68-dff2-b1b6-354410ef7fe1@tycho.nsa.gov>
 <CAMFYTWcz6y9whm8_z4rwQBVtcK_YniTycwu-+zsSiqrYn-kj_A@mail.gmail.com>
 <9f04db8c-6e09-d5c8-9f95-b3f7805edbd7@tycho.nsa.gov>
 <CAFftDdr=sodunXnQoszCOe6P9s4oxrxWC0Vn6eVu5Fde-cEZMg@mail.gmail.com>
In-Reply-To: <CAFftDdr=sodunXnQoszCOe6P9s4oxrxWC0Vn6eVu5Fde-cEZMg@mail.gmail.com>
From: Daniel Cashman <dcashman@google.com>
Date: Mon, 03 Oct 2016 17:27:50 +0000
Message-ID: <CAJQetW5_guNJSPF1Y4fKM7-d8JGdpsc1wix7aOd4ZGcXQSG5OQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
To: William Roberts <bill.c.roberts@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Cc: Bowgo Tsai <bowgotsai@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113f1e9affb995053df94335
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f1e9affb995053df94335
Content-Type: text/plain; charset=UTF-8

+1 SGTM.

On Thu, Sep 29, 2016 at 7:06 AM William Roberts <bill.c.roberts@gmail.com>
wrote:

> On Thu, Sep 29, 2016 at 9:28 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On 09/28/2016 10:17 PM, Bowgo Tsai wrote:
> >> OK, please ignore these patches, will update new ones.
> >> I'll update the top-level Android.mk if we still want to keep Android.mk
> >> upstream.
> >>
> >> However, I was thinking the same thing: it seems better to only keep
> >> Android.mk files in Android tree.
> >> For other *.c/*.h files, keep these files up-to-date in the upstream as
> >> well.
> >>
> >> If no one objects to this, I'll prepare two patches.
> >>
> >>  1. Update secilc/secilc.c
> >>  2. Delete all Android.mk files in the upstream
> >
> > SGTM
>
> SGTM
>

--001a113f1e9affb995053df94335
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+1 SGTM.<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Thu, Sep 29, 2016 at 7:06 AM William Roberts &lt;<a href=3D"mai=
lto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Thu, Sep 29, 2016 at 9:28 AM, Stephen=
 Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov" class=3D"gmail_msg" targe=
t=3D"_blank">sds@tycho.nsa.gov</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; On 09/28/2016 10:17 PM, Bowgo Tsai wrote:<br class=3D"gmail_msg">
&gt;&gt; OK, please ignore these patches, will update new ones.<br class=3D=
"gmail_msg">
&gt;&gt; I&#39;ll update the top-level Android.mk if we still want to keep =
Android.mk<br class=3D"gmail_msg">
&gt;&gt; upstream.<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; However, I was thinking the same thing: it seems better to only ke=
ep<br class=3D"gmail_msg">
&gt;&gt; Android.mk files in Android tree.<br class=3D"gmail_msg">
&gt;&gt; For other *.c/*.h files, keep these files up-to-date in the upstre=
am as<br class=3D"gmail_msg">
&gt;&gt; well.<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; If no one objects to this, I&#39;ll prepare two patches.<br class=
=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;=C2=A0 1. Update secilc/secilc.c<br class=3D"gmail_msg">
&gt;&gt;=C2=A0 2. Delete all Android.mk files in the upstream<br class=3D"g=
mail_msg">
&gt;<br class=3D"gmail_msg">
&gt; SGTM<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
SGTM<br class=3D"gmail_msg">
</blockquote></div>

--001a113f1e9affb995053df94335--
