Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HDrOrT016412
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 09:53:25 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HDqBxh002521
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 13:52:11 GMT
Date: Sun, 17 Oct 2004 15:04:20 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: Alex Ackerman <alex@darkhonor.com>, fedora-selinux-list@redhat.com,
   selinux@tycho.nsa.gov, ackermal@jmu.edu
Subject: Re: SELinux Testing Software/Scripts
Message-ID: <20041017140420.GE19398@lkcl.net>
References: <A52BEA1D8EE8634B9196A136333637B130F1@maat.darkhonor.net> <20041016180414.GB19398@lkcl.net> <1097974915.21919.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1097974915.21919.5.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 17, 2004 at 03:01:54AM +0200, Erich Schubert wrote:
> Hi,
> 
> >  as i understand it, there is no "escalation" present in SE/Linux,
> >  only that assigned in the minds of us humans.
> [...]
> >  that's a bit different from "escalating privilege" because that implies
> >  hierarchy, which SE/Linux doesn't have, per-se.
> 
> As long as you have roles with certain higher privileges (for example
> writing to configuration files, binding to arbitrary ports, loading a
> new policy...) there is privilege escalation.

 
> Privilege escalation just means getting more rights than you were
> supposed to get. 

 ohright, okay: then my statement is incorrect and it is more that
 policy writers need to get their policies right, by not allowing more
 than is needed!


> You usually don't care about losing access rights,
> because you could have done things there earlier. Its only about getting
> a privilege you want to have.

 my point is that selinux allows that [to go from one domain to the
 next, losing all previous rights of the prior domain and gaining those
 of the next domain].

 which is not a "normal" security system so to speak: i'd consider
 "normal" to be that you get given more privileges by going to a
 "higher" privileged state [but i'm not saying "normal" is "good"].

 l.
 

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
