From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, sMoTo <smoto@gmx.de>
Subject: Re: Question concerning proftpd exploit
Date: Fri, 7 Nov 2003 06:22:19 +1100
Cc: SELinux@tycho.nsa.gov
References: <000001c3a463$6d510650$02000a0a@lady> <1068128153.4355.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1068128153.4355.28.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311070622.19614.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 7 Nov 2003 01:15, Stephen Smalley wrote:
> On Thu, 2003-11-06 at 07:42, sMoTo wrote:
> > The open source proof of concept exploit code gains a root shell on my
> > Red Hat 8.0 System without running in enforcing mode. I ran the system
> > with a maintenance kernel. If I would switch to enforcing mode, what
> > would happen? Does the exploit gain a root shell with privileges
> > system_u:system_r:ftp_t? Is this possible?
>
> Yes.  The exploit would be limited to the permissions granted to ftpd_t
> in the SELinux policy.  And, since there are no transitions granted
> out of ftpd_t, there is no possibility of privilege escalation beyond
> those permissions.
>
> If you wanted to prevent the exploit from even executing a shell (or
> other programs), you could remove the corresponding can_exec rules from
> ftpd.te.  Note that some of those rules are simply to allow re-use of
> the ftpd_t domain for the proftpd cron script.  That approach was
> introduced by Russell Coker, but I'd like to see a separate domain
> defined for such cron scripts rather than re-using the daemon domain, as
> it reduces our ability to tightly control code execution by the daemon
> and to truly limit it to least privilege.

One current issue with ftpd and many other domains is that they can read
/etc/shadow to authenticate users.  I have been working on PAM modules to use 
helper programs to authenticate users such that ftpd and other programs never 
need direct access to /etc/shadow.

So with policy changes to match only the following domains need direct access 
to /etc/shadow:

sysadm_chkpwd_t user_chkpwd_t staff_chkpwd_t system_chkpwd_t
sysadm_passwd_t passwd_t backup_t quota_t setfiles_t useradd_t
groupadd_t

When I fix the checkquota program quota_t won't need such access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
