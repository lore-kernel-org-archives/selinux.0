To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>,
   guttman@mitre.org (Joshua D. Guttman),
   "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
   aherzog@mitre.org (Amy L. Herzog), ramsdell@mitre.org (John D. Ramsdell),
   gwilliam@mitre.org (Galen B. Williamson),
   "Grant M. Wagner" <gmw@tycho.ncsc.mil>
Subject: Re: Announce: SELinux conditional policy extensions
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <1072133247.3032.22.camel@colossus.columbia.tresys.com>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 12 Feb 2004 20:22:57 -0500
In-Reply-To: <1072133247.3032.22.camel@colossus.columbia.tresys.com>
Message-ID: <nhawu6r93im.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl --

I've just gotten round to reading through README-COND describing the
conditional policy mechanism.

The idea of dynamic changes to the policy makes me nervous.  It seems
to make the job of understanding the meaning and consequences of  a
policy -- already hard -- even more daunting.  And I don't really see
important security goals that cannot be achieved the old way.  

Doesn't it seem to create a "policy reachability" problem similar to
the old (undecidable) Harrison-Rizzo-Ullman problem?  Do you know
whether it's decidable in general whether there's a sequence of steps
by a particular set of users (let's say) that leads to a particular
user being able to access a particular file?  

Giving conditional access to a few specific services could
alternatively be arranged by having some (trusted, non-kernel) gateway
demons that either respond to requests when desired or don't, when the
flag is set the other way.

Is there a clearly defined minimum policy and maximum policy for every
conditional policy?  Is there a clearly defined set (e.g. a lattice)
of policies corresponding to the different possible dynamic
configurations?  Is this lattice constructible in some straightforward
way?  

And why should we incorporate a mechanism like this, if we haven't yet
understood the answers to a bunch of questions like these?  

May I ask you please to try to explain more precisely and in more
detail than README-COND does, how this mechanism works and why it's
really a good idea?  

Thanks --

        Joshua         

Karl MacMillan <kmacmillan@tresys.com> writes:

>   A new release of the conditional policy extensions to SELinux is
>   available from our website:
>   
>   http://www.tresys.com/selinux/index.html
>   
>   The conditional policy extensions to SELinux allow runtime modification
>   of the security policy without having to load a new policy. Using
>   boolean variables and expressions, it is possible to define sections of
>   policy that are conditionally applied. Please see the website for more
>   information.


-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
