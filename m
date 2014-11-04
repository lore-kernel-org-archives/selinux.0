Message-ID: <5458DAA4.80708@tycho.nsa.gov>
Date: Tue, 04 Nov 2014 08:54:44 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Josh_Pennell@dell.com, selinux@tycho.nsa.gov
Subject: Re: squashfs files showing as unlabeled_t
References: <83DE8B501DA82042847858927365655402BC59B7E7@AUSX7MCPC102.AMER.DELL.COM>
In-Reply-To: <83DE8B501DA82042847858927365655402BC59B7E7@AUSX7MCPC102.AMER.DELL.COM>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/03/2014 09:54 PM, Josh_Pennell@dell.com wrote:
> Hello,
> 
> I'm working on a project using a selinux reference policy on an embedded system.  The device uses a squashfs file system that is labeled during build time.  During the build, policy file labels are applied using Pseudo and setfiles with an alternate root path specified.
> 
> Using a Fedora system it is possible to mount the squashfs file and confirm the file labels are correct.  When checked on target system the squashfs files are incorrect, but ram disk files are correct.  All squashfs files are system_u:object_r:unlabeled_t
> 
> The kernel .config values for squsahfs and selinux here here
> 
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> CONFIG_SQUASHFS_EMBEDDED=y
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=10
> 
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
> CONFIG_SECURITY_SELINUX_DISABLE=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=n
> # CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
> 
> Has anyone else run into this problem?  Any suggestions on what may be wrong?

What type of policy are you building for the target system (i.e. TYPE=
in your build.conf or on the make command-line when building refpolicy)?
 Fedora uses TYPE=mcs by default, so if you set a label on a Fedora
system with SELinux enabled, the on-disk xattr will include a level
field.  If you are building a TYPE=standard policy, then that on-disk
xattr won't be valid on the target and will be remapped to the unlabeled
context.  Likewise if the user, role, or type set on the Fedora side is
not defined in the policy for the target.

Were there any relevant messages in dmesg output on the target, e.g.
regarding an invalid or unmapped context?
