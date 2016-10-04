Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u941nKl8031377
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 21:49:20 -0400
Received: by mail-vk0-f42.google.com with SMTP id z126so177228803vkd.0
 for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 18:49:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJQetW5_guNJSPF1Y4fKM7-d8JGdpsc1wix7aOd4ZGcXQSG5OQ@mail.gmail.com>
References: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
 <f213e1a4-5a68-dff2-b1b6-354410ef7fe1@tycho.nsa.gov>
 <CAMFYTWcz6y9whm8_z4rwQBVtcK_YniTycwu-+zsSiqrYn-kj_A@mail.gmail.com>
 <9f04db8c-6e09-d5c8-9f95-b3f7805edbd7@tycho.nsa.gov>
 <CAFftDdr=sodunXnQoszCOe6P9s4oxrxWC0Vn6eVu5Fde-cEZMg@mail.gmail.com>
 <CAJQetW5_guNJSPF1Y4fKM7-d8JGdpsc1wix7aOd4ZGcXQSG5OQ@mail.gmail.com>
From: Bowgo Tsai <bowgotsai@google.com>
Date: Tue, 4 Oct 2016 09:49:17 +0800
Message-ID: <CAMFYTWe=Mdq-n-5-sU3mtdwuxvORoBtT01kXmM-1=CUUpYBW4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
To: Daniel Cashman <dcashman@google.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=001a114e1638c7fb59053e0044d7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114e1638c7fb59053e0044d7
Content-Type: text/plain; charset=UTF-8

Thanks for the confirmation, both changes were merged into upstream.

On Tue, Oct 4, 2016 at 1:27 AM, Daniel Cashman <dcashman@google.com> wrote:

> +1 SGTM.
>
> On Thu, Sep 29, 2016 at 7:06 AM William Roberts <bill.c.roberts@gmail.com>
> wrote:
>
>> On Thu, Sep 29, 2016 at 9:28 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > On 09/28/2016 10:17 PM, Bowgo Tsai wrote:
>> >> OK, please ignore these patches, will update new ones.
>> >> I'll update the top-level Android.mk if we still want to keep
>> Android.mk
>> >> upstream.
>> >>
>> >> However, I was thinking the same thing: it seems better to only keep
>> >> Android.mk files in Android tree.
>> >> For other *.c/*.h files, keep these files up-to-date in the upstream as
>> >> well.
>> >>
>> >> If no one objects to this, I'll prepare two patches.
>> >>
>> >>  1. Update secilc/secilc.c
>> >>  2. Delete all Android.mk files in the upstream
>> >
>> > SGTM
>>
>> SGTM
>>
>


-- 

Bowgo Tsai |  Engineer |  bowgotsai@google.com |  +886 (2) 8729-6364
<%2B886287296364>

--001a114e1638c7fb59053e0044d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the confirmation, both changes were merged into=
 upstream.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Tue, Oct 4, 2016 at 1:27 AM, Daniel Cashman <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dcashman@google.com" target=3D"_blank">dcashman@google.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">+1 SGTM=
.<br></div><div class=3D"HOEnZb"><div class=3D"h5"><br><div class=3D"gmail_=
quote"><div dir=3D"ltr">On Thu, Sep 29, 2016 at 7:06 AM William Roberts &lt=
;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.rober=
ts@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu,=
 Sep 29, 2016 at 9:28 AM, Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.n=
sa.gov" class=3D"m_-5023886691412809995gmail_msg" target=3D"_blank">sds@tyc=
ho.nsa.gov</a>&gt; wrote:<br class=3D"m_-5023886691412809995gmail_msg">
&gt; On 09/28/2016 10:17 PM, Bowgo Tsai wrote:<br class=3D"m_-5023886691412=
809995gmail_msg">
&gt;&gt; OK, please ignore these patches, will update new ones.<br class=3D=
"m_-5023886691412809995gmail_msg">
&gt;&gt; I&#39;ll update the top-level Android.mk if we still want to keep =
Android.mk<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt; upstream.<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt;<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt; However, I was thinking the same thing: it seems better to only ke=
ep<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt; Android.mk files in Android tree.<br class=3D"m_-50238866914128099=
95gmail_msg">
&gt;&gt; For other *.c/*.h files, keep these files up-to-date in the upstre=
am as<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt; well.<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt;<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt; If no one objects to this, I&#39;ll prepare two patches.<br class=
=3D"m_-5023886691412809995gmail_msg">
&gt;&gt;<br class=3D"m_-5023886691412809995gmail_msg">
&gt;&gt;=C2=A0 1. Update secilc/secilc.c<br class=3D"m_-5023886691412809995=
gmail_msg">
&gt;&gt;=C2=A0 2. Delete all Android.mk files in the upstream<br class=3D"m=
_-5023886691412809995gmail_msg">
&gt;<br class=3D"m_-5023886691412809995gmail_msg">
&gt; SGTM<br class=3D"m_-5023886691412809995gmail_msg">
<br class=3D"m_-5023886691412809995gmail_msg">
SGTM<br class=3D"m_-5023886691412809995gmail_msg">
</blockquote></div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><br><table cellspacing=3D"0" cellpadding=3D"0" style=3D=
"font-family:Times"><tbody><tr style=3D"color:rgb(85,85,85);font-family:san=
s-serif;font-size:small"><td nowrap style=3D"font-family:arial;border-top-s=
tyle:solid;border-top-color:rgb(213,15,37);border-top-width:2px">Bowgo Tsai=
 |</td><td nowrap style=3D"font-family:arial;border-top-style:solid;border-=
top-color:rgb(51,105,232);border-top-width:2px">=C2=A0Engineer |</td><td no=
wrap style=3D"font-family:arial;border-top-style:solid;border-top-color:rgb=
(0,153,57);border-top-width:2px">=C2=A0<a href=3D"mailto:bowgotsai@google.c=
om" target=3D"_blank">bowgotsai@google.com</a>=C2=A0|</td><td nowrap style=
=3D"font-family:arial;border-top-style:solid;border-top-color:rgb(238,178,1=
7);border-top-width:2px">=C2=A0<a href=3D"tel:%2B886287296364" value=3D"+88=
6287296364" style=3D"color:rgb(17,85,204);font-family:arial,sans-serif;font=
-size:12.8000001907349px;white-space:normal" target=3D"_blank">+886 (2) 872=
9-6364</a></td></tr></tbody></table><br><div><font face=3D"Times" size=3D"3=
" style=3D"color:rgb(136,136,136);background-color:rgb(255,255,255)"></font=
></div></div></div></div></div></div></div></div></div></div></div></div></=
div></div></div></div>
</div>

--001a114e1638c7fb59053e0044d7--
