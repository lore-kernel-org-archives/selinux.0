MIME-Version: 1.0
References: <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
 <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
 <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
 <CAFPpqQE1x7oS0R21Fm_tU=1XHRy46FEz=ii-QHS9YDE=KAE7Sg@mail.gmail.com>
 <5a423dc6-6667-772a-4715-64fd23fb8378@tycho.nsa.gov>
 <20180912143644.GA10229@julius.enp8s0.d30>
 <CAFPpqQEdXiduYNoRvS-LuF+TmwEow7Y+5te1dRxjjfCybSXQjQ@mail.gmail.com>
In-Reply-To: <CAFPpqQEdXiduYNoRvS-LuF+TmwEow7Y+5te1dRxjjfCybSXQjQ@mail.gmail.com>
From: Ted Toth <txtoth@gmail.com>
Date: Fri, 14 Sep 2018 16:18:29 -0500
Message-ID: <CAFPpqQGymYh-dNn1XMzFVDHNu-0-MbLo7=8rk+DMuLHEKh963Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000001b3e590575db5e5b"
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000001b3e590575db5e5b
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 12, 2018 at 9:57 AM Ted Toth <txtoth@gmail.com> wrote:

>
>
> On Wed, Sep 12, 2018 at 9:36 AM Dominick Grift <dac.override@gmail.com>
> wrote:
>
>> On Wed, Sep 12, 2018 at 09:57:20AM -0400, Stephen Smalley wrote:
>> > On 09/12/2018 09:26 AM, Ted Toth wrote:
>> > >
>> > >
>> > > On Wed, Sep 12, 2018 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov
>> > > <mailto:sds@tycho.nsa.gov>> wrote:
>> > >
>> > >     On 09/11/2018 04:59 PM, Ted Toth wrote:
>> > >      > That's awesome and now it's got me thinking about other
>> > >      > classes/permissions that we could implement. Can cil macros
>> can be
>> > >      > referenced in .te/.if files?
>> > >
>> > >     Not sure I understand your question.  You can't directly embed cil
>> > >     statements in .te/.if files.  However, if you define a
>> class/permission
>> > >     in a .cil module, you can certainly specify a require on it and
>> use it
>> > >     from a conventional .te/.if module, ala:
>> > >     $ cat > usemcstrans.te <<EOF
>> > >     policy_module(usemcstrans, 1.0)
>> > >
>> > >     require {
>> > >              class mcstrans { color_use };
>> > >              attribute domain;
>> > >     }
>> > >
>> > >     allow domain self:mcstrans color_use;
>> > >     EOF
>> > >
>> > >     $ make -f /usr/share/selinux/devel/Makefile usemcstrans.pp
>> > >     $ sudo semodule -i usemcstrans.pp
>> > >
>> > >
>> > > If the cil contained:
>> > >
>> > > (macro use_color (type caller) (allow caller self mcstrans
>> (color_use)))
>> > >
>> > > then in x.te can I use the macro:
>> > >
>> > > type x_t;
>> > > use_color(x_t)
>> >
>> > Sorry, no.  The macros used in .te/.if files are just m4 definitions
>> handled
>> > at the preprocessing stage, not a feature of the module language.  The
>> CIL
>> > macros are directly supported by the CIL compiler, but they won't be
>> visible
>> > to the module compiler.  Also, you are missing several parentheses above
>> > (I'm not fond of the lisp-like syntax myself).  In a CIL module, I
>> think the
>> > correct syntax would be:
>> >
>> > (macro use_color ((type caller)) (allow caller self (mcstrans
>> (color_use))))
>> >
>> > (call use_color(x_t))
>> >
>> > Or you could define a m4 macro in an .if file and use that in a .te
>> file.
>> > Or both.
>> >
>>
>> Ideally you would have all of your policy written in CIL or in a
>> high-level language that was designed to leverage CIL.
>>
>
> Unfortunately I/we don't live in an ideal world :( but thanks for the
> pointers.
>
>
>>
>> My DSSP2 policy is a CIL-only policy. In there I also leverage unordered
>> classes, Meaning that for example if you remove or disable the mcstrans
>> module then you automatically also remove or disable  the access vectors
>> that mcstrans manages.
>>
>> minimal:
>>
>> https://github.com/DefenSec/dssp2-minimal
>>
>> standard (my personal policy based on top of minimal):
>>
>> https://github.com/DefenSec/dssp2-standard/commits/master
>>
>> DSSP2 does not support enforcement of confidentiality though
>>
>> > _______________________________________________
>> > Selinux mailing list
>> > Selinux@tycho.nsa.gov
>> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>> --
>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>> Dominick Grift
>>
>
I added a security class and permission using the following cil:
(block mcstrans
    (typeattributeset cil_gen_require  setrans_t)
    (typeattributeset cil_gen_require user_t)
    (class level_color (pick_using_dominance))
    (classorder (unordered level_color))

    (mlsconstrain (level_color (pick_using_dominance)) (dom h1 h2))

    (allow setrans_t self (level_color (pick_using_dominance))))

and this works for the mcscolor code I changed to use it. However I wrote
some python code to test the class/permission (using
security_compute_av_raw) and ran it before adding an allow rule for the
python code type and no avc was generated as I'd expected. Is there
anything different about adding a security class this way that would affect
avc generation?

--0000000000001b3e590575db5e5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Wed, Sep 12, 2018 at 9:57 AM Ted Toth &lt;<a href=3D"mailto:t=
xtoth@gmail.com">txtoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><br><div class=3D"gma=
il_quote"><div dir=3D"ltr">On Wed, Sep 12, 2018 at 9:36 AM Dominick Grift &=
lt;<a href=3D"mailto:dac.override@gmail.com" target=3D"_blank">dac.override=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, Sep 12, 2018 at 09:57:20AM -0400, Stephen Smalley wrote:=
<br>
&gt; On 09/12/2018 09:26 AM, Ted Toth wrote:<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; On Wed, Sep 12, 2018 at 8:04 AM Stephen Smalley &lt;<a href=3D"ma=
ilto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank"=
>sds@tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0On 09/11/2018 04:59 PM, Ted Toth wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; That&#39;s awesome and now it&#39;s got =
me thinking about other<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; classes/permissions that we could implem=
ent. Can cil macros can be<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt; referenced in .te/.if files?<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Not sure I understand your question.=C2=A0 You=
 can&#39;t directly embed cil<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0statements in .te/.if files.=C2=A0 However, if=
 you define a class/permission<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0in a .cil module, you can certainly specify a =
require on it and use it<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0from a conventional .te/.if module, ala:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0$ cat &gt; usemcstrans.te &lt;&lt;EOF<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0policy_module(usemcstrans, 1.0)<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0require {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 class mcstrans { =
color_use };<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 attribute domain;=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0allow domain self:mcstrans color_use;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0EOF<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0$ make -f /usr/share/selinux/devel/Makefile us=
emcstrans.pp<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0$ sudo semodule -i usemcstrans.pp<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; If the cil contained:<br>
&gt; &gt; <br>
&gt; &gt; (macro use_color (type caller) (allow caller self mcstrans (color=
_use)))<br>
&gt; &gt; <br>
&gt; &gt; then in x.te can I use the macro:<br>
&gt; &gt; <br>
&gt; &gt; type x_t;<br>
&gt; &gt; use_color(x_t)<br>
&gt; <br>
&gt; Sorry, no.=C2=A0 The macros used in .te/.if files are just m4 definiti=
ons handled<br>
&gt; at the preprocessing stage, not a feature of the module language.=C2=
=A0 The CIL<br>
&gt; macros are directly supported by the CIL compiler, but they won&#39;t =
be visible<br>
&gt; to the module compiler.=C2=A0 Also, you are missing several parenthese=
s above<br>
&gt; (I&#39;m not fond of the lisp-like syntax myself).=C2=A0 In a CIL modu=
le, I think the<br>
&gt; correct syntax would be:<br>
&gt; <br>
&gt; (macro use_color ((type caller)) (allow caller self (mcstrans (color_u=
se))))<br>
&gt; <br>
&gt; (call use_color(x_t))<br>
&gt; <br>
&gt; Or you could define a m4 macro in an .if file and use that in a .te fi=
le.<br>
&gt; Or both.<br>
&gt; <br>
<br>
Ideally you would have all of your policy written in CIL or in a high-level=
 language that was designed to leverage CIL.<br></blockquote><div><br></div=
><div>Unfortunately I/we don&#39;t live in an ideal world :( but thanks for=
 the pointers.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
My DSSP2 policy is a CIL-only policy. In there I also leverage unordered cl=
asses, Meaning that for example if you remove or disable the mcstrans modul=
e then you automatically also remove or disable=C2=A0 the access vectors th=
at mcstrans manages.<br>
<br>
minimal:<br>
<br>
<a href=3D"https://github.com/DefenSec/dssp2-minimal" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/DefenSec/dssp2-minimal</a><br>
<br>
standard (my personal policy based on top of minimal):<br>
<br>
<a href=3D"https://github.com/DefenSec/dssp2-standard/commits/master" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/DefenSec/dssp2-standar=
d/commits/master</a><br>
<br>
DSSP2 does not support enforcement of confidentiality though<br>
<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tyc=
ho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tych=
o.nsa.gov</a>.<br>
<br>
-- <br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br></blockquote></div></div></blockquote><div><br></div><div=
>I added a security class and permission using the following cil:</div><div=
>(block mcstrans</div><div>=C2=A0 =C2=A0 (typeattributeset cil_gen_require=
=C2=A0 setrans_t)</div><div>=C2=A0 =C2=A0 (typeattributeset cil_gen_require=
 user_t)</div><div>=C2=A0 =C2=A0 (class level_color (pick_using_dominance))=
</div><div>=C2=A0 =C2=A0 (classorder (unordered level_color))</div><div><br=
></div><div>=C2=A0 =C2=A0 (mlsconstrain (level_color (pick_using_dominance)=
) (dom h1 h2))</div><div><br></div><div>=C2=A0 =C2=A0 (allow setrans_t self=
 (level_color (pick_using_dominance))))</div><div><br></div><div>and this w=
orks for the mcscolor code I changed to use it. However I wrote some python=
 code to test the class/permission (using security_compute_av_raw) and ran =
it before adding an allow rule for the python code type and no avc was gene=
rated as I&#39;d expected. Is there anything different about adding a secur=
ity class this way that would affect avc generation?</div></div></div></div=
>

--0000000000001b3e590575db5e5b--
