Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single
	program
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1178637238.25354.29.camel@localhost.localdomain>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
	 <1178637238.25354.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 May 2007 11:34:14 -0400
Message-Id: <1178638454.6056.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 11:13 -0400, Karl MacMillan wrote:
> On Fri, 2007-05-04 at 15:19 -0400, Stephen Smalley wrote:
> > restorecon started life as a much simpler program, but has gradually
> > grown to being largely a duplicate of setfiles, only differing in its
> > interface and default behaviors.  Meanwhile, people keep adding features
> > and options to both programs, leading to inconsistencies.
> > 
> > This patch coalesces setfiles and restorecon into a single program
> > presenting different interfaces and default behaviors depending on
> > basename(argv[0]), making restorecon a symlink to setfiles.
> > 
> > Unresolved issue: Current policy defines separate domains for the two
> > programs.  We need to either coalesce the domains as well, or if there
> > is legitimate reason for separating them, restorecon could remain a
> > separate binary (either a complete separate copy or a wrapper) even if
> > the sources are coalesced.
> > 
> > Comments?
> > 
> 
> I'm fine with this change (and the associated bug fix).
> 
> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Ok.  Does anyone have any comments on the policy issue for setfiles vs.
restorecon?  Should we just collapse restorecon_t and restorecon_exec_t
down to typealiases for setfiles_t and setfiles_exec_t for
compatibility?  Or do we need to keep them separated?  In the past, some
people have suggested that restorecon is "safer" since it doesn't let
the caller specify the file contexts file, but I tend to view that as
illusory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
