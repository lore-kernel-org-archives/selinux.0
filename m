Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single
	program
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 11 May 2007 10:38:38 -0400
Message-Id: <1178894318.11064.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 15:19 -0400, Stephen Smalley wrote:
> restorecon started life as a much simpler program, but has gradually
> grown to being largely a duplicate of setfiles, only differing in its
> interface and default behaviors.  Meanwhile, people keep adding features
> and options to both programs, leading to inconsistencies.
> 
> This patch coalesces setfiles and restorecon into a single program
> presenting different interfaces and default behaviors depending on
> basename(argv[0]), making restorecon a symlink to setfiles.
> 
> Unresolved issue: Current policy defines separate domains for the two
> programs.  We need to either coalesce the domains as well, or if there
> is legitimate reason for separating them, restorecon could remain a
> separate binary (either a complete separate copy or a wrapper) even if
> the sources are coalesced.
> 
> Comments?
> 

This and the bug fix patch were merged into trunk and policyrep.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
