Message-Id: <200510211644.j9LGiaen007329@mms-r01.iijmio.jp>
Date: Fri, 21 Oct 2005 12:44:18 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: Re: capability audit_write, audit_control
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1129896530.2375.556.camel@moss-spartans.epoch.ncsc.mil>
References: <1129896530.2375.556.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley  wrote:
> The eff_cap is computed when the netlink message is sent by the
> selinux_netlink_send() hook function.  That performs a complete
> capability access vector computation based on the sender's context.  The
> audit system then checks the appropriate capability bit in the eff_cap
> when it processes the received message.  Since we must compute the
> entire capability vector at send time without knowing which capability
> (if any) will actually be required by the receive-side code, no auditing
> is performed here.
I understand, thank you!
The capability set by selinux_netlink_send is checked in 
audit_receive_msg -->audit_netlink_ok at audit.c.

If a domain is not allowed capability:audit_write, 
capability:audit_write and audit_control will be denied even in permissive mode, 
and no log is outputted.
In such case, How does user know he has to allow capability:audit_control ?

> > In addition, I found strange behavior.
> > I add following lines in strict policy.
> > auditallow sshd_t self:capability { audit_control };
> > neverallow sshd_t self:capability audit_control;
> If I add the above to strict policy here, I get an assertion failure on
> the neverallow rule when I try to rebuild policy.  What version of
> checkpolicy are you using?  What version of policy?
...
> If I add the auditallow rule without the neverallow rule, I also see
> this message, which just means that sshd (via pam) is setting the
> loginuid via /proc/self/loginuid.  But it is allowed in my policy
> (indirectly via an attribute), and I suspect it is allowed in your
> policy too.  You might just have a checkpolicy with a broken assertion
> (neverallow) checker.

Before adding auditallow I modified following line in ssh.te
* before
allow $1_t self:capability {  audit_control kill sys_chroot sys_resource chown d
ac_override fowner fsetid setgid setuid sys_tty_config };
* after (audit_control is deleted)
allow $1_t self:capability {  kill sys_chroot sys_resource chown d
ac_override fowner fsetid setgid setuid sys_tty_config };

And make reload was success, and I saw grant log of ssh_t's audit_control.
Following is my strict policy and checkpolicy version.
# rpm -q selinux-policy-strict checkpolicy
selinux-policy-strict-1.23.16-6
checkpolicy-1.23.1-1

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
