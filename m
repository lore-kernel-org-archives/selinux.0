Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB9DFfvG030464
 for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2015 08:15:42 -0500
Received: by oiww189 with SMTP id w189so26187497oiw.3
 for <selinux@tycho.nsa.gov>; Wed, 09 Dec 2015 05:15:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL8PO=1vpZ0=CL4LjpR8V4R2kpSsQ80dSUvSF74L=ct21UsKCA@mail.gmail.com>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <671085597.26020826.1449655668740.JavaMail.zimbra@redhat.com>
 <CAL8PO=1vpZ0=CL4LjpR8V4R2kpSsQ80dSUvSF74L=ct21UsKCA@mail.gmail.com>
Date: Wed, 9 Dec 2015 14:15:31 +0100
Message-ID: <CAL8PO=0jLoHuqwsTuEC8GHK-V_s0OHx+dTOBFy3uHmOJRSuk7A@mail.gmail.com>
Subject: Re: Performance issues - huge amount of AVC misses
From: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
To: Milos Malik <mmalik@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113d444a7e122e052676e257
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113d444a7e122e052676e257
Content-Type: text/plain; charset=UTF-8

Hi,

after increasing the cache, I do not see many reclaims, like couple of them
here and there. The cache size had to be increased to 2048 to get ti this
state.

# avcstat 15

    537645     537623         22         22         32         32
    942916     942912          4          4          0          0
    604466     604457          9          9          0          0
    451737     451730          7          7         16         16
    457669     457669          0          0          0          0
    519135     519133          2          2          0          0
    517288     517288          0          0          0          0
    380376     380376          0          0          0          0
    464272     464269          3          3          0          0
    531484     531482          2          2          0          0
   1422422    1422421          1          1          0          0
   1380932    1380932          0          0          0          0
    512999     512999          0          0          0          0


Is it ok if I get longest chain length 13 in hash stats (It was higher in
the beginning - 19, but got to 13 after 2 hours)?

Michal

On Wed, Dec 9, 2015 at 11:19 AM, Michal Marciniszyn <
michal.marciniszyn@gooddata.com> wrote:

> Hi,
>
> regarding the process, we see that in perf top. Under heavier load we see
> following
> 21.53% [kernel] [k] avtab_search_node
>
> sometimes even with higher percentage.
>
> --blesk
>
> On Wed, Dec 9, 2015 at 11:07 AM, Milos Malik <mmalik@redhat.com> wrote:
>
>> Hi Michal,
>>
>> which process (from the "top -d1" output) is consuming almost 30% of CPU?
>> Is it setroubleshootd or auditd or sedispatch or kernel? Thanks for the
>> answer.
>>
>> Milos Malik
>> SELinux QE person
>> BaseOS QE Security team
>> Red Hat Czech
>>
>> ----- Original Message -----
>> > Hello,
>> >
>> > we are heavy SELinux shop and we recently run into AVC related
>> performance
>> > issue. I was trying to find an answer on freenode IRC chat but I was
>> sent
>> > here by multiple guys. We're running on Scientific Linux 6.6 (upgrade
>> to 6.7
>> > ongoing) and we see this on some of our nodes:
>> >
>> > # cat /selinux/avc/cache_stats
>> > lookups hits misses allocations reclaims frees
>> > 3976846641 3626568307 350278334 350303465 344833264 346344169
>> > 3474274460 3092218096 382056364 382081270 381170512 382671551
>> > 2037181411 1655679702 381501709 381527148 380680320 382162477
>> > 1943162363 1651603455 291558908 291584892 288099840 289631602
>> > 829213467 406079951 423133516 423158604 422311024 423847681
>> > 1963015875 1555848944 407166931 407192104 406718592 408227742
>> > 3490131033 3117047653 373083380 373108386 372270880 373862706
>> > 940880689 549698684 391182005 391207388 390339328 391888374
>> > 4098417807 3712068859 386348948 386373592 385604096 387172806
>> > 3931378773 3549502965 381875808 381901074 381059904 382628308
>> >
>> > Also we see
>> >
>> > # cat /selinux/avc/hash_stats
>> > entries: 499
>> > buckets used: 257/512
>> > longest chain: 6
>> >
>> > Some times under load we see SELinux consuming about 30% of CPU time.
>> There
>> > is about 16% of cache misses on these nodes (and sometimes it goes as
>> high
>> > as 30%). The lates article about the issue is from RHEL 5 times -
>> >
>> https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
>> > . We do not feel this to be too relevant in this case.
>> >
>> > Are there any recommendations on cache sizing for SELinux? We can resize
>> > cache to 1024 or 2048 entries, but would this help to resolve the issue?
>> >
>> > I'm attaching seinfo from node with our policy and then for comparison
>> from
>> > node without any policy.
>> >
>> > With policy:
>> > # seinfo
>> >
>> > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
>> > Policy Version & Type: v.24 (binary, mls)
>> >
>> > Classes: 81 Permissions: 238
>> > Sensitivities: 1 Categories: 1024
>> > Types: 4273 Attributes: 295
>> > Users: 9 Roles: 12
>> > Booleans: 234 Cond. Expr.: 274
>> > Allow: 352554 Neverallow: 0
>> > Auditallow: 140 Dontaudit: 321786
>> > Type_trans: 42813 Type_change: 38
>> > Type_member: 48 Role allow: 19
>> > Role_trans: 409 Range_trans: 6421
>> > Constraints: 90 Validatetrans: 0
>> > Initial SIDs: 27 Fs_use: 23
>> > Genfscon: 84 Portcon: 505
>> > Netifcon: 0 Nodecon: 0
>> > Permissives: 91 Polcap: 2
>> >
>> >
>> >
>> > Without policy:
>> >
>> > seinfo
>> >
>> > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
>> > Policy Version & Type: v.24 (binary, mls)
>> >
>> > Classes: 81 Permissions: 238
>> > Sensitivities: 1 Categories: 1024
>> > Types: 3926 Attributes: 295
>> > Users: 9 Roles: 12
>> > Booleans: 234 Cond. Expr.: 274
>> > Allow: 320969 Neverallow: 0
>> > Auditallow: 140 Dontaudit: 273256
>> > Type_trans: 41915 Type_change: 38
>> > Type_member: 48 Role allow: 19
>> > Role_trans: 386 Range_trans: 6069
>> > Constraints: 90 Validatetrans: 0
>> > Initial SIDs: 27 Fs_use: 23
>> > Genfscon: 84 Portcon: 479
>> > Netifcon: 0 Nodecon: 0
>> > Permissives: 91 Polcap: 2
>> >
>> >
>> > Any help or guidance would be very much appreciated, if there is more
>> > in-depth info needed I'll be more than happy to provide it.
>> >
>> > Yours sincerely,
>> >
>> > Michal Marciniszyn
>> > Manager - SW Engineering
>> > GoodData
>> >
>> > _______________________________________________
>> > Selinux mailing list
>> > Selinux@tycho.nsa.gov
>> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to
>> > Selinux-request@tycho.nsa.gov.
>>
>
>

--001a113d444a7e122e052676e257
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>after increasing the cache, I do no=
t see many reclaims, like couple of them here and there. The cache size had=
 to be increased to 2048 to get ti this state.</div><div><br></div><div># a=
vcstat 15</div><div><div><br></div><div>=C2=A0 =C2=A0 537645 =C2=A0 =C2=A0 =
537623 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32</div><div>=C2=A0 =
=C2=A0 942916 =C2=A0 =C2=A0 942912 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A0 604466 =C2=A0 =C2=A0 =
604457 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A09 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0</div><div>=C2=A0 =C2=A0 451737 =C2=A0 =C2=A0 451730 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A07 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16</div><div>=C2=A0 =C2=A0 457669 =C2=A0=
 =C2=A0 457669 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00</div><div>=C2=A0 =C2=A0 519135 =C2=A0 =C2=A0 519133 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=
=A0 517288 =C2=A0 =C2=A0 517288 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A0 380376 =C2=A0 =C2=A0 3803=
76 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</di=
v><div>=C2=A0 =C2=A0 464272 =C2=A0 =C2=A0 464269 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A0 531484=
 =C2=A0 =C2=A0 531482 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A01422422 =C2=A0 =C2=A01422421 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=
=A0 =C2=A01380932 =C2=A0 =C2=A01380932 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A0 512999 =C2=A0 =C2=
=A0 512999 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00</div></div><div><br></div><div><br></div><div>Is it ok if I get longes=
t chain length 13 in hash stats (It was higher in the beginning - 19, but g=
ot to 13 after 2 hours)?</div><div><br></div><div>Michal</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Dec 9, 2015 at 1=
1:19 AM, Michal Marciniszyn <span dir=3D"ltr">&lt;<a href=3D"mailto:michal.=
marciniszyn@gooddata.com" target=3D"_blank">michal.marciniszyn@gooddata.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">H=
i,<div><br></div><div>regarding the process, we see that in perf top. Under=
 heavier load we see following</div><div><div>21.53% [kernel] [k] avtab_sea=
rch_node</div></div><div><br></div><div>sometimes even with higher percenta=
ge.</div><div><br></div><div>--blesk</div></div><div class=3D"HOEnZb"><div =
class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On W=
ed, Dec 9, 2015 at 11:07 AM, Milos Malik <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mmalik@redhat.com" target=3D"_blank">mmalik@redhat.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi Michal,<br>
<br>
which process (from the &quot;top -d1&quot; output) is consuming almost 30%=
 of CPU? Is it setroubleshootd or auditd or sedispatch or kernel? Thanks fo=
r the answer.<br>
<span><font color=3D"#888888"><br>
Milos Malik<br>
SELinux QE person<br>
BaseOS QE Security team<br>
Red Hat Czech<br>
</font></span><div><div><br>
----- Original Message -----<br>
&gt; Hello,<br>
&gt;<br>
&gt; we are heavy SELinux shop and we recently run into AVC related perform=
ance<br>
&gt; issue. I was trying to find an answer on freenode IRC chat but I was s=
ent<br>
&gt; here by multiple guys. We&#39;re running on Scientific Linux 6.6 (upgr=
ade to 6.7<br>
&gt; ongoing) and we see this on some of our nodes:<br>
&gt;<br>
&gt; # cat /selinux/avc/cache_stats<br>
&gt; lookups hits misses allocations reclaims frees<br>
&gt; 3976846641 3626568307 350278334 350303465 344833264 346344169<br>
&gt; <a href=3D"tel:3474274460" value=3D"+13474274460" target=3D"_blank">34=
74274460</a> <a href=3D"tel:3092218096" value=3D"+13092218096" target=3D"_b=
lank">3092218096</a> 382056364 382081270 381170512 382671551<br>
&gt; <a href=3D"tel:2037181411" value=3D"+12037181411" target=3D"_blank">20=
37181411</a> 1655679702 381501709 381527148 380680320 382162477<br>
&gt; 1943162363 1651603455 291558908 291584892 288099840 289631602<br>
&gt; 829213467 406079951 423133516 423158604 422311024 423847681<br>
&gt; 1963015875 1555848944 407166931 407192104 406718592 408227742<br>
&gt; 3490131033 3117047653 373083380 373108386 372270880 373862706<br>
&gt; 940880689 549698684 391182005 391207388 390339328 391888374<br>
&gt; <a href=3D"tel:4098417807" value=3D"+14098417807" target=3D"_blank">40=
98417807</a> 3712068859 386348948 386373592 385604096 387172806<br>
&gt; 3931378773 3549502965 381875808 381901074 381059904 382628308<br>
&gt;<br>
&gt; Also we see<br>
&gt;<br>
&gt; # cat /selinux/avc/hash_stats<br>
&gt; entries: 499<br>
&gt; buckets used: 257/512<br>
&gt; longest chain: 6<br>
&gt;<br>
&gt; Some times under load we see SELinux consuming about 30% of CPU time. =
There<br>
&gt; is about 16% of cache misses on these nodes (and sometimes it goes as =
high<br>
&gt; as 30%). The lates article about the issue is from RHEL 5 times -<br>
&gt; <a href=3D"https://access.redhat.com/documentation/en-US/Red_Hat_Enter=
prise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html" rel=3D"norefe=
rrer" target=3D"_blank">https://access.redhat.com/documentation/en-US/Red_H=
at_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html</a><br=
>
&gt; . We do not feel this to be too relevant in this case.<br>
&gt;<br>
&gt; Are there any recommendations on cache sizing for SELinux? We can resi=
ze<br>
&gt; cache to 1024 or 2048 entries, but would this help to resolve the issu=
e?<br>
&gt;<br>
&gt; I&#39;m attaching seinfo from node with our policy and then for compar=
ison from<br>
&gt; node without any policy.<br>
&gt;<br>
&gt; With policy:<br>
&gt; # seinfo<br>
&gt;<br>
&gt; Statistics for policy file: /etc/selinux/targeted/policy/policy.24<br>
&gt; Policy Version &amp; Type: v.24 (binary, mls)<br>
&gt;<br>
&gt; Classes: 81 Permissions: 238<br>
&gt; Sensitivities: 1 Categories: 1024<br>
&gt; Types: 4273 Attributes: 295<br>
&gt; Users: 9 Roles: 12<br>
&gt; Booleans: 234 Cond. Expr.: 274<br>
&gt; Allow: 352554 Neverallow: 0<br>
&gt; Auditallow: 140 Dontaudit: 321786<br>
&gt; Type_trans: 42813 Type_change: 38<br>
&gt; Type_member: 48 Role allow: 19<br>
&gt; Role_trans: 409 Range_trans: 6421<br>
&gt; Constraints: 90 Validatetrans: 0<br>
&gt; Initial SIDs: 27 Fs_use: 23<br>
&gt; Genfscon: 84 Portcon: 505<br>
&gt; Netifcon: 0 Nodecon: 0<br>
&gt; Permissives: 91 Polcap: 2<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Without policy:<br>
&gt;<br>
&gt; seinfo<br>
&gt;<br>
&gt; Statistics for policy file: /etc/selinux/targeted/policy/policy.24<br>
&gt; Policy Version &amp; Type: v.24 (binary, mls)<br>
&gt;<br>
&gt; Classes: 81 Permissions: 238<br>
&gt; Sensitivities: 1 Categories: 1024<br>
&gt; Types: 3926 Attributes: 295<br>
&gt; Users: 9 Roles: 12<br>
&gt; Booleans: 234 Cond. Expr.: 274<br>
&gt; Allow: 320969 Neverallow: 0<br>
&gt; Auditallow: 140 Dontaudit: 273256<br>
&gt; Type_trans: 41915 Type_change: 38<br>
&gt; Type_member: 48 Role allow: 19<br>
&gt; Role_trans: 386 Range_trans: 6069<br>
&gt; Constraints: 90 Validatetrans: 0<br>
&gt; Initial SIDs: 27 Fs_use: 23<br>
&gt; Genfscon: 84 Portcon: 479<br>
&gt; Netifcon: 0 Nodecon: 0<br>
&gt; Permissives: 91 Polcap: 2<br>
&gt;<br>
&gt;<br>
&gt; Any help or guidance would be very much appreciated, if there is more<=
br>
&gt; in-depth info needed I&#39;ll be more than happy to provide it.<br>
&gt;<br>
&gt; Yours sincerely,<br>
&gt;<br>
&gt; Michal Marciniszyn<br>
&gt; Manager - SW Engineering<br>
&gt; GoodData<br>
&gt;<br>
</div></div><div><div>&gt; _______________________________________________<=
br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tyc=
ho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Sel=
inux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a113d444a7e122e052676e257--
