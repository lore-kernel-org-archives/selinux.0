Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119546240.28493.128.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
	 <1119470092.9358.43.camel@localhost>  <1119540816.9390.35.camel@localhost>
	 <1119546240.28493.128.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 18:41:07 +0100
Message-Id: <1119548467.9390.56.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > But I've got:
> > domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
> > allow initrc_t postfix_master_t:process { noatsecure siginh rlimitinh };
> > role_transition system_r postfix_master_exec_t object_r;
> 
> This is wrong.  object_r is only for objects, not processes.
Yes, I figured the last one was not helping. I was just trying random
things, hoping to understand the error message better.
I removed the change, so now I can start postfix again without problems,
but I am back where I started with spamd:

audit(1119545469.251:0): avc:  denied  { transition } for  pid=19693
exe=/usr/bin/spamc path=/usr/sbin/sendmail dev=md3 ino=783481
scontext=system_u:system_r:spamd_t
tcontext=system_u:object_r:postfix_pipe_t tclass=process

Even though I have:
domain_auto_trans(postfix_pipe_t, spamc_exec_t, spamd_t)
domain_auto_trans(spamd_t, sendmail_exec_t, postfix_pipe_t)
(to allow mail to be filtered by spamassassin in/out)
system_u:object_r:spamc_exec_t   /usr/bin/spamc
system_u:object_r:sendmail_exec_t /usr/sbin/sendmail

Audit2why tells me I should add a type attribute, but I really cannot
figure out *which one* that could be, and to which domain:

audit(1119545469.251:0): avc:  denied  { transition } for  pid=19693
exe=/usr/bin/spamc path=/usr/sbin/sendmail dev=md3 ino=783481
scontext=system_u:system_r:spamd_t
tcontext=system_u:object_r:postfix_pipe_t tclass=process
        Was caused by:
                Constraint violation.
                Check policy/constraints.
                Typically, you just need to add a type attribute to the
domain to satisfy the constraint.

I've been stuck on this one little nagging denial for over a week now...

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
