Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119567031.9390.66.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
	 <1119470092.9358.43.camel@localhost>  <1119540816.9390.35.camel@localhost>
	 <1119546240.28493.128.camel@moss-spartans.epoch.ncsc.mil>
	 <1119548467.9390.56.camel@localhost>
	 <1119548686.28493.161.camel@moss-spartans.epoch.ncsc.mil>
	 <1119549355.28493.175.camel@moss-spartans.epoch.ncsc.mil>
	 <1119567031.9390.66.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 08:13:59 -0400
Message-Id: <1119615239.12865.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 23:50 +0100, antoine wrote:
> Thanks, I found it. In another .te file I was allowing sysadm_r to
> become object_r... I guess this took precedence over running sendmail as
> system_u:system_r:postfix_pipe_t
> Can this (somewhat dumb error I'll admit) be prevented with a neverallow
> type of check?

Not presently; neverallow is currently only for TE allow rules.  We
could certainly introduce a neverroleallow for role allow rules into
checkpolicy and put a neverroleallow * object_r; rule into the policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
