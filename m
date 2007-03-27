Subject: Re: nscd errors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sylviane Molinet <Sylviane.Molinet@IReS.in2p3.fr>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <4608E744.20405@IReS.in2p3.fr>
References: <4608E744.20405@IReS.in2p3.fr>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 10:03:09 -0400
Message-Id: <1175004189.3864.319.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 11:43 +0200, Sylviane Molinet wrote:
> Hello,
> 
> I've installed redhat ES 4 server with nis authentification. But I have 
> following errors in /var/log/messages :
> nscd:
> 
> Mar 27 09:36:52 nscd: Can't send to audit system: USER_AVC pid=25562 
> uid=28 loginuid=-1 message=avc:  denied  { getgrp } for  
> scontext=root:system_r:unconfined_t tcontext=root:system_r:initrc_t 
> tclass=nscd
> Mar 27 09:36:52  nscd: Can't send to audit system: USER_AVC pid=25562 
> uid=28 loginuid=-1 message=avc:  denied  { shmempwd } for  
> scontext=root:system_r:unconfined_t tcontext=root:system_r:initrc_t 
> tclass=nscd
> Mar 27 09:36:52 nscd: Can't send to audit system: USER_AVC pid=25562 
> uid=28 loginuid=-1 message=avc:  denied  { getpwd } for  
> scontext=root:system_r:unconfined_t tcontext=root:system_r:initrc_t 
> tclass=nscd

Not sure that nscd is supposed to be running in initrc_t in RHEL4, but
you can workaround the issue by allowing the above permissions.  You'd
need to install the selinux-policy-targeted-sources and checkpolicy
packages, and then you can use audit2allow.  Some resources that may
help you:
http://fedoraproject.org/wiki/SELinux/
http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/index.html

Be aware however that SELinux has changed a lot since RHEL4, so you
can't use newer features like loadable policy modules and semanage there
(they are included in RHEL5).  The Fedora Core 3 SELinux FAQ and the
RHEL4 SELinux guide are likely the most suitable resources for RHEL4
SELinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
