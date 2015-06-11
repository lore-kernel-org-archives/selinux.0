MIME-Version: 1.0
In-Reply-To: <CAHC9VhR1NbLkaXRY8Up0DT_onxFe05Xr87ddRMBXTUkA4QvyLQ@mail.gmail.com>
References: <008e01d0a431$3c777980$b5666c80$@gmail.com>
 <557983AD.1040706@tycho.nsa.gov>
 <00b901d0a449$0988c2f0$1c9a48d0$@gmail.com>
 <CA+SaE3uawE6VSKiDTeh-dayVnjWzK=DzqQ9Ju5YtN1m_uyuAiQ@mail.gmail.com>
 <CAHC9VhR1NbLkaXRY8Up0DT_onxFe05Xr87ddRMBXTUkA4QvyLQ@mail.gmail.com>
Date: Thu, 11 Jun 2015 22:47:31 +0200
Message-ID: <CA+SaE3t=02nZnoM=K2cd+1MyPo74QZHvYwv+5Shr0+LpLFUGBA@mail.gmail.com>
Subject: Re: SELinux: Interface Labeling Problem
From: Maurizio Pagani <pag.maurizio@gmail.com>
To: Paul Moore <paul@paul-moore.com>, selinux@lists.fedoraproject.org,
 Selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b624dd8b07dfd05184419b6
Cc: "james.l.morris@oracle.com" <james.l.morris@oracle.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b624dd8b07dfd05184419b6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ok, imattached also the community on this thread.

Please someone can help me?

Thanksa

Il gioved=C3=AC 11 giugno 2015, Paul Moore <paul@paul-moore.com> ha scritto=
:

> On Thu, Jun 11, 2015 at 4:22 PM, Maurizio Pagani <pag.maurizio@gmail.com
> <javascript:;>> wrote:
> > Any idea??? Please is important.
>
> As Stephen already mentioned, please repost your question to the
> mailing list so that others can benefit.
>
> > Il gioved=C3=AC 11 giugno 2015, Gmail <pag.maurizio@gmail.com <javascri=
pt:;>>
> ha scritto:
> >>
> >> Hi Stephen,
> >>
> >> ok, but with peer labeling i saw that is not possible block a specific
> >> domain to use an interface labeled with netif_hostonly_t, right? If
> not, how
> >> can i block a specific domain, to use my network interface?
> >>
> >> However the next questions, i'll write to distribution list
> >>
> >> Thanks in advance,
> >>
> >>
> >>
> >>
> >>                      Maurizio Pagani
> >>             Systems and Security Specialist
> >>
> >>
> >>                    Kay Systems Italia
> >>                           www.ksi.it
> >>              Viale Libano , 80 - 00144 Roma
> >>                  fax:  +39 06  542799-60
> >>                  mobile:  +39 335 1382689
> >>              e-mail: maurizio.pagani@ksi.it <javascript:;>
> >>
> >> -----Messaggio originale-----
> >> Da: Stephen Smalley [mailto:sds@tycho.nsa.gov <javascript:;>]
> >> Inviato: gioved=C3=AC 11 giugno 2015 14:49
> >> A: Gmail; paul@paul-moore.com <javascript:;>; james.l.morris@oracle.co=
m
> <javascript:;>; 'Daniel J
> >> Walsh'; 'Dominick Grift'; 'Sven Vermeulen'; eparis@parisplace.org
> <javascript:;>
> >> Oggetto: Re: SELinux: Interface Labeling Problem
> >>
> >> Is there a reason you didn't post this to selinux list
> >> (selinux@tycho.nsa.gov <javascript:;>, subscribe via
> selinux-join@tycho.nsa.gov <javascript:;>)?
> >> We prefer questions to go to the list so that they are archived for
> others
> >> and anyone in the community can respond to them.
> >>
> >> In any event, SELinux network permission checks have changed over time=
.
> >> The netif { tcp_recv tcp_send udp_recv udp_send } checks were legacy
> >> network checks that were removed in Linux 2.6.30.  netif { ingress
> egress }
> >> are newer checks that are only enabled if you have configured peer
> labeling
> >> via NetLabel or labeled IPSEC/xfrm.
> >>
> >> On 06/11/2015 06:27 AM, Gmail wrote:
> >> > Hi everybody
> >> >
> >> >
> >> >
> >> > I=E2=80=99m Maurizio Pagani (LordFire in #SELinux IRC freenode).
> >> >
> >> > I write to you, because i=E2=80=99m implementing a SELinux solution =
with
> >> > particular attention about Network Labeling.
> >> >
> >> > I=E2=80=99m doing this trough some blog(Paul Moore in particular, Wa=
lsh and
> >> > other) and books (Sven Vermeulen), but now i=E2=80=99m blocked in a =
little
> >> > problem that cannot permit me to go on.
> >> >
> >> >
> >> >
> >> > The subject is : *=E2=80=9CInterface Labeling=E2=80=9D.*
> >> >
> >> >
> >> >
> >> > In few words i created a very simple policy called
> >> > *=E2=80=9Cnetif_hostonly_t=E2=80=9D* the .te is this:
> >> >
> >> >
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > policy_module(netif_hostonly, 1.0.0)
> >> >
> >> >
> >> >
> >> > require {
> >> >
> >> >         type unconfined_t;
> >> >
> >> >         class netif { tcp_recv tcp_send udp_recv udp_send ingress
> >> > egress } ;
> >> >
> >> > }
> >> >
> >> >
> >> >
> >> > #I declare my type
> >> >
> >> > type netif_hostonly_t;
> >> >
> >> >
> >> >
> >> > allow unconfined_t netif_hostonly_t : netif { tcp_recv tcp_send
> >> > udp_recv udp_send ingress egress } ;
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > *Next Step:*
> >> >
> >> >
> >> >
> >> > semanage interface -a -t netif_hostonly_t eno50332208
> >> >
> >> >
> >> >
> >> > I checked that is labeled correctly
> >> >
> >> >
> >> >
> >> > But i don=E2=80=99t see any avc denied messages, this is the problem=
, i though
> >> > that as always, SELinux block everything and after trough RAW SELinu=
x
> >> > language (allow/dontaudit/auditallow/neverallow), we can open specif=
ic
> >> > communications, but instead i don=E2=80=99t see anything.
> >> >
> >> > I=E2=80=99m wron something? It is not very clear on the web, or in t=
he other
> >> > blogs / books, because maybe i need of a SECMARK rule? But is not
> >> > specific as a requirement, because also =E2=80=9Cport labeling=E2=80=
=9D is used
> >> > without set SECMARK rule.
> >> >
> >> >
> >> >
> >> > Please i=E2=80=99m blocked with my customer project, for this (i thi=
nk) stupid
> >> > problem, maybe you know surely the solution, and can share with me.
> >> >
> >> >
> >> >
> >> > Thanks in advace,
> >> >
> >> >
> >> >
> >> > Maurizio Pagani
> >> >
> >> >
> >> >
> >> >
> ------------------------------------------------------------------------
> >> > Avast logo <https://www.avast.com/antivirus>
> >> >
> >> > Questa e-mail =C3=A8 stata controllata per individuare virus con Ava=
st
> >> > antivirus.
> >> > www.avast.com <https://www.avast.com/antivirus>
> >> >
> >> >
> >>
> >>
> >>
> >> ---
> >> Questa e-mail =C3=A8 stata controllata per individuare virus con Avast
> >> antivirus.
> >> https://www.avast.com/antivirus
> >>
> >
>
>
>
> --
> paul moore
> www.paul-moore.com
>

--047d7b624dd8b07dfd05184419b6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ok, imattached also the community on this thread.<div><br></div><div>Please=
 someone can help me?=C2=A0</div><div><br></div><div>Thanksa<br><br>Il giov=
ed=C3=AC 11 giugno 2015, Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.c=
om">paul@paul-moore.com</a>&gt; ha scritto:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On Thu, Jun 11, 2015 at 4:22 PM, Maurizio Pagani &lt;<a href=3D"javascri=
pt:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;pag.maurizio@gmail.com&#39;=
)">pag.maurizio@gmail.com</a>&gt; wrote:<br>
&gt; Any idea??? Please is important.<br>
<br>
As Stephen already mentioned, please repost your question to the<br>
mailing list so that others can benefit.<br>
<br>
&gt; Il gioved=C3=AC 11 giugno 2015, Gmail &lt;<a href=3D"javascript:;" onc=
lick=3D"_e(event, &#39;cvml&#39;, &#39;pag.maurizio@gmail.com&#39;)">pag.ma=
urizio@gmail.com</a>&gt; ha scritto:<br>
&gt;&gt;<br>
&gt;&gt; Hi Stephen,<br>
&gt;&gt;<br>
&gt;&gt; ok, but with peer labeling i saw that is not possible block a spec=
ific<br>
&gt;&gt; domain to use an interface labeled with netif_hostonly_t, right? I=
f not, how<br>
&gt;&gt; can i block a specific domain, to use my network interface?<br>
&gt;&gt;<br>
&gt;&gt; However the next questions, i&#39;ll write to distribution list<br=
>
&gt;&gt;<br>
&gt;&gt; Thanks in advance,<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Maurizio Pagani<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Systems and Securit=
y Specialist<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Kay Systems Italia<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.ksi.it" target=3D"_bla=
nk">www.ksi.it</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Viale Libano , 80 =
- 00144 Roma<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fax:=
=C2=A0 +39 06=C2=A0 542799-60<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mobi=
le:=C2=A0 +39 335 1382689<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e-mail: <a href=3D=
"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;maurizio.pagani@ks=
i.it&#39;)">maurizio.pagani@ksi.it</a><br>
&gt;&gt;<br>
&gt;&gt; -----Messaggio originale-----<br>
&gt;&gt; Da: Stephen Smalley [mailto:<a href=3D"javascript:;" onclick=3D"_e=
(event, &#39;cvml&#39;, &#39;sds@tycho.nsa.gov&#39;)">sds@tycho.nsa.gov</a>=
]<br>
&gt;&gt; Inviato: gioved=C3=AC 11 giugno 2015 14:49<br>
&gt;&gt; A: Gmail; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&=
#39;, &#39;paul@paul-moore.com&#39;)">paul@paul-moore.com</a>; <a href=3D"j=
avascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;james.l.morris@oracl=
e.com&#39;)">james.l.morris@oracle.com</a>; &#39;Daniel J<br>
&gt;&gt; Walsh&#39;; &#39;Dominick Grift&#39;; &#39;Sven Vermeulen&#39;; <a=
 href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;eparis@par=
isplace.org&#39;)">eparis@parisplace.org</a><br>
&gt;&gt; Oggetto: Re: SELinux: Interface Labeling Problem<br>
&gt;&gt;<br>
&gt;&gt; Is there a reason you didn&#39;t post this to selinux list<br>
&gt;&gt; (<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#3=
9;selinux@tycho.nsa.gov&#39;)">selinux@tycho.nsa.gov</a>, subscribe via <a =
href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;selinux-joi=
n@tycho.nsa.gov&#39;)">selinux-join@tycho.nsa.gov</a>)?<br>
&gt;&gt; We prefer questions to go to the list so that they are archived fo=
r others<br>
&gt;&gt; and anyone in the community can respond to them.<br>
&gt;&gt;<br>
&gt;&gt; In any event, SELinux network permission checks have changed over =
time.<br>
&gt;&gt; The netif { tcp_recv tcp_send udp_recv udp_send } checks were lega=
cy<br>
&gt;&gt; network checks that were removed in Linux 2.6.30.=C2=A0 netif { in=
gress egress }<br>
&gt;&gt; are newer checks that are only enabled if you have configured peer=
 labeling<br>
&gt;&gt; via NetLabel or labeled IPSEC/xfrm.<br>
&gt;&gt;<br>
&gt;&gt; On 06/11/2015 06:27 AM, Gmail wrote:<br>
&gt;&gt; &gt; Hi everybody<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I=E2=80=99m Maurizio Pagani (LordFire in #SELinux IRC freenod=
e).<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I write to you, because i=E2=80=99m implementing a SELinux so=
lution with<br>
&gt;&gt; &gt; particular attention about Network Labeling.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I=E2=80=99m doing this trough some blog(Paul Moore in particu=
lar, Walsh and<br>
&gt;&gt; &gt; other) and books (Sven Vermeulen), but now i=E2=80=99m blocke=
d in a little<br>
&gt;&gt; &gt; problem that cannot permit me to go on.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The subject is : *=E2=80=9CInterface Labeling=E2=80=9D.*<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; In few words i created a very simple policy called<br>
&gt;&gt; &gt; *=E2=80=9Cnetif_hostonly_t=E2=80=9D* the .te is this:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; policy_module(netif_hostonly, 1.0.0)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; require {<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type unconfined_t;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0class netif { tcp_recv tcp_s=
end udp_recv udp_send ingress<br>
&gt;&gt; &gt; egress } ;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; #I declare my type<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; type netif_hostonly_t;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; allow unconfined_t netif_hostonly_t : netif { tcp_recv tcp_se=
nd<br>
&gt;&gt; &gt; udp_recv udp_send ingress egress } ;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; *Next Step:*<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; semanage interface -a -t netif_hostonly_t eno50332208<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I checked that is labeled correctly<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But i don=E2=80=99t see any avc denied messages, this is the =
problem, i though<br>
&gt;&gt; &gt; that as always, SELinux block everything and after trough RAW=
 SELinux<br>
&gt;&gt; &gt; language (allow/dontaudit/auditallow/neverallow), we can open=
 specific<br>
&gt;&gt; &gt; communications, but instead i don=E2=80=99t see anything.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I=E2=80=99m wron something? It is not very clear on the web, =
or in the other<br>
&gt;&gt; &gt; blogs / books, because maybe i need of a SECMARK rule? But is=
 not<br>
&gt;&gt; &gt; specific as a requirement, because also =E2=80=9Cport labelin=
g=E2=80=9D is used<br>
&gt;&gt; &gt; without set SECMARK rule.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Please i=E2=80=99m blocked with my customer project, for this=
 (i think) stupid<br>
&gt;&gt; &gt; problem, maybe you know surely the solution, and can share wi=
th me.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks in advace,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Maurizio Pagani<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -------------------------------------------------------------=
-----------<br>
&gt;&gt; &gt; Avast logo &lt;<a href=3D"https://www.avast.com/antivirus" ta=
rget=3D"_blank">https://www.avast.com/antivirus</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Questa e-mail =C3=A8 stata controllata per individuare virus =
con Avast<br>
&gt;&gt; &gt; antivirus.<br>
&gt;&gt; &gt; <a href=3D"http://www.avast.com" target=3D"_blank">www.avast.=
com</a> &lt;<a href=3D"https://www.avast.com/antivirus" target=3D"_blank">h=
ttps://www.avast.com/antivirus</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; Questa e-mail =C3=A8 stata controllata per individuare virus con A=
vast<br>
&gt;&gt; antivirus.<br>
&gt;&gt; <a href=3D"https://www.avast.com/antivirus" target=3D"_blank">http=
s://www.avast.com/antivirus</a><br>
&gt;&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" target=3D"_blank">www.paul-moore.com<=
/a><br>
</blockquote></div>

--047d7b624dd8b07dfd05184419b6--
