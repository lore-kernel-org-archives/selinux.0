Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t46MXbKw024950
 for <selinux@tycho.nsa.gov>; Wed, 6 May 2015 18:33:37 -0400
Received: by oica37 with SMTP id a37so19741517oic.0
 for <selinux@tycho.nsa.gov>; Wed, 06 May 2015 15:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <551C2AFE.5030604@tresys.com>
References: <1427908281-11224-1-git-send-email-jwcart2@tycho.nsa.gov>
 <551C2AFE.5030604@tresys.com>
Date: Wed, 6 May 2015 15:33:34 -0700
Message-ID: <CABXk95CkeVT=HF6z4VkmgTjKeSaGwC3AmFMaeaUTkYHT9Xx2Mw@mail.gmail.com>
Subject: Re: [PATCH 0/3 v5] libsepol, policycoreutils, and checkpolicy: Add
 support for generating CIL to libsepol and checkpolicy
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Steve Lawrence <slawrence@tresys.com>
Content-Type: multipart/alternative; boundary=001a113485c8b491580515716298
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113485c8b491580515716298
Content-Type: text/plain; charset=UTF-8

I am working on switching AOSP to the upstream selinux project.
Unfortunately this commit breaks the AOSP build on Mac OS. Darwin has no
fmemopen.

external/selinux/libsepol/src/module_to_cil.c:2927:7: warning: implicit
declaration of function 'fmemopen' [-Wimplicit-function-declaration]
        fp = fmemopen(seusers, seusers_len, "r");
             ^
external/selinux/libsepol/src/module_to_cil.c:2927:5: error: incompatible
integer to pointer conversion assigning to 'FILE *' (aka 'struct __sFILE
*') from 'int' [-Werror,-Wint-conversion]
        fp = fmemopen(seusers, seusers_len, "r");
           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
external/selinux/libsepol/src/module_to_cil.c:3017:5: error: incompatible
integer to pointer conversion assigning to 'FILE *' (aka 'struct __sFILE
*') from 'int' [-Werror,-Wint-conversion]
        fp = fmemopen(userx, userx_len, "r");
           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
external/selinux/libsepol/src/module_to_cil.c:3073:5: error: incompatible
integer to pointer conversion assigning to 'FILE *' (aka 'struct __sFILE
*') from 'int' [-Werror,-Wint-conversion]
        fp = fmemopen(fc, fc_len, "r");
           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning and 3 errors generated.
make: ***
[out/host/darwin-x86/obj32/STATIC_LIBRARIES/libsepol_intermediates/src/module_to_cil.o]
Error 1

On Wed, Apr 1, 2015 at 10:29 AM, Steve Lawrence <slawrence@tresys.com>
wrote:

> On 04/01/2015 01:11 PM, James Carter wrote:
> > V5 Update usage functions for checkpolicy and checkmodule.
> > V4 Adds the new command-line options to the checkpolicy and checkmodule
> man pages, adds error checking and messages to checkpolicy and checkmodule,
> updates libsepol's Android.mk and libsepol.map.in files as needed, and
> makes pp linke libsepol dynamically.
> > V3 fixes another whitespace issue.
> > V2 fixes some whitespace issues and make the new libsepol file LGPL
> instead of GPL.
> >
> > This patch set moves the code to generate CIL from pp.c in
> policycoreutils/hll/pp to libsepol, adds a new function to generate CIL
> from a module policydb, and modifies checkpolicy and checkmodule to support
> generating CIL as their output.
> >
> > The primary motivation of this work is to allow SE for Android to use
> the CIl compiler. Converting the policy.conf to CIL and then compiling to
> the kernel binary policy results in a policy that is about 20% smaller. The
> smaller size is because type expressions with negations are converted to
> type attribute sets in CIL instead of being expanded.
> >
> > James Carter (3):
> >   libsepol, policycoreutils: Move functions to convert a module package
> >     to CIL
> >   libsepol: add function to generate CIL from a module policydb
> >   checkpolicy: Add support for generating CIL
> >
> >  checkpolicy/checkmodule.8              |    5 +-
> >  checkpolicy/checkmodule.c              |   66 +-
> >  checkpolicy/checkpolicy.8              |    5 +-
> >  checkpolicy/checkpolicy.c              |   85 +-
> >  libsepol/Android.mk                    |    1 +
> >  libsepol/include/sepol/module_to_cil.h |    8 +
> >  libsepol/src/libsepol.map.in           |    3 +
> >  libsepol/src/module_to_cil.c           | 4010
> ++++++++++++++++++++++++++++++++
> >  policycoreutils/hll/pp/Makefile        |    2 +-
> >  policycoreutils/hll/pp/pp.c            | 3830
> +-----------------------------
> >  10 files changed, 4131 insertions(+), 3884 deletions(-)
> >  create mode 100644 libsepol/include/sepol/module_to_cil.h
> >  create mode 100644 libsepol/src/module_to_cil.c
> >
>
> Acked-by: Steve Lawrence <slawrence@tresys.com>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a113485c8b491580515716298
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am working on switching AOSP to the upstream selinux pro=
ject. Unfortunately this commit breaks the AOSP build on Mac OS. Darwin has=
 no fmemopen.=C2=A0<div><br></div><div><div>external/selinux/libsepol/src/m=
odule_to_cil.c:2927:7: warning: implicit declaration of function &#39;fmemo=
pen&#39; [-Wimplicit-function-declaration]</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fp =3D fmemopen(seusers, seusers_len, &quot;r&quot;);</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>external/selinux/l=
ibsepol/src/module_to_cil.c:2927:5: error: incompatible integer to pointer =
conversion assigning to &#39;FILE *&#39; (aka &#39;struct __sFILE *&#39;) f=
rom &#39;int&#39; [-Werror,-Wint-conversion]</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fp =3D fmemopen(seusers, seusers_len, &quot;r&quot;);</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
</div><div>external/selinux/libsepol/src/module_to_cil.c:3017:5: error: inc=
ompatible integer to pointer conversion assigning to &#39;FILE *&#39; (aka =
&#39;struct __sFILE *&#39;) from &#39;int&#39; [-Werror,-Wint-conversion]</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D fmemopen(userx, userx_len, &quo=
t;r&quot;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^ ~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~</div><div>external/selinux/libsepol/src/module_to_cil=
.c:3073:5: error: incompatible integer to pointer conversion assigning to &=
#39;FILE *&#39; (aka &#39;struct __sFILE *&#39;) from &#39;int&#39; [-Werro=
r,-Wint-conversion]</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D fmemopen(f=
c, fc_len, &quot;r&quot;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^ ~~~~~~~~~~~~~~~~~~~~~~~~~</div><div>1 warning and 3 errors generated.<=
/div><div>make: *** [out/host/darwin-x86/obj32/STATIC_LIBRARIES/libsepol_in=
termediates/src/module_to_cil.o] Error 1</div></div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Wed, Apr 1, 2015 at 10:29 AM, S=
teve Lawrence <span dir=3D"ltr">&lt;<a href=3D"mailto:slawrence@tresys.com"=
 target=3D"_blank">slawrence@tresys.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 04/01/2015 =
01:11 PM, James Carter wrote:<br>
&gt; V5 Update usage functions for checkpolicy and checkmodule.<br>
&gt; V4 Adds the new command-line options to the checkpolicy and checkmodul=
e man pages, adds error checking and messages to checkpolicy and checkmodul=
e, updates libsepol&#39;s Android.mk and <a href=3D"http://libsepol.map.in"=
 target=3D"_blank">libsepol.map.in</a> files as needed, and makes pp linke =
libsepol dynamically.<br>
&gt; V3 fixes another whitespace issue.<br>
&gt; V2 fixes some whitespace issues and make the new libsepol file LGPL in=
stead of GPL.<br>
&gt;<br>
&gt; This patch set moves the code to generate CIL from pp.c in policycoreu=
tils/hll/pp to libsepol, adds a new function to generate CIL from a module =
policydb, and modifies checkpolicy and checkmodule to support generating CI=
L as their output.<br>
&gt;<br>
&gt; The primary motivation of this work is to allow SE for Android to use =
the CIl compiler. Converting the policy.conf to CIL and then compiling to t=
he kernel binary policy results in a policy that is about 20% smaller. The =
smaller size is because type expressions with negations are converted to ty=
pe attribute sets in CIL instead of being expanded.<br>
&gt;<br>
&gt; James Carter (3):<br>
&gt;=C2=A0 =C2=A0libsepol, policycoreutils: Move functions to convert a mod=
ule package<br>
&gt;=C2=A0 =C2=A0 =C2=A0to CIL<br>
&gt;=C2=A0 =C2=A0libsepol: add function to generate CIL from a module polic=
ydb<br>
&gt;=C2=A0 =C2=A0checkpolicy: Add support for generating CIL<br>
&gt;<br>
&gt;=C2=A0 checkpolicy/checkmodule.8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 5 +-<br>
&gt;=C2=A0 checkpolicy/checkmodule.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A066 +-<br>
&gt;=C2=A0 checkpolicy/checkpolicy.8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 5 +-<br>
&gt;=C2=A0 checkpolicy/checkpolicy.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A085 +-<br>
&gt;=C2=A0 libsepol/Android.mk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 libsepol/include/sepol/module_to_cil.h |=C2=A0 =C2=A0 8 +<br>
&gt;=C2=A0 libsepol/src/<a href=3D"http://libsepol.map.in" target=3D"_blank=
">libsepol.map.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 3 +<br>
&gt;=C2=A0 libsepol/src/module_to_cil.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 4010 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 policycoreutils/hll/pp/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 2 +-<br>
&gt;=C2=A0 policycoreutils/hll/pp/pp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 3830 +-----------------------------<br>
&gt;=C2=A0 10 files changed, 4131 insertions(+), 3884 deletions(-)<br>
&gt;=C2=A0 create mode 100644 libsepol/include/sepol/module_to_cil.h<br>
&gt;=C2=A0 create mode 100644 libsepol/src/module_to_cil.c<br>
&gt;<br>
<br>
</div></div>Acked-by: Steve Lawrence &lt;<a href=3D"mailto:slawrence@tresys=
.com">slawrence@tresys.com</a>&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5">___________________________________=
____________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br></div>

--001a113485c8b491580515716298--
