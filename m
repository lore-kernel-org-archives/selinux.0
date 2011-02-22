Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1MME2k6022557
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 17:14:03 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1MME28e016180
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 22:14:02 GMT
Message-ID: <4D643523.7040907@itechfrontiers.com>
Date: Tue, 22 Feb 2011 17:13:55 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Ethan Heidrick <ethanheidrick@gmail.com>
CC: Sanjai Narain <narain@research.telcordia.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux and Stuxnet
References: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>	<4D45E42A.80303@research.telcordia.com>	<4D4604DB.3060402@itechfrontiers.com>	<4D63EA14.2080701@itechfrontiers.com>	<4D63F01E.70903@research.telcordia.com>	<4D63F5A9.3000301@itechfrontiers.com>	<4D63F854.3030907@itechfrontiers.com> <AANLkTikoywS7qNGgwY7cE20y4PpeF7fja3vxEtRiVjAJ@mail.gmail.com>
In-Reply-To: <AANLkTikoywS7qNGgwY7cE20y4PpeF7fja3vxEtRiVjAJ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ethan,

What are you talking about?


Patrick K.

On 2/22/2011 4:47 PM, Ethan Heidrick wrote:
> IE: infrastructure is process based on detecting such side channeling
> attacks excuse the pun, but revising SeLinux security authorization if
> that is what you are suggesting would create an independent node of
> programmable patches directed specific technique.
>
> Where would an node discrimination in the coding be "hazardous" for such
> red team analysis for penetration?
>
> On Tue, Feb 22, 2011 at 9:54 AM, cto@itechfrontiers.com
> <mailto:cto@itechfrontiers.com> <cto@itechfrontiers.com
> <mailto:cto@itechfrontiers.com>> wrote:
>
>     Need to add it myself, that human being is also error-prone,
>
>     i.e. last message I meant "waives" and wrote "waves"
>
>     such errors happen even in development, in software and in security
>
>
>
>     On 2/22/2011 12:43 PM, cto@itechfrontiers.com
>     <mailto:cto@itechfrontiers.com> wrote:
>       Sanjai,
>
>       Security is a complex business, I'm afraid that SELINUX is an
>     attempt to
>       simplify part of this job at least,
>
>       The more secure you want to make a system the more complex
>     naturally it
>       becomes,
>
>       however complexity is enemy of security by itself,
>
>       There is somewhat a dilemma, a paradox in here, I'm afraid it
>     cannot be
>       oversimplified as regular users would become security experts or such
>       simplification waves the need for security specialists
>
>       Best,
>
>       Patrick K.
>
>
>
>         On 2/22/2011 12:19 PM, Sanjai Narain wrote:
>
>             Hi Patrick: Thanks for your note. I understand that SELinux
>             does not
>             directly apply to Stuxnet since it targeted Windows. However, my
>             question was conceptually motivated: whether mandatory
>             access control
>             could have contained the impact of this worm, had it been
>             available. I
>             had thought that the answer is yes but wanted to find out
>             from other
>             experts. I believe you concur. Now, if only we could make
>             SELinux a lot
>             easier to use..... this is where one of my interests lie. --
>             Sanjai
>
>
>             On 2/22/2011 11:53 AM, cto@itechfrontiers.com
>             <mailto:cto@itechfrontiers.com> wrote:
>
>                 On 1/30/2011 7:39 PM, cto@itechfrontiers.com
>                 <mailto:cto@itechfrontiers.com> wrote:
>
>                     Hello,
>
>                     Stuxnet is a Windows Worm, and SELinux is Mandatory
>                     Access Control for
>                     Linux
>
>                     on Linux SELinux can reduce the impact of such worms
>                     if targeting Linux
>                     boxes, but it is not a preemptive mechanism for not
>                     having any kind of
>                     compromise due to any vulnerability, Although if you
>                     protect your
>                     system
>                     and targeted processes you may have reach the goal
>                     of containing the
>                     impact of possible compromises
>
>
>                     Best,
>
>                     Patrick K.
>
>                     On 1/30/2011 5:20 PM, Sanjai Narain wrote:
>
>                         Has there been thinking on whether
>                         SELinux-hardened machines can avoid
>                         the spread of Stuxnet-like worms? Thanks. --Sanjai
>
>
>
>                     --
>                     This message was distributed to subscribers of the
>                     selinux mailing
>                     list.
>                     If you no longer wish to subscribe, send mail to
>                     majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov>
>                     with
>                     the words "unsubscribe selinux" without quotes as
>                     the message.
>
>
>                 Sanjai,
>
>                 SELinux is Mandatory Access Control for Linux
>
>                 Stuxnet only compromises Windows, SCADA and PLC 7
>                 systems (Siemens
>                 systems)
>
>                 it is a worm, for a worm to compromise a system you need
>                 to have
>                 certain vulnerabilities
>
>                 It cannot compromise Linux (the same way); as that worm
>                 has been
>                 designed for particular purposes and taking advantages
>                 of Windows
>                 vulnerabilities
>
>                 If you mean protecting a network using Linux front ends
>                 or inline
>                 systems Like IPS systems that's another story which is
>                 irrelevant to
>                 SELINUX actually (although an IPS system -Intrusion
>                 Prevention system-
>                 on Linux can take advantages of SELINUX)
>
>                 in brief , theoretically in case of a worm for Linux, it
>                 could be
>                 contained if SELINUX is effectively used.
>
>                 in practice Stuxnet is for Windows
>
>                 Best,
>
>                 Patrick K.
>
>
>
>
>         --
>         This message was distributed to subscribers of the selinux
>         mailing list.
>         If you no longer wish to subscribe, send mail to
>         majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov>
>         with
>         the words "unsubscribe selinux" without quotes as the message.
>
>
>
>     --
>     This message was distributed to subscribers of the selinux mailing list.
>     If you no longer wish to subscribe, send mail to
>     majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov> with
>     the words "unsubscribe selinux" without quotes as the message.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
