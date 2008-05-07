Subject: Re: [PATCH v4] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0805072342570.15234@us.intercode.com.au>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
	 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
	 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
	 <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805072342570.15234@us.intercode.com.au>
Content-Type: text/plain
Date: Wed, 07 May 2008 11:12:03 -0400
Message-Id: <1210173123.6434.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-07 at 23:45 +1000, James Morris wrote:
> On Wed, 7 May 2008, Stephen Smalley wrote:
> 
> > So the next question is whether there are any other cases where we want
> > to use this variant interface.  For example, if
> > selinux_inode_getsecurity() were to use this variant interface, then we
> > would report the original context string to userspace upon getxattr()
> > rather than the unlabeled context, and thus in my example sequence, the
> > ls -Z would always show the system_u:object_r:foo_exec_t label on the
> > bar file regardless of whether it was defined in the policy.
> 
> I wonder if it makes sense to only show the external labels if the process 
> has CAP_MAC_ADMIN ?

Seems somewhat intuitive (a process that can set an undefined label
should already be aware of this possibility and may want to see the raw
value), but could also be very confusing.  Also, I wouldn't want to
apply a capable() check on every getxattr() of the SELinux attribute.

For now, I'll just update the patch to introduce and use this variant
interface in the inode_init_security case so that we correctly handle
fscreate and re-post with those changes.

> 
> > I assume we do NOT want to use this variant interface when getting
> > contexts to display in audit messages, as we want the audit messages to
> > correspond to the actual denial and to yield proper policy if turned
> > into an allow rule.
> 
> Correct.
> 
> > Likewise, are there any other cases where we want to use the reverse
> > interface (security_context_to_sid_force) beyond just setxattr and
> > fscreate to permit userspace to set undefined contexts on anything else?
> 
> Not that I can think of.
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
