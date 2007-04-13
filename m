Subject: Re: [Fwd: policycoreutils patches]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1176477448.8230.21.camel@localhost.localdomain>
References: <461F7D36.2070602@redhat.com>
	 <1176474662.3986.239.camel@moss-spartans.epoch.ncsc.mil>
	 <461F9611.9050204@redhat.com>
	 <1176475763.3986.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1176477448.8230.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 14:43:24 -0400
Message-Id: <1176489804.3986.291.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-13 at 11:17 -0400, Karl MacMillan wrote:
> On Fri, 2007-04-13 at 10:49 -0400, Stephen Smalley wrote:
> > On Fri, 2007-04-13 at 10:39 -0400, Daniel J Walsh wrote:
> > > Stephen Smalley wrote:
> > > > On Fri, 2007-04-13 at 08:53 -0400, Daniel J Walsh wrote:
> > > >   
> > > >> Moved audit2allow to sbin to match audit2why.
> > > >>     
> > > >
> > > > (one patch per message would be nicer)
> > > >
> > > > I actually don't like having so many of the programs in /sbin
> > > > or /usr/sbin, as they aren't in normal user paths and make it more
> > > > painful to find the commands.  And moving them can cause user confusion
> > > > and/or script breakage.  
> > > >
> > > >   
> > > Then for consistency we should move audit2why to the same directory as 
> > > audit2allow.
> > 
> > My real preference would be that the audit2why functionality would be
> > replicated (and improved) in sepolgen, and audit2allow would directly
> > use that functionality to identify the cause of the denial as part of
> > generating policy.  Then audit2allow could directly generate refpolicy
> > interface calls to e.g. add an attribute to a domain so that it passes
> > some constraint, or generate a role allow rule.  auditwhy in its current
> > form is really only to help you; it isn't very useful for end users
> > (doesn't provide enough information).
> > 
> 
> I would like to see that as well. We have also discussed moving the
> setroubleshoot plugins into sepolgen to gain broader review and improved
> maintenance. The current audit2why only provides part of the picture (as
> you say), we really want to start telling users when they should relabel
> a file, flib a boolean, or take some action _other_ than allowing the
> access via allow rules of refpolicy interfaces.

Yes, although I'm not sure the heuristic/plugin model is the right one.
Given the right support in libsepol, audit2allow/sepolgen should be able
to search the conditional avtab for conditional rules that would have
allowed the access and discover the right boolean directly from policy.
For file labeling, it might be able to probe what types are accessible
to the domain in question, and try to propose one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
