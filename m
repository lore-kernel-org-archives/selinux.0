Subject: Re: [PATCH v4] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
	 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
	 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
Content-Type: text/plain
Date: Wed, 07 May 2008 08:45:25 -0400
Message-Id: <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-07 at 08:31 +1000, James Morris wrote:
> On Tue, 6 May 2008, Stephen Smalley wrote:
> 
> > So, the question is should we just drop this hunk of the patch and only
> > support this functionality for setxattr, or do we need
> > selinux_inode_init_security() to recover the original context string
> > (which is available in the SID table, just not returned by
> > security_sid_to_context when it isn't defined by policy) and use that
> > for the on-disk xattr value?
> 
> I think we need to use the "alternative" context if it exists, so yes.

I assume this means that you want to retain the fscreate support,
introduce a variant interface to security_sid_to_context() that will
return the original context string rather than the unlabeled context for
these undefined contexts, and use that interface from
selinux_inode_init_security().

So the next question is whether there are any other cases where we want
to use this variant interface.  For example, if
selinux_inode_getsecurity() were to use this variant interface, then we
would report the original context string to userspace upon getxattr()
rather than the unlabeled context, and thus in my example sequence, the
ls -Z would always show the system_u:object_r:foo_exec_t label on the
bar file regardless of whether it was defined in the policy.

I assume we do NOT want to use this variant interface when getting
contexts to display in audit messages, as we want the audit messages to
correspond to the actual denial and to yield proper policy if turned
into an allow rule.

Likewise, are there any other cases where we want to use the reverse
interface (security_context_to_sid_force) beyond just setxattr and
fscreate to permit userspace to set undefined contexts on anything else?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
