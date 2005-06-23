Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: Colin Walters <walters@verbum.org>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119540816.9390.35.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
	 <1119470092.9358.43.camel@localhost>  <1119540816.9390.35.camel@localhost>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:04:00 -0400
Message-Id: <1119546240.28493.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:33 +0100, antoine wrote:
> Oh well, I thought it was working but that was before I restarted
> postfix. When I do, I get (audit2why):
> 
> audit(1119536844.319:0): avc:  denied  { transition } for  pid=11754
> exe=/bin/bash path=/usr/sbin/postfix dev=md3 ino=783515
> scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:postfix_master_t tclass=process

object_r should never be on a process, and system_r -> object_r
certainly shouldn't be allowed.  

> But I've got:
> domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
> allow initrc_t postfix_master_t:process { noatsecure siginh rlimitinh };
> role_transition system_r postfix_master_exec_t object_r;

This is wrong.  object_r is only for objects, not processes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
