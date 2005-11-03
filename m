Subject: Re: [PATCH] libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jonathan Kim <jkim@TrustedCS.com>
Cc: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>
	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 15:33:41 -0500
Message-Id: <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-03 at 15:10 -0500, Stephen Smalley wrote:
> On Thu, 2005-11-03 at 14:33 -0500, Jonathan Kim wrote:
> > This patch is for handling correctly when label portion is removed from
> > seusers file. 
> > Will refer to *.users file instead of asking role:type:level to user as
> > expected.
> 
> I'm not sure that this is what you want.  Keep in mind that seusers is
> intended to allow you to assign ranges and role sets (aka SELinux users)
> to individual Linux users without requiring any modification to SELinux
> policy (even at policy load time, which is going away with the advent of
> libsemanage; SETLOCALDEFS=0 should become the norm
> for /etc/selinux/config soon).  If you don't want to use seusers at all,
> you can certainly omit it from your policy, in which case things will
> fall through to the usual logic, and you can even do that per-user by
> omitting an entry for that user entirely from seusers, but I'm not clear
> on why you would have an entry for the Linux user but no level there -
> that means that you still need per-Linux user entries in your policy for
> the range authorizations, which defeats the purpose of having the user
> in seusers at all.

Just to note:  I'm not opposed to the patch per se (although it might be
better to treat this as an error condition rather than falling through
to the base user definitions, as they may give wider access then you
want since multiple Linux users may be mapped to a single SELinux user),
but I'm unclear about why one would use an empty level in this manner in
seusers versus just omitting the entry for the user altogether if you
want the fallback behavior.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
