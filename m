Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1189693393.18713.71.camel@moss-spartans.epoch.ncsc.mil>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <1189689116.18713.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1189689599.3538.7.camel@localhost.localdomain>
	 <1189689910.18713.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1189691965.3391.28.camel@localhost.localdomain>
	 <1189693393.18713.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 10:42:22 -0400
Message-Id: <1189694542.3538.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 10:23 -0400, Stephen Smalley wrote:
> On Thu, 2007-09-13 at 09:59 -0400, Eric Paris wrote:
> > On Thu, 2007-09-13 at 09:25 -0400, Stephen Smalley wrote:

[...]

> > Wow, I can't believe I just heard that after being railed on for
> > considering using selinuxfs for things like handle_unknown (something
> > which specifically doesn't have large atomicity issues like compat_net)
> > Wasn't your main argument post analysis tools?  I can't imagine anything
> > worse than this to see how the system was set up.  Now when you do
> > analysis you need to look at 'setenforce' 'compat_net' 'the booleans'
> > and 'every single friggin type on the whole system.'  Your list of
> > things to look at in selinuxfs just got a bit larger....
> > 
> > I guess I'm in favor of doing it in policy...
> 
> Permissive mode (system-wide or per-domain) means that there is no
> meaningful analysis possible.

Minor detail!

>   It is purely a development tool for
> helping to discover an application's behavior as input into creating a
> policy.
> 

Well - a development tool that will be deployed on production systems.

> In your scenario, the same person supplying the application and its
> policy is likely also supplying its init script.

The world is not that simple - often people writing selinux policy in
large organizations are not the same people packaging / maintaining the
software. Not only that, selinux is _always_ an easier sell if it is
entirely self-contained.

So I'm fine if we do this via semanage and a config file that sets
permissive domains via selinuxfs on boot, but there is no way we can
sell changing init scripts by hand. Honestly, policy just seems so much
easier.

>   Thus, allowing them to
> make their domain permissive in policy isn't substantively different
> than allowing them to make it permissive in their init script (which
> should not be running in the same domain as the application itself -
> init scripts generally require different sets of permissions).
> 

See above - that is not the case.

> I see permissive mode (system-wide or per-domain) as purely as
> development tool.

You are, obviously, free to view it however you want. That doesn't
change the fact that the impetus for this feature is customers that
requested it for production systems. We should design the feature with
that use in mind.

>   Certain users may choose to employ it in production
> systems as you say, but those users aren't going to be the ones worried
> about analyzable or certifiable policy, eh?
> 

You're probably right as things are today, but why force them into
different camps?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
