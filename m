Subject: Re: Adding audit messge to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Chris Wright <chrisw@osdl.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051221174113.9362.qmail@web51510.mail.yahoo.com>
References: <20051221174113.9362.qmail@web51510.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 13:09:15 -0500
Message-Id: <1135188555.18223.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-21 at 09:41 -0800, Steve G wrote:
> >Why don't you drop capabilities first, then switch to the real uid?
> 
> You answered yourself. Need setuid capabilities.

Yes, but I'm still not sure about the implications.  Not all kernel
operations compare capability sets, e.g. signals only compare the uids
of the relevant tasks.  So if you switch to the caller's uid while still
possessing all capabilities, you may be opening yourself to manipulation
by the caller.  ptrace does compare the permitted sets for a subset
relationship.  Might still be safer to shed everything you can first,
and then drop CAP_SETUID last after the setuid.

> Any reason we can't move this up earlier in main()?
> 
> I suppose we could move it above the selinux enabled call.
> 
> >Ideally, it should be the first thing in main() to ensure that everything 
> >else runs under the caller's uid as before.
> 
> But after the bindtext call for localization?

I would assume before, as you otherwise risk still having uid 0 and
capabilities at that point if there is some locale-related exploit.
Purging the environment on entry to main() wouldn't hurt either.
http://www.dwheeler.com/secure-programs/Secure-Programs-HOWTO/

> I generally prefer to use the stack on small programs. Its less complicated and
> runs faster. We aren't short for stack space in this program. My comment may be
> misleading you. i wanted to say that its an arbitrary number and can be changed
> if someone decideds its safe to make it bigger or smaller. Is there a define that
> has the maximum string representation of a context?

No, there is no maximum imposed by SELinux itself.  Certain kernel
interfaces (/proc/pid/attr, selinuxfs) presently limit them to no more
than PAGE_SIZE, but the core SELinux code doesn't bound them.  xattrs
are only "limited" to 64K.  In any event, with the fixed value, you risk
truncation of the audit message (especially the new context). 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
