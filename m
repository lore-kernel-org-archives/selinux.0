Subject: Re: capability audit_write, audit_control
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510211644.j9LGiaen007329@mms-r01.iijmio.jp>
References: <1129896530.2375.556.camel@moss-spartans.epoch.ncsc.mil>
	 <200510211644.j9LGiaen007329@mms-r01.iijmio.jp>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 14:04:54 -0400
Message-Id: <1129917894.27663.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 12:44 -0400, Yuichi Nakamura wrote:
> If a domain is not allowed capability:audit_write, 
> capability:audit_write and audit_control will be denied even in permissive mode, 
> and no log is outputted.
> In such case, How does user know he has to allow capability:audit_control ?

Yes, that is a known problem.  There have been previous discussions
about the issue, and there were even patches posted by Chris Wright that
moved the checking from the receive-side code to a callback at send
time, but it didn't seem to go anywhere upstream.  I'm not certain why.

Of course, you typically should know what programs/code needs audit
privileges in the system.

> Before adding auditallow I modified following line in ssh.te
> * before
> allow $1_t self:capability {  audit_control kill sys_chroot sys_resource chown d
> ac_override fowner fsetid setgid setuid sys_tty_config };
> * after (audit_control is deleted)
> allow $1_t self:capability {  kill sys_chroot sys_resource chown d
> ac_override fowner fsetid setgid setuid sys_tty_config };

That doesn't mean that the permission isn't granted via attribute
elsewhere, e.g.
	allow auth_chkpwd self:capability { audit_write audit_control };

> And make reload was success, and I saw grant log of ssh_t's audit_control.
> Following is my strict policy and checkpolicy version.
> # rpm -q selinux-policy-strict checkpolicy
> selinux-policy-strict-1.23.16-6
> checkpolicy-1.23.1-1

Hmm...I suspect a problem in the assertion checker in that version,
although I'm not sure.  I get an assertion failure with the current
checkpolicy if I add that neverallow rule to my policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
