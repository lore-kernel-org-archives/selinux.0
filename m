MIME-Version: 1.0
In-Reply-To: <CAFJ0LnFyevTSrP2WsaAEOG6k_aoQq8Us-NySsyZGE4e4vcmYKw@mail.gmail.com>
References: <1479145685-4899-1-git-send-email-sds@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC561CD24A5C@ORSMSX103.amr.corp.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC561CD24D0F@ORSMSX103.amr.corp.intel.com>
 <c2d2d660-b8c6-7974-2ee7-a26e931addba@tycho.nsa.gov>
 <CAFftDdoGPHLap-BmZT0MUyECqLzXi70XTL_=Q_CSikrgyNw3YA@mail.gmail.com>
 <CAFJ0LnFyevTSrP2WsaAEOG6k_aoQq8Us-NySsyZGE4e4vcmYKw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 09:34:38 -0800
Message-ID: <CAFftDdo+GrscrHh4c+FE1Q64ZJvJxHRBptoxYVYi7Rpbj2QoEA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
To: Nick Kralevich <nnk@google.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113b0070f2631b05415a5ec1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113b0070f2631b05415a5ec1
Content-Type: text/plain; charset=UTF-8

On Nov 15, 2016 09:30, "Nick Kralevich" <nnk@google.com> wrote:
>
> Perhaps merge Stephen's change now, and address any changes in a
> followup? I'd like to get it merged into the selinux tree so I can
> merge the changes into the Android tree.

That's fine with me too.

>
> -- Nick
>
> On Tue, Nov 15, 2016 at 9:10 AM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > For bit setting in constant time, one could always clear the bit(s) and
or
> > in what you want. I think that logic might be applicable here. I could
take
> > a stab at looking at it today, if no one has anything better by tomorrow
> > well just merge yours as is. Does that sound reasonable?
> >
> >
> > On Nov 15, 2016 06:18, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> >>
> >> On 11/14/2016 02:41 PM, Roberts, William C wrote:
> >> >
> >> >
> >> >> -----Original Message-----
> >> >> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> >> >> Roberts,
> >> >> William C
> >> >> Sent: Monday, November 14, 2016 10:44 AM
> >> >> To: Stephen Smalley <sds@tycho.nsa.gov>; selinux@tycho.nsa.gov
> >> >> Subject: RE: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler
> >> >> bug
> >> >>
> >> >>
> >> >>
> >> >>> -----Original Message-----
> >> >>> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> >> >>> Stephen Smalley
> >> >>> Sent: Monday, November 14, 2016 9:48 AM
> >> >>> To: selinux@tycho.nsa.gov
> >> >>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> >> >>> Subject: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler
bug
> >> >>>
> >> >>> The combining logic for dontaudit rules was wrong, causing a
dontaudit
> >> >>> A B:C *; rule to be clobbered by a dontaudit A B:C p; rule.
> >> >>>
> >> >>> Reported-by: Nick Kralevich <nnk@google.com>
> >> >>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> >>> ---
> >> >>>  libsepol/src/expand.c | 16 ++++++++++++----
> >> >>>  1 file changed, 12 insertions(+), 4 deletions(-)
> >> >>>
> >> >>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c index
> >> >>> 004a029..d7adbf8
> >> >>> 100644
> >> >>> --- a/libsepol/src/expand.c
> >> >>> +++ b/libsepol/src/expand.c
> >> >>> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t
*
> >> >>> state, static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
> >> >>>                                avtab_t * avtab, avtab_key_t * key,
> >> >>>                                cond_av_list_t ** cond,
> >> >>> -                              av_extended_perms_t *xperms)
> >> >>> +                              av_extended_perms_t *xperms,
> >> >>> +                              char *alloced)
> >> >>>  {
> >> >>>     avtab_ptr_t node;
> >> >>>     avtab_datum_t avdatum;
> >> >>> @@ -1658,6 +1659,11 @@ static avtab_ptr_t
> >> >>> find_avtab_node(sepol_handle_t * handle,
> >> >>>                     nl->next = *cond;
> >> >>>                     *cond = nl;
> >> >>>             }
> >> >>> +           if (alloced)
> >> >>> +                   *alloced = 1;
> >> >>> +   } else {
> >> >>> +           if (alloced)
> >> >>> +                   *alloced = 0;
> >> >>>     }
> >> >>>
> >> >>>     return node;
> >> >>> @@ -1750,7 +1756,7 @@ static int
expand_terule_helper(sepol_handle_t *
> >> >>> handle,
> >> >>>                     return EXPAND_RULE_CONFLICT;
> >> >>>             }
> >> >>>
> >> >>> -           node = find_avtab_node(handle, avtab, &avkey, cond,
NULL);
> >> >>> +           node = find_avtab_node(handle, avtab, &avkey, cond,
NULL,
> >> >>> NULL);
> >> >>>             if (!node)
> >> >>>                     return -1;
> >> >>>             if (enabled) {
> >> >>> @@ -1790,6 +1796,7 @@ static int
expand_avrule_helper(sepol_handle_t *
> >> >>> handle,
> >> >>>     class_perm_node_t *cur;
> >> >>>     uint32_t spec = 0;
> >> >>>     unsigned int i;
> >> >>> +   char alloced;
> >> >>>
> >> >>>     if (specified & AVRULE_ALLOWED) {
> >> >>>             spec = AVTAB_ALLOWED;
> >> >>> @@ -1824,7 +1831,8 @@ static int
expand_avrule_helper(sepol_handle_t *
> >> >>> handle,
> >> >>>             avkey.target_class = cur->tclass;
> >> >>>             avkey.specified = spec;
> >> >>>
> >> >>> -           node = find_avtab_node(handle, avtab, &avkey, cond,
> >> >>> extended_perms);
> >> >>> +           node = find_avtab_node(handle, avtab, &avkey, cond,
> >> >>> +                                  extended_perms, &alloced);
> >> >>>             if (!node)
> >> >>>                     return EXPAND_RULE_ERROR;
> >> >>>             if (enabled) {
> >> >>> @@ -1850,7 +1858,7 @@ static int
expand_avrule_helper(sepol_handle_t *
> >> >>> handle,
> >> >>>                      */
> >> >>>                     avdatump->data &= cur->data;
> >> >>>             } else if (specified & AVRULE_DONTAUDIT) {
> >> >>> -                   if (avdatump->data)
> >> >>> +                   if (!alloced)
> >> >>>                             avdatump->data &= ~cur->data;
> >> >>>                     else
> >> >>>                             avdatump->data = ~cur->data;
> >> >>
> >> >> This seems awkward to me. If the insertion created a new empty node
why
> >> >> wouldn't !avdump->data be true (note the addition of the not
operator)?
> >> >
> >> > I misstated that a bit, but the !avdump->data was the else case. I am
> >> > really
> >> > saying why didn't this work before? In my mind, we don't care if its
> >> > allocated
> >> > we care if it's set or not.
> >>
> >> The old logic wrongly assumed that !avdatump->data would only be true
if
> >> this was the first dontaudit rule for the (source type, target type,
> >> target class) and the node had just been allocated by find_avtab_node()
> >> with a zero avdatump->data value.
> >> However, if you have a dontaudit A B:C *; rule, then the set complement
> >> of it will be 0, so we can have !avdatump->data be true in that case
> >> too.  Thus, if we end up processing:
> >>         dontaudit A B:C *;
> >>         dontaudit A B:C { p1 p2 ... };
> >> we'll end up clobbering avdatump->data with ~{ p1 p2 ... }.
> >>
> >> The marlin policy contains:
> >>         dontaudit su self:capability *;
> >>         dontaudit domain self:capability sys_module;
> >> and self rules are expanded (the kernel has no notion of self), so we
> >> end up with:
> >>         dontaudit su self:capability *;
> >>         dontaudit su self:capability sys_module;
> >>
> >> We have never encountered this situation before because there are no
> >> dontaudit A B:C *; rules in refpolicy; that's a corner case that only
> >> shows up in Android's su policy, and only because it is a permissive
> >> domain with no explicit allow rules (other than those picked up via
> >> macros that set up attributes or transitions).
> >>
> >> The fix was to replace the avdatump->data test with an explicit
> >> indication that the node was freshly allocated i.e. this is the first
> >> such rule.  I agree that it could be clearer, but I was going for the
> >> simplest, least invasive fix for now, both due to limited time and to
> >> ease back-porting.
> >>
> >> >>
> >> >> Or perhaps a mechanism to actual set the data on allocation, this
way
> >> >> the logic is
> >> >> Just &=.
> >>
> >> _______________________________________________
> >> Selinux mailing list
> >> Selinux@tycho.nsa.gov
> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> To get help, send an email containing "help" to
> >> Selinux-request@tycho.nsa.gov.
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
>
>
>
> --
> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--001a113b0070f2631b05415a5ec1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 15, 2016 09:30, &quot;Nick Kralevich&quot; &lt;<a hre=
f=3D"mailto:nnk@google.com">nnk@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Perhaps merge Stephen&#39;s change now, and address any changes in a<b=
r>
&gt; followup? I&#39;d like to get it merged into the selinux tree so I can=
<br>
&gt; merge the changes into the Android tree.</p>
<p dir=3D"ltr">That&#39;s fine with me too.</p>
<p dir=3D"ltr">&gt;<br>
&gt; -- Nick<br>
&gt;<br>
&gt; On Tue, Nov 15, 2016 at 9:10 AM, William Roberts<br>
&gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.c=
om</a>&gt; wrote:<br>
&gt; &gt; For bit setting in constant time, one could always clear the bit(=
s) and or<br>
&gt; &gt; in what you want. I think that logic might be applicable here. I =
could take<br>
&gt; &gt; a stab at looking at it today, if no one has anything better by t=
omorrow<br>
&gt; &gt; well just merge yours as is. Does that sound reasonable?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Nov 15, 2016 06:18, &quot;Stephen Smalley&quot; &lt;<a href=3D=
"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 11/14/2016 02:41 PM, Roberts, William C wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; &gt;&gt; From: Selinux [mailto:<a href=3D"mailto:selinux-boun=
ces@tycho.nsa.gov">selinux-bounces@tycho.nsa.gov</a>] On Behalf Of<br>
&gt; &gt;&gt; &gt;&gt; Roberts,<br>
&gt; &gt;&gt; &gt;&gt; William C<br>
&gt; &gt;&gt; &gt;&gt; Sent: Monday, November 14, 2016 10:44 AM<br>
&gt; &gt;&gt; &gt;&gt; To: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.=
nsa.gov">sds@tycho.nsa.gov</a>&gt;; <a href=3D"mailto:selinux@tycho.nsa.gov=
">selinux@tycho.nsa.gov</a><br>
&gt; &gt;&gt; &gt;&gt; Subject: RE: [PATCH v2] libsepol: fix checkpolicy do=
ntaudit compiler<br>
&gt; &gt;&gt; &gt;&gt; bug<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; &gt;&gt;&gt; From: Selinux [mailto:<a href=3D"mailto:selinux-=
bounces@tycho.nsa.gov">selinux-bounces@tycho.nsa.gov</a>] On Behalf Of<br>
&gt; &gt;&gt; &gt;&gt;&gt; Stephen Smalley<br>
&gt; &gt;&gt; &gt;&gt;&gt; Sent: Monday, November 14, 2016 9:48 AM<br>
&gt; &gt;&gt; &gt;&gt;&gt; To: <a href=3D"mailto:selinux@tycho.nsa.gov">sel=
inux@tycho.nsa.gov</a><br>
&gt; &gt;&gt; &gt;&gt;&gt; Cc: Stephen Smalley &lt;<a href=3D"mailto:sds@ty=
cho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; Subject: [PATCH v2] libsepol: fix checkpolicy do=
ntaudit compiler bug<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; The combining logic for dontaudit rules was wron=
g, causing a dontaudit<br>
&gt; &gt;&gt; &gt;&gt;&gt; A B:C *; rule to be clobbered by a dontaudit A B=
:C p; rule.<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; Reported-by: Nick Kralevich &lt;<a href=3D"mailt=
o:nnk@google.com">nnk@google.com</a>&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; Signed-off-by: Stephen Smalley &lt;<a href=3D"ma=
ilto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 libsepol/src/expand.c | 16 ++++++++++++---=
-<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 1 file changed, 12 insertions(+), 4 deleti=
ons(-)<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; diff --git a/libsepol/src/expand.c b/libsepol/sr=
c/expand.c index<br>
&gt; &gt;&gt; &gt;&gt;&gt; 004a029..d7adbf8<br>
&gt; &gt;&gt; &gt;&gt;&gt; 100644<br>
&gt; &gt;&gt; &gt;&gt;&gt; --- a/libsepol/src/expand.c<br>
&gt; &gt;&gt; &gt;&gt;&gt; +++ b/libsepol/src/expand.c<br>
&gt; &gt;&gt; &gt;&gt;&gt; @@ -1604,7 +1604,8 @@ static int expand_range_tr=
ans(expand_state_t *<br>
&gt; &gt;&gt; &gt;&gt;&gt; state, static avtab_ptr_t find_avtab_node(sepol_=
handle_t * handle,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avtab_t * av=
tab, avtab_key_t * key,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond_av_list=
_t ** cond,<br>
&gt; &gt;&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av_extended_per=
ms_t *xperms)<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 av_extended_per=
ms_t *xperms,<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *alloced)<=
br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 {<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0avtab_ptr_t node;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0avtab_datum_t avdatum;<br>
&gt; &gt;&gt; &gt;&gt;&gt; @@ -1658,6 +1659,11 @@ static avtab_ptr_t<br>
&gt; &gt;&gt; &gt;&gt;&gt; find_avtab_node(sepol_handle_t * handle,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0nl-&gt;next =3D *cond;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*cond =3D nl;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (al=
loced)<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*alloced =3D 1;<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0} else {<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (al=
loced)<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*alloced =3D 0;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0return node;<br>
&gt; &gt;&gt; &gt;&gt;&gt; @@ -1750,7 +1756,7 @@ static int expand_terule_h=
elper(sepol_handle_t *<br>
&gt; &gt;&gt; &gt;&gt;&gt; handle,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return EXPAND_RULE_CONFLICT;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =
=3D find_avtab_node(handle, avtab, &amp;avkey, cond, NULL);<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =
=3D find_avtab_node(handle, avtab, &amp;avkey, cond, NULL,<br>
&gt; &gt;&gt; &gt;&gt;&gt; NULL);<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (!node)<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (enabled) {<br>
&gt; &gt;&gt; &gt;&gt;&gt; @@ -1790,6 +1796,7 @@ static int expand_avrule_h=
elper(sepol_handle_t *<br>
&gt; &gt;&gt; &gt;&gt;&gt; handle,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0class_perm_node_t *cur;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0uint32_t spec =3D 0;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0char alloced;<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0if (specified &amp; AVRULE_AL=
LOWED) {<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
pec =3D AVTAB_ALLOWED;<br>
&gt; &gt;&gt; &gt;&gt;&gt; @@ -1824,7 +1831,8 @@ static int expand_avrule_h=
elper(sepol_handle_t *<br>
&gt; &gt;&gt; &gt;&gt;&gt; handle,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
vkey.target_class =3D cur-&gt;tclass;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
vkey.specified =3D spec;<br>
&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =
=3D find_avtab_node(handle, avtab, &amp;avkey, cond,<br>
&gt; &gt;&gt; &gt;&gt;&gt; extended_perms);<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node =
=3D find_avtab_node(handle, avtab, &amp;avkey, cond,<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
xtended_perms, &amp;alloced);<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (!node)<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return EXPAND_RULE_ERROR;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (enabled) {<br>
&gt; &gt;&gt; &gt;&gt;&gt; @@ -1850,7 +1858,7 @@ static int expand_avrule_h=
elper(sepol_handle_t *<br>
&gt; &gt;&gt; &gt;&gt;&gt; handle,<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data &amp;=3D cur-&gt;data;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
 else if (specified &amp; AVRULE_DONTAUDIT) {<br>
&gt; &gt;&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (avdatump-&gt;data)<br>
&gt; &gt;&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!alloced)<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data &a=
mp;=3D ~cur-&gt;data;<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt;&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data =
=3D ~cur-&gt;data;<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; This seems awkward to me. If the insertion created a=
 new empty node why<br>
&gt; &gt;&gt; &gt;&gt; wouldn&#39;t !avdump-&gt;data be true (note the addi=
tion of the not operator)?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; I misstated that a bit, but the !avdump-&gt;data was the=
 else case. I am<br>
&gt; &gt;&gt; &gt; really<br>
&gt; &gt;&gt; &gt; saying why didn&#39;t this work before? In my mind, we d=
on&#39;t care if its<br>
&gt; &gt;&gt; &gt; allocated<br>
&gt; &gt;&gt; &gt; we care if it&#39;s set or not.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The old logic wrongly assumed that !avdatump-&gt;data would o=
nly be true if<br>
&gt; &gt;&gt; this was the first dontaudit rule for the (source type, targe=
t type,<br>
&gt; &gt;&gt; target class) and the node had just been allocated by find_av=
tab_node()<br>
&gt; &gt;&gt; with a zero avdatump-&gt;data value.<br>
&gt; &gt;&gt; However, if you have a dontaudit A B:C *; rule, then the set =
complement<br>
&gt; &gt;&gt; of it will be 0, so we can have !avdatump-&gt;data be true in=
 that case<br>
&gt; &gt;&gt; too.=C2=A0 Thus, if we end up processing:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dontaudit A B:C *;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dontaudit A B:C { p1 p2 ... =
};<br>
&gt; &gt;&gt; we&#39;ll end up clobbering avdatump-&gt;data with ~{ p1 p2 .=
.. }.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The marlin policy contains:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dontaudit su self:capability=
 *;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dontaudit domain self:capabi=
lity sys_module;<br>
&gt; &gt;&gt; and self rules are expanded (the kernel has no notion of self=
), so we<br>
&gt; &gt;&gt; end up with:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dontaudit su self:capability=
 *;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dontaudit su self:capability=
 sys_module;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We have never encountered this situation before because there=
 are no<br>
&gt; &gt;&gt; dontaudit A B:C *; rules in refpolicy; that&#39;s a corner ca=
se that only<br>
&gt; &gt;&gt; shows up in Android&#39;s su policy, and only because it is a=
 permissive<br>
&gt; &gt;&gt; domain with no explicit allow rules (other than those picked =
up via<br>
&gt; &gt;&gt; macros that set up attributes or transitions).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The fix was to replace the avdatump-&gt;data test with an exp=
licit<br>
&gt; &gt;&gt; indication that the node was freshly allocated i.e. this is t=
he first<br>
&gt; &gt;&gt; such rule.=C2=A0 I agree that it could be clearer, but I was =
going for the<br>
&gt; &gt;&gt; simplest, least invasive fix for now, both due to limited tim=
e and to<br>
&gt; &gt;&gt; ease back-porting.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; Or perhaps a mechanism to actual set the data on all=
ocation, this way<br>
&gt; &gt;&gt; &gt;&gt; the logic is<br>
&gt; &gt;&gt; &gt;&gt; Just &amp;=3D.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; Selinux mailing list<br>
&gt; &gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.go=
v</a><br>
&gt; &gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave=
@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt;&gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; &gt;&gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-requ=
est@tycho.nsa.gov</a>.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Selinux mailing list<br>
&gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
><br>
&gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tyc=
ho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; &gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@=
tycho.nsa.gov</a>.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Nick Kralevich | Android Security | <a href=3D"mailto:nnk@google.com">=
nnk@google.com</a> | 650.214.4037<br></p>

--001a113b0070f2631b05415a5ec1--
