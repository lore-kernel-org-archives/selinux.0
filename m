Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9MVtIi016876
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:31:55 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9MVwEj013125
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 22:31:58 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iB9MVwpf025500
	for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 16:31:58 -0600
Subject: Re: Adding a new user domain
From: Nick Gray <nick-lists@austin.rr.com>
To: SE Linux list <selinux@tycho.nsa.gov>
In-Reply-To: <1102624952.32175.249.camel@moss-spartans.epoch.ncsc.mil>
References: <1102624510.24067.8.camel@hawaii.grays-systems.com>
	 <1102624952.32175.249.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 16:31:58 -0600
Message-Id: <1102631518.24067.29.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It appears that the file was in the wrong place

Now I am getting:

domains/user.te:3:ERROR 'syntax error' at token 'allow' on line 6742:
allow sysadm_r tomcat_r
allow system_r tomcat_r
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.18] Error 1


On Thu, 2004-12-09 at 15:42 -0500, Stephen Smalley wrote:
> On Thu, 2004-12-09 at 15:35, Nick Gray wrote:
> > I am stuck!
> > 
> > System: Core 3 Strict/Targeted
> > Added: selinux-policy-targeted-sources-1.17.30-2.19.noarch.rpm
> > 
> > Problem 1: I am trying to use the instructions s"Getting started with
> > SELinux" and there are a lot of inconsistencies
> > 
> > There was no user.te file so I created one
> > in /etc/selinux/targeted/src/policy, with the contents:
> > 
> > full_user_role(tomcat)
> > allow system_r (tomcat)
> > allow sysadm_r (tomcat)
> > 
> > Then I went into
> > the /etc/selinux/targeted/src/policy/macros/user_macros.te and added 
> > 
> > role tomcat_r types $1;
> > 
> > to this file. I cd'd back up to the policy directory and did a 'make
> > policy' I didn't see any errors.
> > 
> > I am assuming from any user who has user_u:system_r:unconfined_t I
> > should be able to do this:
> > 
> > newrole -r tomcat_r
> > 
> > When I do I get:
> > 
> > Couldn't get default type.
> > 
> > Are there updated instructions that make this less of a hunt and peck
> > operation?
> 
> If you want the strict policy, then do:
> yum install selinux-policy-strict selinux-policy-strict-sources
> run system-config-securitylevel and change to strict or manually:
> 	change SELINUXTYPE to strict in /etc/selinux/config
> 	touch /.autorelabel
> reboot
> 
> targeted policy was introduced by FC3, so none of the sourceforge
> documentation or NSA documentation is likely to mention it yet.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
