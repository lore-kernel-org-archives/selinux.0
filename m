Subject: RE: [RFC]Kernel Built-in IDS extension
From: Stephen Smalley <sds@tycho.nsa.gov>
To: horietk@nttdata.co.jp
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6ACF5196CB5AA4FB50C32559083A36901633F0F@MAILSV12.msg.nttdata.co.jp>
References: 
	 <E6ACF5196CB5AA4FB50C32559083A36901633F0F@MAILSV12.msg.nttdata.co.jp>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 08:32:35 -0400
Message-Id: <1119357155.19219.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-21 at 19:24 +0900, horietk@nttdata.co.jp wrote:
> Certainly, I agree that the logging daemon based implementation is much 
> simpler than kernel based one. But I think syslogd may not be reliable 
> enough for this kind of purpose, i.e. printk() loses some of messages 
> under very high load. So this is one of benefits which kernel based 
> implementation gives.

The kernel audit framework allows redirection of audit messages to a
separate audit daemon, with the communication handled via netlink.  In
FC4, this is now the default; there has been a lot of work on the kernel
audit framework and auditd for FC4.

> Currently, I have a plan for integrating IDS functionality with MLS 
> instead of boolean. This implementation will make trap description more 
> flexible and stateful. The following usage is intended.
> 
> example) Progressive access policy
> By means of detecting symbolic access context which indicates transition 
> to the next processing phase, the privileges of running daemon can be 
> changed according to its progress. 
> 
> It provides similar functionality to domain trasition. But no execve() 
> is needed. I think it's more secure way because the daemon's privileges 
> can be configured such that the process is only allowed the privileges 
> which are needed exactly at that point.
> 
> How about this plan?

I'm not sure I follow your description.  Items to note:

- SELinux includes a setcon(3) operation since 2.6.11 (introduced by
Trusted Computer Solutions), so programs can be modified to change
contexts (if allowed by policy) during their operation for such
privilege bracketing.  But such privilege bracketing within the program
is not as good as decomposing the program into multiple programs and
performing exec-based transitions, because it requires that the entire
application be trusted to maintain any desired separation between the
old and new contexts and the binding between the code and the set of
privileges at any given point is weak and unreliable.

- Dynamically changing the process context in the kernel without an
explicit setcon(3) call seems even worse, because at least with an
explicit setcon(3) call, the program had to be aware of the transition
and would know to adjust its state prior to switching contexts to
maintain any desired separation.

I'm not sure what you mean by integrating it with MLS rather than
booleans; the booleans seem like a more natural fit and allow the policy
writer to define exactly how he wants the policy rules to evolve.

But again, it isn't clear that it is justified to provide this
functionality in the kernel, especially given the use of auditd these
days for SELinux auditing.  It would seem to make more sense to extend
auditd to trap specific SELinux audit messages (among other things) and
possibly run a helper to adjust boolean settings to tighten or deny
access for the process that is exhibiting questionable behavior without
interfering with normal operation by legitimate users.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
