MIME-Version: 1.0
In-Reply-To: <975ba9db-54e7-f220-dc7d-112e0fc734c9@tycho.nsa.gov>
References: <1479238801-13053-1-git-send-email-william.c.roberts@intel.com>
 <1479238801-13053-3-git-send-email-william.c.roberts@intel.com>
 <975ba9db-54e7-f220-dc7d-112e0fc734c9@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 12:18:37 -0800
Message-ID: <CAFftDdodf1vJ00qkLRRQ6TwZj8JgU1Gng9a5x-cUx518E6jbGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: fix checkpolicy dontaudit compiler bug
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1137bdde62f1dc05415ca922
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1137bdde62f1dc05415ca922
Content-Type: text/plain; charset=UTF-8

On Nov 15, 2016 12:09, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 11/15/2016 02:40 PM, william.c.roberts@intel.com wrote:
> > From: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > The combining logic for dontaudit rules was wrong, causing
> > a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
> > rule.
> >
> > This is a reimplimation of 6201bb5e2 that avoids the cumbersome
> > pointer assignments on alloced.
> >
> > Reported-by: Nick Kralevich <nnk@google.com>
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsepol/src/expand.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 004a029..ef04908 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t *
state,
> >  static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
> >                                  avtab_t * avtab, avtab_key_t * key,
> >                                  cond_av_list_t ** cond,
> > -                                av_extended_perms_t *xperms)
> > +                                av_extended_perms_t *xperms,
> > +                                uint32_t init_data)
> >  {
> >       avtab_ptr_t node;
> >       avtab_datum_t avdatum;
> > @@ -1640,6 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t
* handle,
> >
> >       if (!node) {
> >               memset(&avdatum, 0, sizeof avdatum);
> > +             avdatum.data = init_data;
> >               /* this is used to get the node - insertion is actually
unique */
> >               node = avtab_insert_nonunique(avtab, key, &avdatum);
> >               if (!node) {
> > @@ -1750,7 +1752,7 @@ static int expand_terule_helper(sepol_handle_t *
handle,
> >                       return EXPAND_RULE_CONFLICT;
> >               }
> >
> > -             node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
> > +             node = find_avtab_node(handle, avtab, &avkey, cond, NULL,
0);
> >               if (!node)
> >                       return -1;
> >               if (enabled) {
> > @@ -1824,7 +1826,15 @@ static int expand_avrule_helper(sepol_handle_t *
handle,
> >               avkey.target_class = cur->tclass;
> >               avkey.specified = spec;
> >
> > -             node = find_avtab_node(handle, avtab, &avkey, cond,
extended_perms);
> > +             node = find_avtab_node(handle, avtab, &avkey, cond,
> > +                                    extended_perms,
> > +                                    /*
> > +                                     * dontaudit rules need to be
> > +                                     * initialized on creation, others
can
> > +                                     * be 0.
> > +                                     */
> > +                                    specified & AVRULE_DONTAUDIT
> > +                                         ? ~cur->data : 0);
>
> There seems to be a lack of symmetry here.  Either we should initialize
> them all to the proper value (including AUDITDENY, which I think might
> be broken too, although no one uses it anymore since the transition to
> DONTAUDIT), or we should initialize the ones that are ORed to 0 and the
> ones that are ANDed to ~0 and then let the subsequent OR'ing or AND'ing
> adjust appropriately.

I noticed that and thought of doing that, so I'm OK with that. I'll send a
v2.

>
> >               if (!node)
> >                       return EXPAND_RULE_ERROR;
> >               if (enabled) {
> > @@ -1850,10 +1860,7 @@ static int expand_avrule_helper(sepol_handle_t *
handle,
> >                        */
> >                       avdatump->data &= cur->data;
> >               } else if (specified & AVRULE_DONTAUDIT) {
> > -                     if (avdatump->data)
> > -                             avdatump->data &= ~cur->data;
> > -                     else
> > -                             avdatump->data = ~cur->data;
> > +                     avdatump->data &= ~cur->data;
> >               } else if (specified & AVRULE_XPERMS) {
> >                       xperms = avdatump->xperms;
> >                       if (!xperms) {
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1137bdde62f1dc05415ca922
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 15, 2016 12:09, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 11/15/2016 02:40 PM, <a href=3D"mailto:william.c.roberts@intel.com"=
>william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt; From: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sd=
s@tycho.nsa.gov</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; The combining logic for dontaudit rules was wrong, causing<br>
&gt; &gt; a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;=
<br>
&gt; &gt; rule.<br>
&gt; &gt;<br>
&gt; &gt; This is a reimplimation of 6201bb5e2 that avoids the cumbersome<b=
r>
&gt; &gt; pointer assignments on alloced.<br>
&gt; &gt;<br>
&gt; &gt; Reported-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com"=
>nnk@google.com</a>&gt;<br>
&gt; &gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.ro=
berts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 libsepol/src/expand.c | 21 ++++++++++++++-------<br>
&gt; &gt;=C2=A0 1 file changed, 14 insertions(+), 7 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c<br>
&gt; &gt; index 004a029..ef04908 100644<br>
&gt; &gt; --- a/libsepol/src/expand.c<br>
&gt; &gt; +++ b/libsepol/src/expand.c<br>
&gt; &gt; @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_=
t * state,<br>
&gt; &gt;=C2=A0 static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avtab_t * avtab, avtab=
_key_t * key,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond_av_list_t ** cond=
,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av_extended_perms_t *xperm=
s)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av_extended_perms_t *xperm=
s,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t init_data)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avtab_ptr_t node;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0avtab_datum_t avdatum;<br>
&gt; &gt; @@ -1640,6 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_ha=
ndle_t * handle,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!node) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp=
;avdatum, 0, sizeof avdatum);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatum.data =3D=
 init_data;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* this is =
used to get the node - insertion is actually unique */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D av=
tab_insert_nonunique(avtab, key, &amp;avdatum);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!node) =
{<br>
&gt; &gt; @@ -1750,7 +1752,7 @@ static int expand_terule_helper(sepol_handl=
e_t * handle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return EXPAND_RULE_CONFLICT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_av=
tab_node(handle, avtab, &amp;avkey, cond, NULL);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_av=
tab_node(handle, avtab, &amp;avkey, cond, NULL, 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!node)<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enabled=
) {<br>
&gt; &gt; @@ -1824,7 +1826,15 @@ static int expand_avrule_helper(sepol_hand=
le_t * handle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avkey.targe=
t_class =3D cur-&gt;tclass;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avkey.speci=
fied =3D spec;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_av=
tab_node(handle, avtab, &amp;avkey, cond, extended_perms);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_av=
tab_node(handle, avtab, &amp;avkey, cond,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extended_per=
ms,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* dont=
audit rules need to be<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* init=
ialized on creation, others can<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* be 0=
.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 specified &a=
mp; AVRULE_DONTAUDIT<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0? ~cur-&gt;data : 0);<br>
&gt;<br>
&gt; There seems to be a lack of symmetry here.=C2=A0 Either we should init=
ialize<br>
&gt; them all to the proper value (including AUDITDENY, which I think might=
<br>
&gt; be broken too, although no one uses it anymore since the transition to=
<br>
&gt; DONTAUDIT), or we should initialize the ones that are ORed to 0 and th=
e<br>
&gt; ones that are ANDed to ~0 and then let the subsequent OR&#39;ing or AN=
D&#39;ing<br>
&gt; adjust appropriately.</p>
<p dir=3D"ltr">I noticed that and thought of doing that, so I&#39;m OK with=
 that. I&#39;ll send a v2.</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!node)<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return EXPAND_RULE_ERROR;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enabled=
) {<br>
&gt; &gt; @@ -1850,10 +1860,7 @@ static int expand_avrule_helper(sepol_hand=
le_t * handle,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0avdatump-&gt;data &amp;=3D cur-&gt;data;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (=
specified &amp; AVRULE_DONTAUDIT) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (avdatump-&gt;data)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data &amp;=3D ~cur-&g=
t;data;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data =3D ~cur-&gt;dat=
a;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0avdatump-&gt;data &amp;=3D ~cur-&gt;data;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (=
specified &amp; AVRULE_XPERMS) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0xperms =3D avdatump-&gt;xperms;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (!xperms) {<br>
&gt; &gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--001a1137bdde62f1dc05415ca922--
