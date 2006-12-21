Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
In-Reply-To: <34763.81442.qm@web51513.mail.yahoo.com>
References: <34763.81442.qm@web51513.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 10:19:41 -0500
Message-Id: <1166714381.30579.210.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-12-21 at 07:05 -0800, Steve G wrote:
> >Currently it means that access decisions which would rely on that
> >class/perm will be denied.  They will still be logged based on the
> >kernel's view.  So actually the logging is still correct and complete.
> 
> This sounds like it should go to syslog as an error then. Errors do not need to
> be audited, just access control decisions and significant changes in state of
> security functions like loading policy, disabling selinux, flipping boolean, etc.
> 
> I also wonder if there should be a way to cause the system to panic if a policy
> loads that has these kind of holes in it?

The plan is to support three options, selectable when policy is
built/generated:
- reject policy at load time (in which case userspace can handle it as
desired - init will already halt the system if enforcing and it cannot
load policy; policy package would just report an error from %post for
updates),
- accept policy at load time and deny undefined classes/perms,
- accept policy at load time and allow undefined classes/perms.

In any event, I think printk KERN_INFO is appropriate for these
particular messages about missing classes and perms.  Then if the config
flag is to reject the policy, an error message can be generated, or if
the config flag is to accept the policy and deny undefined
classes/perms, we'll get audit messages from the AVC upon any attempts
to use those undefined classes/perms.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
