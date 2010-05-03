Subject: Re: /etc/initscript breaks SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
In-Reply-To: <4BDF07E1.2020500@gmail.com>
References: <p2vdd18b0c31005022154obbc1db15s4e01c5821bf7baa2@mail.gmail.com>
	 <1272904285.20339.82.camel@moss-pluto.epoch.ncsc.mil>
	 <4BDF0059.7050907@gmail.com>
	 <1272906164.20339.107.camel@moss-pluto.epoch.ncsc.mil>
	 <4BDF07E1.2020500@gmail.com>
Content-Type: text/plain
Date: Mon, 03 May 2010 13:32:40 -0400
Message-Id: <1272907960.20339.131.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-03 at 10:29 -0700, Justin P. Mattock wrote:
> On 05/03/2010 10:02 AM, Stephen Smalley wrote:
> > On Mon, 2010-05-03 at 09:56 -0700, Justin P. Mattock wrote:
> >> On 05/03/2010 09:31 AM, Stephen Smalley wrote:
> >>> On Sun, 2010-05-02 at 21:54 -0700, Justin Mattock wrote:
> >>>> I've been racking my brain for the last few days on
> >>>> this one, and seem(for the life of me), have no solution.
> >>>>
> >>>> at first thought this was opensuse specific, but it's not
> >>>> i.g. my cblfs systems hit this as well(if not all systems at that).
> >>>>
> >>>> when adding /etc/initscript somehow SELinux can't figure how to
> >>>> transistion with the whole SHELL -c thing.
> >>>>
> >>>> under init.c #800(sysvinit-2.85)
> >>>> the code is this:
> >>>>
> >>>>    /* See if there is an "initscript" (except in single user mode). */
> >>>>     if (access(INITSCRIPT, R_OK) == 0&&   runlevel != 'S') {
> >>>> 	/* Build command line using "initscript" */
> >>>> 	args[1] = SHELL;
> >>>> 	args[2] = INITSCRIPT;
> >>>> 	args[3] = ch->id;
> >>>> 	args[4] = ch->rlevel;
> >>>> 	args[5] = "unknown";
> >>>> 	for(f = 0; actions[f].name; f++) {
> >>>> 		if (ch->action == actions[f].act) {
> >>>> 			args[5] = actions[f].name;
> >>>> 			break;
> >>>> 		}
> >>>> 	}
> >>>>
> >>>>
> >>>> any ideas why SELinux gets confused with this, and
> >>>> doesn't want to transistion?
> >>>
> >>> In the above code, you are exec'ing the shell and just passing the
> >>> script as an argument, not exec'ing the script.  So you need a domain
> >>> transition on the shell rather than the script, or you need to perform a
> >>> setexecon() in the code.
> >>>
> >>
> >> Thanks for the info on this..
> >>
> >> I'll have a look at seeing how todo this
> >> (I enjoy the challenge).
> >>
> >> As an example on setexecon() I was looking
> >> at the sulogin.c patch for SELinux, but still
> >> need to figure out how to actually do this.
> >
> > Well, you can do it without using setexeccon() just by configuring
> > policy to domain transition from init_t to initrc_t on shell_exec_t.
> > That's what happens if you enable init_upstart=on.  So I think it is
> > mostly just a matter of making that the default and dropping the legacy
> > transition to sysadm_t for single-user mode.
> >
> 
> what/where is that code at in the policy?
> (I've looked but can seem to grep the right word).

system/init.te, line 182:
tunable_policy(`init_upstart',`
        corecmd_shell_domtrans(init_t, initrc_t)
',`
        # Run the shell in the sysadm role for single-user mode.
        # causes problems with upstart
        sysadm_shell_domtrans(init_t)
')

> As for the dropping the legacy(as mentioned in this post:
> http://oss.tresys.com/pipermail/refpolicy/2010-February/002012.html)

Yes, that was the prior discussion.

> tough to say... right now(as a learning experience) I'll dive into
> sysvinit(because I need to get better at reading/writing code),
> as well as do the same for the policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
