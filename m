Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6E1e7gA029958
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 21:40:07 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6E1alvl028953
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 01:36:47 GMT
Date: Wed, 13 Jul 2005 21:36:37 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MCS/Targeted Policy...
In-Reply-To: <20050713155129.60027.qmail@web31606.mail.mud.yahoo.com>
Message-ID: <Xine.LNX.4.44.0507132104400.10789-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Jul 2005, Casey Schaufler wrote:

> I expect that you're going to have an
> uphill battle explaining how this is
> superior to ACLs.

I would not claim that MCS is superior to ACLs (whatever superior is 
supposed to mean).

MCS categories, as initially envisioned, are functionally similar to ACLs, 
but not equivalent.

There are some fundamental differences between the systems; here are some
very basic definitions:

- ACLs govern discretionary access rights to an object.
- MCS constrains DAC and TE access rights to an object.

ACLs impose a specific set of access rights (rwx) and semantics, which are
not necessarily appropriate to our needs. For example, TE provides a
richer set of permissions and security abstractions, which MCS can readily
constrain.  MCS can also operate on TE attributes.

ACL labeling semantics are fixed.  Examples:
- ACLs must be copied from a directory's default ACL list for files
  created in that directory.
- If a user has newgrp'd to a supplementary group, files created by the
  user will be created with that group.

We don't necessarily want these things to always happen, and in fact,
definitely don't under the initial model.  MCS labeling semantics could be
more flexible, if required, via policy specification and/or changes in fs
labeling behavior.

ACLs are limited to a small set of file type OS objects.  MCS could be
applied to any of the objects which SELinux controls, including userspace
components.  Down the track, MCS could be useful for things like Security
Enhanced X and Postgresql.  MCS seems to provide far more extensibility
and scope as an SELinu-based technology.

MCS may not always be as simple DAC mechanism.  This is how it is
initially envisioned, but via SELinux policy, its behavior can be changed.

Note that MCS is merely a simplified MLS policy (but should not be
considered in any way to actually be MLS of course: I'm referring to the
technology base).  It is essentially a filesystem relabel and a policy
change which makes use of existing or planned MLS components.

MCS would be more closely integrated with both SELinux and CAPP audit,
and better leverage existing technologies and efforts in these areas.

An ACL failure, by default, will not be audited.  An MCS failure will be
audited as an SELinux denial, which will contain important security
information, such as security contexts containing category labels.
Auditing can be further enhanced if necessary with auditallow rules, and
ultimately, enabling auditd.  Adding an audit rule for ACL controlled
operations is not as useful: neither the object's ACL nor the subject's
supplementary groups are included in audit records.

If ACLs were to be considered as an alternative to MCS, setting aside the 
relative inflexibility, reduced integration with CAPP/SELinux and fixed 
semantics as discussed above, there are still issues such as:

- ACL functionality needs to be mapped to basic MCS functionality. e.g.
  higher level tools than get/setfacl would be needed ensure that the
  effective rights mask is set correctly and that 'rwx' is always set.
  It's simpler just to use MCS directly.

- What happens if SELinux is disabled on the system? ACLs will still be in 
  effect, and security could be seriously degraded without TE in place, as 
  ACLs are a privilege escalation mechanism.  In the case of MCS, the 
  category labels would do nothing without SELinux enabled.

- Re-using ACLs for this purpose may also clash with other uses of ACLs 
  and Unix groups on the same system.  We'd be kind of hijacking ACLs.


-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
