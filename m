Subject: Re: User defined roles on Linux
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: "S, Senthilprabu (NSN - IN/Bangalore)" <senthilprabu.s@nsn.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
References: 
	 <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
Content-Type: text/plain
Date: Wed, 11 Aug 2010 11:47:04 -0400
Message-Id: <1281541624.8117.95.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-08-11 at 22:59 +0800, S, Senthilprabu (NSN - IN/Bangalore)
wrote:
> Hello All, 
>     I am a newbie to Linux and SELinux as well. So apologize me if my question is stupid. All these days, I have been playing with Solaris. Have implemented user profiles and associated them with roles using RBAC on Solaris to facilitate set of users to run my application. Users assuming my role can only start, stop and troubleshoot application whereas not possible to execute any other commands. Now after RHEL 5.5 migration, I am trying to implement similar roles here too. After running through various RHEL manuals I assume that SELinux can be used to define RBAC roles to some extend, even though its main feature is to implement Mandatory Access Control (MAC). I see few pre-defined roles like  sysadm_r and staff_u. Now my question is it possible to create user defined roles on RHEL 5.5 using SELinux and assign it to shared os accounts?. If possible but not through SELinux, please let me how it can be done?.
> 
> 
> 
> Thanks in advance,
> Senthil Prabu.S
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



This document[1] is a little dated (FC8) but seems to have a good
description of configuring roles in SELinux. One issue is that the
document is specifically about a cash register system that Serge is
explaining. You should be able to take that knowledge though and use it
to make your own custom roles. The basic idea is that you want to figure
out the valid types you want to role to be able to execute, create a new
role containing them and then establish the appropriate transitions.

[1]http://www.ibm.com/developerworks/linux/library/l-rbac-selinux/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
