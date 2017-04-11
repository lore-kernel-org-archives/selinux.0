Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BK6Kut007122
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 16:06:20 -0400
Received: by mail-io0-f172.google.com with SMTP id l7so15830279ioe.3
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 13:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <27297f4a-b3ab-128c-7132-41c9add686a2@tycho.nsa.gov>
In-Reply-To: <27297f4a-b3ab-128c-7132-41c9add686a2@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Tue, 11 Apr 2017 20:06:07 +0000
Message-ID: <CABXk95D0rxRZSsYO0inJLb3ZZeqLkxz9FOTR+iJBV=GQTQdPfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1140a522f153cb054ce99f49
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140a522f153cb054ce99f49
Content-Type: text/plain; charset=UTF-8

Using this patchset with "-G" option - we no longer see preemption on
slowpath policy lookups.

On Tue, Apr 11, 2017 at 12:28 PM James Carter <jwcart2@tycho.nsa.gov> wrote:

On 04/11/2017 01:53 PM, James Carter wrote:
> The number of type attributes included in the binary policy is becomming
a performance issue in some cases.
>
> This patch set more aggressives removes attributes and gives the options
to expand and remove all auto-generated attributes and all attributes with
fewer than a given amount of attributes assigned.
>
> Comparison of the number of attributes remaining in the binary policy
>      mls   normal  android
> org  310     286     255
> old  268     251     130
> max  154      20      17
> min  226     173     119
> def  224     170      80
> gen  221     170      46
> u5   191     112      59
>
> Org - Number of attributes in the CIL policy
> Old - Results without this patch set
> Max - Remove the maximum number of attributes: "-G -X 9999"
> Min - Remove the minimum number of attributes: "-X 0"
> Def - The new defaults for CIL
> Gen - Just removing auto-generated attributes: "-G"
> U5  - Remove attributes with less than five members: "-X 5"
>
>

In case you are interested in sizes:

        mls  normal  android
old   2.1M   2.0M     113K
max  68.3M  63.4M    5041K
min   2.1M   2.0M     122K
def   2.1M   2.0M     115K
gen   2.2M   2.0M     136K
u5    2.2M   2.0M     116K

I would not recommend expanding all attributes.

Jim

> James Carter (2):
>   libsepol/cil: Add ability to expand some attributes in binary policy
>   secilc: Add options to control the expansion of attributes
>
>  libsepol/cil/include/cil/cil.h     |   2 +
>  libsepol/cil/src/cil.c             |  12 ++
>  libsepol/cil/src/cil_binary.c      | 253
+++++++++++++++++++++++++++----------
>  libsepol/cil/src/cil_internal.h    |   7 +-
>  libsepol/cil/src/cil_post.c        |  32 +++--
>  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
>  libsepol/src/libsepol.map.in       |   2 +
>  secilc/secil2conf.c                |   2 +
>  secilc/secilc.8.xml                |  10 ++
>  secilc/secilc.c                    |  31 ++++-
>  10 files changed, 275 insertions(+), 101 deletions(-)
>


--
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1140a522f153cb054ce99f49
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_msg">Using this patchset w=
ith &quot;-G&quot; option - we no longer see preemption on slowpath policy =
lookups.</div><br class=3D"gmail_msg"><div class=3D"gmail_quote gmail_msg">=
<div dir=3D"ltr" class=3D"gmail_msg">On Tue, Apr 11, 2017 at 12:28 PM James=
 Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" class=3D"gmail_msg" ta=
rget=3D"_blank">jwcart2@tycho.nsa.gov</a>&gt; wrote:<br class=3D"gmail_msg"=
></div><blockquote class=3D"gmail_quote gmail_msg" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On 04/11/2017 01:53 PM, Jam=
es Carter wrote:<br class=3D"gmail_msg">
&gt; The number of type attributes included in the binary policy is becommi=
ng a performance issue in some cases.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; This patch set more aggressives removes attributes and gives the optio=
ns to expand and remove all auto-generated attributes and all attributes wi=
th fewer than a given amount of attributes assigned.<br class=3D"gmail_msg"=
>
&gt;<br class=3D"gmail_msg">
&gt; Comparison of the number of attributes remaining in the binary policy<=
br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 mls=C2=A0 =C2=A0normal=C2=A0 android<br class=3D"g=
mail_msg">
&gt; org=C2=A0 310=C2=A0 =C2=A0 =C2=A0286=C2=A0 =C2=A0 =C2=A0255<br class=
=3D"gmail_msg">
&gt; old=C2=A0 268=C2=A0 =C2=A0 =C2=A0251=C2=A0 =C2=A0 =C2=A0130<br class=
=3D"gmail_msg">
&gt; max=C2=A0 154=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A0 =C2=A0 17<br class=
=3D"gmail_msg">
&gt; min=C2=A0 226=C2=A0 =C2=A0 =C2=A0173=C2=A0 =C2=A0 =C2=A0119<br class=
=3D"gmail_msg">
&gt; def=C2=A0 224=C2=A0 =C2=A0 =C2=A0170=C2=A0 =C2=A0 =C2=A0 80<br class=
=3D"gmail_msg">
&gt; gen=C2=A0 221=C2=A0 =C2=A0 =C2=A0170=C2=A0 =C2=A0 =C2=A0 46<br class=
=3D"gmail_msg">
&gt; u5=C2=A0 =C2=A0191=C2=A0 =C2=A0 =C2=A0112=C2=A0 =C2=A0 =C2=A0 59<br cl=
ass=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Org - Number of attributes in the CIL policy<br class=3D"gmail_msg">
&gt; Old - Results without this patch set<br class=3D"gmail_msg">
&gt; Max - Remove the maximum number of attributes: &quot;-G -X 9999&quot;<=
br class=3D"gmail_msg">
&gt; Min - Remove the minimum number of attributes: &quot;-X 0&quot;<br cla=
ss=3D"gmail_msg">
&gt; Def - The new defaults for CIL<br class=3D"gmail_msg">
&gt; Gen - Just removing auto-generated attributes: &quot;-G&quot;<br class=
=3D"gmail_msg">
&gt; U5=C2=A0 - Remove attributes with less than five members: &quot;-X 5&q=
uot;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
In case you are interested in sizes:<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mls=C2=A0 normal=C2=A0 android<br class=3D"gmai=
l_msg">
old=C2=A0 =C2=A02.1M=C2=A0 =C2=A02.0M=C2=A0 =C2=A0 =C2=A0113K<br class=3D"g=
mail_msg">
max=C2=A0 68.3M=C2=A0 63.4M=C2=A0 =C2=A0 5041K<br class=3D"gmail_msg">
min=C2=A0 =C2=A02.1M=C2=A0 =C2=A02.0M=C2=A0 =C2=A0 =C2=A0122K<br class=3D"g=
mail_msg">
def=C2=A0 =C2=A02.1M=C2=A0 =C2=A02.0M=C2=A0 =C2=A0 =C2=A0115K<br class=3D"g=
mail_msg">
gen=C2=A0 =C2=A02.2M=C2=A0 =C2=A02.0M=C2=A0 =C2=A0 =C2=A0136K<br class=3D"g=
mail_msg">
u5=C2=A0 =C2=A0 2.2M=C2=A0 =C2=A02.0M=C2=A0 =C2=A0 =C2=A0116K<br class=3D"g=
mail_msg">
<br class=3D"gmail_msg">
I would not recommend expanding all attributes.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Jim<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; James Carter (2):<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0libsepol/cil: Add ability to expand some attributes in bin=
ary policy<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0secilc: Add options to control the expansion of attributes=
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 libsepol/cil/include/cil/cil.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
2 +<br class=3D"gmail_msg">
&gt;=C2=A0 libsepol/cil/src/cil.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 12 ++<br class=3D"gmail_msg">
&gt;=C2=A0 libsepol/cil/src/cil_binary.c=C2=A0 =C2=A0 =C2=A0 | 253 ++++++++=
+++++++++++++++++++----------<br class=3D"gmail_msg">
&gt;=C2=A0 libsepol/cil/src/cil_internal.h=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<=
br class=3D"gmail_msg">
&gt;=C2=A0 libsepol/cil/src/cil_post.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3=
2 +++--<br class=3D"gmail_msg">
&gt;=C2=A0 libsepol/cil/src/cil_resolve_ast.c |=C2=A0 25 ++--<br class=3D"g=
mail_msg">
&gt;=C2=A0 libsepol/src/<a href=3D"http://libsepol.map.in" rel=3D"noreferre=
r" class=3D"gmail_msg" target=3D"_blank">libsepol.map.in</a>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br class=3D"gmail_msg">
&gt;=C2=A0 secilc/secil2conf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +<br class=3D"gmail_msg">
&gt;=C2=A0 secilc/secilc.8.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 10 ++<br class=3D"gmail_msg">
&gt;=C2=A0 secilc/secilc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 ++++-<br class=3D"gmail_msg">
&gt;=C2=A0 10 files changed, 275 insertions(+), 101 deletions(-)<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" class=3D"gmail_ms=
g" target=3D"_blank">jwcart2@tycho.nsa.gov</a>&gt;<br class=3D"gmail_msg">
National Security Agency<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
Selinux mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:Selinux@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_bla=
nk">Selinux@tycho.nsa.gov</a><br class=3D"gmail_msg">
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" class=3D"gmail_msg" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br=
 class=3D"gmail_msg">
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_blank">Selin=
ux-request@tycho.nsa.gov</a>.<br class=3D"gmail_msg">
</blockquote></div></div>

--001a1140a522f153cb054ce99f49--
