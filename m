Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA26403
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2001 06:09:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA15619
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2001 11:09:29 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzband.ncsc.mil  with ESMTP id LAA15615
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2001 11:09:27 GMT
Date: Thu, 22 Mar 2001 12:09:16 +0100
From: =?iso-8859-2?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: lids
Message-ID: <20010322120916.A8262@bunuel.tii.matav.hu>
References: <Pine.SOL.3.95.1010321082240.12705E-100000@clipper.gw.tislabs.com> <3AB8DAEA.6050606@ksu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <3AB8DAEA.6050606@ksu.ru>; from Pedro.Rosa@ksu.ru on Wed, Mar 21, 2001 at 07:46:34PM +0300
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A levelezõm azt hiszi, hogy Pedro Rosa a következõeket írta:
> > 
> > I'm also not sure what you mean by your discussion of untrusted
> > vs. trusted environments.  The mandatory access controls of SELinux
> > are quite useful for limiting the damage that can be caused by
> > flawed or malicious applications and for supporting different
> > levels of trust among users.  So SELinux should be quite useful
> > in the same environments where LIDS is useful.
> 
> Well I really don't think so. You are quite correct in noting the fact 
> that SELinux is useful to limit possible damages. But note that this 
> kind of architecture is in fact quite vulnerable in places where 
> malicious users are present or there are serious flaws in the 
> communication infrastructure. Besides guarantees against malicious 
> applications fall in the measure of how this environment may allow their 
> presence. One of NSA docs exactly referred to this point. From what I 
> could get, SELinux is only useful when you have an have a secured 
> office, do a good care to check apps and users and have some good 
> firewall system to protect the LANs. In this case SELinux complements 

The mandatory access control policies specifically target the case
where malicious users/malware present. Please read any introductory
paper on the Bell-LaPadula or any other MAC modell.
Please do not get confused about the fact that the selinux docs
explicitly emphasize the well-known fact, that the security of _any_
system cannot be guaranteed without some measures external to the
technical tools of the system. A clearly stated policy, and
definition of user procedures comes to mind as the most important
items. Furthermore _any_ security control is based on assumptions. The
fact that these assumptions are held also should be guaranteed
by measures external to the system.
The above holds for LIDS, even if these facts are not emphasized
in its docs.

> this environment by distributing resources according to policy uses, and 
> caring for their limited use, in face of a control system. Anyway 
> SELinux is not strong enough to avoid systematic attacks or covert 
> agents or a bugged network. Besides, it has not a serious system of 
> countermeasures and accounting beyond its access policies.

The theory behind selinux is very strong. It does not target every
functional requirement you can think of or read in the CC, but it
clearly goes in that direction, in a very planned manner.

Please note that I am not talking about the actual implementation
of these tools, because I am not yet familiar enough with any of them.

-- 
GNU GPL: csak tiszta forrásból

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
