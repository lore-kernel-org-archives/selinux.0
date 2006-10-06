Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Michael C Thompson <thompsmc@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
In-Reply-To: <200610051748.06669.sgrubb@redhat.com>
References: <452432FA.1060009@us.ibm.com>
	 <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>
	 <45256F49.1070105@us.ibm.com>  <200610051748.06669.sgrubb@redhat.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 10:52:23 -0400
Message-Id: <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 17:48 -0400, Steve Grubb wrote:
> On Thursday 05 October 2006 16:47, Michael C Thompson wrote:
> > AFAIK, we can't call audit without getting a failure, and I would really
> > rather not suppress those errors.
> 
> There is a library function get_auditfail_action where admins can say what the 
> expected behavior should be. There is a man page for it.

Ok, so newrole can call get_auditfail_action() upon an audit_open()
failure, and return 0 from send_audit_message() if the failmode is
FAIL_IGNORE.  Then a stock RHEL 5 system can have 'failure_action =
ignore' in /etc/libaudit.conf and 'session required pam_permit.so'
in /etc/pam.d/newrole, and newrole can unconditionally invoke the audit
calls and pam_open/close_session calls.  And the LSPP package can
replace /etc/libaudit.conf to change the failure_action and can
replace /etc/pam.d/newrole to change the session module to
pam_namespace.

> However, why would sending an audit message fail? newrole is setuid, that's 
> why I did a code review last winter...and we can do another code review if 
> people still aren't sure. pam is already used in several setuid programs, so 
> I hope that is not the issue.

Dan had suggested only making newrole suid under the LSPP configuration,
leaving it non-suid otherwise, and having newrole dynamically test
whether it is suid (which it cannot actually do precisely) to decide
whether or not to perform privileged operations.  This was motivated by
the desire to not expose non-LSPP systems (particularly a stock system
with targeted policy) to greater risk, since the changes to newrole for
pam_namespace leave it much more privileged than your earlier changes
for audit.  Unlike the audit support, pam_namespace requires retaining
several powerful capabilities (CAP_SYS_ADMIN, CAP_DAC_OVERRIDE, etc) and
euid 0 for most of the lifetime of newrole (until after pam_namespace
runs, which occurs late).

No one has yet commented on the concern I raised about whether setting
the suid bit on newrole in this manner is workable from a packaging and
maintenance point of view (if policycoreutils installs a non-suid
newrole and the lspp package makes it suid from a scriptlet, then rpm -V
policycoreutils will report variance in the file mode, and an update of
policycoreutils will reset the newrole mode back to non-suid).  That
seems a bit problematic to me.

Russell had alternatively suggested moving newrole into its own package
and only installing it (always suid) if installing a -strict or -mls
policy (i.e. make it a dependency of those policy packages), so that a
default install does not include it at all (as -targeted has no need for
newrole functionality).   Concerns there might include: a) mere
installation of -strict or -mls on a system does not mean that they are
the active policy, so one could still end up with the suid newrole on a
machine running targeted, b) not all users of -strict necessarily want
pam_namespace functionality.   Also not sure about whether that poses
any packaging or dependency issues.

I had earlier suggested having newrole somehow perform a runtime check
of whether pam_namespace is in its pam config, and dropping all
capabilities other than CAP_AUDIT_WRITE if it is not present.  But I
don't see any PAM interface for getting such information, and it seems
to violate pam encapsulation.

> > Is there no sane way to check if an app is suid? Because this would
> > relieve some of the headaches from this.
> 
> I don't think checking suid is the right thing. Checking the capability is.

Possibly, but if we can just call audit_open() unconditionally and use
get_auditfail_action() to decide how to handle an error, then I don't
think we need to do any checking of suid or capability first.  At that
point, we only need to bracket the code that tries to drop capabilities
and revert the uid with a check of whether the process is privileged.

On the question of checking whether an app is suid, I don't see any way
to do that in Linux unambiguously, since there is always the case where
the caller was already in the same uid as the file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
