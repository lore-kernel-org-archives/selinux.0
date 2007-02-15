Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 20:23:16 +0100
Message-Id: <1171567396.3579.4.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno gio, 15/02/2007 alle 14.12 -0500, Stephen Smalley ha scritto:

> > Of course with Ext[23] extended attributes,
> 
> And CONFIG_EXT3_FS_SECURITY=y too, I assume (i.e. not just the base
> xattr support, but also the security xattr handler).

Done, of course.

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y

> > 3) I unpacked the latest refpolicy according to:
> > http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy
> 
> And built it and installed it?  

Yes, like it said in that page.

> And created an /etc/selinux/config file?

Yes.

> With what contents?

# cat /etc/selinux/config
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - SELinux is fully disabled.
SELINUX=permissive
# SELINUXTYPE= type of policy in use. Possible values are:
#       targeted - Only targeted network daemons are protected.
#       strict - Full SELinux protection.
SELINUXTYPE=targeted
# SETLOCALDEFS= Check local definition changes
SETLOCALDEFS=0
# 

> With what kernel messages from SELinux?  

# dmesg | grep SELinux
SELinux:  Initializing.
SELinux:  Starting in permissive mode
# 

Thank you!

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
