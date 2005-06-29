Subject: Re: RFC: jail functionality
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050629161409.GB16233@serge.austin.ibm.com>
References: <20050629161409.GB16233@serge.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 12:35:00 -0400
Message-Id: <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 11:14 -0500, serue@us.ibm.com wrote:
> Attached are the old task_lookup patch which was used by the bsdjail lsm,
> a patch for selinux to utilize this hook, and a sample jail policy and
> .fc, which presumably would eventually be changed to a jail_domain()
> policy macro.  Does this seem at all useful by itself, or should this
> wait until it were actually needed for a complete linux jails
> implementation?

What's the real benefit of "hiding" tasks in this manner?  SELinux can
already prevent processes from accessing anything under /proc/pid for a
process in another domain, and procps already conveniently omits entries
for any such inaccessible /proc/pid directories, so the typical user
experience is the same (i.e. users won't see processes that are
inaccessible in ps output) and at most, only the pids are exposed
in /proc.  

> It seems to me the greatest challenge is network jails.  I don't think
> this can be done right with selinux.  I believe you can restrict a
> domain's access to remote addresses by IP, but not to local addresses
> during bind.  Am I wrong in assuming jails would be useless without
> this?  (I suppose they could at least be useful for sandboxes of some
> sort)  Does anyone have ideas on a good way to implement these?

SELinux has a node_bind check applied upon bind(2) that is based on the
address, similar to the name_bind check based on port.  However, this
doesn't address auto-binding of sockets by the kernel (e.g. when
connecting/sending on an unbound socket), and it doesn't make address
selection transparent for userspace.  

> Some time ago I sent out an RFC for network namespaces, which allowed a
> process to essentially give up its access to a network device.  The
> patch only allowed a process to give up access to real network devices,
> not ip aliases (ie eth0:0).  But this seems much less useful for
> allowing admins to provide multiple jails.
> 
> The linux-vserver team is working on virtual networking which (IIUC)
> creates a virtual network device which is then associated with a
> virtual address, a real network device, and a jail.  This appears to
> be a way to make the simple version of network namespaces I describe
> in the paragraph above more useful, since we would not need to deal
> with ip aliases.
> 
> Is there any interest in seeing the virtual network devices and
> network namespaces pushed upstream?

Yes, although I can't say that I've looked at their approach.

> Read-only bind mounts?

Not sure what happened to earlier discussions and patches related to
that issue on lkml.

> The attached task-lookup patches?

Not sure it provides much value.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
