Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8EulDv004770
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 09:56:47 -0500
Received: by obciw8 with SMTP id iw8so14143464obc.1
 for <selinux@tycho.nsa.gov>; Tue, 08 Dec 2015 06:56:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151208104442.GA32680@x250>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
Date: Tue, 8 Dec 2015 15:56:38 +0100
Message-ID: <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
Subject: Re: Performance issues - huge amount of AVC misses
From: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e015386084d46550526642e80
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e015386084d46550526642e80
Content-Type: text/plain; charset=UTF-8

Hi Dominic,

while there is quite a lot of dontaudit rules around, the amount for
domains running on this node is not high. Is there any way how to monitor
which rules are loaded and released from the cache? Anything better than
plain aggregated stats? We would bot care about performance of such
monitoring tool if it provides some useful answer. For instance, is there a
way how to use system tap or similar kernel profiling to get the data?

I'll do a profiling on how many rules actually apply for the domains on the
node (i.e. use sesearch to find out). If doing so, does the rule in cache
hold whole vector (i.e. A is allowed to do X, Y, Z on B or is one cache
entry A can do X on B)?

Thanks,

--michal

On Tue, Dec 8, 2015 at 11:44 AM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Tue, Dec 08, 2015 at 11:25:40AM +0100, Michal Marciniszyn wrote:
> > Hello,
> >
> > we are heavy SELinux shop and we recently run into AVC related
> performance
> > issue. I was trying to find an answer on freenode IRC chat but I was sent
> > here by multiple guys. We're running on Scientific Linux 6.6 (upgrade to
> > 6.7 ongoing) and we see this on some of our nodes:
> >
> > # cat /selinux/avc/cache_stats
> > lookups hits misses allocations reclaims frees
> > 3976846641 3626568307 350278334 350303465 344833264 346344169
> > 3474274460 3092218096 382056364 382081270 381170512 382671551
> > 2037181411 1655679702 381501709 381527148 380680320 382162477
> > 1943162363 1651603455 291558908 291584892 288099840 289631602
> > 829213467 406079951 423133516 423158604 422311024 423847681
> > 1963015875 1555848944 407166931 407192104 406718592 408227742
> > 3490131033 3117047653 373083380 373108386 372270880 373862706
> > 940880689 549698684 391182005 391207388 390339328 391888374
> > 4098417807 3712068859 386348948 386373592 385604096 387172806
> > 3931378773 3549502965 381875808 381901074 381059904 382628308
> >
> > Also we see
> >
> > # cat /selinux/avc/hash_stats
> > entries: 499
> > buckets used: 257/512
> > longest chain: 6
> >
> > Some times under load we see SELinux consuming about 30% of CPU time.
> There
> > is about 16% of cache misses on these nodes (and sometimes it goes as
> high
> > as 30%). The lates article about the issue is from RHEL 5 times -
> >
> https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
> > . We do not feel this to be too relevant in this case.
> >
> > Are there any recommendations on cache sizing for SELinux? We can resize
> > cache to 1024 or 2048 entries, but would this help to resolve the issue?
> >
> > I'm attaching seinfo from node with our policy and then for comparison
> from
> > node without any policy.
> >
> > With policy:
> > # seinfo
> >
> > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> > Policy Version & Type: v.24 (binary, mls)
> >
> >    Classes:            81    Permissions:       238
> >    Sensitivities:       1    Categories:       1024
> >    Types:            4273    Attributes:        295
> >    Users:               9    Roles:              12
> >    Booleans:          234    Cond. Expr.:       274
> >    Allow:          352554    Neverallow:          0
> >    Auditallow:        140    Dontaudit:      321786
> >    Type_trans:      42813    Type_change:        38
> >    Type_member:        48    Role allow:         19
> >    Role_trans:        409    Range_trans:      6421
> >    Constraints:        90    Validatetrans:       0
> >    Initial SIDs:       27    Fs_use:             23
> >    Genfscon:           84    Portcon:           505
> >    Netifcon:            0    Nodecon:             0
> >    Permissives:        91    Polcap:              2
>
> I don't have any useful input but just an unrelated observation: you
> almost have as many dontaudit rules as you have allow rules. I would not
> be surprised if that were to be somehow related.
>
> >
> >
> >
> > Without policy:
> >
> > seinfo
> >
> > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> > Policy Version & Type: v.24 (binary, mls)
> >
> >    Classes:            81    Permissions:       238
> >    Sensitivities:       1    Categories:       1024
> >    Types:            3926    Attributes:        295
> >    Users:               9    Roles:              12
> >    Booleans:          234    Cond. Expr.:       274
> >    Allow:          320969    Neverallow:          0
> >    Auditallow:        140    Dontaudit:      273256
> >    Type_trans:      41915    Type_change:        38
> >    Type_member:        48    Role allow:         19
> >    Role_trans:        386    Range_trans:      6069
> >    Constraints:        90    Validatetrans:       0
> >    Initial SIDs:       27    Fs_use:             23
> >    Genfscon:           84    Portcon:           479
> >    Netifcon:            0    Nodecon:             0
> >    Permissives:        91    Polcap:              2
> >
> >
> > Any help or guidance would be very much appreciated, if there is more
> > in-depth info needed I'll be more than happy to provide it.
> >
> > Yours sincerely,
> >
> > Michal Marciniszyn
> > Manager - SW Engineering
> > GoodData
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJWZrSWAAoJENAR6kfG5xmctzkMALax9f+yHvM9hiH/RFgf4JMH
> 2avyWCkJggce+DilkHLGuhAZe0yMJW/h4WryF/a93y52q/09l/vYpa4oEShhrasD
> dsOmCOINVW77E6TyWMuv80hYywPoXft+h3XIIgLO9FrURCJoCNlY7WGEpuVIy9PF
> fxk6dxSov4yxxVGnEFW43X8SZ9haypuTiq3DkfvCVTbfeEs1xYu5j2vQ2Ghi0BN0
> N9JdiLiPBBjAZo4O6VFkfgJ3Jt+EfyYuImcL3EhKmOc7c+vTtggc3VEamaSRXnhY
> oXYUnKEqDraaJ7kizgODntPw79YRVpVqpaRipArZq96Qjq9loH/3RsG9DEyRTBgR
> f3VH63L0URGeA7O/qWQmjiHro8ZgZvmKdfnRWtnwtUCfHmaGU8r8rDgWHReC42HD
> FeRn+ymouSp0JDfq9wg3Nbk8R5z/FF4qIk4NpUNIm4KWRREbYQnkTjhMwN3hepg4
> ikMHBdfUP/coPw1kPJtCwYNtwcv+z1D1XbRBiU/icQ==
> =41nB
> -----END PGP SIGNATURE-----
>

--089e015386084d46550526642e80
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Dominic,<div><br></div><div>while there is quite a lot =
of dontaudit rules around, the amount for domains running on this node is n=
ot high. Is there any way how to monitor which rules are loaded and release=
d from the cache? Anything better than plain aggregated stats? We would bot=
 care about performance of such monitoring tool if it provides some useful =
answer. For instance, is there a way how to use system tap or similar kerne=
l profiling to get the data?</div><div><br></div><div>I&#39;ll do a profili=
ng on how many rules actually apply for the domains on the node (i.e. use s=
esearch to find out). If doing so, does the rule in cache hold whole vector=
 (i.e. A is allowed to do X, Y, Z on B or is one cache entry A can do X on =
B)?</div><div><br></div><div>Thanks,</div><div><br></div><div>--michal</div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, De=
c 8, 2015 at 11:44 AM, Dominick Grift <span dir=3D"ltr">&lt;<a href=3D"mail=
to:dac.override@gmail.com" target=3D"_blank">dac.override@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESS=
AGE-----<br>
Hash: SHA512<br>
<div><div class=3D"h5"><br>
On Tue, Dec 08, 2015 at 11:25:40AM +0100, Michal Marciniszyn wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; we are heavy SELinux shop and we recently run into AVC related perform=
ance<br>
&gt; issue. I was trying to find an answer on freenode IRC chat but I was s=
ent<br>
&gt; here by multiple guys. We&#39;re running on Scientific Linux 6.6 (upgr=
ade to<br>
&gt; 6.7 ongoing) and we see this on some of our nodes:<br>
&gt;<br>
&gt; # cat /selinux/avc/cache_stats<br>
&gt; lookups hits misses allocations reclaims frees<br>
&gt; 3976846641 3626568307 350278334 350303465 344833264 346344169<br>
&gt; 3474274460 3092218096 382056364 382081270 381170512 382671551<br>
&gt; 2037181411 1655679702 381501709 381527148 380680320 382162477<br>
&gt; 1943162363 1651603455 291558908 291584892 288099840 289631602<br>
&gt; 829213467 406079951 423133516 423158604 422311024 423847681<br>
&gt; 1963015875 1555848944 407166931 407192104 406718592 408227742<br>
&gt; 3490131033 3117047653 373083380 373108386 372270880 373862706<br>
&gt; 940880689 549698684 391182005 391207388 390339328 391888374<br>
&gt; 4098417807 3712068859 386348948 386373592 385604096 387172806<br>
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
&gt;=C2=A0 =C2=A0 Classes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 81=C2=
=A0 =C2=A0 Permissions:=C2=A0 =C2=A0 =C2=A0 =C2=A0238<br>
&gt;=C2=A0 =C2=A0 Sensitivities:=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 C=
ategories:=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
&gt;=C2=A0 =C2=A0 Types:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4273=C2=
=A0 =C2=A0 Attributes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 295<br>
&gt;=C2=A0 =C2=A0 Users:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A09=C2=A0 =C2=A0 Roles:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 12<br>
&gt;=C2=A0 =C2=A0 Booleans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 234=C2=A0 =C2=
=A0 Cond. Expr.:=C2=A0 =C2=A0 =C2=A0 =C2=A0274<br>
&gt;=C2=A0 =C2=A0 Allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 352554=C2=A0 =C2=
=A0 Neverallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0 Auditallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 140=C2=A0 =C2=A0 D=
ontaudit:=C2=A0 =C2=A0 =C2=A0 321786<br>
&gt;=C2=A0 =C2=A0 Type_trans:=C2=A0 =C2=A0 =C2=A0 42813=C2=A0 =C2=A0 Type_c=
hange:=C2=A0 =C2=A0 =C2=A0 =C2=A0 38<br>
&gt;=C2=A0 =C2=A0 Type_member:=C2=A0 =C2=A0 =C2=A0 =C2=A0 48=C2=A0 =C2=A0 R=
ole allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A019<br>
&gt;=C2=A0 =C2=A0 Role_trans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 409=C2=A0 =C2=A0 R=
ange_trans:=C2=A0 =C2=A0 =C2=A0 6421<br>
&gt;=C2=A0 =C2=A0 Constraints:=C2=A0 =C2=A0 =C2=A0 =C2=A0 90=C2=A0 =C2=A0 V=
alidatetrans:=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0 Initial SIDs:=C2=A0 =C2=A0 =C2=A0 =C2=A027=C2=A0 =C2=A0 F=
s_use:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023<br>
&gt;=C2=A0 =C2=A0 Genfscon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A084=C2=
=A0 =C2=A0 Portcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0505<br>
&gt;=C2=A0 =C2=A0 Netifcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=
=A0 =C2=A0 Nodecon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0 Permissives:=C2=A0 =C2=A0 =C2=A0 =C2=A0 91=C2=A0 =C2=A0 P=
olcap:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
<br>
</div></div>I don&#39;t have any useful input but just an unrelated observa=
tion: you<br>
almost have as many dontaudit rules as you have allow rules. I would not<br=
>
be surprised if that were to be somehow related.<br>
<div><div class=3D"h5"><br>
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
&gt;=C2=A0 =C2=A0 Classes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 81=C2=
=A0 =C2=A0 Permissions:=C2=A0 =C2=A0 =C2=A0 =C2=A0238<br>
&gt;=C2=A0 =C2=A0 Sensitivities:=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 C=
ategories:=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
&gt;=C2=A0 =C2=A0 Types:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3926=C2=
=A0 =C2=A0 Attributes:=C2=A0 =C2=A0 =C2=A0 =C2=A0 295<br>
&gt;=C2=A0 =C2=A0 Users:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A09=C2=A0 =C2=A0 Roles:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 12<br>
&gt;=C2=A0 =C2=A0 Booleans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 234=C2=A0 =C2=
=A0 Cond. Expr.:=C2=A0 =C2=A0 =C2=A0 =C2=A0274<br>
&gt;=C2=A0 =C2=A0 Allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 320969=C2=A0 =C2=
=A0 Neverallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0 Auditallow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 140=C2=A0 =C2=A0 D=
ontaudit:=C2=A0 =C2=A0 =C2=A0 273256<br>
&gt;=C2=A0 =C2=A0 Type_trans:=C2=A0 =C2=A0 =C2=A0 41915=C2=A0 =C2=A0 Type_c=
hange:=C2=A0 =C2=A0 =C2=A0 =C2=A0 38<br>
&gt;=C2=A0 =C2=A0 Type_member:=C2=A0 =C2=A0 =C2=A0 =C2=A0 48=C2=A0 =C2=A0 R=
ole allow:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A019<br>
&gt;=C2=A0 =C2=A0 Role_trans:=C2=A0 =C2=A0 =C2=A0 =C2=A0 386=C2=A0 =C2=A0 R=
ange_trans:=C2=A0 =C2=A0 =C2=A0 6069<br>
&gt;=C2=A0 =C2=A0 Constraints:=C2=A0 =C2=A0 =C2=A0 =C2=A0 90=C2=A0 =C2=A0 V=
alidatetrans:=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0 Initial SIDs:=C2=A0 =C2=A0 =C2=A0 =C2=A027=C2=A0 =C2=A0 F=
s_use:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023<br>
&gt;=C2=A0 =C2=A0 Genfscon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A084=C2=
=A0 =C2=A0 Portcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0479<br>
&gt;=C2=A0 =C2=A0 Netifcon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=
=A0 =C2=A0 Nodecon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0 Permissives:=C2=A0 =C2=A0 =C2=A0 =C2=A0 91=C2=A0 =C2=A0 P=
olcap:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
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
<br>
</div></div>&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<br>
<br>
- --<br>
02DFF788<br>
4D30 903A 1CF3 B756 FB48=C2=A0 1514 3148 83A2 02DF F788<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x31=
4883A202DFF788" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/pks/lookup?op=3Dget&amp;search=3D0x314883A202DFF788</a><br>
Dominick Grift<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2<br>
<br>
iQGcBAEBCgAGBQJWZrSWAAoJENAR6kfG5xmctzkMALax9f+yHvM9hiH/RFgf4JMH<br>
2avyWCkJggce+DilkHLGuhAZe0yMJW/h4WryF/a93y52q/09l/vYpa4oEShhrasD<br>
dsOmCOINVW77E6TyWMuv80hYywPoXft+h3XIIgLO9FrURCJoCNlY7WGEpuVIy9PF<br>
fxk6dxSov4yxxVGnEFW43X8SZ9haypuTiq3DkfvCVTbfeEs1xYu5j2vQ2Ghi0BN0<br>
N9JdiLiPBBjAZo4O6VFkfgJ3Jt+EfyYuImcL3EhKmOc7c+vTtggc3VEamaSRXnhY<br>
oXYUnKEqDraaJ7kizgODntPw79YRVpVqpaRipArZq96Qjq9loH/3RsG9DEyRTBgR<br>
f3VH63L0URGeA7O/qWQmjiHro8ZgZvmKdfnRWtnwtUCfHmaGU8r8rDgWHReC42HD<br>
FeRn+ymouSp0JDfq9wg3Nbk8R5z/FF4qIk4NpUNIm4KWRREbYQnkTjhMwN3hepg4<br>
ikMHBdfUP/coPw1kPJtCwYNtwcv+z1D1XbRBiU/icQ=3D=3D<br>
=3D41nB<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--089e015386084d46550526642e80--
