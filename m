Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single
	program
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 08 May 2007 15:40:54 +0000
Message-Id: <1178638854.25271.41.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 15:19 -0400, Stephen Smalley wrote:
> Unresolved issue: Current policy defines separate domains for the two
> programs.  We need to either coalesce the domains as well, or if there
> is legitimate reason for separating them, restorecon could remain a
> separate binary (either a complete separate copy or a wrapper) even if
> the sources are coalesced.

There shouldn't be any problem merging restorecon_t into setfiles_t.
The only real difference of consequence is that setfiles can read its
file_contexts from sysadm home dir.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
