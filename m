Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171474739.27788.17.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 14:12:11 -0500
Message-Id: <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 18:38 +0100, Vincenzo Ciaglia wrote:
> Hi, after some weeks i decided to come back at work on SELinux. 
> I'm still writing you about SELinux support problem on an LFS-based
> distribution.
> 
> So, here is what i have done so far:
> 
> 1) Kernel Configuration
> 
> I built the kernel with these options:
> 
> # CONFIG_KEYS is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITY_NETWORK=y
> # CONFIG_SECURITY_NETWORK_XFRM is not set
> CONFIG_SECURITY_CAPABILITIES=y
> # CONFIG_SECURITY_ROOTPLUG is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
> CONFIG_SECURITY_SELINUX_DISABLE=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> # CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set
> # CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
> 
> Of course with Ext[23] extended attributes,

And CONFIG_EXT3_FS_SECURITY=y too, I assume (i.e. not just the base
xattr support, but also the security xattr handler).

> 3) I unpacked the latest refpolicy according to:
> http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy

And built it and installed it?  And created an /etc/selinux/config file?
With what contents?

> 7) Finally i tried to boot with the new kernel (2.6.20) and after the
> reboot the result is:
> 
> # sestatus 
> SELinux status:                 disabled

With what kernel messages from SELinux?  e.g.
$ dmesg | grep SELinux
SELinux:  Initializing.
SELinux:  Starting in permissive mode
SELinux:  Registering netfilter hooks
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
