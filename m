Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F91tNr022043
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 05:01:55 -0400
Received: by mail-qt0-f169.google.com with SMTP id 52so18684189qtq.3
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 02:01:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGFJcwyXyAYm7Ebqrvdv6LVDmC_urNUaryCowvE13ZgEDxnWOA@mail.gmail.com>
References: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
 <d3269864-4abf-0f63-957c-dc0ee8f2e742@ieee.org>
 <CAGFJcwyXyAYm7Ebqrvdv6LVDmC_urNUaryCowvE13ZgEDxnWOA@mail.gmail.com>
From: Miroslav Vadkerti <mvadkert@redhat.com>
Date: Mon, 15 Aug 2016 11:00:50 +0200
Message-ID: <CAGFJcwzuADV9ZkU3eXc91TRbe5sQegxSMZ7=-u51sk43_OcdVg@mail.gmail.com>
Subject: Re: [PATCH] semanage: swap tcp and udp protocol numbers
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c08f13e70601f053a187a5f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c08f13e70601f053a187a5f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2016 at 9:37 AM, Miroslav Vadkerti <mvadkert@redhat.com>
wrote:

> On Sun, Aug 14, 2016 at 10:23 PM, Chris PeBenito <pebenito@ieee.org>
> wrote:
>
>> On 08/10/16 04:39, Miroslav Vadkerti wrote:
>>
>>> The tcp/udp protocol numbers were accidentaly swapped in
>>> the original patch 'semanage: add auditing of changes in records'.
>>>
>>> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
>>> ---
>>>  policycoreutils/semanage/seobject.py | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/policycoreutils/semanage/seobject.py
>>> b/policycoreutils/semanage/seobject.py
>>> index 317b421..786ed0e 100644
>>> --- a/policycoreutils/semanage/seobject.py
>>> +++ b/policycoreutils/semanage/seobject.py
>>> @@ -88,8 +88,8 @@ file_type_str_to_option =3D {"all files": "a",
>>>                             "symbolic link": "l",
>>>                             "named pipe": "p"}
>>>
>>> -proto_to_audit =3D {"tcp": 17,
>>> -                  "udp": 6,
>>> +proto_to_audit =3D {"tcp": 6,
>>> +                  "udp": 17,
>>>                    "ipv4": 4,
>>>                    "ipv6": 41}
>>>
>>
>> I realize this has already been merged, but why not use existing
>> constants such as socket.IPPROTO_TCP and socket.AF_INET rather than hard
>> coding the protocol numbers?
>
>
> =E2=80=8BYes, ot we could directly use socket.getprotobyname(protocolname=
)
> instead of the dictionary. I will supply a patch today, thanks!=E2=80=8B
>

=E2=80=8BThe patch using socket.getprotobyname(protocolname) has been submm=
ited,
but it is based on top of this patch, so if possible please this one also
so there is no conflict.

Thanks!
/M



>
>
>
>>
>>
>> --
>> Chris PeBenito
>>
>
>
>
> --
> Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
> IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
> Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
> Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR
>
>


--=20
Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR

--94eb2c08f13e70601f053a187a5f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default">On Mon, Aug 15, 2016 at 9:37 =
AM, Miroslav Vadkerti <span dir=3D"ltr">&lt;<a href=3D"mailto:mvadkert@redh=
at.com" target=3D"_blank">mvadkert@redhat.com</a>&gt;</span> wrote:<br></di=
v><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><span><div class=3D"gmail=
_default">On Sun, Aug 14, 2016 at 10:23 PM, Chris PeBenito <span dir=3D"ltr=
">&lt;<a href=3D"mailto:pebenito@ieee.org" target=3D"_blank">pebenito@ieee.=
org</a>&gt;</span> wrote:<br></div></span><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote"><span><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><span>On 08/10/16 04:39, Miroslav Vadkerti wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
The tcp/udp protocol numbers were accidentaly swapped in<br>
the original patch &#39;semanage: add auditing of changes in records&#39;.<=
br>
<br>
Signed-off-by: Miroslav Vadkerti &lt;<a href=3D"mailto:mvadkert@redhat.com"=
 target=3D"_blank">mvadkert@redhat.com</a>&gt;<br>
---<br>
=C2=A0policycoreutils/semanage/seob<wbr>ject.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/policycoreutils/semanage/seo<wbr>bject.py b/policycoreutils/se=
manage/seo<wbr>bject.py<br>
index 317b421..786ed0e 100644<br>
--- a/policycoreutils/semanage/seo<wbr>bject.py<br>
+++ b/policycoreutils/semanage/seo<wbr>bject.py<br>
@@ -88,8 +88,8 @@ file_type_str_to_option =3D {&quot;all files&quot;: &quot=
;a&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;symbolic link&quot;: &quot;l&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;named pipe&quot;: &quot;p&quot;}<br>
<br>
-proto_to_audit =3D {&quot;tcp&quot;: 17,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;udp&q=
uot;: 6,<br>
+proto_to_audit =3D {&quot;tcp&quot;: 6,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;udp&q=
uot;: 17,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
ipv4&quot;: 4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
ipv6&quot;: 41}<br>
</blockquote>
<br></span>
I realize this has already been merged, but why not use existing constants =
such as socket.IPPROTO_TCP and socket.AF_INET rather than hard coding the p=
rotocol numbers?</blockquote><div><br></div></span><div><div class=3D"gmail=
_default" style=3D"font-family:monospace,monospace">=E2=80=8BYes, ot we cou=
ld directly use=C2=A0<font face=3D"monospace, monospace">socket.getprotobyn=
ame(prot<wbr>ocolname) instead of the dictionary. I will supply a patch tod=
ay, thanks!</font>=E2=80=8B</div></div></div></div></div></blockquote><div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-family:monospace,=
monospace">=E2=80=8BThe patch using socket.getprotobyname(protocolname) has=
 been submmited, but it is based on top of this patch, so if possible pleas=
e this one also so there is no conflict.</div></div><div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace"><br></div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace">Thanks!</div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace">/M</d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><span><font color=3D"#888888"><br><span><font color=3D"#888888">
<br>
-- <br>
Chris PeBenito<br>
</font></span></font></span></blockquote></div><span><font color=3D"#888888=
"><br><br clear=3D"all"><div><br></div>-- <br><div data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><di=
v><font face=3D"monospace, monospace" size=3D"2">Miroslav Vadkerti :: Senio=
r QE / RHCSS :: BaseOS QE Security</font></div><div><font face=3D"monospace=
, monospace" size=3D"2">IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881=
087<br></font></div><div><font face=3D"monospace, monospace" size=3D"2">Des=
k Phone <a href=3D"tel:%2B420%20532%20294%20129" value=3D"+420532294129" ta=
rget=3D"_blank">+420 532 294 129</a> :: Mobile <a href=3D"tel:%2B420%20773%=
20944%20252" value=3D"+420773944252" target=3D"_blank">+420 773 944 252</a>=
<br></font></div><div><font face=3D"monospace, monospace" size=3D"2">Red Ha=
t Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR</font><br></div><div>=
<br></div></div></div></div></div></div></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div data-sm=
artmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><di=
v dir=3D"ltr"><div><font face=3D"monospace, monospace" size=3D"2">Miroslav =
Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security</font></div><div><font =
face=3D"monospace, monospace" size=3D"2">IRC mvadkert #qe #urt #brno #rpmdi=
ff :: GPG 0x25881087<br></font></div><div><font face=3D"monospace, monospac=
e" size=3D"2">Desk Phone <a href=3D"tel:%2B420%20532%20294%20129" value=3D"=
+420532294129" target=3D"_blank">+420 532 294 129</a> :: Mobile <a href=3D"=
tel:%2B420%20773%20944%20252" value=3D"+420773944252" target=3D"_blank">+42=
0 773 944 252</a><br></font></div><div><font face=3D"monospace, monospace" =
size=3D"2">Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR</fon=
t><br></div><div><br></div></div></div></div></div></div></div>
</div></div>

--94eb2c08f13e70601f053a187a5f--
