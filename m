MIME-Version: 1.0
In-Reply-To: <CAFftDdomOar=2iq-Ur6yBSj-d7M2WwrRiFbU=VqEptAmFFkPvg@mail.gmail.com>
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov> <5603F39A.6060607@tycho.nsa.gov>
 <5604018A.5030805@quarksecurity.com>
 <CAFftDdrfvJVhCifZ4tpoBd89v-RSDF2v9gYm3RwbBNFZHzqFcQ@mail.gmail.com>
 <560AE27B.7070602@quarksecurity.com>
 <CAFftDdpyUtkUKeRg7d98vVeU3ZOWMq1RCr+5DHcyOur2xh_gYw@mail.gmail.com>
 <560AE7E4.4040401@quarksecurity.com>
 <CAFftDdomOar=2iq-Ur6yBSj-d7M2WwrRiFbU=VqEptAmFFkPvg@mail.gmail.com>
Date: Tue, 29 Sep 2015 13:19:12 -0700
Message-ID: <CAFftDdqt0JOCRDtW_KzVcbG_ZkX5mX3p6L5_HjE2E9Ciheu5Jg@mail.gmail.com>
Subject: Re: Find attributes for a type with sepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c3ae84f9872d0520e886ae
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c3ae84f9872d0520e886ae
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 29, 2015 at 12:36 PM, William Roberts <bill.c.roberts@gmail.com>
wrote:

>
> On Sep 29, 2015 12:35 PM, "Joshua Brindle" <brindle@quarksecurity.com>
> wrote:
> >
> > William Roberts wrote:
> >>
> >> On Sep 29, 2015 12:12 PM, "Joshua Brindle"<brindle@quarksecurity.com>
> >> wrote:
> >>>
> >>> William Roberts wrote:
> >>>>
> >>>> Out of curiosity, whats the purpose of the types field in the struct
> >>>> type_datum? This seems to never have anything in it.
> >>>>
> >>> type_datum is used for both types and attributes (as designated by the
> >>
> >> flavor field). In the attribute case the types field is the ebitmap of
> >> types have have this attribute.
> >>
> >> What about if its a type, is it an ebitmap of attrs?
> >
> >
> > No, but as Stephen said below there is a type_attr_map that contains
> that.
>
> OK that explains why its empty.
>
So is this information only available at compile time? I see that the types
field is
empty for both attributes and types. Perhaps my code is wrong to do this,
but
I can loop over the ebitmap entries from the attr_type and type_attr maps
just
fine.

>
> >> It is set in checkpolicy, look at
> policy_define.c:define_typeattribute().
> >>>
> >>>
> >>>
> >>>> Also, conditional.h has a field called bool, this would seem to
> conflict
> >>>> with stdbool.h, whats the consensus on renaming this to boolean
> perhaps?
> >>>>
> >>> probably...
> >>>
> >>>
> >>>> On Thu, Sep 24, 2015 at 6:58 AM, Joshua Brindle<
> brindle@quarksecurity.com
> >>>> wrote:
> >>>>
> >>>>> Stephen Smalley wrote:
> >>>>>
> >>>>>> On 09/24/2015 08:43 AM, James Carter wrote:
> >>>>>>
> >>>>>>> On 09/23/2015 06:39 PM, Roberts, William C wrote:
> >>>>>>>
> >>>>>>>> How would one find all the attributes of a type with libsepol, can
> >>>>>>>> someone point me to any relevant structures or functions?
> >>>>>>>>
> >>>>>>>> The policydb_t structure has type_attr_map field which maps types
> to
> >>
> >> an
> >>>>>>>
> >>>>>>> ebitmap of attributes.
> >>>>>>>
> >>>>>> It also has the reverse map (attr_type_map) if you want that.
> >>>>>>
> >>>>>> In Android, external/sepolicy/tools/sepolicy-analyze has examples of
> >>>>>> using both maps.
> >>>>>>
> >>>>>>
> >>>>> seinfo also knows how to do it, if you need more examples:
> >>>>>
> >>>>> $ seinfo -x -tuntrusted_app sepolicy
> >>>>>      untrusted_app
> >>>>>         bluetoothdomain
> >>>>>         netdomain
> >>>>>         appdomain
> >>>>>         domain
> >>>>>
> >>>>> _______________________________________________
> >>>>> Selinux mailing list
> >>>>> Selinux@tycho.nsa.gov
> >>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >>>>> To get help, send an email containing "help" to
> >>>>> Selinux-request@tycho.nsa.gov.
> >>>>>
> >>>>
> >>>>
> >>
> >
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--001a11c3ae84f9872d0520e886ae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Sep 29, 2015 at 12:36 PM, William Roberts <span dir=3D"ltr">&lt=
;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.rober=
ts@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex"><span class=3D""><p =
dir=3D"ltr"><br>
On Sep 29, 2015 12:35 PM, &quot;Joshua Brindle&quot; &lt;<a href=3D"mailto:=
brindle@quarksecurity.com" target=3D"_blank">brindle@quarksecurity.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; William Roberts wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Sep 29, 2015 12:12 PM, &quot;Joshua Brindle&quot;&lt;<a href=3D=
"mailto:brindle@quarksecurity.com" target=3D"_blank">brindle@quarksecurity.=
com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; William Roberts wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Out of curiosity, whats the purpose of the types field in =
the struct<br>
&gt;&gt;&gt;&gt; type_datum? This seems to never have anything in it.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; type_datum is used for both types and attributes (as designate=
d by the<br>
&gt;&gt;<br>
&gt;&gt; flavor field). In the attribute case the types field is the ebitma=
p of<br>
&gt;&gt; types have have this attribute.<br>
&gt;&gt;<br>
&gt;&gt; What about if its a type, is it an ebitmap of attrs?<br>
&gt;<br>
&gt;<br>
&gt; No, but as Stephen said below there is a type_attr_map that contains t=
hat.</p>
</span><p dir=3D"ltr">OK that explains why its empty.</p></blockquote><div>=
So is this information only available at compile time? I see that the types=
 field is</div><div>empty for both attributes and types. Perhaps my code is=
 wrong to do this, but</div><div>I can loop over the ebitmap entries from t=
he attr_type and type_attr maps just</div><div>fine.=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left=
:1ex"><div><div class=3D"h5"><br>
&gt;&gt; It is set in checkpolicy, look at policy_define.c:define_typeattri=
bute().<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Also, conditional.h has a field called bool, this would se=
em to conflict<br>
&gt;&gt;&gt;&gt; with stdbool.h, whats the consensus on renaming this to bo=
olean perhaps?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; probably...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, Sep 24, 2015 at 6:58 AM, Joshua Brindle&lt;<a href=
=3D"mailto:brindle@quarksecurity.com" target=3D"_blank">brindle@quarksecuri=
ty.com</a><br>
&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Stephen Smalley wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 09/24/2015 08:43 AM, James Carter wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 09/23/2015 06:39 PM, Roberts, William C wro=
te:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; How would one find all the attributes of a=
 type with libsepol, can<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; someone point me to any relevant structure=
s or functions?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The policydb_t structure has type_attr_map=
 field which maps types to<br>
&gt;&gt;<br>
&gt;&gt; an<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ebitmap of attributes.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; It also has the reverse map (attr_type_map) if you=
 want that.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; In Android, external/sepolicy/tools/sepolicy-analy=
ze has examples of<br>
&gt;&gt;&gt;&gt;&gt;&gt; using both maps.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; seinfo also knows how to do it, if you need more examp=
les:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; $ seinfo -x -tuntrusted_app sepolicy<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0untrusted_app<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 bluetoothdomain<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 netdomain<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 appdomain<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 domain<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt;&gt; Selinux mailing list<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_bl=
ank">Selinux@tycho.nsa.gov</a><br>
&gt;&gt;&gt;&gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinu=
x-leave@tycho.nsa.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<b=
r>
&gt;&gt;&gt;&gt;&gt; To get help, send an email containing &quot;help&quot;=
 to<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov" targe=
t=3D"_blank">Selinux-request@tycho.nsa.gov</a>.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</div></div><p></p>
<br>_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gma=
il_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--001a11c3ae84f9872d0520e886ae--
