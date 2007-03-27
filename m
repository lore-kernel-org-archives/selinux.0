Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
	applet)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1175010151.29300.39.camel@sgc>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1174925566.28830.61.camel@sgc>
	 <1174927054.12204.45.camel@localhost.localdomain>
	 <1174939981.28830.84.camel@sgc>
	 <1174999512.3864.278.camel@moss-spartans.epoch.ncsc.mil>
	 <1175010151.29300.39.camel@sgc>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 11:48:18 -0400
Message-Id: <1175010498.3864.370.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 11:42 -0400, Christopher J. PeBenito wrote:
> On Tue, 2007-03-27 at 08:45 -0400, Stephen Smalley wrote:
> > On Mon, 2007-03-26 at 20:13 +0000, Christopher J. PeBenito wrote:
> > > On Mon, 2007-03-26 at 12:37 -0400, Karl MacMillan wrote:
> > > > On Mon, 2007-03-26 at 12:12 -0400, Christopher J. PeBenito wrote:
> > > > > In my personal opinion, if you are really going tiny, that means its a
> > > > > customized system, which includes customized policy.  That means you
> > > > > should be setting the correct initial boolean values when you build the
> > > > > policy, which also means monolithic instead of modular.
> > > > 
> > > > What if the booleans are used to represent runtime state, for example
> > > > different security settings when a PDA is docked as opposed to undocked?
> > > > In that case there is no reasonable default and not preserving the
> > > > current values could cause serious problems.
> > > 
> > > I disagree.  The correct answer is whichever state the device assumes
> > > when it powers up.  PDAs already have to determine that type of state
> > > when they power up after the initial setup, so at that time when it
> > > determines the state, it can also set the boolean.
> > 
> > The state might be set by the user, e.g. knowing that I am about to take
> > my PDA out of the building, I set or clear a boolean to lock it down,
> > and I don't want that to be unlocked until I take explicit action to do
> > so - reboot shouldn't reset it.
> 
> Using the power button on a PDA doesn't shut it down, it does something
> more like putting it into standby mode so it can still pop up calendar
> reminders.  Thus, when it "turns on" it still has the same boolean
> states.  The only time it boots is because the battery was just dead, or
> you force it because the system is locked up (or some similar reason).
> Both reset the device state too, and then falling back to the defaults
> would be the anticipated behavior.  If a lock down is supposed to
> survive even that, I would argue that its not a state, its a
> configuration and that the tunables are the way to go.

Ok, so what I'm hearing is that we don't need to preserve support for
local boolean and user definitions apart from managed policy.  If anyone
disagrees, speak up please.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
