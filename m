Message-Id: <200504141937.j3EJbk8R026238@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Serge Hallyn'" <serue@us.ibm.com>, <selinux@tycho.nsa.gov>,
   "'James Morris'" <jmorris@redhat.com>, <selinux-dev@tresys.com>,
   <linux-audit@redhat.com>
Subject: RE: dcache_lock deadlock due to auditing
Date: Thu, 14 Apr 2005 15:37:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1113495337.373.166.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, April 14, 2005 12:16 PM
> To: Karl MacMillan
> Cc: 'Serge Hallyn'; selinux@tycho.nsa.gov; 'James Morris'; selinux-
> dev@tresys.com; linux-audit@redhat.com
> Subject: RE: dcache_lock deadlock due to auditing
> 
> On Thu, 2005-04-14 at 12:06 -0400, Karl MacMillan wrote:
> > Just to be clear, this decision is really to continue the movement away from
> avc
> > messages being a complete source for audit message related to SELinux to
> both
> > avc and syscall auditing being required to get a full picture. My sense is
> that
> > this is the direction that things must go in for technical and political
> > reasons, though I have to say that my preference would be (for what it's
> worth)
> > for SELinux avc audit messages to be complete, self-contained, and be
> triggered
> > even with DAC permissions deny access.
> 
> The SELinux avc audit messages will remain complete as far as having all
> the information you need to tie it back to policy or generate policy
> rules, i.e. the security contexts and class information.  The auxiliary
> audit information (pid, exe, path, port, ipaddr, etc) has always just
> been to help track down the causes of denials.  As far as being
> triggered for DAC denials, that just isn't an option, as the LSM hooks
> are placed after the DAC checks in most cases and won't be reached for
> DAC denials.  That avoids filling the logs with MAC denials that would
> have been denied due to DAC anyway (which is quite common due to
> application and library probing of the environment) and doesn't leak
> information (since both the DAC denial and the MAC denial yield the same
> error code).  But if your real concern is capturing the relevant
> security contexts upon a DAC denial, we can support that; SELinux
> already provides hook functions for copying the contexts of processes
> and files to buffers to support the /proc/pid/attr and xattr APIs, so
> that audit framework can call those hooks and save that information for
> processing by audit_log_exit upon DAC denials as well.
> 

Having the context information is part of my real concern. The thought is to
build intrusion detection systems that interpret audit messages in terms of
SELinux policy. The only additional benefit to having all of the data part of
SELinux audit messages is that the policy could control the generation of the
messages - e.g., the intrusion detection piece could change a boolean that
increased the number of audit messages for a particular type. The way this is
moving will cause my audit policy to be stored in two places in vastly different
forms.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
