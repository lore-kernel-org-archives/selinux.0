MIME-Version: 1.0
In-Reply-To: <5626450D.5090309@tycho.nsa.gov>
References: <562531F6.8010609@tycho.nsa.gov>
 <44617616.392600.1445344058683.JavaMail.yahoo@mail.yahoo.com>
 <5626450D.5090309@tycho.nsa.gov>
Date: Tue, 20 Oct 2015 07:00:30 -0700
Message-ID: <CAFftDdratpqGkyLp0m48YWo1iOw58sECd+NhQe1o4TqZQOSwcw@mail.gmail.com>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b41409847f298052289af84
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b41409847f298052289af84
Content-Type: text/plain; charset=UTF-8

On Oct 20, 2015 7:46 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 10/20/2015 08:27 AM, Richard Haines wrote:
>>
>>
>>
>>
>>
>>> On Monday, 19 October 2015, 19:10, Stephen Smalley <sds@tycho.nsa.gov>
wrote:
>>>>
>>>> On 10/18/2015 11:00 AM, Richard Haines wrote:
>>>>
>>>>
>>>>>   On Sunday, 18 October 2015, 15:07, Dominick Grift
>>>
>>> <dac.override@gmail.com> wrote:
>>>>
>>>>
>>>>>>   -----BEGIN PGP SIGNED MESSAGE-----
>>>>>
>>>>>   Hash: SHA512
>>>>>
>>>>>   On Sun, Oct 18, 2015 at 12:48:12PM +0000, Richard Haines wrote:
>>>>>>
>>>>>>     I added openssl to libselinux to support the new
>>>
>>> selabel_digest(3)
>>>>>>
>>>>>>     function.
>>>>>>
>>>>>>     I'm not aware of any issues between openssl and gnutls,
>>>
>>> however as
>>>>>>
>>>>>>
>>>>>>     selabel_digest was only added last week I guess not much testing.
>>>>>>     Well apart from myself as I'm currently adding the
>>>
>>> selinux_restorecon
>>>>>>
>>>>>>     feature that makes use of it.
>>>>>>
>>>>>
>>>>>   Thanks for clarifying, I am not hitting any issues with it just
>>>>>   wondering if instead of openssl, gnutls could be used for this and
if
>>>>
>>>>
>>>>>   so, if this should be somehow supported or not.
>>>>
>>>>
>>>>   I tried using gnutls after I read your initial email, however I
>>>>   could not find a way to generate the same digest as openssl
>>>>   (I changed the SHA1 function to gnutls_hmac_fast(3) with various
>>>>   algorithms and used the selabel_digest util to compare digests).
>>>>   It could be that I should use some other function but I could
>>>>
>>>>   not find any useful info on this (including web searches).
>>>>   If anyone knows how to resolve this please let me know.
>>>>
>>>>   I guess what is supported (openssl or gnutls) would be down to
>>>>   the maintainers.
>>>
>>>
>>> Wondering if dependency on openssl might be a license issue for Debian
>>> or others.  Apparently openssl license is considered GPL-incompatible
>>> [1] [2], and obviously libselinux is linked by a variety of GPL-licensed
>>> programs.  Fedora seems to view this as falling under the system library
>>> exception [3] but not clear that other distributions would view it that
>>> way.  On the other hand, using gnutls would be subject to the reverse
>>> problem; it would make libselinux depend on a LGPL library, and that
>>> could create issues for non-GPL programs that statically link
>>> libselinux.  We might need to revert this change and revisit how to
>>
>>
>>> solve this in a manner that avoids such issues.
>>
>>
>>
>> Would building with the Android mincrypt SHA functions help regarding the
>> licensing issues ??? I've attached a quick patch that seems to work okay
>> using Android system/core/libmincrypt/sha.c
>
>
> That looks BSD-licensed and thus broadly compatible.  We would need to
amend libselinux/LICENSE to add that license information and we would need
to hide those functions from being exposed outside of the library.  Other
alternative would be to look for a public domain SHA implementation and use
that.
>
>

Will CryptLib work:
http://unlicense.org/

>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--047d7b41409847f298052289af84
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Oct 20, 2015 7:46 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto:=
sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/20/2015 08:27 AM, Richard Haines wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; On Monday, 19 October 2015, 19:10, Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 10/18/2015 11:00 AM, Richard Haines wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 On Sunday, 18 October 2015, 15:07, Dominick Gri=
ft<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:dac.override@gmail.com">dac.override@gma=
il.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 Hash: SHA512<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 On Sun, Oct 18, 2015 at 12:48:12PM +0000, Richa=
rd Haines wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 I added openssl to libselinux to sup=
port the new<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; selabel_digest(3)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 function.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 I&#39;m not aware of any issues betw=
een openssl and gnutls,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; however as<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 selabel_digest was only added last w=
eek I guess not much testing.<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 Well apart from myself as I&#39;m cu=
rrently adding the<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; selinux_restorecon<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 feature that makes use of it.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 Thanks for clarifying, I am not hitting any iss=
ues with it just<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 wondering if instead of openssl, gnutls could b=
e used for this and if<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 so, if this should be somehow supported or not.=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 I tried using gnutls after I read your initial emai=
l, however I<br>
&gt;&gt;&gt;&gt; =C2=A0 could not find a way to generate the same digest as=
 openssl<br>
&gt;&gt;&gt;&gt; =C2=A0 (I changed the SHA1 function to gnutls_hmac_fast(3)=
 with various<br>
&gt;&gt;&gt;&gt; =C2=A0 algorithms and used the selabel_digest util to comp=
are digests).<br>
&gt;&gt;&gt;&gt; =C2=A0 It could be that I should use some other function b=
ut I could<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 not find any useful info on this (including web sea=
rches).<br>
&gt;&gt;&gt;&gt; =C2=A0 If anyone knows how to resolve this please let me k=
now.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 I guess what is supported (openssl or gnutls) would=
 be down to<br>
&gt;&gt;&gt;&gt; =C2=A0 the maintainers.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Wondering if dependency on openssl might be a license issue fo=
r Debian<br>
&gt;&gt;&gt; or others.=C2=A0 Apparently openssl license is considered GPL-=
incompatible<br>
&gt;&gt;&gt; [1] [2], and obviously libselinux is linked by a variety of GP=
L-licensed<br>
&gt;&gt;&gt; programs.=C2=A0 Fedora seems to view this as falling under the=
 system library<br>
&gt;&gt;&gt; exception [3] but not clear that other distributions would vie=
w it that<br>
&gt;&gt;&gt; way.=C2=A0 On the other hand, using gnutls would be subject to=
 the reverse<br>
&gt;&gt;&gt; problem; it would make libselinux depend on a LGPL library, an=
d that<br>
&gt;&gt;&gt; could create issues for non-GPL programs that statically link<=
br>
&gt;&gt;&gt; libselinux.=C2=A0 We might need to revert this change and revi=
sit how to<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; solve this in a manner that avoids such issues.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Would building with the Android mincrypt SHA functions help regard=
ing the<br>
&gt;&gt; licensing issues ??? I&#39;ve attached a quick patch that seems to=
 work okay<br>
&gt;&gt; using Android system/core/libmincrypt/sha.c<br>
&gt;<br>
&gt;<br>
&gt; That looks BSD-licensed and thus broadly compatible.=C2=A0 We would ne=
ed to amend libselinux/LICENSE to add that license information and we would=
 need to hide those functions from being exposed outside of the library.=C2=
=A0 Other alternative would be to look for a public domain SHA implementati=
on and use that.<br>
&gt;<br>
&gt;</p>
<p dir=3D"ltr">Will CryptLib work:<br>
<a href=3D"http://unlicense.org/">http://unlicense.org/</a><br><br></p>
<p dir=3D"ltr">&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</p>

--047d7b41409847f298052289af84--
