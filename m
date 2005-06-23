Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NFhUgA027745
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 11:43:30 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NFXfNa024458
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 15:33:41 GMT
Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Colin Walters <walters@verbum.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119470092.9358.43.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
	 <1119470092.9358.43.camel@localhost>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 16:33:36 +0100
Message-Id: <1119540816.9390.35.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > I have absolutely no idea where to go from here...
> > 
> > Tried audit2why?  Could be constraints or RBAC denial.

Oh well, I thought it was working but that was before I restarted
postfix. When I do, I get (audit2why):

audit(1119536844.319:0): avc:  denied  { transition } for  pid=11754
exe=/bin/bash path=/usr/sbin/postfix dev=md3 ino=783515
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:postfix_master_t tclass=process
        Was caused by:
                Constraint violation.
                Check policy/constraints.
                Typically, you just need to add a type attribute to the
domain to satisfy the constraint.

But I've got:
domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
allow initrc_t postfix_master_t:process { noatsecure siginh rlimitinh };
role_transition system_r postfix_master_exec_t object_r;
role system_r types postfix_master_t;
(may be redundant but does not help)

system_u:object_r:postfix_master_exec_t /usr/lib/postfix/master
system_u:object_r:postfix_pipe_exec_t /usr/lib/postfix/pipe

Which type attribute could it be?
Any ideas?

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
