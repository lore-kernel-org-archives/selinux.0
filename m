Subject: Re: system_u:system_r:system_chkpwd_t:UNCLASSIFIED, how did I get
	here?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <475ACE83.30609@gmail.com>
References: <475ACE83.30609@gmail.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 09:55:56 -0500
Message-Id: <1197298556.18120.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-12-08 at 11:04 -0600, Ted X Toth wrote:
> I'm running F8 with MLS reference policy (in permissive right now) and 
> I'm trying to understand how I get into this context. I can understand 
> how at some point while authenticating a transition to 
> system_u:system_r:system_chkpwd_t would occur by virtue of running 
> unix_chkpwd but then why wouldn't a transition to user_u:user_r:<*>_t 
> happen? Also I'd like to understand how policy for pam, since it's a 
> bunch of shared libraries, works. Are there any good sources of 
> information on writing policy for shared libraries?

getdefaultcon in libselinux/utils can help you with investigating what
context will be returned for a given user and from-context (i.e. context
of the login process).

First question is why is the user being mapped to system_u?  Bad seusers
configuration?  semanage login -l

As for chkpwd, get_ordered_context_list() first asks the kernel for the
full set of reachable contexts for the user via security_compute_user(),
which merely checks process transition permission.  Thus, the chkpwd
context is included in that set since it is reachable (since the login
process does in fact transition to it when executing unix_chkpwd).  But
it normally gets pruned from the final list based
on /etc/selinux/$SELINUXTYPE/contexts/default_contexts.  However, if no
matches are found there, it will return the original list from the
kernel, and thus you could end up there (in permissive mode).  There has
been some talk of overhauling get_ordered_context_list.

With regard to pam, there are no domain transitions on function calls,
only on execve, so there are no domain transitions when invoking pam
modules, only when those modules invoke helper programs like
unix_chkpwd.  The pam modules themselves run within the domain of the
caller.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
