Subject: Re: Question concerning proftpd exploit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: sMoTo <smoto@gmx.de>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <000001c3a463$6d510650$02000a0a@lady>
References: <000001c3a463$6d510650$02000a0a@lady>
Content-Type: text/plain
Message-Id: <1068128153.4355.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Nov 2003 09:15:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-11-06 at 07:42, sMoTo wrote:
> The open source proof of concept exploit code gains a root shell on my
> Red Hat 8.0 System without running in enforcing mode. I ran the system
> with a maintenance kernel. If I would switch to enforcing mode, what
> would happen? Does the exploit gain a root shell with privileges
> system_u:system_r:ftp_t? Is this possible? 

Yes.  The exploit would be limited to the permissions granted to ftpd_t
in the SELinux policy.  And, since there are no transitions granted
out of ftpd_t, there is no possibility of privilege escalation beyond
those permissions.

If you wanted to prevent the exploit from even executing a shell (or
other programs), you could remove the corresponding can_exec rules from
ftpd.te.  Note that some of those rules are simply to allow re-use of
the ftpd_t domain for the proftpd cron script.  That approach was
introduced by Russell Coker, but I'd like to see a separate domain
defined for such cron scripts rather than re-using the daemon domain, as
it reduces our ability to tightly control code execution by the daemon
and to truly limit it to least privilege.

> Which security feature of SELinux handles such attacks? Which avc
> loggings should I see?

SELinux only provides one "security feature", the kernel mandatory
access controls.  You'll see avc denied messages whenever your exploit
tries to do something in violation of the ftpd_t policy.  Note that in
permissive mode, each denial is only logged once (unless you perform a
policy reload or toggle back and forth between permissive and enforcing
mode to flush the cache), as you would otherwise often be flooded by
repeat denials.  In enforcing mode, the denial should be logged each
time, although there is a rate limit mechanism to deal with the
inability of the logging infrastructure to handle high load.  In the
long term, the avc auditing should be retargeted to a better logging
framework once one becomes integrated into the mainline kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
