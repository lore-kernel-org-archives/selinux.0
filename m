Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8GH5Kh012317
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 11:17:05 -0500
Received: by oige206 with SMTP id e206so11819826oig.2
 for <selinux@tycho.nsa.gov>; Tue, 08 Dec 2015 08:16:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5666F74C.3010302@tycho.nsa.gov>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <5666F74C.3010302@tycho.nsa.gov>
Date: Tue, 8 Dec 2015 17:16:40 +0100
Message-ID: <CAL8PO=0f+8YeuN6fMq-jUHSNS7vdbR-YCGVSKxzc43H9jvYt-Q@mail.gmail.com>
Subject: Re: Performance issues - huge amount of AVC misses
From: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a113d7c1282c2ac0526654c8e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113d7c1282c2ac0526654c8e
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 8, 2015 at 4:29 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 12/08/2015 05:25 AM, Michal Marciniszyn wrote:
>
>> Hello,
>>
>> we are heavy SELinux shop and we recently run into AVC related
>> performance issue. I was trying to find an answer on freenode IRC chat
>> but I was sent here by multiple guys. We're running on Scientific Linux
>> 6.6 (upgrade to 6.7 ongoing) and we see this on some of our nodes:
>>
>> # cat /selinux/avc/cache_stats
>> lookups hits misses allocations reclaims frees
>> 3976846641 3626568307 350278334 350303465 344833264 346344169
>> 3474274460 3092218096 382056364 382081270 381170512 382671551
>> 2037181411 1655679702 381501709 381527148 380680320 382162477
>> 1943162363 1651603455 291558908 291584892 288099840 289631602
>> 829213467 406079951 423133516 423158604 422311024 423847681
>> 1963015875 1555848944 407166931 407192104 406718592 408227742
>> 3490131033 3117047653 373083380 373108386 372270880 373862706
>> 940880689 549698684 391182005 391207388 390339328 391888374
>> 4098417807 3712068859 386348948 386373592 385604096 387172806
>> 3931378773 3549502965 381875808 381901074 381059904 382628308
>>
>
> FWIW, avcstat would summarize that for you.
> Those stats seem very unusual.  You said you see this on some nodes.
> Anything to distinguish these nodes from the others that don't exhibit this
> behavior?

Yes, these nodes are nodes with clustered vertica DB, which probably has
the biggest amount of rules overall.


>
>
>
>> Also we see
>>
>> # cat /selinux/avc/hash_stats
>> entries: 499
>> buckets used: 257/512
>> longest chain: 6
>>
>> Some times under load we see SELinux consuming about 30% of CPU time.
>> There is about 16% of cache misses on these nodes (and sometimes it goes
>> as high as 30%). The lates article about the issue is from RHEL 5 times
>> -
>>
>> https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
>> . We do not feel this to be too relevant in this case.
>>
>> Are there any recommendations on cache sizing for SELinux? We can resize
>> cache to 1024 or 2048 entries, but would this help to resolve the issue?
>>
>
> Yes, increasing the cache threshold should help as you are evidently
> thrashing the cache.
>
> I'm attaching seinfo from node with our policy and then for comparison
>> from node without any policy.
>>
>
> What do you mean by "our policy" versus "without any policy"?  Do you mean
> that the former has some local policy modules that you have added and the
> latter is the stock SL6.6 policy?

Yes, exacly, the 1st has stock SL 6.6 + our module, the latter one is just
with stock 6.6.

>
>
> With policy:
>> # seinfo
>>
>> Statistics for policy file: /etc/selinux/targeted/policy/policy.24
>> Policy Version & Type: v.24 (binary, mls)
>>
>>     Classes:            81    Permissions:       238
>>     Sensitivities:       1    Categories:       1024
>>     Types:            4273    Attributes:        295
>>     Users:               9    Roles:              12
>>     Booleans:          234    Cond. Expr.:       274
>>     Allow:          352554    Neverallow:          0
>>     Auditallow:        140    Dontaudit:      321786
>>     Type_trans:      42813    Type_change:        38
>>     Type_member:        48    Role allow:         19
>>     Role_trans:        409    Range_trans:      6421
>>     Constraints:        90    Validatetrans:       0
>>     Initial SIDs:       27    Fs_use:             23
>>     Genfscon:           84    Portcon:           505
>>     Netifcon:            0    Nodecon:             0
>>     Permissives:        91    Polcap:              2
>>
>>
>>
>> Without policy:
>>
>> seinfo
>>
>> Statistics for policy file: /etc/selinux/targeted/policy/policy.24
>> Policy Version & Type: v.24 (binary, mls)
>>
>>     Classes:            81    Permissions:       238
>>     Sensitivities:       1    Categories:       1024
>>     Types:            3926    Attributes:        295
>>     Users:               9    Roles:              12
>>     Booleans:          234    Cond. Expr.:       274
>>     Allow:          320969    Neverallow:          0
>>     Auditallow:        140    Dontaudit:      273256
>>     Type_trans:      41915    Type_change:        38
>>     Type_member:        48    Role allow:         19
>>     Role_trans:        386    Range_trans:      6069
>>     Constraints:        90    Validatetrans:       0
>>     Initial SIDs:       27    Fs_use:             23
>>     Genfscon:           84    Portcon:           479
>>     Netifcon:            0    Nodecon:             0
>>     Permissives:        91    Polcap:              2
>>
>>
>> Any help or guidance would be very much appreciated, if there is more
>> in-depth info needed I'll be more than happy to provide it.
>>
>
>
>

--001a113d7c1282c2ac0526654c8e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Dec 8, 2015 at 4:29 PM, Stephen Smalley <span dir=3D"ltr">&lt;<=
a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 12=
/08/2015 05:25 AM, Michal Marciniszyn wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
we are heavy SELinux shop and we recently run into AVC related<br>
performance issue. I was trying to find an answer on freenode IRC chat<br>
but I was sent here by multiple guys. We&#39;re running on Scientific Linux=
<br>
6.6 (upgrade to 6.7 ongoing) and we see this on some of our nodes:<br>
<br>
# cat /selinux/avc/cache_stats<br>
lookups hits misses allocations reclaims frees<br>
3976846641 3626568307 350278334 350303465 344833264 346344169<br>
<a href=3D"tel:3474274460" value=3D"+13474274460" target=3D"_blank">3474274=
460</a>=C2=A0<a href=3D"tel:3092218096" value=3D"+13092218096" target=3D"_b=
lank">3092218096</a> 382056364 382081270 381170512 382671551<br>
<a href=3D"tel:2037181411" value=3D"+12037181411" target=3D"_blank">2037181=
411</a>=C2=A01655679702 381501709 381527148 380680320 382162477<br>
1943162363 1651603455 291558908 291584892 288099840 289631602<br>
829213467 406079951 423133516 423158604 422311024 423847681<br>
1963015875 1555848944 407166931 407192104 406718592 408227742<br>
3490131033 3117047653 373083380 373108386 372270880 373862706<br>
940880689 549698684 391182005 391207388 390339328 391888374<br>
<a href=3D"tel:4098417807" value=3D"+14098417807" target=3D"_blank">4098417=
807</a>=C2=A03712068859 386348948 386373592 385604096 387172806<br>
3931378773 3549502965 381875808 381901074 381059904 382628308<br>
</blockquote>
<br></span>
FWIW, avcstat would summarize that for you.<br>
Those stats seem very unusual.=C2=A0 You said you see this on some nodes. A=
nything to distinguish these nodes from the others that don&#39;t exhibit t=
his behavior?</blockquote><div>Yes, these nodes are nodes with clustered ve=
rtica DB, which probably has the biggest amount of rules overall.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Also we see<br>
<br>
# cat /selinux/avc/hash_stats<br>
entries: 499<br>
buckets used: 257/512<br>
longest chain: 6<br>
<br>
Some times under load we see SELinux consuming about 30% of CPU time.<br>
There is about 16% of cache misses on these nodes (and sometimes it goes<br=
>
as high as 30%). The lates article about the issue is from RHEL 5 times<br>
-<br>
<a href=3D"https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise=
_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html" rel=3D"noreferrer"=
 target=3D"_blank">https://access.redhat.com/documentation/en-US/Red_Hat_En=
terprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html</a><br>
. We do not feel this to be too relevant in this case.<br>
<br>
Are there any recommendations on cache sizing for SELinux? We can resize<br=
>
cache to 1024 or 2048 entries, but would this help to resolve the issue?<br=
>
</blockquote>
<br></span>
Yes, increasing the cache threshold should help as you are evidently thrash=
ing the cache.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I&#39;m attaching seinfo from node with our policy and then for comparison<=
br>
from node without any policy.<br>
</blockquote>
<br></span>
What do you mean by &quot;our policy&quot; versus &quot;without any policy&=
quot;?=C2=A0 Do you mean that the former has some local policy modules that=
 you have added and the latter is the stock SL6.6 policy?</blockquote><div>=
Yes, exacly, the 1st has stock SL 6.6 + our module, the latter one is just =
with stock 6.6.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOE=
nZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
With policy:<br>
# seinfo<br>
<br>
Statistics for policy file: /etc/selinux/targeted/policy/policy.24<br>
Policy Version &amp; Type: v.24 (binary, mls)<br>
<br>
=C2=A0 =C2=A0 Classes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 81=C2=A0 =
=C2=A0 Permissions:=C2=A0 =C2=A0 =C2=A0 =C2=A0238<br>
=C2=A0 =C2=A0 Sensitivities:=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 Categ=
ories:=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
=C2=A0 =C2=A0 Types:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4273=C2=A0 =
=C2=A0 Attributes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 295<br>
=C2=A0 =C2=A0 Users:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
9=C2=A0 =C2=A0 Roles:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12<br=
>
=C2=A0 =C2=A0 Booleans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 234=C2=A0 =C2=A0 =
Cond. Expr.:=C2=A0 =C2=A0 =C2=A0 =C2=A0274<br>
=C2=A0 =C2=A0 Allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 352554=C2=A0 =C2=A0 =
Neverallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
=C2=A0 =C2=A0 Auditallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 140=C2=A0 =C2=A0 Donta=
udit:=C2=A0 =C2=A0 =C2=A0 321786<br>
=C2=A0 =C2=A0 Type_trans:=C2=A0 =C2=A0 =C2=A0 42813=C2=A0 =C2=A0 Type_chang=
e:=C2=A0 =C2=A0 =C2=A0 =C2=A0 38<br>
=C2=A0 =C2=A0 Type_member:=C2=A0 =C2=A0 =C2=A0 =C2=A0 48=C2=A0 =C2=A0 Role =
allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A019<br>
=C2=A0 =C2=A0 Role_trans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 409=C2=A0 =C2=A0 Range=
_trans:=C2=A0 =C2=A0 =C2=A0 6421<br>
=C2=A0 =C2=A0 Constraints:=C2=A0 =C2=A0 =C2=A0 =C2=A0 90=C2=A0 =C2=A0 Valid=
atetrans:=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0 =C2=A0 Initial SIDs:=C2=A0 =C2=A0 =C2=A0 =C2=A027=C2=A0 =C2=A0 Fs_us=
e:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023<br>
=C2=A0 =C2=A0 Genfscon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A084=C2=A0 =
=C2=A0 Portcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0505<br>
=C2=A0 =C2=A0 Netifcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =
=C2=A0 Nodecon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0 =C2=A0 Permissives:=C2=A0 =C2=A0 =C2=A0 =C2=A0 91=C2=A0 =C2=A0 Polca=
p:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
<br>
<br>
<br>
Without policy:<br>
<br>
seinfo<br>
<br>
Statistics for policy file: /etc/selinux/targeted/policy/policy.24<br>
Policy Version &amp; Type: v.24 (binary, mls)<br>
<br>
=C2=A0 =C2=A0 Classes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 81=C2=A0 =
=C2=A0 Permissions:=C2=A0 =C2=A0 =C2=A0 =C2=A0238<br>
=C2=A0 =C2=A0 Sensitivities:=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 Categ=
ories:=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
=C2=A0 =C2=A0 Types:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3926=C2=A0 =
=C2=A0 Attributes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 295<br>
=C2=A0 =C2=A0 Users:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
9=C2=A0 =C2=A0 Roles:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12<br=
>
=C2=A0 =C2=A0 Booleans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 234=C2=A0 =C2=A0 =
Cond. Expr.:=C2=A0 =C2=A0 =C2=A0 =C2=A0274<br>
=C2=A0 =C2=A0 Allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 320969=C2=A0 =C2=A0 =
Neverallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
=C2=A0 =C2=A0 Auditallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 140=C2=A0 =C2=A0 Donta=
udit:=C2=A0 =C2=A0 =C2=A0 273256<br>
=C2=A0 =C2=A0 Type_trans:=C2=A0 =C2=A0 =C2=A0 41915=C2=A0 =C2=A0 Type_chang=
e:=C2=A0 =C2=A0 =C2=A0 =C2=A0 38<br>
=C2=A0 =C2=A0 Type_member:=C2=A0 =C2=A0 =C2=A0 =C2=A0 48=C2=A0 =C2=A0 Role =
allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A019<br>
=C2=A0 =C2=A0 Role_trans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 386=C2=A0 =C2=A0 Range=
_trans:=C2=A0 =C2=A0 =C2=A0 6069<br>
=C2=A0 =C2=A0 Constraints:=C2=A0 =C2=A0 =C2=A0 =C2=A0 90=C2=A0 =C2=A0 Valid=
atetrans:=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0 =C2=A0 Initial SIDs:=C2=A0 =C2=A0 =C2=A0 =C2=A027=C2=A0 =C2=A0 Fs_us=
e:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023<br>
=C2=A0 =C2=A0 Genfscon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A084=C2=A0 =
=C2=A0 Portcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0479<br>
=C2=A0 =C2=A0 Netifcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =
=C2=A0 Nodecon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0 =C2=A0 Permissives:=C2=A0 =C2=A0 =C2=A0 =C2=A0 91=C2=A0 =C2=A0 Polca=
p:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
<br>
<br>
Any help or guidance would be very much appreciated, if there is more<br>
in-depth info needed I&#39;ll be more than happy to provide it.<br>
</blockquote>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a113d7c1282c2ac0526654c8e--
