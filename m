Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJEb9Ii020752
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 09:37:09 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJEZf3F005280
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 14:35:41 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Joshua D. Guttman disp: slinux" <guttman@mitre.org>
Cc: Amy L Herzog <aherzog@mitre.org>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <nhau0rm54ra.fsf@malabar.mitre.org>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
Content-Type: text/plain
Message-Id: <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 09:33:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-19 at 08:48, Joshua D. Guttman wrote:
> >   I think it will have to be a "read write" flow, i.e. equivalence
> >   required, particularly given the possibility of per-thread
> >   contexts introduced by this change (one thread may switch to a
> >   different context while another is still running in the old one) 
> 
> Are you sure that this is a good idea?  If different threads can have
> different contexts within the same process, what are you really buying
> in security protection?
> 
> Wouldn't you really need to know a lot about the possible behavior of
> a program in order to know that the threads executing with lower
> privileges really can't do harm?  I mean, whatever harm you were
> worried about that made you want to give them lower privileges in the
> first place?  
> 
> Much more complexity isn't worth it (in my opinion), unless you can
> really say what  ability you gain to prevent something from going
> wrong.  What harm can you really prevent?  

Even in the single-threaded case, for a dynamic context transition, you
have to trust the application to maintain any desired separation between
the two security contexts since there is no kernel control over the
inheritance of state or the initialization of the process in the new
security context.  So I don't see any difference in assurance burden on
the application, given that we are allowing a dynamic context transition
by the application in the first place.

The benefit of per-thread contexts (like other Linux *id state) would be
allowing each thread to perform privilege bracketing independently, so
in a multi-threaded server, each thread could switch to a context
derived from the client without any impact on any of the other server
threads.  Naturally, a bug in the application could inadvertently allow
a client in one security context to observe or modify information in
another security context contrary to policy, but that would also be true
of a single-threaded server that switches back and forth between the
main application context and a context derived from the client for each
request.  No difference in the trust required in the application, and
debateable as to whether this is any more prone to programmer error than
the single-threaded case.

Regardless of what path is chosen, some change is required to the patch
that was proposed.   Either the kernel code needs to explicitly prohibit
usage by multi-threaded applications or the libselinux code needs to use
/proc/self/task/<tid>/attr/current to allow usage by multi-threaded
applications.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
