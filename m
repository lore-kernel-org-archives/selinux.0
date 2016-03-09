MIME-Version: 1.0
In-Reply-To: <56E04456.5050500@tycho.nsa.gov>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov> <56DDE54F.4050208@tycho.nsa.gov>
 <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
 <56DED6C6.4000407@tycho.nsa.gov>
 <CAFftDdq_g07J-0LufxQM+5Bjxmk_LuVhAZ+aXU0zwu=GSjtwVg@mail.gmail.com>
 <56E02EAE.3090505@tycho.nsa.gov> <56E04456.5050500@tycho.nsa.gov>
Date: Wed, 9 Mar 2016 07:45:15 -0800
Message-ID: <CAFftDdqnfkBATzUfPwV1RF=T3CAXGNbBW6zju8X5gcpDtkc+ew@mail.gmail.com>
Subject: Re: initial_sid context via libsepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1140cd0493c69d052d9f95af
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140cd0493c69d052d9f95af
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 9, 2016 at 7:42 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 03/09/2016 09:09 AM, Stephen Smalley wrote:
>
>> On 03/09/2016 12:18 AM, William Roberts wrote:
>>
>>>
>>> On Mar 8, 2016 05:41, "Stephen Smalley" <sds@tycho.nsa.gov
>>> <mailto:sds@tycho.nsa.gov>> wrote:
>>>  >
>>>  > On 03/07/2016 08:32 PM, William Roberts wrote:
>>>  >>
>>>  >>
>>>  >>
>>>  >> On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov
>>> <mailto:sds@tycho.nsa.gov>
>>>  >> <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>> wrote:
>>>  >>
>>>  >>     On 03/07/2016 01:44 PM, Stephen Smalley wrote:
>>>  >>
>>>  >>         On 03/07/2016 10:41 AM, Richard Haines wrote:
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>                 On Saturday, 5 March 2016, 14:48, Richard Haines
>>>  >>                 <richard_c_haines@btinternet.com
>>> <mailto:richard_c_haines@btinternet.com>
>>>  >>                 <mailto:richard_c_haines@btinternet.com
>>> <mailto:richard_c_haines@btinternet.com>>> wrote:
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>                 On Friday, 4 March 2016, 21:18, "Roberts, William C=
"
>>>  >>                 <william.c.roberts@intel.com
>>> <mailto:william.c.roberts@intel.com>
>>>  >>                 <mailto:william.c.roberts@intel.com
>>> <mailto:william.c.roberts@intel.com>>> wrote:
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>                     How can one obtain the same value as
>>>  >>                     /sys/fs/selinux/initial_contexts/file
>>>  >>
>>>  >>                 via libsepol?
>>>  >>
>>>  >>
>>>  >>                     I=E2=80=99ve been digging around libsepol and i=
ts not
>>> quite
>>>  >>                     clear to me.
>>>  >>
>>>  >>                     It looks as though the record is here:
>>>  >>                                       context_struct_t *a =3D
>>> &((policydb_t
>>>  >>
>>>  >>                 *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>>  >>
>>>  >>                                       context_struct_t *b =3D
>>> &((policydb_t
>>>  >>
>>>  >>                 *)pol.db)->ocontexts[OCON_ISID]->context[1];
>>>  >>
>>>  >>
>>>  >>                                       printf("%u\n", a->type);
>>>  >>                                       printf("%u\n",b->type);
>>>  >>
>>>  >>                     Prints:
>>>  >>                     185
>>>  >>                     0
>>>  >>
>>>  >>                     Not sure if this is right, and how to format th=
e
>>>  >>                     context struct to a
>>>  >>                     string.
>>>  >>
>>>  >>                 I didn=E2=80=99t see any helpers.
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>
>>>  >>                 I've attached an example, hope it's useful
>>>  >>
>>>  >>
>>>  >>             I've updated the example with more detail and display S=
ID
>>>  >>             name using
>>>  >>             SID value not counter.
>>>  >>
>>>  >>
>>>  >>         Any particular reason you didn't use sepol_sid_to_context()=
?
>>>  >>
>>>  >>
>>>  >>     I guess context_to_string() on the context structure would work
>>>  >>     better for your purposes.   sepol_sid_to_context() would requir=
e
>>>  >>     loading the sidtab via policydb_load_isids() and setting the
>>>  >>     internal policydb to the one you loaded via sepol_set_policydb(=
).
>>>  >>
>>>  >>
>>>  >>
>>>  >> Seems as though its not exported api, but it does indeed print
>>> something:
>>>  >> code:
>>>  >> char *s;
>>>  >> size_t len;
>>>  >> context_struct_t *a =3D &((policydb_t
>>>  >> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>>  >>
>>>  >> int rc =3D context_to_string(pol.handle, (policydb_t *)pol.db, a, &=
s,
>>> &len);
>>>  >>
>>>  >> printf("rc: %d\n", rc);
>>>  >> printf("con: %s\n", s);
>>>  >>
>>>  >> prints:
>>>  >>    rc: 0
>>>  >>    con: u:object_r:null_device:s0
>>>  >>
>>>  >> However, I am after the initial sid for file, which this isn't
>>> it... is
>>>  >> it in the ocontexts array under a different index?
>>>  >
>>>  >
>>>  > ocontext[OCON_ISID] points to the head of a linked list of initial
>>> SIDs, with the values in ->sid[0] and the context structures in
>>> ->context[0].  Richard's sample program showed you how to walk it and
>>> print out all the entries.  The symbolic names themselves aren't in the
>>> policydb, as he noted; you can grab it from the kernel source
>>> (linux/security/selinux/include/initial_sid_to_string.h) or from the
>>> refpolicy (run make in refpolicy/policy/flask and grab
>>> kernel/initial_sid_to_string.h).
>>>
>>> I was hoping there was something I was missing between what you were
>>> posting and Richards sample. Looks like it's all by ordinal, so
>>> (conjecturing here) initial sid ordering must match the kernel header
>>> ordering as far as I can tell, is that right?
>>>
>>> Something must remap it in the kernel from initial sid to class.
>>>
>>> I was hoping there would be a clean way to grab this from the policy fo=
r
>>> use in fs_config tools under build, but just hard coding the default
>>> context string seems to be the best approach.
>>>
>>
>> I don't know what you are doing, but the initial SID context is not what
>> you want for fs_config.  You want the result of selabel_lookup(), just
>> as is done by system/extras/ext4_utils to label files in the generated
>> images.
>>
>
> Oh, I see - you are trying to replace the hardcoded
> "u:object_r:unlabeled:s0" fallback in fs_config.c when selabel_lookup()
> fails.  Worthy goal, but I don't think trying to use an initial SID conte=
xt
> is the right approach.  I guess the question is whether selabel_lookup()
> failure ought to just be a hard error for fs_config; if the file does not
> match any expression in file_contexts, then that reflects a gap in the
> file_contexts configuration that should be filled.  We don't actually wan=
t
> any files with the unlabeled context; the rules for unlabeled in the poli=
cy
> are just for upgrading from pre-SELinux devices with unlabeled /data.
>

Yeah I was trying to understand why its not a hard failure. I was thinking
at boot the fc would relabel it, but it would be the same fc as packaged in
the ota afaik.  I think the easiest would be just ask nick what his
intentions were here and what corner case he was trying to cover. I haven't
been able to get it to take that path in fs_config.c

I noticed this when doing this work:
https://android-review.googlesource.com/#/q/topic:fs-config

--=20
Respectfully,

William C Roberts

--001a1140cd0493c69d052d9f95af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Mar 9, 2016 at 7:42 AM, Stephen Smalley <span dir=3D"ltr">&lt;<=
a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">On=
 03/09/2016 09:09 AM, Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On 03/09/2016 12:18 AM, William Roberts wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
On Mar 8, 2016 05:41, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto:sds=
@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a><br>
&lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho=
.nsa.gov</a>&gt;&gt; wrote:<br>
=C2=A0&gt;<br>
=C2=A0&gt; On 03/07/2016 08:32 PM, William Roberts wrote:<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt; On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a><br>
&lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho=
.nsa.gov</a>&gt;<br>
=C2=A0&gt;&gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_b=
lank">sds@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov"=
 target=3D"_blank">sds@tycho.nsa.gov</a>&gt;&gt;&gt; wrote:<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0On 03/07/2016 01:44 PM, Stephen Smalley w=
rote:<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 03/07/2016 10:41 AM, Ric=
hard Haines wrote:<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0On Saturday, 5 March 2016, 14:48, Richard Haines<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;<a href=3D"mailto:richard_c_haines@btinternet.com" target=3D"_blank"=
>richard_c_haines@btinternet.com</a><br>
&lt;mailto:<a href=3D"mailto:richard_c_haines@btinternet.com" target=3D"_bl=
ank">richard_c_haines@btinternet.com</a>&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;mailto:<a href=3D"mailto:richard_c_haines@btinternet.com" target=3D"=
_blank">richard_c_haines@btinternet.com</a><br>
&lt;mailto:<a href=3D"mailto:richard_c_haines@btinternet.com" target=3D"_bl=
ank">richard_c_haines@btinternet.com</a>&gt;&gt;&gt; wrote:<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0On Friday, 4 March 2016, 21:18, &quot;Roberts, William C&quot;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blank">wil=
liam.c.roberts@intel.com</a><br>
&lt;mailto:<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blank"=
>william.c.roberts@intel.com</a>&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;mailto:<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_bla=
nk">william.c.roberts@intel.com</a><br>
&lt;mailto:<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blank"=
>william.c.roberts@intel.com</a>&gt;&gt;&gt; wrote:<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0How can one obtain the same value as<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/sys/fs/selinux/initial_contexts/file<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0via libsepol?<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0I=E2=80=99ve been digging around libsepol and its not<br>
quite<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0clear to me.<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0It looks as though the record is here:<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0context_struct_t *a =3D<br>
&amp;((policydb_t<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[0];<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0context_struct_t *b =3D<br>
&amp;((policydb_t<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[1];<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0printf(&quot;%u\n&quot;, a-&gt;type);<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0printf(&quot;%u\n&quot;,b-&gt;type);<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Prints:<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0185<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Not sure if this is right, and how to format the<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0context struct to a<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0string.<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0I didn=E2=80=99t see any helpers.<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0I&#39;ve attached an example, hope it&#39;s useful<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I&#39;ve upda=
ted the example with more detail and display SID<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name using<br=
>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SID value not=
 counter.<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Any particular reason you d=
idn&#39;t use sepol_sid_to_context()?<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0I guess context_to_string() on the contex=
t structure would work<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0better for your purposes.=C2=A0 =C2=A0sep=
ol_sid_to_context() would require<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0loading the sidtab via policydb_load_isid=
s() and setting the<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0internal policydb to the one you loaded v=
ia sepol_set_policydb().<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt; Seems as though its not exported api, but it does indeed pri=
nt<br>
something:<br>
=C2=A0&gt;&gt; code:<br>
=C2=A0&gt;&gt; char *s;<br>
=C2=A0&gt;&gt; size_t len;<br>
=C2=A0&gt;&gt; context_struct_t *a =3D &amp;((policydb_t<br>
=C2=A0&gt;&gt; *)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[0];<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt; int rc =3D context_to_string(pol.handle, (policydb_t *)pol.d=
b, a, &amp;s,<br>
&amp;len);<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt; printf(&quot;rc: %d\n&quot;, rc);<br>
=C2=A0&gt;&gt; printf(&quot;con: %s\n&quot;, s);<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt; prints:<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 rc: 0<br>
=C2=A0&gt;&gt;=C2=A0 =C2=A0 con: u:object_r:null_device:s0<br>
=C2=A0&gt;&gt;<br>
=C2=A0&gt;&gt; However, I am after the initial sid for file, which this isn=
&#39;t<br>
it... is<br>
=C2=A0&gt;&gt; it in the ocontexts array under a different index?<br>
=C2=A0&gt;<br>
=C2=A0&gt;<br>
=C2=A0&gt; ocontext[OCON_ISID] points to the head of a linked list of initi=
al<br>
SIDs, with the values in -&gt;sid[0] and the context structures in<br>
-&gt;context[0].=C2=A0 Richard&#39;s sample program showed you how to walk =
it and<br>
print out all the entries.=C2=A0 The symbolic names themselves aren&#39;t i=
n the<br>
policydb, as he noted; you can grab it from the kernel source<br>
(linux/security/selinux/include/initial_sid_to_string.h) or from the<br>
refpolicy (run make in refpolicy/policy/flask and grab<br>
kernel/initial_sid_to_string.h).<br>
<br>
I was hoping there was something I was missing between what you were<br>
posting and Richards sample. Looks like it&#39;s all by ordinal, so<br>
(conjecturing here) initial sid ordering must match the kernel header<br>
ordering as far as I can tell, is that right?<br>
<br>
Something must remap it in the kernel from initial sid to class.<br>
<br>
I was hoping there would be a clean way to grab this from the policy for<br=
>
use in fs_config tools under build, but just hard coding the default<br>
context string seems to be the best approach.<br>
</blockquote>
<br>
I don&#39;t know what you are doing, but the initial SID context is not wha=
t<br>
you want for fs_config.=C2=A0 You want the result of selabel_lookup(), just=
<br>
as is done by system/extras/ext4_utils to label files in the generated<br>
images.<br>
</blockquote>
<br></div></div>
Oh, I see - you are trying to replace the hardcoded &quot;u:object_r:unlabe=
led:s0&quot; fallback in fs_config.c when selabel_lookup() fails.=C2=A0 Wor=
thy goal, but I don&#39;t think trying to use an initial SID context is the=
 right approach.=C2=A0 I guess the question is whether selabel_lookup() fai=
lure ought to just be a hard error for fs_config; if the file does not matc=
h any expression in file_contexts, then that reflects a gap in the file_con=
texts configuration that should be filled.=C2=A0 We don&#39;t actually want=
 any files with the unlabeled context; the rules for unlabeled in the polic=
y are just for upgrading from pre-SELinux devices with unlabeled /data.<br>=
</blockquote><div><br></div><div>Yeah I was trying to understand why its no=
t a hard failure. I was thinking at boot the fc would relabel it, but it wo=
uld be the same fc as packaged in the ota afaik.=C2=A0 I think the easiest =
would be just ask nick what his intentions were here and what corner case h=
e was trying to cover. I haven&#39;t been able to get it to take that path =
in fs_config.c</div><div><br></div><div>I noticed this when doing this work=
:=C2=A0<a href=3D"https://android-review.googlesource.com/#/q/topic:fs-conf=
ig">https://android-review.googlesource.com/#/q/topic:fs-config</a></div></=
div><div><br></div>-- <br><div class=3D"gmail_signature">Respectfully,<br><=
br>William C Roberts<br><br></div>
</div></div>

--001a1140cd0493c69d052d9f95af--
