Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8F6HAV005938
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 10:06:17 -0500
Subject: Re: Performance issues - huge amount of AVC misses
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>, selinux@tycho.nsa.gov
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
 <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <5666F1D2.5010701@redhat.com>
Date: Tue, 8 Dec 2015 10:05:54 -0500
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-28272-1449587157-0001-2"
In-Reply-To: <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-28272-1449587157-0001-2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

How are you defining your dontaudit rules?  It is a bad idea to use the
"-" sign.

dontaudit {domain -nissdomain} self:process kill;

Or something like that causes hundreds (Thousands) of rules to be added. 

If you could somehow clean this up to use an attribute like

dontaudit domainswithoutnis self:process kill

Would add one rule.

On 12/08/2015 09:56 AM, Michal Marciniszyn wrote:
> Hi Dominic, > > while there is quite a lot of dontaudit rules around, the amount
for domains running on this node is not high. Is there any way how to
monitor which rules are loaded and released from the cache? Anything
better than plain aggregated stats? We would bot care about performance
of such monitoring tool if it provides some useful answer. For instance,
is there a way how to use system tap or similar kernel profiling to get
the data? > > I'll do a profiling on how many rules actually apply for
the domains on the node (i.e. use sesearch to find out). If doing so,
does the rule in cache hold whole vector (i.e. A is allowed to do X, Y,
Z on B or is one cache entry A can do X on B)? > > Thanks, > > --michal
> > On Tue, Dec 8, 2015 at 11:44 AM, Dominick Grift
<dac.override@gmail.com <mailto:dac.override@gmail.com>> wrote: >
> On Tue, Dec 08, 2015 at 11:25:40AM +0100, Michal Marciniszyn wrote:
> > Hello,
>
> > we are heavy SELinux shop and we recently run into AVC related
> performance
> > issue. I was trying to find an answer on freenode IRC chat but I was
> sent
> > here by multiple guys. We're running on Scientific Linux 6.6 (upgrade to
> > 6.7 ongoing) and we see this on some of our nodes:
>
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
>
> > Also we see
>
> > # cat /selinux/avc/hash_stats
> > entries: 499
> > buckets used: 257/512
> > longest chain: 6
>
> > Some times under load we see SELinux consuming about 30% of CPU
> time. There
> > is about 16% of cache misses on these nodes (and sometimes it goes
> as high
> > as 30%). The lates article about the issue is from RHEL 5 times -
> >
> https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
> > . We do not feel this to be too relevant in this case.
>
> > Are there any recommendations on cache sizing for SELinux? We can resize
> > cache to 1024 or 2048 entries, but would this help to resolve the issue?
>
> > I'm attaching seinfo from node with our policy and then for
> comparison from
> > node without any policy.
>
> > With policy:
> > # seinfo
>
> > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> > Policy Version & Type: v.24 (binary, mls)
>
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
>
>
>
> > Without policy:
>
> > seinfo
>
> > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> > Policy Version & Type: v.24 (binary, mls)
>
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
>
>
> > Any help or guidance would be very much appreciated, if there is more
> > in-depth info needed I'll be more than happy to provide it.
>
> > Yours sincerely,
>
> > Michal Marciniszyn
> > Manager - SW Engineering
> > GoodData
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
> <mailto:Selinux-leave@tycho.nsa.gov>.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>
>
> > > > > _______________________________________________ > Selinux
mailing list > Selinux@tycho.nsa.gov > To unsubscribe, send email to
Selinux-leave@tycho.nsa.gov. > To get help, send an email containing
"help" to Selinux-request@tycho.nsa.gov.



--=_Boundary-28272-1449587157-0001-2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    How are you defining your dontaudit rules?=A0 It is a bad idea to us=
e
    the "-" sign.<br>
    <br>
    dontaudit {domain -nissdomain} self:process kill;<br>
    <br>
    Or something like that causes hundreds (Thousands) of rules to be
    added.=A0 <br>
    <br>
    If you could somehow clean this up to use an attribute like<br>
    <br>
    dontaudit domainswithoutnis self:process kill<br>
    <br>
    Would add one rule.<br>
    <br>
    On 12/08/2015 09:56 AM, Michal Marciniszyn wrote:<br>
    <span style=3D"white-space: pre;">&gt; Hi Dominic,
&gt;
&gt; while there is quite a lot of dontaudit rules around, the amount fo=
r domains running on this node is not high. Is there any way how to moni=
tor which rules are loaded and released from the cache? Anything better =
than plain aggregated stats? We would bot care about performance of such=
 monitoring tool if it provides some useful answer. For instance, is the=
re a way how to use system tap or similar kernel profiling to get the da=
ta?
&gt;
&gt; I'll do a profiling on how many rules actually apply for the domain=
s on the node (i.e. use sesearch to find out). If doing so, does the rul=
e in cache hold whole vector (i.e. A is allowed to do X, Y, Z on B or is=
 one cache entry A can do X on B)?
&gt;
&gt; Thanks,
&gt;
&gt; --michal
&gt;
&gt; On Tue, Dec 8, 2015 at 11:44 AM, Dominick Grift &lt;<a class=3D"moz=
-txt-link-abbreviated" href=3D"mailto:dac.override@gmail.com">dac.overri=
de@gmail.com</a> <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:dac.o=
verride@gmail.com">&lt;mailto:dac.override@gmail.com&gt;</a>&gt; wrote:
&gt;</span><br>
    <blockquote type=3D"cite">On Tue, Dec 08, 2015 at 11:25:40AM +0100,
      Michal Marciniszyn wrote:<br>
      &gt; Hello,<br>
      <br>
      &gt; we are heavy SELinux shop and we recently run into AVC
      related performance<br>
      &gt; issue. I was trying to find an answer on freenode IRC chat
      but I was sent<br>
      &gt; here by multiple guys. We're running on Scientific Linux 6.6
      (upgrade to<br>
      &gt; 6.7 ongoing) and we see this on some of our nodes:<br>
      <br>
      &gt; # cat /selinux/avc/cache_stats<br>
      &gt; lookups hits misses allocations reclaims frees<br>
      &gt; 3976846641 3626568307 350278334 350303465 344833264 346344169=
<br>
      &gt; 3474274460 3092218096 382056364 382081270 381170512 382671551=
<br>
      &gt; 2037181411 1655679702 381501709 381527148 380680320 382162477=
<br>
      &gt; 1943162363 1651603455 291558908 291584892 288099840 289631602=
<br>
      &gt; 829213467 406079951 423133516 423158604 422311024 423847681<b=
r>
      &gt; 1963015875 1555848944 407166931 407192104 406718592 408227742=
<br>
      &gt; 3490131033 3117047653 373083380 373108386 372270880 373862706=
<br>
      &gt; 940880689 549698684 391182005 391207388 390339328 391888374<b=
r>
      &gt; 4098417807 3712068859 386348948 386373592 385604096 387172806=
<br>
      &gt; 3931378773 3549502965 381875808 381901074 381059904 382628308=
<br>
      <br>
      &gt; Also we see<br>
      <br>
      &gt; # cat /selinux/avc/hash_stats<br>
      &gt; entries: 499<br>
      &gt; buckets used: 257/512<br>
      &gt; longest chain: 6<br>
      <br>
      &gt; Some times under load we see SELinux consuming about 30% of
      CPU time. There<br>
      &gt; is about 16% of cache misses on these nodes (and sometimes it
      goes as high<br>
      &gt; as 30%). The lates article about the issue is from RHEL 5
      times -<br>
      &gt;
<a class=3D"moz-txt-link-freetext" href=3D"https://access.redhat.com/doc=
umentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon=
-section-0102.html">https://access.redhat.com/documentation/en-US/Red_Ha=
t_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html</a><=
br>
      &gt; . We do not feel this to be too relevant in this case.<br>
      <br>
      &gt; Are there any recommendations on cache sizing for SELinux? We
      can resize<br>
      &gt; cache to 1024 or 2048 entries, but would this help to resolve
      the issue?<br>
      <br>
      &gt; I'm attaching seinfo from node with our policy and then for
      comparison from<br>
      &gt; node without any policy.<br>
      <br>
      &gt; With policy:<br>
      &gt; # seinfo<br>
      <br>
      &gt; Statistics for policy file:
      /etc/selinux/targeted/policy/policy.24<br>
      &gt; Policy Version &amp; Type: v.24 (binary, mls)<br>
      <br>
      &gt;=A0=A0=A0 Classes:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 81=A0=A0=A0=
 Permissions:=A0=A0=A0=A0=A0=A0 238<br>
      &gt;=A0=A0=A0 Sensitivities:=A0=A0=A0=A0=A0=A0 1=A0=A0=A0 Categori=
es:=A0=A0=A0=A0=A0=A0 1024<br>
      &gt;=A0=A0=A0 Types:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4273=A0=A0=A0=
 Attributes:=A0=A0=A0=A0=A0=A0=A0 295<br>
      &gt;=A0=A0=A0 Users:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9=A0=
=A0=A0 Roles:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12<br>
      &gt;=A0=A0=A0 Booleans:=A0=A0=A0=A0=A0=A0=A0=A0=A0 234=A0=A0=A0 Co=
nd. Expr.:=A0=A0=A0=A0=A0=A0 274<br>
      &gt;=A0=A0=A0 Allow:=A0=A0=A0=A0=A0=A0=A0=A0=A0 352554=A0=A0=A0 Ne=
verallow:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br>
      &gt;=A0=A0=A0 Auditallow:=A0=A0=A0=A0=A0=A0=A0 140=A0=A0=A0 Dontau=
dit:=A0=A0=A0=A0=A0 321786<br>
      &gt;=A0=A0=A0 Type_trans:=A0=A0=A0=A0=A0 42813=A0=A0=A0 Type_chang=
e:=A0=A0=A0=A0=A0=A0=A0 38<br>
      &gt;=A0=A0=A0 Type_member:=A0=A0=A0=A0=A0=A0=A0 48=A0=A0=A0 Role a=
llow:=A0=A0=A0=A0=A0=A0=A0=A0 19<br>
      &gt;=A0=A0=A0 Role_trans:=A0=A0=A0=A0=A0=A0=A0 409=A0=A0=A0 Range_=
trans:=A0=A0=A0=A0=A0 6421<br>
      &gt;=A0=A0=A0 Constraints:=A0=A0=A0=A0=A0=A0=A0 90=A0=A0=A0 Valida=
tetrans:=A0=A0=A0=A0=A0=A0 0<br>
      &gt;=A0=A0=A0 Initial SIDs:=A0=A0=A0=A0=A0=A0 27=A0=A0=A0 Fs_use:=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 23<br>
      &gt;=A0=A0=A0 Genfscon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 84=A0=A0=A0 =
Portcon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 505<br>
      &gt;=A0=A0=A0 Netifcon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
 Nodecon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br>
      &gt;=A0=A0=A0 Permissives:=A0=A0=A0=A0=A0=A0=A0 91=A0=A0=A0 Polcap=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2<br>
      <br>
      I don't have any useful input but just an unrelated observation:
      you<br>
      almost have as many dontaudit rules as you have allow rules. I
      would not<br>
      be surprised if that were to be somehow related.<br>
      <br>
      <br>
      <br>
      <br>
      &gt; Without policy:<br>
      <br>
      &gt; seinfo<br>
      <br>
      &gt; Statistics for policy file:
      /etc/selinux/targeted/policy/policy.24<br>
      &gt; Policy Version &amp; Type: v.24 (binary, mls)<br>
      <br>
      &gt;=A0=A0=A0 Classes:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 81=A0=A0=A0=
 Permissions:=A0=A0=A0=A0=A0=A0 238<br>
      &gt;=A0=A0=A0 Sensitivities:=A0=A0=A0=A0=A0=A0 1=A0=A0=A0 Categori=
es:=A0=A0=A0=A0=A0=A0 1024<br>
      &gt;=A0=A0=A0 Types:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3926=A0=A0=A0=
 Attributes:=A0=A0=A0=A0=A0=A0=A0 295<br>
      &gt;=A0=A0=A0 Users:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9=A0=
=A0=A0 Roles:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12<br>
      &gt;=A0=A0=A0 Booleans:=A0=A0=A0=A0=A0=A0=A0=A0=A0 234=A0=A0=A0 Co=
nd. Expr.:=A0=A0=A0=A0=A0=A0 274<br>
      &gt;=A0=A0=A0 Allow:=A0=A0=A0=A0=A0=A0=A0=A0=A0 320969=A0=A0=A0 Ne=
verallow:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br>
      &gt;=A0=A0=A0 Auditallow:=A0=A0=A0=A0=A0=A0=A0 140=A0=A0=A0 Dontau=
dit:=A0=A0=A0=A0=A0 273256<br>
      &gt;=A0=A0=A0 Type_trans:=A0=A0=A0=A0=A0 41915=A0=A0=A0 Type_chang=
e:=A0=A0=A0=A0=A0=A0=A0 38<br>
      &gt;=A0=A0=A0 Type_member:=A0=A0=A0=A0=A0=A0=A0 48=A0=A0=A0 Role a=
llow:=A0=A0=A0=A0=A0=A0=A0=A0 19<br>
      &gt;=A0=A0=A0 Role_trans:=A0=A0=A0=A0=A0=A0=A0 386=A0=A0=A0 Range_=
trans:=A0=A0=A0=A0=A0 6069<br>
      &gt;=A0=A0=A0 Constraints:=A0=A0=A0=A0=A0=A0=A0 90=A0=A0=A0 Valida=
tetrans:=A0=A0=A0=A0=A0=A0 0<br>
      &gt;=A0=A0=A0 Initial SIDs:=A0=A0=A0=A0=A0=A0 27=A0=A0=A0 Fs_use:=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 23<br>
      &gt;=A0=A0=A0 Genfscon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 84=A0=A0=A0 =
Portcon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 479<br>
      &gt;=A0=A0=A0 Netifcon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
 Nodecon:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br>
      &gt;=A0=A0=A0 Permissives:=A0=A0=A0=A0=A0=A0=A0 91=A0=A0=A0 Polcap=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2<br>
      <br>
      <br>
      &gt; Any help or guidance would be very much appreciated, if there
      is more<br>
      &gt; in-depth info needed I'll be more than happy to provide it.<b=
r>
      <br>
      &gt; Yours sincerely,<br>
      <br>
      &gt; Michal Marciniszyn<br>
      &gt; Manager - SW Engineering<br>
      &gt; GoodData<br>
      <br>
      &gt; _______________________________________________<br>
      &gt; Selinux mailing list<br>
      &gt; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@=
tycho.nsa.gov">Selinux@tycho.nsa.gov</a> <a class=3D"moz-txt-link-rfc239=
6E" href=3D"mailto:Selinux@tycho.nsa.gov">&lt;mailto:Selinux@tycho.nsa.g=
ov&gt;</a><br>
      &gt; To unsubscribe, send email to <a class=3D"moz-txt-link-abbrev=
iated" href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.n=
sa.gov</a>
      <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Selinux-leave@ty=
cho.nsa.gov">&lt;mailto:Selinux-leave@tycho.nsa.gov&gt;</a>.<br>
      &gt; To get help, send an email containing "help" to
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux-reque=
st@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>
      <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Selinux-request@=
tycho.nsa.gov">&lt;mailto:Selinux-request@tycho.nsa.gov&gt;</a>.<br>
      <br>
      <br>
    </blockquote>
    <span style=3D"white-space: pre;">&gt;
&gt;
&gt;
&gt;
&gt; _______________________________________________
&gt; Selinux mailing list
&gt; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.=
nsa.gov">Selinux@tycho.nsa.gov</a>
&gt; To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated"=
 href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov=
</a>.
&gt; To get help, send an email containing "help" to <a class=3D"moz-txt=
-link-abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux=
-request@tycho.nsa.gov</a>.</span><br>
    <br>
    <br>
  </body>
</html>

--=_Boundary-28272-1449587157-0001-2--
