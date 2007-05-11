Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single
	program
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1178894318.11064.0.camel@localhost.localdomain>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
	 <1178894318.11064.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 May 2007 17:06:55 +0000
Message-Id: <1178903215.11827.7.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-11 at 10:38 -0400, Karl MacMillan wrote:
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
> This and the bug fix patch were merged into trunk and policyrep.
> 
> Karl

The related policy changes have been committed to trunk.  Those that are
interested in the policy change can see:

http://oss.tresys.com/projects/refpolicy/changeset/2293

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
