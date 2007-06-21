Subject: Re: Services running into vserver
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <daniel.gil-mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <467A7993.8020506@brunel.de>
References: <467A2A30.2070905@brunel.de>
	 <1182428600.15064.275.camel@moss-spartans.epoch.ncsc.mil>
	 <467A7993.8020506@brunel.de>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 11:19:33 -0400
Message-Id: <1182439173.15064.308.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 15:13 +0200, Daniel Gil Mayol wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-06-21 at 09:35 +0200, Daniel Gil Mayol wrote:
> >   
> >> Hello my name is Daniel and I have a question related with the services 
> >> running into a vserver.
> >>
> >> I have read that for Red Hat Enterprise Linux (v. 4), due to a SELinux 
> >> bug the dbus can't send audit messages (here is the link: 
> >> http://rhn.redhat.com/errata/RHBA-2006-0049.html ).
> >>
> >> I have the services dns and dhcp running in a vserver and the system 
> >> doesn't work as expected but no audit messages are logged (I suppose 
> >> that these both services uses dbus (messagebus) and don't send denied 
> >> messages to audit system). Can I get audit messages without update the 
> >> selinux policy (fix the bug)? Obviously, without place the services out 
> >> of the vserver :)
> >>     
> >
> > I'm a bit skeptical that the dbus issue has anything to do with the
> > problem you are encountering.
> >
> > Can you provide more information about what you mean by "the system
> > doesn't work as expected"?  And have you tried with SELinux in
> > permissive mode (setenforce 0) to verify that selinux is the culprit?
> >   
> For example, there is a pppoe connection which works with SELinux 
> disabled but in Enforcing mode, after few seconds it breaks.
> No audit messages are posted...but something like "can't bind to fix 
> socket" appear in the console.

Sounds like a name_bind denial.  Many of those are dontaudit'd because a
common library and application behavior is to scan the port space for an
available port, trying each one in sequence or pseudo randomly, thereby
generating a lot of avc denials.  Sometimes the application will then
fail after so many tries.  See e.g.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=219349
for a similar case with vsftpd.

To see the name_bind denials, build and load a policy that omits the
dontaudit rules and retry. Under RHEL4, that would be done by installing
selinux-policy-targeted-sources (if using targeted policy, of course)
and checkpolicy packages (if not already present) and then:
cd /etc/selinux/targeted/src/policy
make clean enableaudit load

This will remove all dontaudit rules from policy, yielding a lot of avc
messages for harmless application and library probing.  But it should
also show you the name_bind denials.  To revert the policy to its
original state, you can:
cd /etc/selinux/targeted/src/policy
make clean load

> If a service works with SELinux disabled and then it s started in 
> Enforcing mode and no audit messages are logged, can this service be 
> blocked by the SELinux? I have some dontaudit defined but this makes 
> that an operation is not processed by AUDIT (no audit-message is shown), 
> it shall not block the service, or?.

dontaudit means to suppress the avc denial message, while still denying
the operation.  It is used to silence noisy messages caused by innocent
application and library probing that is not truly needed for operation.

> > Are you checking the right place for audit messages?  /var/log/messages
> > if not running auditd; /var/log/audit/audit.log if running auditd.
> >   
> Yes, the messages are logged in /var/log/messages.
> Instead of auditd, kauditd is running but doesn't write into 
> /var/log/audit/audit.log .... is that ok?

Yes, only the userspace auditd will write to /var/log/audit/audit.log;
the kernel auditd thread just sends the audit messages to the userspace
audit daemon (or feeds them to klogd if not present).

> > You can also rebuild your policy with no dontaudit rules via 'make
> > enableaudit load' to turn on all SELinux auditing.
> >
> > Kernel version and .config?
> >   
> Red Hat Enterprise Linux 4
> Linux  kernel-2.6.17.13-1

Just to note:  by using your own custom kernel on RHEL4, your policy may
be out of sync with the kernel, e.g. the kernel may include newer
permission checks not defined by your RHEL4 policy.

And, of course, RHEL5 is available and has a much more modern version of
SELinux with it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
