Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9VMlmXZ022096
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2004 17:47:49 -0500 (EST)
Received: from oe-im1.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9VMkNhK007672
	for <selinux@tycho.nsa.gov>; Sun, 31 Oct 2004 22:46:29 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>, <selinux@tycho.nsa.gov>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Chad Hanson'" <chanson@TrustedCS.com>
Subject: RE: dynamic context transitions
Date: Sun, 31 Oct 2004 17:47:41 -0500
Message-ID: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4182959B.4080503@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Excuse the detailed response. too many nerves were struck by this proposal.]

> 	We would like to propose adding support for a trusted process to
> alter its security context dynamically in order to support privilege
> bracketing within an application.  We are aware that this idea has
> been discussed in the past on the list and entirely understand the
> concerns about non-tranquility, but we feel that this feature, and its
> implementation, have considerable merit and can be provided with
> appropriate controls to mitigate the risks.

I fear this day would come.  I partially attribute the loss of high-assurance in
the MLS arena to loss of tranquility, and the slippery slope that its loss
starts (as greatly exploited by CMWs of the era).  On the other hand Linux is a
typical lower assurance OS so perhaps the demand for this "feature" was
inevitable.

>        The motivator behind this proposal is to provide a mechanism
> for a trusted application (one written to leverage the security
> policy) to be able to remove unnecessary privileges when they are no
> longer needed, as well as temporarily raise the privilege level to
> perform certain operations and then return to a less privileged
> level.  

First a question, "leverage the security policy"; what do you mean?  Second, the
tone of the statement is that "trustedness" is a binary condition.  Perhaps true
in some MLS implementations where one has privilege to write down or break
tranquility, but not necessarily the case in type enforcement.  

> By privilege level, we are referring to access to other
> types/domains and access to security classes such as system, passwd,
> and capability.  The former provides enhanced security for
> applications/daemons which need access to many things to initialize,
> but can then run with much less access to the system.  

Yes a legacy problem, so we live with it and improve over time rather than
fundamentally change to slightly improve legacy software. 

> The latter
> method of privilege bracketing helps code audits of large
> applications by identifying critical regions of code that require
> more privileges to run. 

Or rather, possibly a way to achieve great sense of a false assurance.  We
evolved the so called privilege bracketing concept back in the Orange Book days
because we were stuck with legacy software, and so decided that if we bracketed
privilege, somehow the running process was of less "trustedness" when the
privilege was turned off.  I would argue the idea is not necessarily valid,
given we're talking about a single execution "domain" with complete control of
its privileges (and complete lack of control of its privileges if all software
executing within the process is not *all* entirely trusted equally).  So maybe
its better to require software engineers to be concerned about all software in a
"trusted" process, and not just that inside a privilege bracket controllable by
any software in the process.

> 	A goal of SELinux and trusted application programming is to
> create smaller programs which can be secured and audited. However,
> there are and will continue to be applications which don't fall into
> this framework. For these applications, a privilege bracketing
> approach provides a more granular security framework than what
> currently exists from SELinux today at process level.

You are certainly correct about the need for legacy software.  However, perhaps
we achieve less assurance through loss of tranquility, and the long term effect
that will have (i.e., by continuing poor application security engineering) than
we would get by leaving tranquility, understanding the privileges associated
with an entire process, and working towards better trustworthy applications in
the future.  I fear the alternative you suggest is that the weak (or false)
assurance we achieve by bracketing will become the norm.
 
> 	The MLS model is another reason for this functionality. We have
> chosen to create MLS policy overrides using a new SELinux MLS
> capability class. 

I have not thought greatly about this choice, but I wonder if it was wise to
make the MLS mechanism dependent on the capability mechanism.  Orthogonal
mechanisms would seem smarter.  

> Trusted MLS applications may require a specific
> capability to satisfy or "temporarily" override a policy to change
> the MLS label of an object after it has passed "official procedures".

So the use of a capability to control this privilege was a design "chose";
perhaps that's where the problem lies? 

> A process may also jump between multiple MLS labels and perform
> actions at each. This functionality requires the need for dynamic
> domain transitions. 

Only because someone chose to implement a BLP trusted process by breaking
tranquility rather than allowing write down (and leaving object labels alone).
In any case, no need to disturb the domain type right?

I freely admit my ignorance of SELinux MLS implementation details, can you
further explain why TE has to be changed to support it?

>       The implementation is fairly straightforward.  You will be
> allowed to write  to /proc/PID/attr/current.  This will require the
> new permission of "allow XXX_t  self:process setcurrent".  A second
> check will then be done to ensure that the  current context is
> allowed to dynamically transition to the new context by  requiring
> the new permission of "allow XXX_t YYY_t:process dyntransition". 
> Role allow rules are checked in the kernel just like exec-based
> transitions.  There are also constraints which will not allow a user
> change or a role change.  We have also examined the the issues of
> state inheritance and have concluded that extra checks along those
> lines would have no real security benefit. One note on this topic is
> that file descriptor access is re-validated on use. This will prevent
> lower privileged domains from using file descriptors, of a type which
> the more privileged domain only has access to, that may be open after
> a dynamic transition. 

Ah and here we have the beginning of the slippery slope.  This might be easy in
terms of lines of code, but the conceptual complexity of what you describe above
scares me.  I still wonder why we have to change TE to support a MLS convention.
I'd much rather you did not make these mechanisms dependent on each other.  

>       Since the ability to perform dynamic transitions is controlled
> by separate permission from exec-based transitions (process
> setcurrent), policy writers have the ability to not use the new
> feature.  The chain of allowable dynamic  transitions is also
> controlled on a context-pair basis.  This allows a "dynamic 
> transition group" to be treated as an equivalence class for policy
> analysis. 

Again, I wouldn't argue (anymore) about MLS tranquility, but why effect type
tranquility?

>       In closing, this feature will greatly aid the adoption of Linux
> (and SELinux of course) by current developers and users of trusted
> operating systems because it provides them with a transition tool to
> migrate their current generation applications which use privilege
> bracketing.  

Hmmm, by "trusted OSs" you mean MLS right?  There are certainly many "MLS
security engineering conventions" evolved for lower assurance MLS OSs over the
years I'd rather not see adopted for the TE portion of SELinux.  Let's give TE a
chance :-)





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
