Subject: Re: logging question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Moore <eemoore@fyndo.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu>
References: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 12:39:10 -0400
Message-Id: <1129567150.26309.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-17 at 12:26 -0400, Eric Moore wrote:
> I have a debian unstable machine I'm trying to get selinux to work on.
> I've gotten a policy to build, installed the userland tools, loaded
> it, etc.  It's working, because I can swithc into enforcing mode, and
> things break (presumably due to my havng screwed up the policy).  But
> I never sdeem to get any logging messages of what was denied and why
> (In or out of enforcing mode).  What's the best way for me to get
> the kernel to log the appropriate messages somewhere?

In 2.6, SELinux was converted over to using the native kernel audit
subsystem for logging its denials.  So:
- Does your kernel have auditing enabled (CONFIG_AUDIT=y)?  If not, time
to rebuild your kernel.
- Are you running auditd?  If so, look in /var/log/audit/audit.log or
wherever /etc/auditd.conf directs audit messages.  If not, look
in /var/log/messages or wherever /etc/syslog.conf directs kern.warn
messages.
- If you still don't have anything logged in either location, run 'make
clean enableaudit load' in your policy directory to clear all
"dontaudit" rules from the loaded policy so that no log messages are
suppressed (normally, certain denials are silently denied to avoid
filling your logs with noise from known probing by library and
applications that is common but not needed for operation).  Then do a
'make clean load' later to re-include those dontaudit rules after you've
collected your log messages.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
