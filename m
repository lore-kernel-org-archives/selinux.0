Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Todd Miller <tmiller@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1187280118.909.22.camel@moss-spartans.epoch.ncsc.mil>
References: <20070815204411.705994826@tresys.com>
	 <1187190639.2674.51.camel@localhost.localdomain>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1187205378.2838.12.camel@localhost.localdomain>
	 <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1187209022.2838.38.camel@localhost.localdomain>
	 <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1187210504.2838.56.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com>
	 <1187212166.2838.73.camel@localhost.localdomain>
	 <1187280118.909.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 17 Aug 2007 09:31:10 -0400
Message-Id: <1187357470.9435.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 12:01 -0400, Stephen Smalley wrote:
> On Wed, 2007-08-15 at 17:09 -0400, Karl MacMillan wrote:
> > On Wed, 2007-08-15 at 16:47 -0400, Joshua Brindle wrote:

[...]

> 
> I guess I'm confused.  genhomedircon has been present in upstream
> selinux for some time, so we can't just remove it without providing
> equivalent functionality.
> 

Well - it would have to be coordinated with policy updates. I guess I'd
be fine with providing a way to optionally run it.

> Not generating per-role types can be done by shipping a homedir_template
> with no "macros" (ROLE).
> 
> It doesn't actually walk all users, does it? 

Not the current version.

>  Just ones that have
> explicit entries in seusers (everyone else falling back to the default
> and having their home directories labeled with the base set of home
> directory types for user_t).
> 

I'm still concerned about the number of calls out to a directory for a
large seusers file and eventually I want to push the seusers mapping
into the directory as well.

I'm also thinking about when we finally have labeled, remote home
directories. Each system trying to label home directories based on its
view of the default role for a user is going to break horribly.

> So what's the real problem with leaving it intact, and just changing
> your usage if you don't want per-role home directory types.
> 

If it can be completely disabled that's fine (this is assuming that Dan
wants to make this change on home directory labeling). What I'm really
pushing for is reconsidering whether the current practice makes sense
and considering the problems that it causes. I'm probably go about this
the wrong way as there hasn't been much discussion on that point.

As I'm trying to make user home directories work in a typical remote
homedir / directory setting I would like to get the defaults changed
sooner so that when that support finally shows up we are ready.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
