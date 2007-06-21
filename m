Subject: Re: Services running into vserver
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <daniel.gil-mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <467A2A30.2070905@brunel.de>
References: <467A2A30.2070905@brunel.de>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 08:23:20 -0400
Message-Id: <1182428600.15064.275.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 09:35 +0200, Daniel Gil Mayol wrote:
> Hello my name is Daniel and I have a question related with the services 
> running into a vserver.
> 
> I have read that for Red Hat Enterprise Linux (v. 4), due to a SELinux 
> bug the dbus can't send audit messages (here is the link: 
> http://rhn.redhat.com/errata/RHBA-2006-0049.html ).
> 
> I have the services dns and dhcp running in a vserver and the system 
> doesn't work as expected but no audit messages are logged (I suppose 
> that these both services uses dbus (messagebus) and don't send denied 
> messages to audit system). Can I get audit messages without update the 
> selinux policy (fix the bug)? Obviously, without place the services out 
> of the vserver :)

I'm a bit skeptical that the dbus issue has anything to do with the
problem you are encountering.

Can you provide more information about what you mean by "the system
doesn't work as expected"?  And have you tried with SELinux in
permissive mode (setenforce 0) to verify that selinux is the culprit?

Are you checking the right place for audit messages?  /var/log/messages
if not running auditd; /var/log/audit/audit.log if running auditd.

You can also rebuild your policy with no dontaudit rules via 'make
enableaudit load' to turn on all SELinux auditing.

Kernel version and .config?
audit version?

> I'm writing also test scripts for checking that the services running in 
> the SELinux system are properly protected. All the services running into 
> the vserver has a common security context, it means, there is no 
> difference for dns or dhcp services. Should I write an special test 
> script only for the vserver, enter into the vserver with "[root@mypc ~]# 
> vserver VSERVER_NAME enter" and run the script?

What's an example of something you think would be stopped by the selinux
policy that wouldn't be stopped by the vserver mechanism if you are only
using a single context per vserver?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
