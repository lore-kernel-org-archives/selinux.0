Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m922DUF9006055
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 22:13:30 -0400
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m922CPMP023022
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2008 02:12:25 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 15/16] cipso: Add support for native local labeling and fixup mapping names
Date: Wed, 1 Oct 2008 22:13:26 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <200810011305.04872.paul.moore@hp.com> <alpine.LRH.1.10.0810020810570.12028@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810020810570.12028@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810012213.26916.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2008 6:12:16 pm James Morris wrote:
> On Wed, 1 Oct 2008, Paul Moore wrote:
> > > ... and why specify zero filling?  (Setting and testing that
> > > would be wasted cycles, if you enforced it).
> >
> > Better alignment within the IP option field, the goal being to try
> > and get the secid aligned on a 32bit boundary.  However, it just
> > occurred to me that by adding the two octets of padding I've
> > actually pushed it out of alignment (I forgot about the obligatory
> > IP option type and length octets).
>
> I mean, why specify zero-filled rather than simply "unused" ?

Gotcha.  Yes, "unused" or "reserved" would be much better but it is 
kinda moot right now anyway since the Right Thing is to just remove the 
padding entirely.

> > Man I hate IPv4 options, what a parsing nightmare ...
>
> It was all fixed with IPv6, right? :-)

That is what the brochure says :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
