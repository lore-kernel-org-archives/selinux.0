Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1HDtXZ027841
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 12:13:55 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1HCWCE014870
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 17:12:34 GMT
Message-ID: <36282A1733C57546BE392885C06185924D90DB@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Frank Mayer <mayerf@tresys.com>, Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
   selinux@tycho.nsa.gov
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Subject: RE: dynamic context transitions
Date: Mon, 1 Nov 2004 12:14:34 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I've addressed some of your concerns below.....

> -----Original Message-----
> From: Frank Mayer [mailto:mayerf@tresys.com]
> Sent: Sunday, October 31, 2004 4:48 PM
> To: 'Darrel Goeddel'; selinux@tycho.nsa.gov
> Cc: 'Stephen Smalley'; 'Chad Hanson'
> Subject: RE: dynamic context transitions
> 
> 
> [Excuse the detailed response. too many nerves were struck by 
> this proposal.]
> 
> > 	We would like to propose adding support for a trusted process to
> > alter its security context dynamically in order to support privilege
> > bracketing within an application.  We are aware that this idea has
> > been discussed in the past on the list and entirely understand the
> > concerns about non-tranquility, but we feel that this 
> feature, and its
> > implementation, have considerable merit and can be provided with
> > appropriate controls to mitigate the risks.
> 
> I fear this day would come.  I partially attribute the loss 
> of high-assurance in
> the MLS arena to loss of tranquility, and the slippery slope 
> that its loss
> starts (as greatly exploited by CMWs of the era).  On the 
> other hand Linux is a
> typical lower assurance OS so perhaps the demand for this 
> "feature" was
> inevitable.
> 

Would not running MLS and TE bring back some of the assurance that were
lost? The alternative of MLS only solutions would continue this weakness.

> >        The motivator behind this proposal is to provide a mechanism
> > for a trusted application (one written to leverage the security
> > policy) to be able to remove unnecessary privileges when they are no
> > longer needed, as well as temporarily raise the privilege level to
> > perform certain operations and then return to a less privileged
> > level.  
> 
> First a question, "leverage the security policy"; what do you 
> mean?  Second, the
> tone of the statement is that "trustedness" is a binary 
> condition.  Perhaps true
> in some MLS implementations where one has privilege to write 
> down or break
> tranquility, but not necessarily the case in type enforcement.  
> 

By "leverage the security policy", we are talking about an application that
is aware of the security policy and uses security interfaces to alter it's
state. An application doesn't have to break tranquility to perform a
privileged operation. Most MLS implmentations allow for a privilege to
override MLS policy. Also, many MLS operations require a privilege for an
operation to succeed like object upgrade or downgrade.

This issue is relevant to TE and MLS for any existing application which has
not been rewritten to a framework which execs many small executables.  A
dynamic domain transition is an implementation of privilege bracketing to
increase or decrease an application's security state.

> > By privilege level, we are referring to access to other
> > types/domains and access to security classes such as system, passwd,
> > and capability.  The former provides enhanced security for
> > applications/daemons which need access to many things to initialize,
> > but can then run with much less access to the system.  
> 
> Yes a legacy problem, so we live with it and improve over 
> time rather than
> fundamentally change to slightly improve legacy software. 
> 
> > The latter
> > method of privilege bracketing helps code audits of large
> > applications by identifying critical regions of code that require
> > more privileges to run. 
> 
> Or rather, possibly a way to achieve great sense of a false 
> assurance.  We
> evolved the so called privilege bracketing concept back in 
> the Orange Book days
> because we were stuck with legacy software, and so decided 
> that if we bracketed
> privilege, somehow the running process was of less 
> "trustedness" when the
> privilege was turned off.  I would argue the idea is not 
> necessarily valid,
> given we're talking about a single execution "domain" with 
> complete control of
> its privileges (and complete lack of control of its 
> privileges if all software
> executing within the process is not *all* entirely trusted 
> equally).  So maybe
> its better to require software engineers to be concerned 
> about all software in a
> "trusted" process, and not just that inside a privilege 
> bracket controllable by
> any software in the process.
> 

Legacy software still exists and is relevant to TE and MLS for any existing
application which has not been rewritten to a framework which execs many
small executables.  A dynamic domain transition is an implementation of
privilege bracketing to increase or decrease an application's security
state. IMHO a properly utilized privilege bracketing system can provide
strength to an application by removing future access to resources. As
software engineers, I agree we should care about all code in a trusted
process.

> > 	A goal of SELinux and trusted application programming is to
> > create smaller programs which can be secured and audited. However,
> > there are and will continue to be applications which don't fall into
> > this framework. For these applications, a privilege bracketing
> > approach provides a more granular security framework than what
> > currently exists from SELinux today at process level.
> 
> You are certainly correct about the need for legacy software. 
>  However, perhaps
> we achieve less assurance through loss of tranquility, and 
> the long term effect
> that will have (i.e., by continuing poor application security 
> engineering) than
> we would get by leaving tranquility, understanding the 
> privileges associated
> with an entire process, and working towards better 
> trustworthy applications in
> the future.  I fear the alternative you suggest is that the 
> weak (or false)
> assurance we achieve by bracketing will become the norm.
>  

The goal is always to increase the security of systems. We should try to
improve existing applications and write new applications to utilize the best
technologies that exist. We cannot, however, expect the entire realm of MLS
software to be rewritten to meet new paradigms. We can greatly increase the
security of the existing application by placing more granular controls on
operations performed by the app.

> > 	The MLS model is another reason for this functionality. We have
> > chosen to create MLS policy overrides using a new SELinux MLS
> > capability class. 
> 
> I have not thought greatly about this choice, but I wonder if 
> it was wise to
> make the MLS mechanism dependent on the capability mechanism. 
>  Orthogonal
> mechanisms would seem smarter.  
> 

The MLS Capabilities are an SELinux class and not dependent on the Linux
Capability system.

> > Trusted MLS applications may require a specific
> > capability to satisfy or "temporarily" override a policy to change
> > the MLS label of an object after it has passed "official 
> procedures".
> 
> So the use of a capability to control this privilege was a 
> design "chose";
> perhaps that's where the problem lies? 
> 

Whether it is a capability or an explicit allow rule, the ability needs to
be granted to change object MLS attributes, same as TE.

> > A process may also jump between multiple MLS labels and perform
> > actions at each. This functionality requires the need for dynamic
> > domain transitions. 
> 
> Only because someone chose to implement a BLP trusted process 
> by breaking
> tranquility rather than allowing write down (and leaving 
> object labels alone).
> In any case, no need to disturb the domain type right?
> 

There is no need to disturb the domain type for a MLS label change.

> I freely admit my ignorance of SELinux MLS implementation 
> details, can you
> further explain why TE has to be changed to support it?
> 
> >       The implementation is fairly straightforward.  You will be
> > allowed to write  to /proc/PID/attr/current.  This will require the
> > new permission of "allow XXX_t  self:process setcurrent".  A second
> > check will then be done to ensure that the  current context is
> > allowed to dynamically transition to the new context by  requiring
> > the new permission of "allow XXX_t YYY_t:process dyntransition". 
> > Role allow rules are checked in the kernel just like exec-based
> > transitions.  There are also constraints which will not allow a user
> > change or a role change.  We have also examined the the issues of
> > state inheritance and have concluded that extra checks along those
> > lines would have no real security benefit. One note on this topic is
> > that file descriptor access is re-validated on use. This 
> will prevent
> > lower privileged domains from using file descriptors, of a 
> type which
> > the more privileged domain only has access to, that may be 
> open after
> > a dynamic transition. 
> 
> Ah and here we have the beginning of the slippery slope.  
> This might be easy in
> terms of lines of code, but the conceptual complexity of what 
> you describe above
> scares me.  I still wonder why we have to change TE to 
> support a MLS convention.
> I'd much rather you did not make these mechanisms dependent 
> on each other.  
> 

If these are independent, TE would not be able to control/restrict
operations from the MLS policy. The addition of a dynamic transition
provides an extra ability, only when necessary, to tighten the security of a
process.

> >       Since the ability to perform dynamic transitions is controlled
> > by separate permission from exec-based transitions (process
> > setcurrent), policy writers have the ability to not use the new
> > feature.  The chain of allowable dynamic  transitions is also
> > controlled on a context-pair basis.  This allows a "dynamic 
> > transition group" to be treated as an equivalence class for policy
> > analysis. 
> 
> Again, I wouldn't argue (anymore) about MLS tranquility, but 
> why effect type
> tranquility?

In SELinux, the type is the basis for all non-MLS decisions. One cannot tie
abilities to specific MLS levels, so the process type is the bearer of
security rights. 

> 
> >       In closing, this feature will greatly aid the 
> adoption of Linux
> > (and SELinux of course) by current developers and users of trusted
> > operating systems because it provides them with a transition tool to
> > migrate their current generation applications which use privilege
> > bracketing.  
> 
> Hmmm, by "trusted OSs" you mean MLS right?  There are 
> certainly many "MLS
> security engineering conventions" evolved for lower assurance 
> MLS OSs over the
> years I'd rather not see adopted for the TE portion of 
> SELinux.  Let's give TE a
> chance :-)
> 

I think TE can be very beneficial to upgrade the state of existing MLS
solutions.  We just need to provide a migration path for existing
appplications and create new and better MLS applications in the future.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
