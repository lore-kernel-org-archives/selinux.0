MIME-Version: 1.0
In-Reply-To: <5604018A.5030805@quarksecurity.com>
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov> <5603F39A.6060607@tycho.nsa.gov>
 <5604018A.5030805@quarksecurity.com>
Date: Tue, 29 Sep 2015 11:15:35 -0700
Message-ID: <CAFftDdrfvJVhCifZ4tpoBd89v-RSDF2v9gYm3RwbBNFZHzqFcQ@mail.gmail.com>
Subject: Re: Find attributes for a type with sepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=14dae9cc97eedd455d0520e6cc16
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--14dae9cc97eedd455d0520e6cc16
Content-Type: text/plain; charset=UTF-8

Out of curiosity, whats the purpose of the types field in the struct
type_datum? This seems to never have anything in it.

Also, conditional.h has a field called bool, this would seem to conflict
with stdbool.h, whats the consensus on renaming this to boolean perhaps?


On Thu, Sep 24, 2015 at 6:58 AM, Joshua Brindle <brindle@quarksecurity.com>
wrote:

> Stephen Smalley wrote:
>
>> On 09/24/2015 08:43 AM, James Carter wrote:
>>
>>> On 09/23/2015 06:39 PM, Roberts, William C wrote:
>>>
>>>> How would one find all the attributes of a type with libsepol, can
>>>> someone point me to any relevant structures or functions?
>>>>
>>>> The policydb_t structure has type_attr_map field which maps types to an
>>> ebitmap of attributes.
>>>
>>
>> It also has the reverse map (attr_type_map) if you want that.
>>
>> In Android, external/sepolicy/tools/sepolicy-analyze has examples of
>> using both maps.
>>
>>
> seinfo also knows how to do it, if you need more examples:
>
> $ seinfo -x -tuntrusted_app sepolicy
>    untrusted_app
>       bluetoothdomain
>       netdomain
>       appdomain
>       domain
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

--14dae9cc97eedd455d0520e6cc16
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Out of curiosity, whats the purpose of the types field in =
the struct type_datum? This seems to never have anything in it.<div><div><b=
r></div><div>Also, conditional.h has a field called bool, this would seem t=
o conflict with stdbool.h, whats the consensus on renaming this to boolean =
perhaps?</div><div><br></div></div></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Thu, Sep 24, 2015 at 6:58 AM, Joshua Brindle <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:brindle@quarksecurity.com" target=3D"_=
blank">brindle@quarksecurity.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 09/24/2015 08:43 AM, James Carter wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 09/23/2015 06:39 PM, Roberts, William C wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
How would one find all the attributes of a type with libsepol, can<br>
someone point me to any relevant structures or functions?<br>
<br>
</blockquote>
The policydb_t structure has type_attr_map field which maps types to an<br>
ebitmap of attributes.<br>
</blockquote>
<br>
It also has the reverse map (attr_type_map) if you want that.<br>
<br>
In Android, external/sepolicy/tools/sepolicy-analyze has examples of<br>
using both maps.<br>
<br>
</blockquote>
<br></span>
seinfo also knows how to do it, if you need more examples:<br>
<br>
$ seinfo -x -tuntrusted_app sepolicy<br>
=C2=A0 =C2=A0untrusted_app<br>
=C2=A0 =C2=A0 =C2=A0 bluetoothdomain<br>
=C2=A0 =C2=A0 =C2=A0 netdomain<br>
=C2=A0 =C2=A0 =C2=A0 appdomain<br>
=C2=A0 =C2=A0 =C2=A0 domain<div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><b=
r></div>
</div>

--14dae9cc97eedd455d0520e6cc16--
