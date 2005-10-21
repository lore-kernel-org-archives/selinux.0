Subject: Re: capability audit_write, audit_control
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510210233.j9L2X1Df006128@mms-r00.iijmio.jp>
References: <200510210233.j9L2X1Df006128@mms-r00.iijmio.jp>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 08:08:50 -0400
Message-Id: <1129896530.2375.556.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 22:32 -0400, Yuichi Nakamura wrote:
> Are capability audit_write and audit_control actually used ?
> I can not find code where capability audit_control and audit_write are used.
> Capability is checked capable ---> selinux_capable.
> But I can not find "capable(CAP_AUDIT_WRITE)" and "capable(CAP_AUDIT_CONTROL)". 
> My kernel is  2.6.12-1.1398_FC4 .
> I found following in kernel/audit.c
> if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
> if (!cap_raised(eff_cap, CAP_AUDIT_WRITE))
> However, "capable" is not used so selinux_capable will not be called.

The eff_cap is computed when the netlink message is sent by the
selinux_netlink_send() hook function.  That performs a complete
capability access vector computation based on the sender's context.  The
audit system then checks the appropriate capability bit in the eff_cap
when it processes the received message.  Since we must compute the
entire capability vector at send time without knowing which capability
(if any) will actually be required by the receive-side code, no auditing
is performed here.

However, CAP_AUDIT_CONTROL is checked using capable() by
fs/proc/base.c:proc_loginuid_write when a process tries to set its
loginuid via /proc/self/loginuid.  That would trigger auditing of that
capability.

> In addition, I found strange behavior.
> I add following lines in strict policy.
> 
> auditallow sshd_t self:capability { audit_control };
> neverallow sshd_t self:capability audit_control;

If I add the above to strict policy here, I get an assertion failure on
the neverallow rule when I try to rebuild policy.  What version of
checkpolicy are you using?  What version of policy?

> In this policy, sshd will never be allowed to use audit_control.
> 
> However, I found following log when user logged in by ssh. 
> 
> audit(1129827338.333:34): avc:  granted  { audit_control } for  pid=2313 comm="sshd" capability=30 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=capability
> 
> ssh_t is granted audit_control in log, 
> but  sshd_t is not granted auditcontrol in policy.

If I add the auditallow rule without the neverallow rule, I also see
this message, which just means that sshd (via pam) is setting the
loginuid via /proc/self/loginuid.  But it is allowed in my policy
(indirectly via an attribute), and I suspect it is allowed in your
policy too.  You might just have a checkpolicy with a broken assertion
(neverallow) checker.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
