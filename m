Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1MLlokn021273
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 16:47:50 -0500
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1MLlncZ026889
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 21:47:49 GMT
Received: by gyd10 with SMTP id 10so1273930gyd.12
        for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 13:47:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D63F854.3030907@itechfrontiers.com>
References: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>
	<4D45E42A.80303@research.telcordia.com>
	<4D4604DB.3060402@itechfrontiers.com>
	<4D63EA14.2080701@itechfrontiers.com>
	<4D63F01E.70903@research.telcordia.com>
	<4D63F5A9.3000301@itechfrontiers.com>
	<4D63F854.3030907@itechfrontiers.com>
Date: Tue, 22 Feb 2011 13:47:49 -0800
Message-ID: <AANLkTikoywS7qNGgwY7cE20y4PpeF7fja3vxEtRiVjAJ@mail.gmail.com>
Subject: Re: SELinux and Stuxnet
From: Ethan Heidrick <ethanheidrick@gmail.com>
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
Cc: Sanjai Narain <narain@research.telcordia.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd30b527855de049ce5eecf
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd30b527855de049ce5eecf
Content-Type: text/plain; charset=ISO-8859-1

IE: infrastructure is process based on detecting such side channeling
attacks excuse the pun, but revising SeLinux security authorization if that
is what you are suggesting would create an independent node of programmable
patches directed specific technique.

Where would an node discrimination in the coding be "hazardous" for such red
team analysis for penetration?

On Tue, Feb 22, 2011 at 9:54 AM, cto@itechfrontiers.com <
cto@itechfrontiers.com> wrote:

> Need to add it myself, that human being is also error-prone,
>
> i.e. last message I meant "waives" and wrote "waves"
>
> such errors happen even in development, in software and in security
>
>
>
> On 2/22/2011 12:43 PM, cto@itechfrontiers.com wrote:
>  Sanjai,
>
>  Security is a complex business, I'm afraid that SELINUX is an attempt to
>  simplify part of this job at least,
>
>  The more secure you want to make a system the more complex naturally it
>  becomes,
>
>  however complexity is enemy of security by itself,
>
>  There is somewhat a dilemma, a paradox in here, I'm afraid it cannot be
>  oversimplified as regular users would become security experts or such
>  simplification waves the need for security specialists
>
>  Best,
>
>  Patrick K.
>
>
>>
>> On 2/22/2011 12:19 PM, Sanjai Narain wrote:
>>
>>> Hi Patrick: Thanks for your note. I understand that SELinux does not
>>> directly apply to Stuxnet since it targeted Windows. However, my
>>> question was conceptually motivated: whether mandatory access control
>>> could have contained the impact of this worm, had it been available. I
>>> had thought that the answer is yes but wanted to find out from other
>>> experts. I believe you concur. Now, if only we could make SELinux a lot
>>> easier to use..... this is where one of my interests lie. -- Sanjai
>>>
>>>
>>> On 2/22/2011 11:53 AM, cto@itechfrontiers.com wrote:
>>>
>>>> On 1/30/2011 7:39 PM, cto@itechfrontiers.com wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> Stuxnet is a Windows Worm, and SELinux is Mandatory Access Control for
>>>>> Linux
>>>>>
>>>>> on Linux SELinux can reduce the impact of such worms if targeting Linux
>>>>> boxes, but it is not a preemptive mechanism for not having any kind of
>>>>> compromise due to any vulnerability, Although if you protect your
>>>>> system
>>>>> and targeted processes you may have reach the goal of containing the
>>>>> impact of possible compromises
>>>>>
>>>>>
>>>>> Best,
>>>>>
>>>>> Patrick K.
>>>>>
>>>>> On 1/30/2011 5:20 PM, Sanjai Narain wrote:
>>>>>
>>>>>> Has there been thinking on whether SELinux-hardened machines can avoid
>>>>>> the spread of Stuxnet-like worms? Thanks. --Sanjai
>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing
>>>>> list.
>>>>> If you no longer wish to subscribe, send mail to
>>>>> majordomo@tycho.nsa.gov
>>>>> with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>
>>>>
>>>> Sanjai,
>>>>
>>>> SELinux is Mandatory Access Control for Linux
>>>>
>>>> Stuxnet only compromises Windows, SCADA and PLC 7 systems (Siemens
>>>> systems)
>>>>
>>>> it is a worm, for a worm to compromise a system you need to have
>>>> certain vulnerabilities
>>>>
>>>> It cannot compromise Linux (the same way); as that worm has been
>>>> designed for particular purposes and taking advantages of Windows
>>>> vulnerabilities
>>>>
>>>> If you mean protecting a network using Linux front ends or inline
>>>> systems Like IPS systems that's another story which is irrelevant to
>>>> SELINUX actually (although an IPS system -Intrusion Prevention system-
>>>> on Linux can take advantages of SELINUX)
>>>>
>>>> in brief , theoretically in case of a worm for Linux, it could be
>>>> contained if SELINUX is effectively used.
>>>>
>>>> in practice Stuxnet is for Windows
>>>>
>>>> Best,
>>>>
>>>> Patrick K.
>>>>
>>>>
>>>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--000e0cd30b527855de049ce5eecf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

IE: infrastructure is process based on detecting such side channeling attac=
ks excuse the pun, but revising SeLinux security authorization if that is w=
hat you are suggesting would create an independent node of programmable pat=
ches directed specific technique.<br>
<br>Where would an node discrimination in the coding be &quot;hazardous&quo=
t; for such red team analysis for penetration?<br><br><div class=3D"gmail_q=
uote">On Tue, Feb 22, 2011 at 9:54 AM, <a href=3D"mailto:cto@itechfrontiers=
.com">cto@itechfrontiers.com</a> <span dir=3D"ltr">&lt;<a href=3D"mailto:ct=
o@itechfrontiers.com">cto@itechfrontiers.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Need to add it my=
self, that human being is also error-prone,<br>
<br>
i.e. last message I meant &quot;waives&quot; and wrote &quot;waves&quot;<br=
>
<br>
such errors happen even in development, in software and in security<div><di=
v></div><div class=3D"h5"><br>
<br>
<br>
On 2/22/2011 12:43 PM, <a href=3D"mailto:cto@itechfrontiers.com" target=3D"=
_blank">cto@itechfrontiers.com</a> wrote:<br>
=A0Sanjai,<br>
<br>
=A0Security is a complex business, I&#39;m afraid that SELINUX is an attemp=
t to<br>
=A0simplify part of this job at least,<br>
<br>
=A0The more secure you want to make a system the more complex naturally it<=
br>
=A0becomes,<br>
<br>
=A0however complexity is enemy of security by itself,<br>
<br>
=A0There is somewhat a dilemma, a paradox in here, I&#39;m afraid it cannot=
 be<br>
=A0oversimplified as regular users would become security experts or such<br=
>
=A0simplification waves the need for security specialists<br>
<br>
=A0Best,<br>
<br>
=A0Patrick K.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
<br>
On 2/22/2011 12:19 PM, Sanjai Narain wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi Patrick: Thanks for your note. I understand that SELinux does not<br>
directly apply to Stuxnet since it targeted Windows. However, my<br>
question was conceptually motivated: whether mandatory access control<br>
could have contained the impact of this worm, had it been available. I<br>
had thought that the answer is yes but wanted to find out from other<br>
experts. I believe you concur. Now, if only we could make SELinux a lot<br>
easier to use..... this is where one of my interests lie. -- Sanjai<br>
<br>
<br>
On 2/22/2011 11:53 AM, <a href=3D"mailto:cto@itechfrontiers.com" target=3D"=
_blank">cto@itechfrontiers.com</a> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
On 1/30/2011 7:39 PM, <a href=3D"mailto:cto@itechfrontiers.com" target=3D"_=
blank">cto@itechfrontiers.com</a> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hello,<br>
<br>
Stuxnet is a Windows Worm, and SELinux is Mandatory Access Control for<br>
Linux<br>
<br>
on Linux SELinux can reduce the impact of such worms if targeting Linux<br>
boxes, but it is not a preemptive mechanism for not having any kind of<br>
compromise due to any vulnerability, Although if you protect your<br>
system<br>
and targeted processes you may have reach the goal of containing the<br>
impact of possible compromises<br>
<br>
<br>
Best,<br>
<br>
Patrick K.<br>
<br>
On 1/30/2011 5:20 PM, Sanjai Narain wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Has there been thinking on whether SELinux-hardened machines can avoid<br>
the spread of Stuxnet-like worms? Thanks. --Sanjai<br>
<br>
</blockquote>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing<br>
list.<br>
If you no longer wish to subscribe, send mail to<br>
<a href=3D"mailto:majordomo@tycho.nsa.gov" target=3D"_blank">majordomo@tych=
o.nsa.gov</a><br>
with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</blockquote>
<br>
Sanjai,<br>
<br>
SELinux is Mandatory Access Control for Linux<br>
<br>
Stuxnet only compromises Windows, SCADA and PLC 7 systems (Siemens<br>
systems)<br>
<br>
it is a worm, for a worm to compromise a system you need to have<br>
certain vulnerabilities<br>
<br>
It cannot compromise Linux (the same way); as that worm has been<br>
designed for particular purposes and taking advantages of Windows<br>
vulnerabilities<br>
<br>
If you mean protecting a network using Linux front ends or inline<br>
systems Like IPS systems that&#39;s another story which is irrelevant to<br=
>
SELINUX actually (although an IPS system -Intrusion Prevention system-<br>
on Linux can take advantages of SELINUX)<br>
<br>
in brief , theoretically in case of a worm for Linux, it could be<br>
contained if SELINUX is effectively used.<br>
<br>
in practice Stuxnet is for Windows<br>
<br>
Best,<br>
<br>
Patrick K.<br>
<br>
<br>
</blockquote></blockquote>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a><br>
with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</blockquote>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--000e0cd30b527855de049ce5eecf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
