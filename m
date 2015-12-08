Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8APx6a017640
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 05:25:59 -0500
Received: by oixx65 with SMTP id x65so7462978oix.0
 for <selinux@tycho.nsa.gov>; Tue, 08 Dec 2015 02:25:41 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 8 Dec 2015 11:25:40 +0100
Message-ID: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
Subject: Performance issues - huge amount of AVC misses
From: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113d7c123c6f0805266065db
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113d7c123c6f0805266065db
Content-Type: text/plain; charset=UTF-8

Hello,

we are heavy SELinux shop and we recently run into AVC related performance
issue. I was trying to find an answer on freenode IRC chat but I was sent
here by multiple guys. We're running on Scientific Linux 6.6 (upgrade to
6.7 ongoing) and we see this on some of our nodes:

# cat /selinux/avc/cache_stats
lookups hits misses allocations reclaims frees
3976846641 3626568307 350278334 350303465 344833264 346344169
3474274460 3092218096 382056364 382081270 381170512 382671551
2037181411 1655679702 381501709 381527148 380680320 382162477
1943162363 1651603455 291558908 291584892 288099840 289631602
829213467 406079951 423133516 423158604 422311024 423847681
1963015875 1555848944 407166931 407192104 406718592 408227742
3490131033 3117047653 373083380 373108386 372270880 373862706
940880689 549698684 391182005 391207388 390339328 391888374
4098417807 3712068859 386348948 386373592 385604096 387172806
3931378773 3549502965 381875808 381901074 381059904 382628308

Also we see

# cat /selinux/avc/hash_stats
entries: 499
buckets used: 257/512
longest chain: 6

Some times under load we see SELinux consuming about 30% of CPU time. There
is about 16% of cache misses on these nodes (and sometimes it goes as high
as 30%). The lates article about the issue is from RHEL 5 times -
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
. We do not feel this to be too relevant in this case.

Are there any recommendations on cache sizing for SELinux? We can resize
cache to 1024 or 2048 entries, but would this help to resolve the issue?

I'm attaching seinfo from node with our policy and then for comparison from
node without any policy.

With policy:
# seinfo

Statistics for policy file: /etc/selinux/targeted/policy/policy.24
Policy Version & Type: v.24 (binary, mls)

   Classes:            81    Permissions:       238
   Sensitivities:       1    Categories:       1024
   Types:            4273    Attributes:        295
   Users:               9    Roles:              12
   Booleans:          234    Cond. Expr.:       274
   Allow:          352554    Neverallow:          0
   Auditallow:        140    Dontaudit:      321786
   Type_trans:      42813    Type_change:        38
   Type_member:        48    Role allow:         19
   Role_trans:        409    Range_trans:      6421
   Constraints:        90    Validatetrans:       0
   Initial SIDs:       27    Fs_use:             23
   Genfscon:           84    Portcon:           505
   Netifcon:            0    Nodecon:             0
   Permissives:        91    Polcap:              2



Without policy:

seinfo

Statistics for policy file: /etc/selinux/targeted/policy/policy.24
Policy Version & Type: v.24 (binary, mls)

   Classes:            81    Permissions:       238
   Sensitivities:       1    Categories:       1024
   Types:            3926    Attributes:        295
   Users:               9    Roles:              12
   Booleans:          234    Cond. Expr.:       274
   Allow:          320969    Neverallow:          0
   Auditallow:        140    Dontaudit:      273256
   Type_trans:      41915    Type_change:        38
   Type_member:        48    Role allow:         19
   Role_trans:        386    Range_trans:      6069
   Constraints:        90    Validatetrans:       0
   Initial SIDs:       27    Fs_use:             23
   Genfscon:           84    Portcon:           479
   Netifcon:            0    Nodecon:             0
   Permissives:        91    Polcap:              2


Any help or guidance would be very much appreciated, if there is more
in-depth info needed I'll be more than happy to provide it.

Yours sincerely,

Michal Marciniszyn
Manager - SW Engineering
GoodData

--001a113d7c123c6f0805266065db
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>we are heavy SELinux shop and we=
 recently run into AVC related performance issue. I was trying to find an a=
nswer on freenode IRC chat but I was sent here by multiple guys. We&#39;re =
running on Scientific Linux 6.6 (upgrade to 6.7 ongoing) and we see this on=
 some of our nodes:</div><div><br></div><div><div># cat /selinux/avc/cache_=
stats=C2=A0</div><div>lookups hits misses allocations reclaims frees</div><=
div>3976846641 3626568307 350278334 350303465 344833264 346344169</div><div=
>3474274460 3092218096 382056364 382081270 381170512 382671551</div><div>20=
37181411 1655679702 381501709 381527148 380680320 382162477</div><div>19431=
62363 1651603455 291558908 291584892 288099840 289631602</div><div>82921346=
7 406079951 423133516 423158604 422311024 423847681</div><div>1963015875 15=
55848944 407166931 407192104 406718592 408227742</div><div>3490131033 31170=
47653 373083380 373108386 372270880 373862706</div><div>940880689 549698684=
 391182005 391207388 390339328 391888374</div><div>4098417807 3712068859 38=
6348948 386373592 385604096 387172806</div><div>3931378773 3549502965 38187=
5808 381901074 381059904 382628308</div></div><div><br></div><div>Also we s=
ee</div><div><br></div><div><div><div># cat /selinux/avc/hash_stats=C2=A0</=
div><div>entries: 499</div><div>buckets used: 257/512</div><div>longest cha=
in: 6</div></div></div><div><br></div><div>Some times under load we see SEL=
inux consuming about 30% of CPU time. There is about 16% of cache misses on=
 these nodes (and sometimes it goes as high as 30%). The lates article abou=
t the issue is from RHEL 5 times -=C2=A0<a href=3D"https://access.redhat.co=
m/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcomm=
on-section-0102.html">https://access.redhat.com/documentation/en-US/Red_Hat=
_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html</a> . We=
 do not feel this to be too relevant in this case.</div><div><br></div><div=
>Are there any recommendations on cache sizing for SELinux? We can resize c=
ache to 1024 or 2048 entries, but would this help to resolve the issue?</di=
v><div><br></div><div>I&#39;m attaching seinfo from node with our policy an=
d then for comparison from node without any policy.</div><div><br></div><di=
v>With policy:</div><div><div># seinfo=C2=A0</div><div><br></div><div>Stati=
stics for policy file: /etc/selinux/targeted/policy/policy.24</div><div>Pol=
icy Version &amp; Type: v.24 (binary, mls)</div><div><br></div><div>=C2=A0 =
=C2=A0Classes: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A081 =C2=A0 =C2=A0Per=
missions: =C2=A0 =C2=A0 =C2=A0 238</div><div>=C2=A0 =C2=A0Sensitivities: =
=C2=A0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0Categories: =C2=A0 =C2=A0 =C2=A0 1024</=
div><div>=C2=A0 =C2=A0Types: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04273 =
=C2=A0 =C2=A0Attributes: =C2=A0 =C2=A0 =C2=A0 =C2=A0295</div><div>=C2=A0 =
=C2=A0Users: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 9 =C2=A0 =C2=
=A0Roles: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A012</div><div>=C2=
=A0 =C2=A0Booleans: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0234 =C2=A0 =C2=A0Cond=
. Expr.: =C2=A0 =C2=A0 =C2=A0 274</div><div>=C2=A0 =C2=A0Allow: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0352554 =C2=A0 =C2=A0Neverallow: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A0Auditallow: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0140 =C2=A0 =C2=A0Dontaudit: =C2=A0 =C2=A0 =C2=A0321786</div><div>=C2=
=A0 =C2=A0Type_trans: =C2=A0 =C2=A0 =C2=A042813 =C2=A0 =C2=A0Type_change: =
=C2=A0 =C2=A0 =C2=A0 =C2=A038</div><div>=C2=A0 =C2=A0Type_member: =C2=A0 =
=C2=A0 =C2=A0 =C2=A048 =C2=A0 =C2=A0Role allow: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 19</div><div>=C2=A0 =C2=A0Role_trans: =C2=A0 =C2=A0 =C2=A0 =C2=A0409 =C2=
=A0 =C2=A0Range_trans: =C2=A0 =C2=A0 =C2=A06421</div><div>=C2=A0 =C2=A0Cons=
traints: =C2=A0 =C2=A0 =C2=A0 =C2=A090 =C2=A0 =C2=A0Validatetrans: =C2=A0 =
=C2=A0 =C2=A0 0</div><div>=C2=A0 =C2=A0Initial SIDs: =C2=A0 =C2=A0 =C2=A0 2=
7 =C2=A0 =C2=A0Fs_use: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 23</div><d=
iv>=C2=A0 =C2=A0Genfscon: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 84 =C2=A0 =C2=
=A0Portcon: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 505</div><div>=C2=A0 =C2=A0N=
etifcon: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0Nodecon: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0</div><div>=C2=A0 =C2=A0Permissi=
ves: =C2=A0 =C2=A0 =C2=A0 =C2=A091 =C2=A0 =C2=A0Polcap: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02</div></div><div><br></div><div><br></div><=
div><br></div><div>Without policy:</div><div><br></div><div><div>seinfo=C2=
=A0</div><div><br></div><div>Statistics for policy file: /etc/selinux/targe=
ted/policy/policy.24</div><div>Policy Version &amp; Type: v.24 (binary, mls=
)</div><div><br></div><div>=C2=A0 =C2=A0Classes: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A081 =C2=A0 =C2=A0Permissions: =C2=A0 =C2=A0 =C2=A0 238</div=
><div>=C2=A0 =C2=A0Sensitivities: =C2=A0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0Categ=
ories: =C2=A0 =C2=A0 =C2=A0 1024</div><div>=C2=A0 =C2=A0Types: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03926 =C2=A0 =C2=A0Attributes: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0295</div><div>=C2=A0 =C2=A0Users: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 9 =C2=A0 =C2=A0Roles: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A012</div><div>=C2=A0 =C2=A0Booleans: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0234 =C2=A0 =C2=A0Cond. Expr.: =C2=A0 =C2=A0 =C2=A0 274</div><d=
iv>=C2=A0 =C2=A0Allow: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0320969 =C2=A0 =C2=
=A0Neverallow: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00</div><div>=C2=A0 =C2=A0A=
uditallow: =C2=A0 =C2=A0 =C2=A0 =C2=A0140 =C2=A0 =C2=A0Dontaudit: =C2=A0 =
=C2=A0 =C2=A0273256</div><div>=C2=A0 =C2=A0Type_trans: =C2=A0 =C2=A0 =C2=A0=
41915 =C2=A0 =C2=A0Type_change: =C2=A0 =C2=A0 =C2=A0 =C2=A038</div><div>=C2=
=A0 =C2=A0Type_member: =C2=A0 =C2=A0 =C2=A0 =C2=A048 =C2=A0 =C2=A0Role allo=
w: =C2=A0 =C2=A0 =C2=A0 =C2=A0 19</div><div>=C2=A0 =C2=A0Role_trans: =C2=A0=
 =C2=A0 =C2=A0 =C2=A0386 =C2=A0 =C2=A0Range_trans: =C2=A0 =C2=A0 =C2=A06069=
</div><div>=C2=A0 =C2=A0Constraints: =C2=A0 =C2=A0 =C2=A0 =C2=A090 =C2=A0 =
=C2=A0Validatetrans: =C2=A0 =C2=A0 =C2=A0 0</div><div>=C2=A0 =C2=A0Initial =
SIDs: =C2=A0 =C2=A0 =C2=A0 27 =C2=A0 =C2=A0Fs_use: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 23</div><div>=C2=A0 =C2=A0Genfscon: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 84 =C2=A0 =C2=A0Portcon: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=
79</div><div>=C2=A0 =C2=A0Netifcon: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00 =C2=A0 =C2=A0Nodecon: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0</div=
><div>=C2=A0 =C2=A0Permissives: =C2=A0 =C2=A0 =C2=A0 =C2=A091 =C2=A0 =C2=A0=
Polcap: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02</div></div><div><=
br></div><div><br></div><div>Any help or guidance would be very much apprec=
iated, if there is more in-depth info needed I&#39;ll be more than happy to=
 provide it.</div><div><br></div><div>Yours sincerely,</div><div><br></div>=
<div>Michal Marciniszyn</div><div>Manager - SW Engineering</div><div>GoodDa=
ta</div></div>

--001a113d7c123c6f0805266065db--
