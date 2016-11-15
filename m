MIME-Version: 1.0
In-Reply-To: <c2d2d660-b8c6-7974-2ee7-a26e931addba@tycho.nsa.gov>
References: <1479145685-4899-1-git-send-email-sds@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC561CD24A5C@ORSMSX103.amr.corp.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC561CD24D0F@ORSMSX103.amr.corp.intel.com>
 <c2d2d660-b8c6-7974-2ee7-a26e931addba@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 09:10:49 -0800
Message-ID: <CAFftDdoGPHLap-BmZT0MUyECqLzXi70XTL_=Q_CSikrgyNw3YA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Content-Type: multipart/alternative; boundary=001a113d48accbb43805415a092d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113d48accbb43805415a092d
Content-Type: text/plain; charset=UTF-8

For bit setting in constant time, one could always clear the bit(s) and or
in what you want. I think that logic might be applicable here. I could take
a stab at looking at it today, if no one has anything better by tomorrow
well just merge yours as is. Does that sound reasonable?

On Nov 15, 2016 06:18, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On 11/14/2016 02:41 PM, Roberts, William C wrote:
> >
> >
> >> -----Original Message-----
> >> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> Roberts,
> >> William C
> >> Sent: Monday, November 14, 2016 10:44 AM
> >> To: Stephen Smalley <sds@tycho.nsa.gov>; selinux@tycho.nsa.gov
> >> Subject: RE: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> >>> Stephen Smalley
> >>> Sent: Monday, November 14, 2016 9:48 AM
> >>> To: selinux@tycho.nsa.gov
> >>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> >>> Subject: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
> >>>
> >>> The combining logic for dontaudit rules was wrong, causing a dontaudit
> >>> A B:C *; rule to be clobbered by a dontaudit A B:C p; rule.
> >>>
> >>> Reported-by: Nick Kralevich <nnk@google.com>
> >>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>> ---
> >>>  libsepol/src/expand.c | 16 ++++++++++++----
> >>>  1 file changed, 12 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c index
> >>> 004a029..d7adbf8
> >>> 100644
> >>> --- a/libsepol/src/expand.c
> >>> +++ b/libsepol/src/expand.c
> >>> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t *
> >>> state, static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
> >>>                                avtab_t * avtab, avtab_key_t * key,
> >>>                                cond_av_list_t ** cond,
> >>> -                              av_extended_perms_t *xperms)
> >>> +                              av_extended_perms_t *xperms,
> >>> +                              char *alloced)
> >>>  {
> >>>     avtab_ptr_t node;
> >>>     avtab_datum_t avdatum;
> >>> @@ -1658,6 +1659,11 @@ static avtab_ptr_t
> >>> find_avtab_node(sepol_handle_t * handle,
> >>>                     nl->next = *cond;
> >>>                     *cond = nl;
> >>>             }
> >>> +           if (alloced)
> >>> +                   *alloced = 1;
> >>> +   } else {
> >>> +           if (alloced)
> >>> +                   *alloced = 0;
> >>>     }
> >>>
> >>>     return node;
> >>> @@ -1750,7 +1756,7 @@ static int expand_terule_helper(sepol_handle_t *
> >>> handle,
> >>>                     return EXPAND_RULE_CONFLICT;
> >>>             }
> >>>
> >>> -           node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
> >>> +           node = find_avtab_node(handle, avtab, &avkey, cond, NULL,
> >>> NULL);
> >>>             if (!node)
> >>>                     return -1;
> >>>             if (enabled) {
> >>> @@ -1790,6 +1796,7 @@ static int expand_avrule_helper(sepol_handle_t *
> >>> handle,
> >>>     class_perm_node_t *cur;
> >>>     uint32_t spec = 0;
> >>>     unsigned int i;
> >>> +   char alloced;
> >>>
> >>>     if (specified & AVRULE_ALLOWED) {
> >>>             spec = AVTAB_ALLOWED;
> >>> @@ -1824,7 +1831,8 @@ static int expand_avrule_helper(sepol_handle_t *
> >>> handle,
> >>>             avkey.target_class = cur->tclass;
> >>>             avkey.specified = spec;
> >>>
> >>> -           node = find_avtab_node(handle, avtab, &avkey, cond,
> >>> extended_perms);
> >>> +           node = find_avtab_node(handle, avtab, &avkey, cond,
> >>> +                                  extended_perms, &alloced);
> >>>             if (!node)
> >>>                     return EXPAND_RULE_ERROR;
> >>>             if (enabled) {
> >>> @@ -1850,7 +1858,7 @@ static int expand_avrule_helper(sepol_handle_t *
> >>> handle,
> >>>                      */
> >>>                     avdatump->data &= cur->data;
> >>>             } else if (specified & AVRULE_DONTAUDIT) {
> >>> -                   if (avdatump->data)
> >>> +                   if (!alloced)
> >>>                             avdatump->data &= ~cur->data;
> >>>                     else
> >>>                             avdatump->data = ~cur->data;
> >>
> >> This seems awkward to me. If the insertion created a new empty node why
> >> wouldn't !avdump->data be true (note the addition of the not operator)?
> >
> > I misstated that a bit, but the !avdump->data was the else case. I am
> really
> > saying why didn't this work before? In my mind, we don't care if its
> allocated
> > we care if it's set or not.
>
> The old logic wrongly assumed that !avdatump->data would only be true if
> this was the first dontaudit rule for the (source type, target type,
> target class) and the node had just been allocated by find_avtab_node()
> with a zero avdatump->data value.
> However, if you have a dontaudit A B:C *; rule, then the set complement
> of it will be 0, so we can have !avdatump->data be true in that case
> too.  Thus, if we end up processing:
>         dontaudit A B:C *;
>         dontaudit A B:C { p1 p2 ... };
> we'll end up clobbering avdatump->data with ~{ p1 p2 ... }.
>
> The marlin policy contains:
>         dontaudit su self:capability *;
>         dontaudit domain self:capability sys_module;
> and self rules are expanded (the kernel has no notion of self), so we
> end up with:
>         dontaudit su self:capability *;
>         dontaudit su self:capability sys_module;
>
> We have never encountered this situation before because there are no
> dontaudit A B:C *; rules in refpolicy; that's a corner case that only
> shows up in Android's su policy, and only because it is a permissive
> domain with no explicit allow rules (other than those picked up via
> macros that set up attributes or transitions).
>
> The fix was to replace the avdatump->data test with an explicit
> indication that the node was freshly allocated i.e. this is the first
> such rule.  I agree that it could be clearer, but I was going for the
> simplest, least invasive fix for now, both due to limited time and to
> ease back-porting.
>
> >>
> >> Or perhaps a mechanism to actual set the data on allocation, this way
> the logic is
> >> Just &=.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a113d48accbb43805415a092d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">For bit setting in constant time, one could always clear the=
 bit(s) and or in what you want. I think that logic might be applicable her=
e. I could take a stab at looking at it today, if no one has anything bette=
r by tomorrow well just merge yours as is. Does that sound reasonable?</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Nov 15, 2016 0=
6:18, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">=
sds@tycho.nsa.gov</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 11/14/2016 02:41 PM, Roberts, William C wrote:<br>
&gt;<br>
&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Selinux [mailto:<a href=3D"mailto:selinux-bounces@tycho.nsa.=
gov">selinux-bounces@tycho.<wbr>nsa.gov</a>] On Behalf Of Roberts,<br>
&gt;&gt; William C<br>
&gt;&gt; Sent: Monday, November 14, 2016 10:44 AM<br>
&gt;&gt; To: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@t=
ycho.nsa.gov</a>&gt;; <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tych=
o.nsa.gov</a><br>
&gt;&gt; Subject: RE: [PATCH v2] libsepol: fix checkpolicy dontaudit compil=
er bug<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: Selinux [mailto:<a href=3D"mailto:selinux-bounces@tycho.=
nsa.gov">selinux-bounces@tycho.<wbr>nsa.gov</a>] On Behalf Of<br>
&gt;&gt;&gt; Stephen Smalley<br>
&gt;&gt;&gt; Sent: Monday, November 14, 2016 9:48 AM<br>
&gt;&gt;&gt; To: <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa=
.gov</a><br>
&gt;&gt;&gt; Cc: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">s=
ds@tycho.nsa.gov</a>&gt;<br>
&gt;&gt;&gt; Subject: [PATCH v2] libsepol: fix checkpolicy dontaudit compil=
er bug<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The combining logic for dontaudit rules was wrong, causing a d=
ontaudit<br>
&gt;&gt;&gt; A B:C *; rule to be clobbered by a dontaudit A B:C p; rule.<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Reported-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.c=
om">nnk@google.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho=
.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 libsepol/src/expand.c | 16 ++++++++++++----<br>
&gt;&gt;&gt;=C2=A0 1 file changed, 12 insertions(+), 4 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c ind=
ex<br>
&gt;&gt;&gt; 004a029..d7adbf8<br>
&gt;&gt;&gt; 100644<br>
&gt;&gt;&gt; --- a/libsepol/src/expand.c<br>
&gt;&gt;&gt; +++ b/libsepol/src/expand.c<br>
&gt;&gt;&gt; @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_<wb=
r>state_t *<br>
&gt;&gt;&gt; state, static avtab_ptr_t find_avtab_node(sepol_handle_t * han=
dle,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avtab_t * avtab, avtab_key=
_t * key,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond_av_list_t ** cond,<br=
>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av_extended_perms_t *xperms)<=
br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av_extended_perms_t *xperms,<=
br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *alloced)<br>
&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0avtab_ptr_t node;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0avtab_datum_t avdatum;<br>
&gt;&gt;&gt; @@ -1658,6 +1659,11 @@ static avtab_ptr_t<br>
&gt;&gt;&gt; find_avtab_node(sepol_handle_t * handle,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nl-&gt;next =3D *cond;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*cond =3D nl;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (alloced)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*alloced =3D 1;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (alloced)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*alloced =3D 0;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0return node;<br>
&gt;&gt;&gt; @@ -1750,7 +1756,7 @@ static int expand_terule_helper(sepol_<w=
br>handle_t *<br>
&gt;&gt;&gt; handle,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return EXPAND_RULE_CONFLICT;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_avtab_=
node(handle, avtab, &amp;avkey, cond, NULL);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_avtab_=
node(handle, avtab, &amp;avkey, cond, NULL,<br>
&gt;&gt;&gt; NULL);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!node)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -1;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enabled) {<=
br>
&gt;&gt;&gt; @@ -1790,6 +1796,7 @@ static int expand_avrule_helper(sepol_<w=
br>handle_t *<br>
&gt;&gt;&gt; handle,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0class_perm_node_t *cur;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0uint32_t spec =3D 0;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0char alloced;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0if (specified &amp; AVRULE_ALLOWED) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec =3D AVTAB_=
ALLOWED;<br>
&gt;&gt;&gt; @@ -1824,7 +1831,8 @@ static int expand_avrule_helper(sepol_<w=
br>handle_t *<br>
&gt;&gt;&gt; handle,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avkey.target_cl=
ass =3D cur-&gt;tclass;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avkey.specified=
 =3D spec;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_avtab_=
node(handle, avtab, &amp;avkey, cond,<br>
&gt;&gt;&gt; extended_perms);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D find_avtab_=
node(handle, avtab, &amp;avkey, cond,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extended_perms,=
 &amp;alloced);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!node)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return EXPAND_RULE_ERROR;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enabled) {<=
br>
&gt;&gt;&gt; @@ -1850,7 +1858,7 @@ static int expand_avrule_helper(sepol_<w=
br>handle_t *<br>
&gt;&gt;&gt; handle,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0avdatump-&gt;data &amp;=3D cur-&gt;data;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (spec=
ified &amp; AVRULE_DONTAUDIT) {<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (avdatump-&gt;data)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!alloced)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data &amp;=3D ~cur-&g=
t;data;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0else<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data =3D ~cur-&gt;dat=
a;<br>
&gt;&gt;<br>
&gt;&gt; This seems awkward to me. If the insertion created a new empty nod=
e why<br>
&gt;&gt; wouldn&#39;t !avdump-&gt;data be true (note the addition of the no=
t operator)?<br>
&gt;<br>
&gt; I misstated that a bit, but the !avdump-&gt;data was the else case. I =
am really<br>
&gt; saying why didn&#39;t this work before? In my mind, we don&#39;t care =
if its allocated<br>
&gt; we care if it&#39;s set or not.<br>
<br>
The old logic wrongly assumed that !avdatump-&gt;data would only be true if=
<br>
this was the first dontaudit rule for the (source type, target type,<br>
target class) and the node had just been allocated by find_avtab_node()<br>
with a zero avdatump-&gt;data value.<br>
However, if you have a dontaudit A B:C *; rule, then the set complement<br>
of it will be 0, so we can have !avdatump-&gt;data be true in that case<br>
too.=C2=A0 Thus, if we end up processing:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dontaudit A B:C *;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dontaudit A B:C { p1 p2 ... };<br>
we&#39;ll end up clobbering avdatump-&gt;data with ~{ p1 p2 ... }.<br>
<br>
The marlin policy contains:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dontaudit su self:capability *;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dontaudit domain self:capability sys_module;<br=
>
and self rules are expanded (the kernel has no notion of self), so we<br>
end up with:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dontaudit su self:capability *;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dontaudit su self:capability sys_module;<br>
<br>
We have never encountered this situation before because there are no<br>
dontaudit A B:C *; rules in refpolicy; that&#39;s a corner case that only<b=
r>
shows up in Android&#39;s su policy, and only because it is a permissive<br=
>
domain with no explicit allow rules (other than those picked up via<br>
macros that set up attributes or transitions).<br>
<br>
The fix was to replace the avdatump-&gt;data test with an explicit<br>
indication that the node was freshly allocated i.e. this is the first<br>
such rule.=C2=A0 I agree that it could be clearer, but I was going for the<=
br>
simplest, least invasive fix for now, both due to limited time and to<br>
ease back-porting.<br>
<br>
&gt;&gt;<br>
&gt;&gt; Or perhaps a mechanism to actual set the data on allocation, this =
way the logic is<br>
&gt;&gt; Just &amp;=3D.<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div></div>

--001a113d48accbb43805415a092d--
