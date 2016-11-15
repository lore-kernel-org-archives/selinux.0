MIME-Version: 1.0
In-Reply-To: <9c2a17dc-4d04-7095-6fca-5aea4aef83da@tycho.nsa.gov>
References: <1479238801-13053-1-git-send-email-william.c.roberts@intel.com>
 <1479238801-13053-3-git-send-email-william.c.roberts@intel.com>
 <975ba9db-54e7-f220-dc7d-112e0fc734c9@tycho.nsa.gov>
 <9c2a17dc-4d04-7095-6fca-5aea4aef83da@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 12:17:22 -0800
Message-ID: <CAFftDdoRk3484UNYfEzRnWVBYKR5vx4mCeDiAVkv5U87-Q13Rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: fix checkpolicy dontaudit compiler bug
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113cfee0e3957805415ca455
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113cfee0e3957805415ca455
Content-Type: text/plain; charset=UTF-8

On Nov 15, 2016 12:12, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 11/15/2016 03:11 PM, Stephen Smalley wrote:
> > On 11/15/2016 02:40 PM, william.c.roberts@intel.com wrote:
> >> From: Stephen Smalley <sds@tycho.nsa.gov>
>
> Also, you don't have to keep me as the author as the patch is a rewrite
> after a revert.

I didn't realize -C kept the author on git commit.

>
> >>
> >> The combining logic for dontaudit rules was wrong, causing
> >> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
> >> rule.
> >>
> >> This is a reimplimation of 6201bb5e2 that avoids the cumbersome
> >> pointer assignments on alloced.
>
> s/reimplimation/reimplementation/
> s/6201bb532/commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 ("libsepol:
> fix checkpolicy dontaudit compiler bug")/
>
> >>
> >> Reported-by: Nick Kralevich <nnk@google.com>
> >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >> ---
> >>  libsepol/src/expand.c | 21 ++++++++++++++-------
> >>  1 file changed, 14 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> >> index 004a029..ef04908 100644
> >> --- a/libsepol/src/expand.c
> >> +++ b/libsepol/src/expand.c
> >> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t *
state,
> >>  static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
> >>                                 avtab_t * avtab, avtab_key_t * key,
> >>                                 cond_av_list_t ** cond,
> >> -                               av_extended_perms_t *xperms)
> >> +                               av_extended_perms_t *xperms,
> >> +                               uint32_t init_data)
> >>  {
> >>      avtab_ptr_t node;
> >>      avtab_datum_t avdatum;
> >> @@ -1640,6 +1641,7 @@ static avtab_ptr_t
find_avtab_node(sepol_handle_t * handle,
> >>
> >>      if (!node) {
> >>              memset(&avdatum, 0, sizeof avdatum);
> >> +            avdatum.data = init_data;
> >>              /* this is used to get the node - insertion is actually
unique */
> >>              node = avtab_insert_nonunique(avtab, key, &avdatum);
> >>              if (!node) {
> >> @@ -1750,7 +1752,7 @@ static int expand_terule_helper(sepol_handle_t *
handle,
> >>                      return EXPAND_RULE_CONFLICT;
> >>              }
> >>
> >> -            node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
> >> +            node = find_avtab_node(handle, avtab, &avkey, cond, NULL,
0);
> >>              if (!node)
> >>                      return -1;
> >>              if (enabled) {
> >> @@ -1824,7 +1826,15 @@ static int expand_avrule_helper(sepol_handle_t
* handle,
> >>              avkey.target_class = cur->tclass;
> >>              avkey.specified = spec;
> >>
> >> -            node = find_avtab_node(handle, avtab, &avkey, cond,
extended_perms);
> >> +            node = find_avtab_node(handle, avtab, &avkey, cond,
> >> +                                   extended_perms,
> >> +                                   /*
> >> +                                    * dontaudit rules need to be
> >> +                                    * initialized on creation, others
can
> >> +                                    * be 0.
> >> +                                    */
> >> +                                   specified & AVRULE_DONTAUDIT
> >> +                                        ? ~cur->data : 0);
> >
> > There seems to be a lack of symmetry here.  Either we should initialize
> > them all to the proper value (including AUDITDENY, which I think might
> > be broken too, although no one uses it anymore since the transition to
> > DONTAUDIT), or we should initialize the ones that are ORed to 0 and the
> > ones that are ANDed to ~0 and then let the subsequent OR'ing or AND'ing
> > adjust appropriately.
> >
> >>              if (!node)
> >>                      return EXPAND_RULE_ERROR;
> >>              if (enabled) {
> >> @@ -1850,10 +1860,7 @@ static int expand_avrule_helper(sepol_handle_t
* handle,
> >>                       */
> >>                      avdatump->data &= cur->data;
> >>              } else if (specified & AVRULE_DONTAUDIT) {
> >> -                    if (avdatump->data)
> >> -                            avdatump->data &= ~cur->data;
> >> -                    else
> >> -                            avdatump->data = ~cur->data;
> >> +                    avdatump->data &= ~cur->data;
> >>              } else if (specified & AVRULE_XPERMS) {
> >>                      xperms = avdatump->xperms;
> >>                      if (!xperms) {
> >>
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113cfee0e3957805415ca455
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 15, 2016 12:12, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 11/15/2016 03:11 PM, Stephen Smalley wrote:<br>
&gt; &gt; On 11/15/2016 02:40 PM, <a href=3D"mailto:william.c.roberts@intel=
.com">william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt;&gt; From: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov=
">sds@tycho.nsa.gov</a>&gt;<br>
&gt;<br>
&gt; Also, you don&#39;t have to keep me as the author as the patch is a re=
write<br>
&gt; after a revert.</p>
<p dir=3D"ltr">I didn&#39;t realize -C kept the author on git commit.</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The combining logic for dontaudit rules was wrong, causing<br=
>
&gt; &gt;&gt; a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:=
C p;<br>
&gt; &gt;&gt; rule.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is a reimplimation of 6201bb5e2 that avoids the cumberso=
me<br>
&gt; &gt;&gt; pointer assignments on alloced.<br>
&gt;<br>
&gt; s/reimplimation/reimplementation/<br>
&gt; s/6201bb532/commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 (&quot;lib=
sepol:<br>
&gt; fix checkpolicy dontaudit compiler bug&quot;)/<br>
&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Reported-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.=
com">nnk@google.com</a>&gt;<br>
&gt; &gt;&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.=
c.roberts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 libsepol/src/expand.c | 21 ++++++++++++++-------<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 14 insertions(+), 7 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c<br=
>
&gt; &gt;&gt; index 004a029..ef04908 100644<br>
&gt; &gt;&gt; --- a/libsepol/src/expand.c<br>
&gt; &gt;&gt; +++ b/libsepol/src/expand.c<br>
&gt; &gt;&gt; @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_st=
ate_t * state,<br>
&gt; &gt;&gt;=C2=A0 static avtab_ptr_t find_avtab_node(sepol_handle_t * han=
dle,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avtab_t * avtab, av=
tab_key_t * key,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cond_av_list_t ** c=
ond,<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0av_extended_perms_t *xp=
erms)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0av_extended_perms_t *xp=
erms,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t init_data)<br>
&gt; &gt;&gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 avtab_ptr_t node;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 avtab_datum_t avdatum;<br>
&gt; &gt;&gt; @@ -1640,6 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepo=
l_handle_t * handle,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!node) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;a=
vdatum, 0, sizeof avdatum);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avdatum.data =3D i=
nit_data;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* this is us=
ed to get the node - insertion is actually unique */<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D avta=
b_insert_nonunique(avtab, key, &amp;avdatum);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node) {<=
br>
&gt; &gt;&gt; @@ -1750,7 +1752,7 @@ static int expand_terule_helper(sepol_h=
andle_t * handle,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return EXPAND_RULE_CONFLICT;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D find_avta=
b_node(handle, avtab, &amp;avkey, cond, NULL);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D find_avta=
b_node(handle, avtab, &amp;avkey, cond, NULL, 0);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node)<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enabled) =
{<br>
&gt; &gt;&gt; @@ -1824,7 +1826,15 @@ static int expand_avrule_helper(sepol_=
handle_t * handle,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avkey.target_=
class =3D cur-&gt;tclass;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avkey.specifi=
ed =3D spec;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D find_avta=
b_node(handle, avtab, &amp;avkey, cond, extended_perms);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D find_avta=
b_node(handle, avtab, &amp;avkey, cond,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extended_=
perms,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * dontau=
dit rules need to be<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * initia=
lized on creation, others can<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * be 0.<=
br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specified=
 &amp; AVRULE_DONTAUDIT<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ? ~cur-&gt;data : 0);<br>
&gt; &gt;<br>
&gt; &gt; There seems to be a lack of symmetry here.=C2=A0 Either we should=
 initialize<br>
&gt; &gt; them all to the proper value (including AUDITDENY, which I think =
might<br>
&gt; &gt; be broken too, although no one uses it anymore since the transiti=
on to<br>
&gt; &gt; DONTAUDIT), or we should initialize the ones that are ORed to 0 a=
nd the<br>
&gt; &gt; ones that are ANDed to ~0 and then let the subsequent OR&#39;ing =
or AND&#39;ing<br>
&gt; &gt; adjust appropriately.<br>
&gt; &gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node)<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return EXPAND_RULE_ERROR;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enabled) =
{<br>
&gt; &gt;&gt; @@ -1850,10 +1860,7 @@ static int expand_avrule_helper(sepol_=
handle_t * handle,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 avdatump-&gt;data &amp;=3D cur-&gt;data;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (sp=
ecified &amp; AVRULE_DONTAUDIT) {<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (avdatump-&gt;data)<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avdatump-&gt;data &amp;=3D ~cur-&gt;=
data;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avdatump-&gt;data =3D ~cur-&gt;data;=
<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 avdatump-&gt;data &amp;=3D ~cur-&gt;data;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (sp=
ecified &amp; AVRULE_XPERMS) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 xperms =3D avdatump-&gt;xperms;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (!xperms) {<br>
&gt; &gt;&gt;<br>
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

--001a113cfee0e3957805415ca455--
