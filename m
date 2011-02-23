Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1N2sZsw002319
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 21:54:35 -0500
Received: from mail-yw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1N2sYkO008326
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 02:54:34 GMT
Received: by ywl2 with SMTP id 2so930951ywl.12
        for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 18:54:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D643523.7040907@itechfrontiers.com>
References: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>
	<4D45E42A.80303@research.telcordia.com>
	<4D4604DB.3060402@itechfrontiers.com>
	<4D63EA14.2080701@itechfrontiers.com>
	<4D63F01E.70903@research.telcordia.com>
	<4D63F5A9.3000301@itechfrontiers.com>
	<4D63F854.3030907@itechfrontiers.com>
	<AANLkTikoywS7qNGgwY7cE20y4PpeF7fja3vxEtRiVjAJ@mail.gmail.com>
	<4D643523.7040907@itechfrontiers.com>
Date: Tue, 22 Feb 2011 18:54:34 -0800
Message-ID: <AANLkTikKu4P866h+U3JeTMtjynxt_uOYEFyOn6V_Lgw+@mail.gmail.com>
Subject: Re: SELinux and Stuxnet
From: Ethan Heidrick <ethanheidrick@gmail.com>
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
Cc: Sanjai Narain <narain@research.telcordia.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd6acd87f542d049cea37e1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd6acd87f542d049cea37e1
Content-Type: text/plain; charset=ISO-8859-1

The policies that are written are concerned with architecture based
penetration of an interconnecting tree (kernal), where SeLinux is concerned,
What "blocks" of code would be advantageous for an attacker concerned with
such penetration techniques such as key functions {algorithms} and  data
compression encryption taking advantage of the communication of processes in
the tree?


On Tue, Feb 22, 2011 at 2:13 PM, cto@itechfrontiers.com <
cto@itechfrontiers.com> wrote:

> Ethan,
>
> What are you talking about?
>
>
> Patrick K.
>
>
> On 2/22/2011 4:47 PM, Ethan Heidrick wrote:
>
>> IE: infrastructure is process based on detecting such side channeling
>> attacks excuse the pun, but revising SeLinux security authorization if
>> that is what you are suggesting would create an independent node of
>> programmable patches directed specific technique.
>>
>> Where would an node discrimination in the coding be "hazardous" for such
>> red team analysis for penetration?
>>
>> On Tue, Feb 22, 2011 at 9:54 AM, cto@itechfrontiers.com
>> <mailto:cto@itechfrontiers.com> <cto@itechfrontiers.com
>>
>> <mailto:cto@itechfrontiers.com>> wrote:
>>
>>    Need to add it myself, that human being is also error-prone,
>>
>>    i.e. last message I meant "waives" and wrote "waves"
>>
>>    such errors happen even in development, in software and in security
>>
>>
>>
>>    On 2/22/2011 12:43 PM, cto@itechfrontiers.com
>>    <mailto:cto@itechfrontiers.com> wrote:
>>      Sanjai,
>>
>>      Security is a complex business, I'm afraid that SELINUX is an
>>    attempt to
>>      simplify part of this job at least,
>>
>>      The more secure you want to make a system the more complex
>>    naturally it
>>      becomes,
>>
>>      however complexity is enemy of security by itself,
>>
>>      There is somewhat a dilemma, a paradox in here, I'm afraid it
>>    cannot be
>>      oversimplified as regular users would become security experts or such
>>      simplification waves the need for security specialists
>>
>>      Best,
>>
>>      Patrick K.
>>
>>
>>
>>        On 2/22/2011 12:19 PM, Sanjai Narain wrote:
>>
>>            Hi Patrick: Thanks for your note. I understand that SELinux
>>            does not
>>            directly apply to Stuxnet since it targeted Windows. However,
>> my
>>            question was conceptually motivated: whether mandatory
>>            access control
>>            could have contained the impact of this worm, had it been
>>            available. I
>>            had thought that the answer is yes but wanted to find out
>>            from other
>>            experts. I believe you concur. Now, if only we could make
>>            SELinux a lot
>>            easier to use..... this is where one of my interests lie. --
>>            Sanjai
>>
>>
>>            On 2/22/2011 11:53 AM, cto@itechfrontiers.com
>>            <mailto:cto@itechfrontiers.com> wrote:
>>
>>                On 1/30/2011 7:39 PM, cto@itechfrontiers.com
>>                <mailto:cto@itechfrontiers.com> wrote:
>>
>>                    Hello,
>>
>>                    Stuxnet is a Windows Worm, and SELinux is Mandatory
>>                    Access Control for
>>                    Linux
>>
>>                    on Linux SELinux can reduce the impact of such worms
>>                    if targeting Linux
>>                    boxes, but it is not a preemptive mechanism for not
>>                    having any kind of
>>                    compromise due to any vulnerability, Although if you
>>                    protect your
>>                    system
>>                    and targeted processes you may have reach the goal
>>                    of containing the
>>                    impact of possible compromises
>>
>>
>>                    Best,
>>
>>                    Patrick K.
>>
>>                    On 1/30/2011 5:20 PM, Sanjai Narain wrote:
>>
>>                        Has there been thinking on whether
>>                        SELinux-hardened machines can avoid
>>                        the spread of Stuxnet-like worms? Thanks. --Sanjai
>>
>>
>>
>>                    --
>>                    This message was distributed to subscribers of the
>>                    selinux mailing
>>                    list.
>>                    If you no longer wish to subscribe, send mail to
>>                    majordomo@tycho.nsa.gov <mailto:
>> majordomo@tycho.nsa.gov>
>>
>>                    with
>>                    the words "unsubscribe selinux" without quotes as
>>                    the message.
>>
>>
>>                Sanjai,
>>
>>                SELinux is Mandatory Access Control for Linux
>>
>>                Stuxnet only compromises Windows, SCADA and PLC 7
>>                systems (Siemens
>>                systems)
>>
>>                it is a worm, for a worm to compromise a system you need
>>                to have
>>                certain vulnerabilities
>>
>>                It cannot compromise Linux (the same way); as that worm
>>                has been
>>                designed for particular purposes and taking advantages
>>                of Windows
>>                vulnerabilities
>>
>>                If you mean protecting a network using Linux front ends
>>                or inline
>>                systems Like IPS systems that's another story which is
>>                irrelevant to
>>                SELINUX actually (although an IPS system -Intrusion
>>                Prevention system-
>>                on Linux can take advantages of SELINUX)
>>
>>                in brief , theoretically in case of a worm for Linux, it
>>                could be
>>                contained if SELINUX is effectively used.
>>
>>                in practice Stuxnet is for Windows
>>
>>                Best,
>>
>>                Patrick K.
>>
>>
>>
>>
>>        --
>>        This message was distributed to subscribers of the selinux
>>        mailing list.
>>        If you no longer wish to subscribe, send mail to
>>        majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov>
>>
>>        with
>>        the words "unsubscribe selinux" without quotes as the message.
>>
>>
>>
>>    --
>>    This message was distributed to subscribers of the selinux mailing
>> list.
>>    If you no longer wish to subscribe, send mail to
>>    majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov> with
>>
>>    the words "unsubscribe selinux" without quotes as the message.
>>
>>
>>
>

--000e0cd6acd87f542d049cea37e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The policies that are written are concerned with architecture based penetra=
tion of an interconnecting tree (kernal), where SeLinux is concerned, What =
&quot;blocks&quot; of code would be advantageous for an attacker concerned =
with such penetration techniques such as key functions {algorithms} and=A0 =
data compression encryption taking advantage of the communication of proces=
ses in the tree?<br>
<br><br><div class=3D"gmail_quote">On Tue, Feb 22, 2011 at 2:13 PM, <a href=
=3D"mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</a> <span dir=3D"=
ltr">&lt;<a href=3D"mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Ethan,<br>
<br>
What are you talking about?<br>
<br>
<br>
Patrick K.<div class=3D"im"><br>
<br>
On 2/22/2011 4:47 PM, Ethan Heidrick wrote:<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=
=3D"im">
IE: infrastructure is process based on detecting such side channeling<br>
attacks excuse the pun, but revising SeLinux security authorization if<br>
that is what you are suggesting would create an independent node of<br>
programmable patches directed specific technique.<br>
<br>
Where would an node discrimination in the coding be &quot;hazardous&quot; f=
or such<br>
red team analysis for penetration?<br>
<br>
On Tue, Feb 22, 2011 at 9:54 AM, <a href=3D"mailto:cto@itechfrontiers.com" =
target=3D"_blank">cto@itechfrontiers.com</a><br></div>
&lt;mailto:<a href=3D"mailto:cto@itechfrontiers.com" target=3D"_blank">cto@=
itechfrontiers.com</a>&gt; &lt;<a href=3D"mailto:cto@itechfrontiers.com" ta=
rget=3D"_blank">cto@itechfrontiers.com</a><div class=3D"im"><br>
&lt;mailto:<a href=3D"mailto:cto@itechfrontiers.com" target=3D"_blank">cto@=
itechfrontiers.com</a>&gt;&gt; wrote:<br>
<br>
 =A0 =A0Need to add it myself, that human being is also error-prone,<br>
<br>
 =A0 =A0i.e. last message I meant &quot;waives&quot; and wrote &quot;waves&=
quot;<br>
<br>
 =A0 =A0such errors happen even in development, in software and in security=
<br>
<br>
<br>
<br>
 =A0 =A0On 2/22/2011 12:43 PM, <a href=3D"mailto:cto@itechfrontiers.com" ta=
rget=3D"_blank">cto@itechfrontiers.com</a><br></div><div><div></div><div cl=
ass=3D"h5">
 =A0 =A0&lt;mailto:<a href=3D"mailto:cto@itechfrontiers.com" target=3D"_bla=
nk">cto@itechfrontiers.com</a>&gt; wrote:<br>
 =A0 =A0 =A0Sanjai,<br>
<br>
 =A0 =A0 =A0Security is a complex business, I&#39;m afraid that SELINUX is =
an<br>
 =A0 =A0attempt to<br>
 =A0 =A0 =A0simplify part of this job at least,<br>
<br>
 =A0 =A0 =A0The more secure you want to make a system the more complex<br>
 =A0 =A0naturally it<br>
 =A0 =A0 =A0becomes,<br>
<br>
 =A0 =A0 =A0however complexity is enemy of security by itself,<br>
<br>
 =A0 =A0 =A0There is somewhat a dilemma, a paradox in here, I&#39;m afraid =
it<br>
 =A0 =A0cannot be<br>
 =A0 =A0 =A0oversimplified as regular users would become security experts o=
r such<br>
 =A0 =A0 =A0simplification waves the need for security specialists<br>
<br>
 =A0 =A0 =A0Best,<br>
<br>
 =A0 =A0 =A0Patrick K.<br>
<br>
<br>
<br>
 =A0 =A0 =A0 =A0On 2/22/2011 12:19 PM, Sanjai Narain wrote:<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0Hi Patrick: Thanks for your note. I understand that=
 SELinux<br>
 =A0 =A0 =A0 =A0 =A0 =A0does not<br>
 =A0 =A0 =A0 =A0 =A0 =A0directly apply to Stuxnet since it targeted Windows=
. However, my<br>
 =A0 =A0 =A0 =A0 =A0 =A0question was conceptually motivated: whether mandat=
ory<br>
 =A0 =A0 =A0 =A0 =A0 =A0access control<br>
 =A0 =A0 =A0 =A0 =A0 =A0could have contained the impact of this worm, had i=
t been<br>
 =A0 =A0 =A0 =A0 =A0 =A0available. I<br>
 =A0 =A0 =A0 =A0 =A0 =A0had thought that the answer is yes but wanted to fi=
nd out<br>
 =A0 =A0 =A0 =A0 =A0 =A0from other<br>
 =A0 =A0 =A0 =A0 =A0 =A0experts. I believe you concur. Now, if only we coul=
d make<br>
 =A0 =A0 =A0 =A0 =A0 =A0SELinux a lot<br>
 =A0 =A0 =A0 =A0 =A0 =A0easier to use..... this is where one of my interest=
s lie. --<br>
 =A0 =A0 =A0 =A0 =A0 =A0Sanjai<br>
<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0On 2/22/2011 11:53 AM, <a href=3D"mailto:cto@itechf=
rontiers.com" target=3D"_blank">cto@itechfrontiers.com</a><br></div></div><=
div class=3D"im">
 =A0 =A0 =A0 =A0 =A0 =A0&lt;mailto:<a href=3D"mailto:cto@itechfrontiers.com=
" target=3D"_blank">cto@itechfrontiers.com</a>&gt; wrote:<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0On 1/30/2011 7:39 PM, <a href=3D"mailto:cto=
@itechfrontiers.com" target=3D"_blank">cto@itechfrontiers.com</a><br></div>=
<div><div></div><div class=3D"h5">
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;mailto:<a href=3D"mailto:cto@itechfront=
iers.com" target=3D"_blank">cto@itechfrontiers.com</a>&gt; wrote:<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Hello,<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Stuxnet is a Windows Worm, and SELi=
nux is Mandatory<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Access Control for<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linux<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0on Linux SELinux can reduce the imp=
act of such worms<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if targeting Linux<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0boxes, but it is not a preemptive m=
echanism for not<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0having any kind of<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compromise due to any vulnerability=
, Although if you<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0protect your<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0system<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and targeted processes you may have=
 reach the goal<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of containing the<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0impact of possible compromises<br>
<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Best,<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Patrick K.<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0On 1/30/2011 5:20 PM, Sanjai Narain=
 wrote:<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Has there been thinking on =
whether<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SELinux-hardened machines c=
an avoid<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the spread of Stuxnet-like =
worms? Thanks. --Sanjai<br>
<br>
<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0This message was distributed to sub=
scribers of the<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0selinux mailing<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list.<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If you no longer wish to subscribe,=
 send mail to<br></div></div>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"mailto:majordomo@tycho.n=
sa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> &lt;mailto:<a href=3D=
"mailto:majordomo@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov<=
/a>&gt;<div><div></div>
<div class=3D"h5"><br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0with<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the words &quot;unsubscribe selinux=
&quot; without quotes as<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the message.<br>
<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Sanjai,<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SELinux is Mandatory Access Control for Lin=
ux<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Stuxnet only compromises Windows, SCADA and=
 PLC 7<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0systems (Siemens<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0systems)<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0it is a worm, for a worm to compromise a sy=
stem you need<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to have<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0certain vulnerabilities<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0It cannot compromise Linux (the same way); =
as that worm<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0has been<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0designed for particular purposes and taking=
 advantages<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of Windows<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vulnerabilities<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If you mean protecting a network using Linu=
x front ends<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or inline<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0systems Like IPS systems that&#39;s another=
 story which is<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irrelevant to<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SELINUX actually (although an IPS system -I=
ntrusion<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Prevention system-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0on Linux can take advantages of SELINUX)<br=
>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in brief , theoretically in case of a worm =
for Linux, it<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0could be<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contained if SELINUX is effectively used.<b=
r>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in practice Stuxnet is for Windows<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Best,<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Patrick K.<br>
<br>
<br>
<br>
<br>
 =A0 =A0 =A0 =A0--<br>
 =A0 =A0 =A0 =A0This message was distributed to subscribers of the selinux<=
br>
 =A0 =A0 =A0 =A0mailing list.<br>
 =A0 =A0 =A0 =A0If you no longer wish to subscribe, send mail to<br></div><=
/div>
 =A0 =A0 =A0 =A0<a href=3D"mailto:majordomo@tycho.nsa.gov" target=3D"_blank=
">majordomo@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:majordomo@tycho.=
nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a>&gt;<div class=3D"im"=
><br>
 =A0 =A0 =A0 =A0with<br>
 =A0 =A0 =A0 =A0the words &quot;unsubscribe selinux&quot; without quotes as=
 the message.<br>
<br>
<br>
<br>
 =A0 =A0--<br>
 =A0 =A0This message was distributed to subscribers of the selinux mailing =
list.<br>
 =A0 =A0If you no longer wish to subscribe, send mail to<br></div>
 =A0 =A0<a href=3D"mailto:majordomo@tycho.nsa.gov" target=3D"_blank">majord=
omo@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:majordomo@tycho.nsa.gov"=
 target=3D"_blank">majordomo@tycho.nsa.gov</a>&gt; with<div class=3D"im"><b=
r>
 =A0 =A0the words &quot;unsubscribe selinux&quot; without quotes as the mes=
sage.<br>
<br>
<br>
</div></blockquote>
<br>
</blockquote></div><br>

--000e0cd6acd87f542d049cea37e1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
