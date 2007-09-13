Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1189691965.3391.28.camel@localhost.localdomain>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <1189689116.18713.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1189689599.3538.7.camel@localhost.localdomain>
	 <1189689910.18713.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1189691965.3391.28.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 10:23:13 -0400
Message-Id: <1189693393.18713.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 09:59 -0400, Eric Paris wrote:
> On Thu, 2007-09-13 at 09:25 -0400, Stephen Smalley wrote:
> > On Thu, 2007-09-13 at 09:19 -0400, Karl MacMillan wrote:
> 
> > > > Is it truly something we want expressed in policy, or something that
> > > > should just be controlled via selinuxfs (i.e. create
> > > > a /selinux/permissive directory with one node per domain, and let you
> > > > write a 0 or 1 to those nodes to make them permissive or enforcing)?
> > 
> > On second thought, that should likely instead be a /selinux/domains
> > directory with one subdirectory per domain and an "enforce" node in each
> > subdirectory, so that it more closely matches the
> > existing /selinux/enforce interface and so that we can later add other
> > domain-related state and settings there.
> > 
> > > > The latter would be more akin to the existing permissive mode and avoid
> > > > needing to change anything in policy.  Should be subject to a kernel
> > > > config option too, so we can still build kernels with no permissive
> > > > support at all.
> > > > 
> > > 
> > > I suggested the policy option because:
> > > 
> > > * it needs to persist across reboots and putting it in the policy makes
> > > that simple.
> > 
> > Put:
> > echo -n 0 > /selinux/domains/httpd_t/enforce
> > in the /etc/init.d/httpd script and you're done.
> > But I'm not sure when/why you want that anyway.
> 
> I, the IT guy, just wrote policy for my large trading application.  Here
> on my machine/test environment I tried to test it every way I could to
> exercise all of the code but I probably missed something.  If I break
> this application in production we lose X amount of money and I'm out of
> a job.  How many such people would pull that application out from
> unconfined_t ???
> 
> How many would be willing to run the application in a permissive domain
> for 3 months to see how many code paths they missed?  Only then removing
> the permissive portion of that domain and 'using' selinux.
> Maybe they could do it in their init script, but now they have to
> somehow manage their initscripts and their policy together.  Its never
> easy to make sure that multiple packages are updated at the same time,
> we've seen that over and over.  On an application like this, I wouldn't
> even be surprised if they couldn't add such a thing to startup due to
> some arcane requirement from the propietary vendor or just their own in
> shop policies.  
> 
> Then again do we really want to give initscripts the power to decide
> themselves if they are going to be confined or not?  /me doesn't think
> giving initscripts loadpolicy permissions is a very good idea, nor does
> giving a domain permission to turn on/off its own permissiveness....
> 
> > 
> > > * some of our customers want this to be used on production systems, so
> > > the ability to analyze policy taking into account permissive domains
> > > seems desirable.
> > 
> > I don't quite follow that - if you are enabling permissive mode (whether
> > system-wide or per-domain) in production use, what can you meaningfully
> > say anyway in terms of "analysis" - all information flow is possible
> > through that domain, period. 
> > 
> > Also, consider the parallel with the system-wide enforcing mode or with
> > non-persistent boolean settings.
> > 
> > Analysis tools can of course read the current settings from selinuxfs if
> > they want to assess the current state of the machine.
> 
> Wow, I can't believe I just heard that after being railed on for
> considering using selinuxfs for things like handle_unknown (something
> which specifically doesn't have large atomicity issues like compat_net)
> Wasn't your main argument post analysis tools?  I can't imagine anything
> worse than this to see how the system was set up.  Now when you do
> analysis you need to look at 'setenforce' 'compat_net' 'the booleans'
> and 'every single friggin type on the whole system.'  Your list of
> things to look at in selinuxfs just got a bit larger....
> 
> I guess I'm in favor of doing it in policy...

Permissive mode (system-wide or per-domain) means that there is no
meaningful analysis possible.  It is purely a development tool for
helping to discover an application's behavior as input into creating a
policy.

In your scenario, the same person supplying the application and its
policy is likely also supplying its init script.  Thus, allowing them to
make their domain permissive in policy isn't substantively different
than allowing them to make it permissive in their init script (which
should not be running in the same domain as the application itself -
init scripts generally require different sets of permissions).

I see permissive mode (system-wide or per-domain) as purely as
development tool.  Certain users may choose to employ it in production
systems as you say, but those users aren't going to be the ones worried
about analyzable or certifiable policy, eh?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
