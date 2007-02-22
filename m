Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <658470.80842.qm@web51508.mail.yahoo.com>
References: <658470.80842.qm@web51508.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 07:34:09 -0500
Message-Id: <1172147649.14363.312.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-21 at 10:26 -0800, Steve G wrote:
> >Actually, you could guess "/selinux" and drop back to dynamically determining if
> >that failed.
> 
> This approach works and saves about 7 syscalls. This is the diff of running
> selinuxenabled with and without the attached patch.
<snip>
> This improves performance, falls back to the old method when the guess is wrong,
> and checks that /selinux really is an selinuxfs.
> 
> While reading through the is_enabled code, I realized something. Right before the
> call to getcon_raw(), we decide that its enabled. If the getcon_raw() fails, we
> still consider it enabled. Only if the call return success do we do a test and
> consider it disabled. I don't know if that's good or bad, but I copied the
> behavior. Seems suspicious to me.

That was intentional; likely should add a comment.  The presence of
selinuxfs in /proc/filesystems is a strong indicator that SELinux is
enabled; the getcon test was added later to detect no-policy-loaded, but
could fail for other reasons and I didn't want a failure there to lead
to a selinux-disabled status (particularly given that programs today
usually only check for is_selinux_enabled() > 0).  The only case where a
SELinux system today should have selinuxfs in /proc/filesystems but
no-policy-loaded is if SELINUX=permissive and init wasn't able to load
policy for some reason (e.g. no policy or corrupted policy file); if
SELINUX=enforcing, then init should halt if it can't load policy, and if
SELINUX=disabled, init will use /selinux/disable to turn off SELinux,
which unregisters selinuxfs too.

Patch looks basically sane; a couple of minor points:
- Let's move the existing SELINUXMNT definition used by
src/load_policy.c for mounting selinuxfs for initial policy load to a
private header (e.g. src/policy.h) and use it in this code rather than
repeating the "/selinux" string each time.
- SELINUX_MAGIC doesn't need to be exposed outside of the library, so
I'd put it into src/policy.h too instead of a public header.
- Why u_int32_t instead of just long (per the statfs man page)?  And if
we need to use a fixed size type, we should use C99 style i.e. uint32_t
going forward - a recently merged patch converted all occurrences in
libselinux over to C99 style.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
