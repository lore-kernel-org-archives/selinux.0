MIME-Version: 1.0
In-Reply-To: <CAFftDdoxXB51B0-ZOG761oeSzHAes9njM7uJLDcmZCGgbKaVRg@mail.gmail.com>
References: <1479252622-20935-1-git-send-email-william.c.roberts@intel.com>
 <CAFftDdoxXB51B0-ZOG761oeSzHAes9njM7uJLDcmZCGgbKaVRg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 18:49:24 -0800
Message-ID: <CAFftDdrudSdsT-Na_WoGmjpS7=T77+7KeB=BViW6tzD1Y43R6A@mail.gmail.com>
Subject: Re: [PATCH take2 v5] libsepol: fix checkpolicy dontaudit compiler bug
To: William Roberts <william.c.roberts@intel.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 Nick Kralevich <nnk@google.com>
Content-Type: multipart/alternative; boundary=001a1134fe48ea70550541621ef6
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1134fe48ea70550541621ef6
Content-Type: text/plain; charset=UTF-8

On Nov 15, 2016 4:33 PM, "William Roberts" <bill.c.roberts@gmail.com> wrote:
>
> <snip>
>
> >                 memset(&avdatum, 0, sizeof avdatum);
> > +               /*
> > +                * AUDITDENY and DONTAUDIT are &= assigned, versus |=
for
> > +                * others. Initialize the data accordingly.
> > +                */
> > +               avdatum.data = (key->specified &
> > +                              (AVRULE_AUDITDENY | AVRULE_DONTAUDIT)) ?
~0 : 0;
>
> Nak this, surprising this is working and producing correct output, but

Correct when checking the sesearch output, which makes sense since we're
expecting both classes to be all dontaudit statements.

> we would want to check
> against the AVTAB defines...
>
> This patch, while simple, for some reason is getting the best of me :-P
>
> >                 /* this is used to get the node - insertion is actually
unique */
> >                 node = avtab_insert_nonunique(avtab, key, &avdatum);
> >                 if (!node) {
> <snip>

--001a1134fe48ea70550541621ef6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 15, 2016 4:33 PM, &quot;William Roberts&quot; &lt;<a =
href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt; &lt;snip&gt;<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mems=
et(&amp;avdatum, 0, sizeof avdatum);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * AUDITD=
ENY and DONTAUDIT are &amp;=3D assigned, versus |=3D for<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * others=
. Initialize the data accordingly.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatum.d=
ata =3D (key-&gt;specified &amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (AVRULE_AUDITDENY | AVRULE_DONTAU=
DIT)) ? ~0 : 0;<br>
&gt;<br>
&gt; Nak this, surprising this is working and producing correct output, but=
</p>
<p dir=3D"ltr">Correct when checking the sesearch output, which makes sense=
 since we&#39;re expecting both classes to be all dontaudit statements.</p>
<p dir=3D"ltr">&gt; we would want to check<br>
&gt; against the AVTAB defines...<br>
&gt;<br>
&gt; This patch, while simple, for some reason is getting the best of me :-=
P<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* t=
his is used to get the node - insertion is actually unique */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node=
 =3D avtab_insert_nonunique(avtab, key, &amp;avdatum);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
!node) {<br>
&gt; &lt;snip&gt;<br></p>

--001a1134fe48ea70550541621ef6--
