MIME-Version: 1.0
In-Reply-To: <56DDE54F.4050208@tycho.nsa.gov>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov> <56DDE54F.4050208@tycho.nsa.gov>
Date: Mon, 7 Mar 2016 17:32:56 -0800
Message-ID: <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
Subject: Re: initial_sid context via libsepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1133723691c455052d7f8f37
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1133723691c455052d7f8f37
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 03/07/2016 01:44 PM, Stephen Smalley wrote:
>
>> On 03/07/2016 10:41 AM, Richard Haines wrote:
>>
>>>
>>>
>>>
>>>
>>>
>>> On Saturday, 5 March 2016, 14:48, Richard Haines
>>>> <richard_c_haines@btinternet.com> wrote:
>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> On Friday, 4 March 2016, 21:18, "Roberts, William C"
>>>> <william.c.roberts@intel.com> wrote:
>>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>> How can one obtain the same value as
>>>>> /sys/fs/selinux/initial_contexts/file
>>>>>
>>>> via libsepol?
>>>>
>>>>>
>>>>> I=E2=80=99ve been digging around libsepol and its not quite clear to =
me.
>>>>>
>>>>> It looks as though the record is here:
>>>>>                  context_struct_t *a =3D &((policydb_t
>>>>>
>>>> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>>>
>>>>>                  context_struct_t *b =3D &((policydb_t
>>>>>
>>>> *)pol.db)->ocontexts[OCON_ISID]->context[1];
>>>>
>>>>>
>>>>>                  printf("%u\n", a->type);
>>>>>                  printf("%u\n",b->type);
>>>>>
>>>>> Prints:
>>>>> 185
>>>>> 0
>>>>>
>>>>> Not sure if this is right, and how to format the context struct to a
>>>>> string.
>>>>>
>>>> I didn=E2=80=99t see any helpers.
>>>>
>>>>>
>>>>>
>>>>
>>>>>
>>> I've attached an example, hope it's useful
>>>>
>>>
>>> I've updated the example with more detail and display SID name using
>>> SID value not counter.
>>>
>>>
>> Any particular reason you didn't use sepol_sid_to_context()?
>>
>
> I guess context_to_string() on the context structure would work better fo=
r
> your purposes.   sepol_sid_to_context() would require loading the sidtab
> via policydb_load_isids() and setting the internal policydb to the one yo=
u
> loaded via sepol_set_policydb().



Seems as though its not exported api, but it does indeed print something:

code:
char *s;
size_t len;
context_struct_t *a =3D &((policydb_t
*)pol.db)->ocontexts[OCON_ISID]->context[0];

int rc =3D context_to_string(pol.handle, (policydb_t *)pol.db, a, &s, &len)=
;

printf("rc: %d\n", rc);
printf("con: %s\n", s);

prints:
  rc: 0
  con: u:object_r:null_device:s0

However, I am after the initial sid for file, which this isn't it... is it
in the ocontexts array under a different index?

Bill


>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



--=20
Respectfully,

William C Roberts

--001a1133723691c455052d7f8f37
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">O=
n 03/07/2016 01:44 PM, Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On 03/07/2016 10:41 AM, Richard Haines wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
<br>
<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On Saturday, 5 March 2016, 14:48, Richard Haines<br>
&lt;<a href=3D"mailto:richard_c_haines@btinternet.com" target=3D"_blank">ri=
chard_c_haines@btinternet.com</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
</blockquote>
<br>
<br>
<br>
On Friday, 4 March 2016, 21:18, &quot;Roberts, William C&quot;<br>
&lt;<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blank">willia=
m.c.roberts@intel.com</a>&gt; wrote:<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
<br>
<br>
<br>
How can one obtain the same value as<br>
/sys/fs/selinux/initial_contexts/file<br>
</blockquote>
via libsepol?<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
I=E2=80=99ve been digging around libsepol and its not quite clear to me.<br=
>
<br>
It looks as though the record is here:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context_struc=
t_t *a =3D &amp;((policydb_t<br>
</blockquote>
*)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[0];<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context_struc=
t_t *b =3D &amp;((policydb_t<br>
</blockquote>
*)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[1];<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;=
%u\n&quot;, a-&gt;type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;=
%u\n&quot;,b-&gt;type);<br>
<br>
Prints:<br>
185<br>
0<br>
<br>
Not sure if this is right, and how to format the context struct to a<br>
string.<br>
</blockquote>
I didn=E2=80=99t see any helpers.<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
I&#39;ve attached an example, hope it&#39;s useful<br>
</blockquote>
<br>
I&#39;ve updated the example with more detail and display SID name using<br=
>
SID value not counter.<br>
<br>
</blockquote>
<br>
Any particular reason you didn&#39;t use sepol_sid_to_context()?<br>
</blockquote>
<br></div></div>
I guess context_to_string() on the context structure would work better for =
your purposes.=C2=A0 =C2=A0sepol_sid_to_context() would require loading the=
 sidtab via policydb_load_isids() and setting the internal policydb to the =
one you loaded via sepol_set_policydb().</blockquote><div><br></div><div><b=
r></div><div>Seems as though its not exported api, but it does indeed print=
 something:</div><div>=C2=A0</div><div>code:</div><div><div><span class=3D"=
" style=3D"white-space:pre">	</span>char *s;</div><div><span class=3D"" sty=
le=3D"white-space:pre">	</span>size_t len;</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>context_struct_t *a =3D &amp;((policydb_t *)po=
l.db)-&gt;ocontexts[OCON_ISID]-&gt;context[0];</div><div><br></div><div><sp=
an class=3D"" style=3D"white-space:pre">	</span>int rc =3D context_to_strin=
g(pol.handle, (policydb_t *)pol.db, a, &amp;s, &amp;len);</div><div><br></d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>printf(&quot;rc:=
 %d\n&quot;, rc);</div><div><span class=3D"" style=3D"white-space:pre">	</s=
pan>printf(&quot;con: %s\n&quot;, s);</div></div><div><br></div><div>prints=
:</div><div><div>=C2=A0 rc: 0</div><div>=C2=A0 con: u:object_r:null_device:=
s0</div></div><div><br></div><div>However, I am after the initial sid for f=
ile, which this isn&#39;t it... is it in the ocontexts array under a differ=
ent index?</div><div><br></div><div>Bill</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><div class=3D""><div class=3D"h5"><br>
<br>
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
</div></div>

--001a1133723691c455052d7f8f37--
