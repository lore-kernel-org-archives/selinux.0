Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13653
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 11:35:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA15757
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 16:33:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id QAA15749 for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 16:33:54 GMT
Message-Id: <200211191639.LAA14536@moss-shockers.ncsc.mil>
Date: Tue, 19 Nov 2002 11:39:45 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: login (new default_contexts)
To: selinux@tycho.nsa.gov, mayerf@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I must admit that I for one am confused about what changed with login
> and default contexts.  I'll also admit I haven't tried to look through
> the code to understand the changes yet, but perhaps someone can give a
> quick synopsis.  Before one had to have a default context in
> /etc/security/default_context to login.  From what I've seen here, it
> sounds like the file is no longer needed, but instead default_contexts
> is used, which has a different format.  
> 
> It looks like its specifying a default context for a role rather than a
> user.  Is that correct? Does the old default context still work?  Or is
> this replaced with the user's own .defaul_context?  I'm sure this was
> probably discussed in list; I'd appreciate any pointers on what the
> effect of the changes are.  

The old default_context and cron_context files were unsatisfying since
they required updates for each new user (in addition to policy/users), 
they required separate files for different programs (e.g. login/ssh vs. cron),
and at least some of the information stored in these files could be directly 
inferred from the policy and was therefore redundant.  Note that there was no 
way to specify different defaults for a local login vs. a ssh login using
these files.  These files and the corresponding libsecure functions are obsolete 
as of the October release and not used by the current versions of login,
sshd, or crond.

The new approach (implemented via new libsecure functions) is to ask the 
in-kernel security server for the set of legal SIDs for a given user that are 
reachable from the current process SID (i.e. the SID of the login, sshd, or 
crond process) and then apply a prioritization based on an optional 
$HOME/.default_contexts file and/or an optional /etc/security/default_contexts 
file to determine the default SID.

If no default_contexts configuration exists at all, then everything will still 
work, just with no prioritization (i.e. your default SID will just be whatever
the in-kernel security server happens to place first in the list).  If a 
$HOME/.default_contexts file exists and has a matching entry, then its entries 
are ranked higher in the prioritization than any matching entry in 
/etc/security/default_contexts.  This is done from the perspective that the 
selection of a default SID is not a mandatory policy issue and should be 
customizable by individual users, as long as the default SID is within the set 
of legal SIDs returned by the security server.  Any context in a 
default_contexts configuration that is not within the set of legal SIDs for the 
user that can be reached from the current process SID will be ignored.

Each line of a default_contexts file specifies an entry consisting of
a "partial context" for the calling process (i.e. login, sshd, or crond's
context) followed by a list of one or more "partial contexts" for users in the 
desired prioritization order.  A "partial context" is a context without a user 
identity value.  Partial contexts are used in the list of user contexts since 
the user identity is implicitly the user who was authenticated.  Partial 
contexts are used for the calling context to support future use by user-executed 
programs, like newrole, where the user identity will also be variable.   In the 
simplest form, an entry identifies the calling context and then provides a 
single user context to use as the default.  For crond, it is a little
more complicated due to the need to support system cron jobs with their
own security context.

The new approach eliminates the need to maintain per-user default entries 
(while still permitting it via $HOME/.default_contexts), unifies the
per-program configuration files, and draws upon information available
from the policy (by asking the in-kernel security server for the legal
set of SIDs that are reachable).  Changes that might be considered
disadvantages include:
1) Users can now specify their own defaults, as long as they remain
within the set of legal user SIDs authorized by the policy that
are reachable from the calling process. If this becomes too much of a
problem, we could shift this optional per-user information back to system 
configuration files that can only be edited by administrators.
2) If the calling process is running in the wrong domain (e.g. the
program isn't labeled properly), then the in-kernel security server
will return an empty set of legal SIDs for the user that are reachable
from it even in permissive mode.  This is not fatal for login, since
it allows you to specify a context in this case, but would prevent
ssh logins if sshd has the wrong context.

As Russell has mentioned, some policy revisions are needed to support the use of 
$HOME/.default_contexts in enforcing mode.  I'm also inclined to think that we 
can further simplify the default_contexts configuration and make even further 
use of information that is already available in the policy, but haven't explored
this yet.

There is a get_user_sids test program in libsecure/test that you can run
on a SELinux kernel to exercise the new libsecure functions in a similar
manner to how the modified login uses them.  For example: running 
'get_user_sids system_u:system_r:local_login_t root' will display the
default context and permit you to optionally select another context
from a menu, using the first parameter as the calling context and the
second parameter as the user.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
