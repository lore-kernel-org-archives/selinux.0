Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3HFQXZ016353
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 12:15:26 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3HE44w024285
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 17:14:05 GMT
Date: Wed, 3 Nov 2004 17:26:09 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041103172609.GE5061@lkcl.net>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 03, 2004 at 10:36:01AM -0500, Chad Hanson wrote:

> At the end of the day, I don't see how a privilege bracket
> mechanism can weaken the assurance of an application 

 the application's assurance is _already_ weak [in a situation where
 seteuid-like single-process security is used].

 hence 

> if we follow the
> approach that all domains in the "domain transition group" for an
> application are a subset of a high level domain which describes the maximal
> set of application permissions.

 one of us is missing something here.

 let's assume that the "high level domain privileges" is
 AoredwithB, where A is a subset of the privileges (for the up-level)
 and B is the subset of privileges for the down-level.

 i believe it is that the advocates of the present SELinux
 TE strategy [i.e. with no dynamic single-process transition
 mechanism that is seteuid-like] would say that even _having_
 that "high level" i.e. higher privileged domain _at all_
 is an unacceptable security risk, and that the application
 should be designed to split the "higher level (AoredwithB)"
 into two distinct mutually exclusive subsets (set A and set B)
 - and then the program with the set A privileges should exec()
 a program with set B privileges.

 the problem that SELinux faces is that as soon as you provide a
 seteuid-like function as a "sop" to help people adopt SElinux
 in applications, all bets are off for being able to remove
 it at a later date, and SELinux's security assurance is lost.

 
 so, the issue is: how to implement MLS _without_ having dynamic context
 transition capability?

 maybe making _only_ MLS be able to explicitly do dynamic transition,
 such that ordinarily [without MLS] it's not possible [to do dynamic
 transition in a single process]

 of course, at the risk of application writers realising that by
 creating a one-level MLS....

 l.



-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
