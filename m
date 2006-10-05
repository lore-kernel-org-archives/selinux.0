Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
In-Reply-To: <45252DB9.4000506@us.ibm.com>
References: <452432FA.1060009@us.ibm.com>
	 <1160059227.2132.88.camel@moss-spartans.epoch.ncsc.mil>
	 <45252DB9.4000506@us.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 13:40:12 -0400
Message-Id: <1160070012.2132.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 11:07 -0500, Michael C Thompson wrote:
> >> The cleanup process for errors within newrole currently does not make a 
> >> call to pam_end (after pam_start). Is this an issue? There are also 
> >> other cases where cleanup isn't really handled as nicely as it could. 
> >> Since this is a user-space app, a lot of cleanup is handled by the 
> >> kernel, but I do have some patches that go a ways to begin cleaning this 
> >> sort of thing up. Are they desirable?
> > 
> > Yes.
> 
> OK, shall I merge these changes into 1 large patch? or how would you 
> like this delivered? I can do some seperate smaller patches, which take 
> care of cleanup, and then those that take care of adding suid related 
> changes.

Separated patches are nice, but I suspect it depends on the specifics,
e.g. in some cases you are completely reworking the code path, and thus
cleaning up the old error paths becomes fairly useless when you go to
apply your other changes.

> >> I have tested all 4 ways of compiling newrole (no priv, AUDIT_LOG_PRIV, 
> >> NAMESPACE_PRIV, LSPP_PRIV (both)), and it functions as expected.
> > 
> > Did you check the effective identity and capability sets at each stage
> > of execution to see if they were what you expected?  Within newrole
> > after each change?  On entry to pam_namespace?  On entry to
> > namespace.init?  In the newrole'd shell?
> 
> I have run this with debug output (omitted from my patches) and yes the 
> capabilities, uid and euid are all as I expected them to be. I did not 
> check the capabilities on entrance to namespace.init since I would 
> require rebuilding pam_namespace.so, I can do this if desired. From 
> looking at the code, it didn't look like pam_namespace did anything to 
> the capabilities or uids, but I'm only human, so I could be wrong.

Ok, but it is still the case that bash explicitly resets the effective
uid to the real uid unless invoked with -p as a safety precaution, so
namespace.init runs in the caller's uid.  You don't need to rebuild
pam_namespace to see that - just run 'id' in namespace.init.  You would
need to modify the header line of namespace.init to include -p to avoid
that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
