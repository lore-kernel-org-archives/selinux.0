Subject: Re: Compatibility between binary policy file and kernel version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pravin <shindepravin@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <9d1b82480704030444n6dcc45c2t574e100c98b41816@mail.gmail.com>
References: <9d1b82480704020747v1f05b267j874c4bb2d3f1f941@mail.gmail.com>
	 <1175526715.5889.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1175535336.5889.72.camel@moss-spartans.epoch.ncsc.mil>
	 <9d1b82480704030444n6dcc45c2t574e100c98b41816@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 08:48:06 -0400
Message-Id: <1175604486.5889.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-03 at 17:14 +0530, Pravin wrote:
> >
> > Also, are there any differences in the kernel configs between those
> > kernels, particularly for security-related options?
> 
> well, there was difference in kernel config files.
> After some trial and error, i found out following three config
> options, after setting them filesystem labels were recognized :-).
> 
> {{{
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> }}}

Yes, you need xattr and security label support in the filesystem,
naturally.  You shouldn't need POSIX ACL support, although there is no
harm in having it.

> > grep SECURITY .config
> >
> This is output of grep SECURITY .config
> after above modifications
> {{{
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_SECURITY=y
> CONFIG_SECURITY_NETWORK=y
> # CONFIG_SECURITY_NETWORK_XFRM is not set
> CONFIG_SECURITY_CAPABILITIES=y
> # CONFIG_SECURITY_SECLVL is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> # CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set
> }}}
> 
> I dont know if I have to do any other modifications also.

You want CONFIG_SECURITY_SELINUX_DISABLE=1 if you want SELINUX=disabled
to work in your /etc/selinux/config as an alternative way of disabling
SELinux (vs. specifying selinux=0 on the kernel command line).  Or if
selinux=0 is sufficient for you, you don't need it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
