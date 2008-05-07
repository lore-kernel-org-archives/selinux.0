Date: Wed, 7 May 2008 23:45:16 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH v4] selinux:  support deferred mapping of contexts
In-Reply-To: <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805072342570.15234@us.intercode.com.au>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
 <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 May 2008, Stephen Smalley wrote:

> So the next question is whether there are any other cases where we want
> to use this variant interface.  For example, if
> selinux_inode_getsecurity() were to use this variant interface, then we
> would report the original context string to userspace upon getxattr()
> rather than the unlabeled context, and thus in my example sequence, the
> ls -Z would always show the system_u:object_r:foo_exec_t label on the
> bar file regardless of whether it was defined in the policy.

I wonder if it makes sense to only show the external labels if the process 
has CAP_MAC_ADMIN ?

> I assume we do NOT want to use this variant interface when getting
> contexts to display in audit messages, as we want the audit messages to
> correspond to the actual denial and to yield proper policy if turned
> into an allow rule.

Correct.

> Likewise, are there any other cases where we want to use the reverse
> interface (security_context_to_sid_force) beyond just setxattr and
> fscreate to permit userspace to set undefined contexts on anything else?

Not that I can think of.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
