Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F7cHUq013017
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 03:38:17 -0400
Received: by mail-qt0-f177.google.com with SMTP id w38so18197542qtb.0
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 00:38:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d3269864-4abf-0f63-957c-dc0ee8f2e742@ieee.org>
References: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
 <d3269864-4abf-0f63-957c-dc0ee8f2e742@ieee.org>
From: Miroslav Vadkerti <mvadkert@redhat.com>
Date: Mon, 15 Aug 2016 09:37:32 +0200
Message-ID: <CAGFJcwyXyAYm7Ebqrvdv6LVDmC_urNUaryCowvE13ZgEDxnWOA@mail.gmail.com>
Subject: Re: [PATCH] semanage: swap tcp and udp protocol numbers
To: Chris PeBenito <pebenito@ieee.org>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1141b32085f13d053a17505c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141b32085f13d053a17505c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 14, 2016 at 10:23 PM, Chris PeBenito <pebenito@ieee.org> wrote:

> On 08/10/16 04:39, Miroslav Vadkerti wrote:
>
>> The tcp/udp protocol numbers were accidentaly swapped in
>> the original patch 'semanage: add auditing of changes in records'.
>>
>> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
>> ---
>>  policycoreutils/semanage/seobject.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/policycoreutils/semanage/seobject.py
>> b/policycoreutils/semanage/seobject.py
>> index 317b421..786ed0e 100644
>> --- a/policycoreutils/semanage/seobject.py
>> +++ b/policycoreutils/semanage/seobject.py
>> @@ -88,8 +88,8 @@ file_type_str_to_option =3D {"all files": "a",
>>                             "symbolic link": "l",
>>                             "named pipe": "p"}
>>
>> -proto_to_audit =3D {"tcp": 17,
>> -                  "udp": 6,
>> +proto_to_audit =3D {"tcp": 6,
>> +                  "udp": 17,
>>                    "ipv4": 4,
>>                    "ipv6": 41}
>>
>
> I realize this has already been merged, but why not use existing constant=
s
> such as socket.IPPROTO_TCP and socket.AF_INET rather than hard coding the
> protocol numbers?


=E2=80=8BYes, ot we could directly use socket.getprotobyname(protocolname) =
instead
of the dictionary. I will supply a patch today, thanks!=E2=80=8B



>
>
> --
> Chris PeBenito
>



--=20
Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR

--001a1141b32085f13d053a17505c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default">On Sun, Aug 14, 2016 at 10:23=
 PM, Chris PeBenito <span dir=3D"ltr">&lt;<a href=3D"mailto:pebenito@ieee.o=
rg" target=3D"_blank">pebenito@ieee.org</a>&gt;</span> wrote:<br></div><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><span class=3D"">On 08/10/16 04:39, Miroslav Vadke=
rti wrote:<br>
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
rotocol numbers?</blockquote><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace">=E2=80=8BYes, ot we could dire=
ctly use=C2=A0<font face=3D"monospace, monospace">socket.getprotobyname(pro=
tocolname) instead of the dictionary. I will supply a patch today, thanks!<=
/font>=E2=80=8B</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><span class=3D""><font color=3D"#888888"><br>
<br>
-- <br>
Chris PeBenito<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><font face=3D"mo=
nospace, monospace" size=3D"2">Miroslav Vadkerti :: Senior QE / RHCSS :: Ba=
seOS QE Security</font></div><div><font face=3D"monospace, monospace" size=
=3D"2">IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087<br></font></d=
iv><div><font face=3D"monospace, monospace" size=3D"2">Desk Phone +420 532 =
294 129 :: Mobile +420 773 944 252<br></font></div><div><font face=3D"monos=
pace, monospace" size=3D"2">Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 =
00, Brno, CR</font><br></div><div><br></div></div></div></div></div></div><=
/div>
</div></div>

--001a1141b32085f13d053a17505c--
