Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAELheIi020108
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 16:43:40 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAELhgPE018980
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 21:43:43 GMT
Date: Sun, 14 Nov 2004 21:54:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Simo Sorce <idra@samba.org>
Cc: Andrew Bartlett <abartlet@samba.org>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   Chad Hanson <chanson@TrustedCS.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Multiple recipients of list SAMBA-TECHNICAL <samba-technical@samba.org>,
   russell@coker.com.au, tng-technical@samba-tng.org,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041114215428.GP5031@lkcl.net>
References: <418662EE.5090001@trustedcs.com> <20041101203524.GJ9643@lkcl.net> <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil> <200411090142.16657.russell@coker.com.au> <1100395104.13794.12.camel@piglett.bartlett.house> <20041114111527.GK5031@lkcl.net> <1100431351.13794.510.camel@piglett.bartlett.house> <20041114162453.GN5031@lkcl.net> <1100449615.30740.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100449615.30740.14.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Nov 14, 2004 at 05:26:55PM +0100, Simo Sorce wrote:

i apologise in advance for this being a particularly lengthy
message: writing a summary afterwards, for those with little
time, basically it says that samba tng's architecture, which
has all the separate services which people think of as "a
samba" split out into separate daemons - appx twelve separate
daemons, is much better suited to securing with selinux than
mainline samba.

yes, there are that _and_ more separate services in "a samba"!

[btw - to date, five or six years on, i still have not received
 a satisfactory response as to why samba still has a monolithic
 architecture.]


> In samba4 we have process, single AND thread model and a operations are
> async so this will not be a problem anymore.

fantastic

> Btw, from tests seem that in threaded model performance suck anyway :)
 
 i like that - threads are supposed to be All The Rage.

 ... what do you think is going wrong?


> > > but even if we get that (and perhaps the 'terminal server' case will
> > > cause such a proxy to be written), we still have the problem of needing
> > > to become root for some operations.  
> > 
> >  well (as you and others are in a position to appreciate)
> >  i really don't want to get into this in detail but i think
> >  you will find that if you follow the tng architecture -
> >  namely to split services out into separate daemons - then
> >  that problem goes away.
> 
> Not at all, there are operations that we must be able to do and that
> posix allow only for root, so unlike you propose to run always as root,
> we need to go root and back from time to time.
> Look at smbd sources and grep for become_root() and you'll find out why.

 [for those people who are not familiar with the circumstances
 under which become_root is used]

 okay, i think i see what you're getting at: you are saying
 that not all circumstances under which seteuid() is used can
 be replaced by a [simple] redesign, yes?

 ... why is that?


> >  from an selinux security perspective, the tng architecture
> >  is much more amenable to being "locked down".  each service
> >  (e.g. spoolssd) can be given access to ONLY the required
> >  commands (e.g. lpr) it needs to execute to do its job, ONLY
> >  the files it needs (e.g. /var/spool/).
> > 
> >  the point of selinux is to give programs the absolute minimum required
> >  policy to operate.
> 
> Yes, but samba need to do a lot of things, and a mere split down in
> daemons doesn't make it any better from this point of view, smbd will
> still need to go root and back, unless you want to break compatibility.

 i believe that you are assuming that there is an incompatibility
 between selinux and "going to root and back".

 or that there is some association between the use of seteuid, or
 something.

 perhaps i should clarify, starting with selinux, and the concerns over
 the new functionality being added, which will give you a better handle onto
 why doing separate processes per service is so much more preferable,
 and _then_ go on to describe where become_root() and friends would still
 be needed - but as a separate and distinct issue from the one of 
 doing separate processes per service.

 selinux works a bit like that tracing thing - the one which
 monitors system calls, builds up a profile of the calls
 being used, and then you switch "mode" and only _allow_ those
 system calls to do what you originally profiled that they do.

 when i say "a bit like" i am in fact lying: it's a lot more
 than "just" allowing system calls to do pre-vetted things.

 it's worth bearing in mind that the old argument of "if you
 are root, then it's impossible to improve the situation" no
 longer applies when selinux is involved - you only have to
 look at the test sites that people are setting up where they
 offer a root password and invite you to mess about with it.

 anyway.

 firstly, you get assistance from the kernel rather than userspace.

 secondly, as a linux security module (LSM), the "normal"
 unix permissions and capabilities are checked first: only if
 those succeed does the LSM framework call the selinux security
 module: only if _those_ succeed is the function call allowed.

 this saves processing cycles [on failed accesses].

 thirdly, each process (well, in fact, linux kernel thread,
 but nobody actually at present goes to the extreme extent
 of writing policy for individual threads) can have its own
 "vetting" list of operations it is allowed to perform, and
 each "vetting" list is given a name (by the policy writer)
 called a "domain".

 fourthly, and this is the crucial bit, there is a means to "transition"
 between domains automatically.

 AT PRESENT the only way to transition between domains is to "exec()" a
 process.

 the discussion on the selinux mailing list was to add a NEW
 means to change to a different domain - one that works in a
 similar way to seteuid.  namely, that you call a function e.g.
 selinux_change_domain() and bang, you're in a new domain.

 there are some quite grave concerns about adding this seteuid-like
 function in selinux.

 the first one is that it is considered bad security practice to use
 seteuid!!!

 i assume that you are familiar with the potential for
 things going horribly wrong - just as an example, how about
 accidentally opening a file handle as root and forgetting to
 close it before doing the seteuid to another user.

 now, whilst that may appear at first sight to be fine ("my
 program had a security audit, i am a first-rate programmer,
 i made sure that wasn't possible to happen in my code!")
 
 if you bring in a hostile attack against your program into
 the mix, then you cannot guarantee that your program cannot
 be circumvented.

 here's where selinux _can_ start to make such guarantees
 possible _and_ you can prove it with policy analysis tools.

 ... but NOT if you're using the newly proposed yet-to-be-written
 selinux_change_domain() function!!!

 that might need some explanation.

 if you allow a _program_ to make a domain transition [i.e. to move from
 being allowed to do one set of POSIX operations with access to certain
 resources to being allowed to do a totally different set with access to
 completely different resources] then you still don't have control over
 _when_ that transition occurs, and in addition you are _still_ passing
 over a hell of a lot more resources between the two "domains".

 vetting and auditing those resources is going to be
 ... well... hair-raising at best.

 it's best explained like this: with exec(), you _know_ that
 the two programs (the exec()er and the exec()ed) share very
 little information between them, such that you have to design
 and use a communication mechanism - if you need it - and that
 communication mechanism can be audited by selinux policy.

 so, basically, from a security perspective, using seteuid()
 is a bit of a nightmare: in the case of smbd, you have
 a single process which carries resources over from a
 "user-like"-privileged domain to a "root-like"-privileged domain,
 such that if smbd is compromised...

 ... but if say... spoolssd (samba-tng printer server program)
 is compromised, wow big deal, so the attacker can call lpr,
 gosh, shock horror.

 
 now i should address the uses for become_root() and friends.

 smbd starts off as root until an SMB user is authenticated, then there
 are circumstances under which it is necessary to a) switch to a new
 SMB user context (a different SMB VUID+UID+TID tuple) b) switch to root
 temporarily - e.g. for access to protected databases.

 under samba tng's daemon-per-service scheme, the use of become_root and
 become_user is, i believe, reduced.  yes, with the file serving, a)
 above is still necessary.  the number of occurences b) however is far
 less.

 why?

 well, let's take authentication as an example.  in smbd,
 authentication is done by doing a become_root(), reading
 the smbpasswd file or tdb database, and then doing an
 unbecome_root().
 
 all authentication in samba tng is done NOT by the daemons
 themselves (smbd included) but instead by contacting the
 netlogond daemon, which in turn contacts samrd (asking it
 for the user's password).

 so right there you have an example whereby selinux could
 make a big contribution: netlogond's selinux domain could be
 pretty heavily restricted (bare-bones), and samrd's domain
 could be likewise heavily restricted but it requires access
 to the user account database.

 and samrd is the _only_ process requiring access to the user account
 database (SAM database).

 any program - even one with root privileges - that even
 ATTEMPTS to access the SAM database would find it banned and
 an audit message would be logged.

 
 with the present monolithic design of smbd, the same policy that
 specifies access to user files must also have granted to it the right
 to access the SAM database (smbpasswd) file.

 ... can you see that there is something wrong with this picture?

 
 so, whilst programs like spoolssd may still require
 become_root() and friends - for example to oh i dunno read
 printer queues as root or something - they certainly don't
 require become_root() to access the smbpasswd file/database.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
