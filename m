Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KlPIi016156
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:47:25 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KjhPS024572
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:45:47 GMT
Subject: Re: Adding a new user domain
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nick-lists@austin.rr.com>
Cc: SE Linux list <selinux@tycho.nsa.gov>
In-Reply-To: <1102624510.24067.8.camel@hawaii.grays-systems.com>
References: <1102624510.24067.8.camel@hawaii.grays-systems.com>
Content-Type: text/plain
Message-Id: <1102624952.32175.249.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 15:42:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 15:35, Nick Gray wrote:
> I am stuck!
> 
> System: Core 3 Strict/Targeted
> Added: selinux-policy-targeted-sources-1.17.30-2.19.noarch.rpm
> 
> Problem 1: I am trying to use the instructions s"Getting started with
> SELinux" and there are a lot of inconsistencies
> 
> There was no user.te file so I created one
> in /etc/selinux/targeted/src/policy, with the contents:
> 
> full_user_role(tomcat)
> allow system_r (tomcat)
> allow sysadm_r (tomcat)
> 
> Then I went into
> the /etc/selinux/targeted/src/policy/macros/user_macros.te and added 
> 
> role tomcat_r types $1;
> 
> to this file. I cd'd back up to the policy directory and did a 'make
> policy' I didn't see any errors.
> 
> I am assuming from any user who has user_u:system_r:unconfined_t I
> should be able to do this:
> 
> newrole -r tomcat_r
> 
> When I do I get:
> 
> Couldn't get default type.
> 
> Are there updated instructions that make this less of a hunt and peck
> operation?

If you want the strict policy, then do:
yum install selinux-policy-strict selinux-policy-strict-sources
run system-config-securitylevel and change to strict or manually:
	change SELINUXTYPE to strict in /etc/selinux/config
	touch /.autorelabel
reboot

targeted policy was introduced by FC3, so none of the sourceforge
documentation or NSA documentation is likely to mention it yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
