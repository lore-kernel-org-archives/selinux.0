Subject: RE: dcache_lock deadlock due to auditing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Serge Hallyn'" <serue@us.ibm.com>, selinux@tycho.nsa.gov,
   "'James Morris'" <jmorris@redhat.com>, selinux-dev@tresys.com,
   linux-audit@redhat.com
In-Reply-To: <200504141606.j3EG6S8R023875@gotham.columbia.tresys.com>
References: <200504141606.j3EG6S8R023875@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 12:15:37 -0400
Message-Id: <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-14 at 12:06 -0400, Karl MacMillan wrote:
> Just to be clear, this decision is really to continue the movement away from avc
> messages being a complete source for audit message related to SELinux to both
> avc and syscall auditing being required to get a full picture. My sense is that
> this is the direction that things must go in for technical and political
> reasons, though I have to say that my preference would be (for what it's worth)
> for SELinux avc audit messages to be complete, self-contained, and be triggered
> even with DAC permissions deny access.

The SELinux avc audit messages will remain complete as far as having all
the information you need to tie it back to policy or generate policy
rules, i.e. the security contexts and class information.  The auxiliary
audit information (pid, exe, path, port, ipaddr, etc) has always just
been to help track down the causes of denials.  As far as being
triggered for DAC denials, that just isn't an option, as the LSM hooks
are placed after the DAC checks in most cases and won't be reached for
DAC denials.  That avoids filling the logs with MAC denials that would
have been denied due to DAC anyway (which is quite common due to
application and library probing of the environment) and doesn't leak
information (since both the DAC denial and the MAC denial yield the same
error code).  But if your real concern is capturing the relevant
security contexts upon a DAC denial, we can support that; SELinux
already provides hook functions for copying the contexts of processes
and files to buffers to support the /proc/pid/attr and xattr APIs, so
that audit framework can call those hooks and save that information for
processing by audit_log_exit upon DAC denials as well.

> At this point, my only real concern is that it be easier for users to get this
> information and I simply don't know enough about the audit infrastructure to
> know whether this will be the case or not. What kind of configuration will be
> required to get the additional syscall audit messages?

Boot your kernel with audit=1 or run auditctl -e 1 at any time.  That
enables syscall auditing.  Then, every time SELinux generates an audit
message via avc_audit, a syscall audit record will also be written at
syscall exit, and they can be tied together based on the
timestamp/serial number in the prefix.
 
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
