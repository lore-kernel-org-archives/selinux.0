Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v05Jp8CQ026426
 for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2017 14:51:09 -0500
Received: from mail-lf0-f44.google.com (mail-lf0-f44.google.com
 [209.85.215.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A23B2564709
 for <selinux@tycho.nsa.gov>; Thu,  5 Jan 2017 20:50:37 +0100 (CET)
Received: by mail-lf0-f44.google.com with SMTP id x140so33856941lfa.3
 for <selinux@tycho.nsa.gov>; Thu, 05 Jan 2017 11:50:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdqs7zQWCm85YZSmtZ=0fiwXxXsT7JSS=Lr2OxKUwhOfbQ@mail.gmail.com>
References: <20170104220229.26497-1-nicolas.iooss@m4x.org>
 <CAFftDdqs7zQWCm85YZSmtZ=0fiwXxXsT7JSS=Lr2OxKUwhOfbQ@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Thu, 5 Jan 2017 20:50:36 +0100
Message-ID: <CAJfZ7=n2Bv+xa5V5mf+6p7rGFMeyfBFNyghfd-FF3BFUd2JdZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: make capability index an unsigned int
To: William Roberts <bill.c.roberts@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11412b7c1754cc05455e375d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11412b7c1754cc05455e375d
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 5, 2017 at 12:04 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> On Wed, Jan 4, 2017 at 2:02 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
> wrote:
> > When sepol_polcap_getname() is called with a negative capnum, it
> > dereferences polcap_names[capnum] which produces a segmentation fault
> > most of the time.
> >
> > For information, here is a gdb session when hll/pp loads a policy module
> > which has been mutated by American Fuzzy Lop:
> >
> >     Program received signal SIGSEGV, Segmentation fault.
> >     sepol_polcap_getname (capnum=capnum@entry=-4259840) at polcaps.c:34
> >     34      return polcap_names[capnum];
> >     => 0x00007ffff7a8da07 <sepol_polcap_getname+135>:   48 8b 04 f8 mov
> >     (%rax,%rdi,8),%rax
> >
> >     (gdb) bt
> >     #0  sepol_polcap_getname (capnum=capnum@entry=-4259840) at
> >     polcaps.c:34
> >     #1  0x00007ffff7a7c440 in polcaps_to_cil (pdb=0x6042e0) at
> >     module_to_cil.c:2492
> >     #2  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79c75e0
> >     <_IO_2_1_stdout_>, pdb=0x6042e0, linked=linked@entry=0) at
> >     module_to_cil.c:4039
> >     #3  0x00007ffff7a7e695 in sepol_module_package_to_cil
> >     (fp=fp@entry=0x7ffff79c75e0 <_IO_2_1_stdout_>, mod_pkg=0x604280) at
> >     module_to_cil.c:4087
> >     #4  0x0000000000401acc in main (argc=<optimized out>,
> >     argv=<optimized out>) at pp.c:150
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/include/sepol/policydb/polcaps.h | 2 +-
> >  libsepol/src/polcaps.c                    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/polcaps.h
> b/libsepol/include/sepol/policydb/polcaps.h
> > index c9e40f62048d..623818ab10f5 100644
> > --- a/libsepol/include/sepol/policydb/polcaps.h
> > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > @@ -19,7 +19,7 @@ enum {
> >  extern int sepol_polcap_getnum(const char *name);
> >
> >  /* Convert a capability number to name. */
> > -extern const char *sepol_polcap_getname(int capnum);
> > +extern const char *sepol_polcap_getname(unsigned int capnum);
>
> unsigned is definitely a way to fix this, but now I see that
> sepol_polcap_getnum() wouldn't be able
> to use the full range of unsigned as its return of < 0 indicates error.
>
> Perhaps use the enum types in both cases? However, based on compiler
> flags, IIRC, enums may be treated as signed or unsigned int.
>
>  It's really likely never a problem, but just something to
> mention.
>
I prefer not to use enum in both sepol_polcap_getname() and
sepol_polcap_getnum(). For the first function because it is always called
while iterating the policycaps bitmap of a policy so the meaning of the
parameter is really "bit position in a bitmap" instead of "the
compiler-generated index of the item in the enum" and for the second one
because every caller expects the result to be -1 or positive. By the way it
looks funny that "git grep -A5 sepol_polcap_getname" shows three callers
with three different ways to compare the result (capnum < 0, capnum == -1
or capnum == SEPOL_ERR).

>
> >  #ifdef __cplusplus
> >  }
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index 3924cb83f29c..248d2f525185 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -26,7 +26,7 @@ int sepol_polcap_getnum(const char *name)
> >         return -1;
> >  }
> >
> > -const char *sepol_polcap_getname(int capnum)
> > +const char *sepol_polcap_getname(unsigned int capnum)
> >  {
> >         if (capnum > POLICYDB_CAPABILITY_MAX)
> >                 return NULL;
>
> There is a possibility that this enum and the strings could get out of
> sync and then we would also want
> to bound this value (sizeof(polcap_names)/sizeof(polcap_names[0]))) -1
> We would be able to drop the -1 if the NULL on polcap_names can go away...
>
> We could also detect this mismatch at compile time:
> typedef int WRONG_POLCAP_SIZE
> [((sizeof(polcap_names)/sizeof(polcap_names[0]))) -1 ==
> POLICYDB_CAPABILITY_MAX) - 1];
> -1 size arrays are illegal in C, so we want the array to be 0 length
> on correct size, -1 on bad size. That above code snippet might not be
> 100% but that should be close.

I will wait to hear what the project developers think of introducing such a
construction as there are several ways to achieve the same result: using a
global typedef with a conditionally-sized array,
using gcc's __attribute__((error(message))) construction like the kernel
does [1][2], using ((void)sizeof(char[1 - 2 * condition])) like the kernel
also does [3], or even using static_assert(expr, message) introduced by C11
standard.

Thanks for your comments,
Nicolas

[1]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler-gcc.h?h=v4.9#n186
[2]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler.h?h=v4.9#n496
[3]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/compiler.h?h=v4.9#n489

--001a11412b7c1754cc05455e375d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Jan 5, 2017 at 12:04 AM, William Roberts <span dir=3D"ltr">&lt;<a href=
=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Wed, Jan 4, 201=
7 at 2:02 PM, Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org">ni=
colas.iooss@m4x.org</a>&gt; wrote:<br>
&gt; When sepol_polcap_getname() is called with a negative capnum, it<br>
&gt; dereferences polcap_names[capnum] which produces a segmentation fault<=
br>
&gt; most of the time.<br>
&gt;<br>
&gt; For information, here is a gdb session when hll/pp loads a policy modu=
le<br>
&gt; which has been mutated by American Fuzzy Lop:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Program received signal SIGSEGV, Segmentation fault=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0sepol_polcap_getname (capnum=3Dcapnum@entry=3D-4259=
840) at polcaps.c:34<br>
&gt;=C2=A0 =C2=A0 =C2=A034=C2=A0 =C2=A0 =C2=A0 return polcap_names[capnum];=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0=3D&gt; 0x00007ffff7a8da07 &lt;sepol_polcap_getname=
+135&gt;:=C2=A0 =C2=A048 8b 04 f8 mov<br>
&gt;=C2=A0 =C2=A0 =C2=A0(%rax,%rdi,8),%rax<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0(gdb) bt<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0=C2=A0 sepol_polcap_getname (capnum=3Dcapnum@entr=
y=3D-4259840) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0polcaps.c:34<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1=C2=A0 0x00007ffff7a7c440 in polcaps_to_cil (pdb=
=3D0x6042e0) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0module_to_cil.c:2492<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2=C2=A0 sepol_module_policydb_to_cil (fp=3Dfp@entr=
y=3D0x7ffff79c75e0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;_IO_2_1_stdout_&gt;, pdb=3D0x6042e0, linked=3Dl=
inked@entry=3D0) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0module_to_cil.c:4039<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3=C2=A0 0x00007ffff7a7e695 in sepol_module_package=
_to_cil<br>
&gt;=C2=A0 =C2=A0 =C2=A0(fp=3Dfp@entry=3D0x7ffff79c75e0 &lt;_IO_2_1_stdout_=
&gt;, mod_pkg=3D0x604280) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0module_to_cil.c:4087<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4=C2=A0 0x0000000000401acc in main (argc=3D&lt;opt=
imized out&gt;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0argv=3D&lt;optimized out&gt;) at pp.c:150<br>
&gt;<br>
&gt; Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.o=
rg">nicolas.iooss@m4x.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 libsepol/include/sepol/<wbr>policydb/polcaps.h | 2 +-<br>
&gt;=C2=A0 libsepol/src/polcaps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libsepol/include/sepol/<wbr>policydb/polcaps.h b/libsepol=
/include/sepol/<wbr>policydb/polcaps.h<br>
&gt; index c9e40f62048d..623818ab10f5 100644<br>
&gt; --- a/libsepol/include/sepol/<wbr>policydb/polcaps.h<br>
&gt; +++ b/libsepol/include/sepol/<wbr>policydb/polcaps.h<br>
&gt; @@ -19,7 +19,7 @@ enum {<br>
&gt;=C2=A0 extern int sepol_polcap_getnum(const char *name);<br>
&gt;<br>
&gt;=C2=A0 /* Convert a capability number to name. */<br>
&gt; -extern const char *sepol_polcap_getname(int capnum);<br>
&gt; +extern const char *sepol_polcap_getname(unsigned int capnum);<br>
<br>
</div></div>unsigned is definitely a way to fix this, but now I see that<br=
>
sepol_polcap_getnum() wouldn&#39;t be able<br>
to use the full range of unsigned as its return of &lt; 0 indicates error.<=
br>
<br>
Perhaps use the enum types in both cases? However, based on compiler<br>
flags, IIRC, enums may be treated as signed or unsigned int.<br>
<br>
=C2=A0It&#39;s really likely never a problem, but just something to<br>
mention.<br></blockquote><div>I prefer not to use enum in both sepol_polcap=
_getname() and sepol_polcap_getnum(). For the first function because it is =
always called while iterating the policycaps bitmap of a policy so the mean=
ing of the parameter is really &quot;bit position in a bitmap&quot; instead=
 of &quot;the compiler-generated index of the item in the enum&quot; and fo=
r the second one because every caller expects the result to be -1 or positi=
ve. By the way it looks funny that &quot;git grep -A5 sepol_polcap_getname&=
quot; shows three callers with three different ways to compare the result (=
capnum &lt; 0, capnum =3D=3D -1 or capnum =3D=3D SEPOL_ERR).</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmai=
l-">
&gt;<br>
&gt;=C2=A0 #ifdef __cplusplus<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c<br>
&gt; index 3924cb83f29c..248d2f525185 100644<br>
&gt; --- a/libsepol/src/polcaps.c<br>
&gt; +++ b/libsepol/src/polcaps.c<br>
&gt; @@ -26,7 +26,7 @@ int sepol_polcap_getnum(const char *name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -const char *sepol_polcap_getname(int capnum)<br>
&gt; +const char *sepol_polcap_getname(unsigned int capnum)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (capnum &gt; POLICYDB_CAPABILITY_M=
AX)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NU=
LL;<br>
<br>
</span>There is a possibility that this enum and the strings could get out =
of<br>
sync and then we would also want<br>
to bound this value (sizeof(polcap_names)/sizeof(<wbr>polcap_names[0]))) -1=
<br>
We would be able to drop the -1 if the NULL on polcap_names can go away...<=
br>
<br>
We could also detect this mismatch at compile time:<br>
typedef int WRONG_POLCAP_SIZE<br>
[((sizeof(polcap_names)/<wbr>sizeof(polcap_names[0]))) -1 =3D=3D<br>
POLICYDB_CAPABILITY_MAX) - 1];<br>
-1 size arrays are illegal in C, so we want the array to be 0 length<br>
on correct size, -1 on bad size. That above code snippet might not be<br>
100% but that should be close.</blockquote><div>I will wait to hear what th=
e project developers think of introducing such a construction as there are =
several ways to achieve the same result: using a global typedef with a cond=
itionally-sized array, using=C2=A0gcc&#39;s=C2=A0__attribute__((error(messa=
ge))) construction like the kernel does [1][2], using=C2=A0<span style=3D"c=
olor:rgb(0,0,0);font-size:13.3333px">((void)sizeof(char[1 - 2 * condition])=
) like the kernel also does [3], or even using static_assert(expr, message)=
 introduced by C11 standard.</span><br></div><div><br></div><div>Thanks for=
 your comments,</div><div>Nicolas</div><div><br></div><div>[1]=C2=A0<a href=
=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/in=
clude/linux/compiler-gcc.h?h=3Dv4.9#n186">https://git.kernel.org/cgit/linux=
/kernel/git/torvalds/linux.git/tree/include/linux/compiler-gcc.h?h=3Dv4.9#n=
186</a></div><div>[2]=C2=A0<a href=3D"https://git.kernel.org/cgit/linux/ker=
nel/git/torvalds/linux.git/tree/include/linux/compiler.h?h=3Dv4.9#n496">htt=
ps://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/l=
inux/compiler.h?h=3Dv4.9#n496</a></div><div>[3]=C2=A0<a href=3D"https://git=
.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/com=
piler.h?h=3Dv4.9#n489">https://git.kernel.org/cgit/linux/kernel/git/torvald=
s/linux.git/tree/include/linux/compiler.h?h=3Dv4.9#n489</a></div></div></di=
v></div>

--001a11412b7c1754cc05455e375d--
