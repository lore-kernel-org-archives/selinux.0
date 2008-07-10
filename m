Subject: Re: newrole assertion - should be gnome-terminal assertion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joe Nall <joe@nall.com>
In-Reply-To: <cadfc0e40807091517k2a40dcecl90c99bd8e971685a@mail.gmail.com>
References: <cadfc0e40807081202l7badbcb8h84ee373161fd6fd2@mail.gmail.com>
	 <1215617024.24864.28.camel@moss-spartans.epoch.ncsc.mil>
	 <4875026A.3040104@gmail.com>
	 <cadfc0e40807091517k2a40dcecl90c99bd8e971685a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 08:09:31 -0400
Message-Id: <1215691771.31554.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-07-09 at 17:17 -0500, Xavier Toth wrote:
> On Wed, Jul 9, 2008 at 1:24 PM, Ted X Toth <txtoth@gmail.com> wrote:
> > Stephen Smalley wrote:
> >>
> >> On Tue, 2008-07-08 at 14:02 -0500, Xavier Toth wrote:
> >>
> >>>
> >>> Using MLS enforcing in a gnome-terminal with context
> >>> user_u:user_r:user_t:s0-s15:c0.c1023 I run newrole and get these
> >>> results
> >>>
> >>> newrole -l s1-s1 -- -c "gnome-terminal --disable-factory"
> >>> Password:
> >>> **
> >>> ** ERROR:(terminal.c:1016):new_terminal_with_options: assertion
> >>> failed: (profile)
> >>>
> >>>
> >>> I think Joe straced this and has a little more info if he'd like to chime
> >>> in.
> >>>
> >>
> >> So, I assume that this does not happen if in permissive mode?
> >> What AVC denials occur?  Run semodule -DB and retry if there are no AVCs
> >> by default.
> >>
> >> What is the application trying to do at that point (look at the source
> >> code and/or ask on the gnome lists)?  What are the possible failure
> >> conditions there?  What external dependencies does it have?
> >> strace output might help if you have it.
> >>
> >>
> >
> > Sorry to have bothered you. Looks like it has something to do with
> > polyinstantiation of ~/.gnome or ~/.gnome2. We haven't seen this with
> > previous versions even when polyinstantiating :(
> >
> >
> 
> Hmmm this was a bit of a rush to judgment :( It actually turned out
> that if I don't polyinstantiate /tmp then I can start gnome-terminal
> as shown in permissive but it still doesn't work in enforcing. I tried
> turning off dontaudit but I'm not seeing any  AVC out of
> gnome-terminal. I've attached a strace maybe you'll see something that
> I don't.

Look for any avcs at all - they might be occurring during the
polyinstantiation, or from dbus, or from the X server.

Also, run the strace while permissive and diff the two strace outputs to
see how they differ (imperfect, there will be noise, but helpful
nonetheless).

I see quite a few ENOENTs in there, e.g. on the .gnome2 files, not sure
how many of those are expected/harmless.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
