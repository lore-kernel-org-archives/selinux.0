Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4ME0Xth010522
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 10:00:33 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4ME0TCZ006628
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 14:00:29 GMT
Message-ID: <48357C8D.5040408@redhat.com>
Date: Thu, 22 May 2008 10:00:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Suggested global change to policy
References: <483446D5.3050300@redhat.com> <1211462263.11188.95.camel@gorn>
In-Reply-To: <1211462263.11188.95.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2008-05-21 at 11:59 -0400, Daniel J Walsh wrote:
>> Remove all init programs calls to
>> sysadm_dontaudit_list_home_dirs and put that call in the
>>
>> init_system_domain and init_daemon_domain
> 
Well the whole cause of this avc is apps doing a getcwd() call when they
start up.  Which seems to be build into glibc?  Or just executables in
Linux.  So any app that gets started by an administrator sitting in the
/root directory requires this dontaudit rule.  If you look though the
policy this rule is everywhere for both types of init domains.

> I might be able to buy that for the latter, but I don't see it for the
> former.
> 
>> That way we can think about making role/sysadm a module.
>>
>> Of course I believe the /root should have a special context of
>> admin_home_t and not be affected by whether or not you have sysadm
>> policy defined.
> 
> In the RBAC separation branch I was planning to have all the roles have
> the same home directory type anyway (owned by the userdomain module).
> If it ends up that we still need to have a type-based separation between
> unpriv user and admin user home directories, then it will end up being
> as you suggest above.
> 
As long as they are different.  Allowing any confined app to write to
/root should be heavily constrained while writing to random users home
directories is a lot more common.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
