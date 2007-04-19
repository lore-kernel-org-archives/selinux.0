Subject: Re: [PATCH][RFC] selinux: preserve boolean values
	across	policy	reloads
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4627B8C6.7070902@manicmethod.com>
References: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
	 <4627B314.8050103@manicmethod.com>
	 <1177007462.27654.187.camel@moss-spartans.epoch.ncsc.mil>
	 <4627B5DE.2030907@manicmethod.com>
	 <1177008135.27654.198.camel@moss-spartans.epoch.ncsc.mil>
	 <4627B8C6.7070902@manicmethod.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:54:31 -0400
Message-Id: <1177008871.27654.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 14:45 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-04-19 at 14:33 -0400, Joshua Brindle wrote:
> >   
> >> Stephen Smalley wrote:
> >>     
> >>> On Thu, 2007-04-19 at 14:21 -0400, Joshua Brindle wrote:
> >>>   
> >>>       
> >>>> Stephen Smalley wrote:
> >>>>     
> >>>>         
> >>>>> At present, the userland policy loading code has to go through contortions to preserve
> >>>>> boolean values across policy reloads, and cannot do so atomically.  
> >>>>> As this is what we always want to do for reloads, let the kernel preserve them instead.
> >>>>>
> >>>>>   
> >>>>>       
> >>>>>           
> >>>> Are there situation where you may want to reset the boolean state to 
> >>>> policy defaults? I can't think of realistic scenarios but if one ever 
> >>>> comes up do we want to provide that facility?
> >>>>     
> >>>>         
> >>> You can always set them after the load if you want to force them back to
> >>> those defaults.  But I don't think anything is presently using
> >>> load_policy -b.
> >>>
> >>> Alternative model is to make it a policy config flag (which I also
> >>> played with), but then you don't gain anything in libselinux wrt
> >>> removing/reducing the libsepol dependency - you still need sepol
> >>> interfaces to set/clear that flag.
> >>>   
> >>>       
> >> Thats what I was thinking. We could always have an selinuxfs node but 
> >> that is racy. It seems like we need some sort of options struct we can 
> >> send the kernel that is generated at load time and sent before the 
> >> policy so thats its atomic. Would anything else use this? compat_net for 
> >> example?
> >>     
> >
> > It seems like a lot of complication just to allow for a rare (and
> > presently unknown) case.  Policy config flags are easy enough to define
> > and we still have plenty of space for them in the existing header, but
> > then you have to resolve initial setting, preservation, and allowed
> > forms of mutation, and as I said, you'd still be requiring libselinux to
> > call libsepol to map to a policydb, mutate the flag, and map it back to
> > a policy image at load time, so you don't gain a whole lot over the
> > current genbools call (except for the atomicity of the preservation).
> >   
> Well, thats why i suggested an options struct that is independant from 
> the policydb.

That would require a new interface or new policy version.

>  But since we have no known users its fine, I just wonder 
> if we'll need something like this in the future (and we already know 
> that we have issues with eg., compat_net being set after the policy that 
> needs it is loaded)

Yep, although we reverted that later, so compat_net is only manually set
today.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
