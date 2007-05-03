Subject: Re: Where to specific the handling of unknown kernel classes and
	perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4639E183.4080909@manicmethod.com>
References: <1178141128.3897.33.camel@dhcp59-235.rdu.redhat.com>
	 <463930F3.7020803@manicmethod.com>
	 <1178196394.3443.135.camel@moss-spartans.epoch.ncsc.mil>
	 <4639E183.4080909@manicmethod.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 09:54:39 -0400
Message-Id: <1178200479.3443.172.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-03 at 09:20 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-05-02 at 20:46 -0400, Joshua Brindle wrote:
> >   
> >> Eric Paris wrote:
> >>     
> >>> I just sent out a kernel patch with the tristate flag to change kernel
> >>> handling of unknown classes and permissions.  The idea is that when the
> >>> policy is created someone can set the flag to any of the three options
> >>> (deny/reject/allow) and the kernel will act accordingly.  My problem is
> >>> I don't understand the userspace tools which create policy.  I patched
> >>> libsepol to support this new flag when it reads or writes a policydb,
> >>> which allows me to edit my policy.21 by hand in hex and then call
> >>> load_policy to test my kernel.  My problem now is that I don't know
> >>> where a user should be specifying how they want the flags to be set.  To
> >>> be perfectly honest after a bit of searching I'm not even sure where
> >>> policy.21 gets created when I build a policy.
> >>>
> >>>   
> >>>       
> >> It should be setable in semanage.conf or by checkpolicy if building a 
> >> monolithic policy.
> >>     
> >
> > Hmm...actually, I would have argued that it should only be settable by
> > checkpolicy/checkmodule, and always inherited from the base module in
> > the link/expand case.  That way we can always know what the kernel
> > behavior is by looking at the base module, vs. having to separately look
> > at semanage.conf.  It is a tradeoff though in terms of analyzability vs.
> > ease of customization
> Even if it is propagated from the base policy I think it should be 
> overridable in semanage.conf. Propagating it from base means we'll have 
> to extend the policy server object model to cover it but that is no big 
> deal. The reason semanage.conf would be nice is to change the behavior 
> locally on RH systems without rebuilding the base policy.

I understand that, but as semanage.conf is not "managed" (just a config
file to rpm and not managed by libsemanage itself) and changes to it are
not audited, this means that you won't be able to tell easily what
behavior was in effect at a given time.  That's the tradeoff.

Regardless, for Eric's purposes, it would be sufficient for basic
operation to add a command line flag to checkpolicy and checkmodule to
set these flags in monolithic policy and base modules, and to modify
libsepol (in particular, expand_module()) to propagate the base flags in
the same manner as it already does for the mls flag.  Then he or we can
separately add a libsepol interface to mutate the flag and modify
libsemanage to use that interface and have a new semanage.conf setting.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
