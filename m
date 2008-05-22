Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4MDISQc003569
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 09:18:28 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m4MDIRj6007923
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 13:18:27 GMT
Subject: Re: Suggested global change to policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <483446D5.3050300@redhat.com>
References: <483446D5.3050300@redhat.com>
Content-Type: text/plain
Date: Thu, 22 May 2008 09:17:42 -0400
Message-Id: <1211462263.11188.95.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-05-21 at 11:59 -0400, Daniel J Walsh wrote:
> Remove all init programs calls to
> sysadm_dontaudit_list_home_dirs and put that call in the
> 
> init_system_domain and init_daemon_domain

I might be able to buy that for the latter, but I don't see it for the
former.

> That way we can think about making role/sysadm a module.
> 
> Of course I believe the /root should have a special context of
> admin_home_t and not be affected by whether or not you have sysadm
> policy defined.

In the RBAC separation branch I was planning to have all the roles have
the same home directory type anyway (owned by the userdomain module).
If it ends up that we still need to have a type-based separation between
unpriv user and admin user home directories, then it will end up being
as you suggest above.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
