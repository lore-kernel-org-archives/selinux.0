From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Fri, 6 Oct 2006 11:34:27 -0400
Cc: Michael C Thompson <thompsmc@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <200610051748.06669.sgrubb@redhat.com> <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610061134.27916.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 06 October 2006 10:52, Stephen Smalley wrote:
> > There is a library function get_auditfail_action where admins can say
> > what the expected behavior should be. There is a man page for it.
>
> Ok, so newrole can call get_auditfail_action() upon an audit_open()
> failure, and return 0 from send_audit_message() if the failmode is
> FAIL_IGNORE.  Then a stock RHEL 5 system can have 'failure_action =
> ignore' in /etc/libaudit.conf and 'session required pam_permit.so'
> in /etc/pam.d/newrole, and newrole can unconditionally invoke the audit
> calls and pam_open/close_session calls. 

Yes, if that's the way we want to do this.

> > However, why would sending an audit message fail? newrole is setuid,
> > that's why I did a code review last winter...and we can do another code
> > review if people still aren't sure. pam is already used in several setuid
> > programs, so I hope that is not the issue.
>
> Dan had suggested only making newrole suid under the LSPP configuration,
> leaving it non-suid otherwise, and having newrole dynamically test
> whether it is suid (which it cannot actually do precisely) to decide
> whether or not to perform privileged operations.

It can easily test for CAP_SYS_ADMIN, CAP_DAC_OVERRIDE.

> This was motivated by the desire to not expose non-LSPP systems
> (particularly a stock system with targeted policy) to greater risk, since
> the changes to newrole for pam_namespace leave it much more privileged than
> your earlier changes for audit.

So, in a higher assurance deployment we will have something more powerful that 
is not being used by the majority of users? If its dangerous for general 
deployment, it would be dangerous for higher assurance, too.

> Unlike the audit support, pam_namespace requires retaining several powerful
> capabilities (CAP_SYS_ADMIN, CAP_DAC_OVERRIDE, etc) and 
> euid 0 for most of the lifetime of newrole (until after pam_namespace
> runs, which occurs late).

You know, it occurs to me that we would not need newrole if we were able to 
chose a role at login. We used to be able to do that a long time ago. Maybe 
that solves all the problems? Need to change roles...log out and log in.

> No one has yet commented on the concern I raised about whether setting
> the suid bit on newrole in this manner is workable from a packaging and
> maintenance point of view (if policycoreutils installs a non-suid
> newrole and the lspp package makes it suid from a scriptlet, then rpm -V
> policycoreutils will report variance in the file mode, and an update of
> policycoreutils will reset the newrole mode back to non-suid).  That
> seems a bit problematic to me.

We already have that issue. The script takes the setuid bit from several apps. 
However, we are pulling AIDE into RHEL5 and we will be using that for 
Integrity checking part of the RBAC self-test.

> > I don't think checking suid is the right thing. Checking the capability
> > is.
>
> Possibly, but if we can just call audit_open() unconditionally and use
> get_auditfail_action() to decide how to handle an error, then I don't
> think we need to do any checking of suid or capability first.  

What if they don't have audit compiled into their kernel but want 
pam_namespace? Weird, but people are like that.

> On the question of checking whether an app is suid, I don't see any way
> to do that in Linux unambiguously, since there is always the case where
> the caller was already in the same uid as the file.

The check for setuid is mistakenly a check for capabilities.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
