Subject: Re: Cron /null fd:use use denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112295607.12948.69.camel@cobra.ivg2.net>
References: <1112295607.12948.69.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 13:58:03 -0500
Message-Id: <1112295483.11216.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 14:00 -0500, Ivan Gyurdiev wrote:
> What's causing those?
> 
> audit(1112259892.387:9374931): avc:  denied  { use } for  pid=10993
> exe=/usr/sbin/sendmail.sendmail path=/null dev=selinuxfs ino=245
> scontext=system_u:system_r:system_mail_t
> tcontext=system_u:system_r:init_t tclass=fd
> 
> audit(1112259892.551:9376543): avc:  denied  { use } for  pid=10996
> exe=/usr/sbin/tmpwatch path=/null dev=selinuxfs ino=245
> scontext=system_u:system_r:tmpreaper_t tcontext=system_u:system_r:init_t
> tclass=fd
> 
> audit(1112259892.620:9377236): avc:  denied  { use } for  pid=10999
> exe=/usr/sbin/logrotate path=/null dev=selinuxfs ino=245
> scontext=system_u:system_r:logrotate_t tcontext=system_u:system_r:init_t
> tclass=fd

Looks like /sbin/init is leaking a descriptor to something, and then
SELinux is closing it and re-opening it to the null device node in
selinuxfs upon the domain transition to crond (which is then passed on
to its children).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
