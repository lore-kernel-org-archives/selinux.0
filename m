Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1181760372.3976.7.camel@sgc.columbia.tresys.com>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
	 <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>
	 <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>
	 <1181745113.17547.357.camel@moss-spartans.epoch.ncsc.mil>
	 <1181747197.21771.5.camel@sgc.columbia.tresys.com>
	 <1181748515.17547.380.camel@moss-spartans.epoch.ncsc.mil>
	 <1181760372.3976.7.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 15:20:38 -0400
Message-Id: <1181762438.17547.485.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-13 at 14:46 -0400, Christopher J. PeBenito wrote:
> On Wed, 2007-06-13 at 11:28 -0400, Stephen Smalley wrote:
> > On Wed, 2007-06-13 at 11:06 -0400, Christopher J. PeBenito wrote:
> > > On Wed, 2007-06-13 at 10:31 -0400, Stephen Smalley wrote:
> > > > Updated policy patch below, defines the new class and permissions,
> > > > and introduces an interface for allowing the cap_override permissions
> > > > that ensures that these domains are excluded from the set of domains
> > > > that can be controlled by unconfined domains.
> > > 
> > > [...]
> > > 
> > > > +interface(`domain_capoverride',`
> > > 
> > > I would probably call this domain_capability_override() or
> > > domain_cap_override(), maybe even domain_authoritative_caps().
> > > 
> > > > +	gen_require(`
> > > > +		attribute capoverride_domain_type;
> > > > +	')
> > > > +
> > > > +	typeattribute $1 capoverride_domain_type;
> > > > +
> > > > +	allow $1 self:cap_override $2;
> > > 
> > > I think it would be better to just have the allow rule in the TE file.
> > > Then you can put your cap_override and capability allow rules next to
> > > each other and see more clearly which ones are being overridden and
> > > which aren't.
> > 
> > Ok, so you'd prefer the patch below?
> 
> Looks good to me.
> 
> > BTW, one other issue that I noticed is that this has a side effect if I
> > grant capoverride to any of the unconfined domains (not that one should
> > do that, but still), because it seems that unconfined domains are
> > implicitly picking up permissions to self through the allow
> > unconfined_domain_type domain: rules.  Seems like those should be
> > separated?
> 
> I don't understand what the concern is, can you clarify?  I see what you
> mean about it picking up self permissions through domain, but I'm not
> sure what permissions are in question.

As a test case, I created and inserted a policy module that gave
unconfined_t the cap overrides, and immediately started getting denials
on the unconfined_t shell doing things like setpgid to its children,
because unconfined_t was then excluded from the usual allow rule by
virtue of being added to the attribute.

Any time we remove a permission from the list of permissions granted
from unconfined_domain_type to all other domains, we might lose it even
in the self case if we don't have a separate self rule.

I'm also wondering if the current idiom of using allow <domain>
self:process ~{ a b c }; isn't more confusing at this point than an
explicit enumeration of the permissions to be allowed; we keep adding
permissions that we don't want to allow by default.  Or at least those
should be converted to a common macro/pattern so that we can more easily
add exceptions.  The set complement and wildcard cases are also
problematic in their present implementation since they set all of the
other bits, not just the ones that are defined in that policy.  Possibly
set complement and wildcard should be phased out altogether for
permission sets in allow rules, just as we phased them out for types.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
