Subject: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 14 Feb 2007 18:38:59 +0100
Message-Id: <1171474739.27788.17.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, after some weeks i decided to come back at work on SELinux. 
I'm still writing you about SELinux support problem on an LFS-based
distribution.

So, here is what i have done so far:

1) Kernel Configuration

I built the kernel with these options:

# CONFIG_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set

Of course with Ext[23] extended attributes, NET && INET, NETWORK_SECMARK
and AUDIT support.

2) I have built and installed the SELinux userland packages
(checkpolicy,libselinux, policycoreutils, policy) from:

svn co
https://selinux.svn.sourceforge.net/svnroot/selinux/branches/stable/1_0/

3) I unpacked the latest refpolicy according to:
http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy

4) I still haven't patched packages like coreutils and sons.

5) I have created the /selinux mountpoint directory and added the
following lines in fstab:

none                   /selinux  selinuxfs defaults         0    0

6) So i added this line to my "lilo.conf":

        append="enforcing=0"

7) Finally i tried to boot with the new kernel (2.6.20) and after the
reboot the result is:

# sestatus 
SELinux status:                 disabled
# 
#############################

Of course i can't go ahead from the point 5 to 11 of the official README
in "selinux-doc".

I don't know if i really forgot something or if i skip something while
i'm configuring SELinux because this is my really first experience with
selinux configuration. What am i missing? 

Any help would be appreciated.

Thanks in advance for your help!

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
