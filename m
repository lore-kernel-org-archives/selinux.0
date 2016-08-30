MIME-Version: 1.0
In-Reply-To: <CAHC9VhTWAauc8bpDin=+MRiFwV4Tdz_Dzrn3SKo5UWGu66EByA@mail.gmail.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
 <1471985365-1197-3-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhTWAauc8bpDin=+MRiFwV4Tdz_Dzrn3SKo5UWGu66EByA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 29 Aug 2016 22:54:40 -0700
Message-ID: <CAFftDdrbb_N88z8txS_A+0K8evim0LzEWJdvSwaMCh1kbVhmYA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: fix overflow and 0 length allocations
To: Paul Moore <paul@paul-moore.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1146ec9cd9b19e053b439d70
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1146ec9cd9b19e053b439d70
Content-Type: text/plain; charset=UTF-8

On Aug 29, 2016 16:56, "Paul Moore" <paul@paul-moore.com> wrote:
>
> On Tue, Aug 23, 2016 at 4:49 PM,  <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Throughout the SE Linux LSM, values taken from sepolicy are
> > used in places where length == 0 or length == <saturated>
> > matter, find and fix these.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  security/selinux/ss/conditional.c | 3 +++
> >  security/selinux/ss/policydb.c    | 4 ++++
> >  security/selinux/ss/private.h     | 7 +++++++
> >  3 files changed, 14 insertions(+)
> >  create mode 100644 security/selinux/ss/private.h
> >
> > diff --git a/security/selinux/ss/conditional.c
b/security/selinux/ss/conditional.c
> > index 456e1a9..ecc0fb6 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -16,6 +16,7 @@
> >  #include "security.h"
> >  #include "conditional.h"
> >  #include "services.h"
> > +#include "private.h"
> >
> >  /*
> >   * cond_evaluate_expr evaluates a conditional expr
> > @@ -242,6 +243,8 @@ int cond_read_bool(struct policydb *p, struct
hashtab *h, void *fp)
> >                 goto err;
> >
> >         len = le32_to_cpu(buf[2]);
> > +       if (zero_or_saturated(len))
> > +               goto err;
> >
> >         rc = -ENOMEM;
> >         key = kmalloc(len + 1, GFP_KERNEL);
> > diff --git a/security/selinux/ss/policydb.c
b/security/selinux/ss/policydb.c
> > index 4b24385..0e881f3 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -38,6 +38,7 @@
> >  #include "conditional.h"
> >  #include "mls.h"
> >  #include "services.h"
> > +#include "private.h"
> >
> >  #define _DEBUG_HASHES
> >
> > @@ -1094,6 +1095,9 @@ static int str_read(char **strp, gfp_t flags,
void *fp, u32 len)
> >         int rc;
> >         char *str;
> >
> > +       if (zero_or_saturated(len))
> > +               return -EINVAL;
> > +
> >         str = kmalloc(len + 1, flags);
> >         if (!str)
> >                 return -ENOMEM;
> > diff --git a/security/selinux/ss/private.h
b/security/selinux/ss/private.h
> > new file mode 100644
> > index 0000000..0e81a78
> > --- /dev/null
> > +++ b/security/selinux/ss/private.h
> > @@ -0,0 +1,7 @@
> > +#ifndef PRIVATE_H_
> > +#define PRIVATE_H_
> > +
> > +#define is_saturated(x) (x == (typeof(x))-1)
> > +#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
> > +
> > +#endif
>
> While I'm not opposed to the idea of using a macro for this purpose,
> e.g. is_saturated() and zero_or_saturated(), I don't see much value in
> creating this macro buried in the SELinux directory.  Especially if we
> end up creating a new header file just for these macros.  Something as
> generic as this should be something we inherit from the generic kernel
> code so we can leverage existing conventions.

It made more sense when I wanted to keep the change similar to libsepol.
But the str_read() function really reduced the number of checks. I ended up
porting that to libsepol. With that said, the macro serves little purpose
with the exception of readability.

>
> If you can find a macro like these in the core kernel code, go ahead

Ill look, doubt I'll find anything.

> and use it, otherwise please respin this with the bound checks open
> code

Sure

>
> Oh, and use "SELinux" ;)
>
> --
> paul moore
> www.paul-moore.com
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1146ec9cd9b19e053b439d70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Aug 29, 2016 16:56, &quot;Paul Moore&quot; &lt;<a href=3D=
"mailto:paul@paul-moore.com">paul@paul-moore.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Aug 23, 2016 at 4:49 PM,=C2=A0 &lt;<a href=3D"mailto:william.c=
.roberts@intel.com">william.c.roberts@intel.com</a>&gt; wrote:<br>
&gt; &gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@int=
el.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Throughout the SE Linux LSM, values taken from sepolicy are<br>
&gt; &gt; used in places where length =3D=3D 0 or length =3D=3D &lt;saturat=
ed&gt;<br>
&gt; &gt; matter, find and fix these.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.ro=
berts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 security/selinux/ss/conditional.c | 3 +++<br>
&gt; &gt;=C2=A0 security/selinux/ss/policydb.c=C2=A0 =C2=A0 | 4 ++++<br>
&gt; &gt;=C2=A0 security/selinux/ss/private.h=C2=A0 =C2=A0 =C2=A0| 7 ++++++=
+<br>
&gt; &gt;=C2=A0 3 files changed, 14 insertions(+)<br>
&gt; &gt;=C2=A0 create mode 100644 security/selinux/ss/private.h<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/security/selinux/ss/conditional.c b/security/selinux=
/ss/conditional.c<br>
&gt; &gt; index 456e1a9..ecc0fb6 100644<br>
&gt; &gt; --- a/security/selinux/ss/conditional.c<br>
&gt; &gt; +++ b/security/selinux/ss/conditional.c<br>
&gt; &gt; @@ -16,6 +16,7 @@<br>
&gt; &gt;=C2=A0 #include &quot;security.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;conditional.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;services.h&quot;<br>
&gt; &gt; +#include &quot;private.h&quot;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 /*<br>
&gt; &gt;=C2=A0 =C2=A0* cond_evaluate_expr evaluates a conditional expr<br>
&gt; &gt; @@ -242,6 +243,8 @@ int cond_read_bool(struct policydb *p, struct=
 hashtab *h, void *fp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto=
 err;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D le32_to_cpu(buf[2]);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -ENOMEM;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key =3D kmalloc(len + 1, GFP_KER=
NEL);<br>
&gt; &gt; diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss=
/policydb.c<br>
&gt; &gt; index 4b24385..0e881f3 100644<br>
&gt; &gt; --- a/security/selinux/ss/policydb.c<br>
&gt; &gt; +++ b/security/selinux/ss/policydb.c<br>
&gt; &gt; @@ -38,6 +38,7 @@<br>
&gt; &gt;=C2=A0 #include &quot;conditional.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;mls.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;services.h&quot;<br>
&gt; &gt; +#include &quot;private.h&quot;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #define _DEBUG_HASHES<br>
&gt; &gt;<br>
&gt; &gt; @@ -1094,6 +1095,9 @@ static int str_read(char **strp, gfp_t flag=
s, void *fp, u32 len)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *str;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
INVAL;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D kmalloc(len + 1, flags);=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!str)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -ENOMEM;<br>
&gt; &gt; diff --git a/security/selinux/ss/private.h b/security/selinux/ss/=
private.h<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 0000000..0e81a78<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/security/selinux/ss/private.h<br>
&gt; &gt; @@ -0,0 +1,7 @@<br>
&gt; &gt; +#ifndef PRIVATE_H_<br>
&gt; &gt; +#define PRIVATE_H_<br>
&gt; &gt; +<br>
&gt; &gt; +#define is_saturated(x) (x =3D=3D (typeof(x))-1)<br>
&gt; &gt; +#define zero_or_saturated(x) ((x =3D=3D 0) || is_saturated(x))<b=
r>
&gt; &gt; +<br>
&gt; &gt; +#endif<br>
&gt;<br>
&gt; While I&#39;m not opposed to the idea of using a macro for this purpos=
e,<br>
&gt; e.g. is_saturated() and zero_or_saturated(), I don&#39;t see much valu=
e in<br>
&gt; creating this macro buried in the SELinux directory.=C2=A0 Especially =
if we<br>
&gt; end up creating a new header file just for these macros.=C2=A0 Somethi=
ng as<br>
&gt; generic as this should be something we inherit from the generic kernel=
<br>
&gt; code so we can leverage existing conventions.</p>
<p dir=3D"ltr">It made more sense when I wanted to keep the change similar =
to libsepol. But the str_read() function really reduced the number of check=
s. I ended up porting that to libsepol. With that said, the macro serves li=
ttle purpose with the exception of readability.</p>
<p dir=3D"ltr">&gt;<br>
&gt; If you can find a macro like these in the core kernel code, go ahead</=
p>
<p dir=3D"ltr">Ill look, doubt I&#39;ll find anything.</p>
<p dir=3D"ltr">&gt; and use it, otherwise please respin this with the bound=
 checks open<br>
&gt; code</p>
<p dir=3D"ltr">Sure</p>
<p dir=3D"ltr">&gt;<br>
&gt; Oh, and use &quot;SELinux&quot; ;)<br>
&gt;<br>
&gt; --<br>
&gt; paul moore<br>
&gt; <a href=3D"http://www.paul-moore.com">www.paul-moore.com</a><br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--001a1146ec9cd9b19e053b439d70--
