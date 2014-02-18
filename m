Message-ID: <53037645.7060909@tycho.nsa.gov>
Date: Tue, 18 Feb 2014 10:03:33 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>, selinux@tycho.nsa.gov
Subject: Re: Using genfscon's partial_path for other filesystems than proc
References: <20140215190941.1bac965b@gentp.lnet>
In-Reply-To: <20140215190941.1bac965b@gentp.lnet>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/15/2014 01:09 PM, Luis Ressel wrote:
> Hello,
> 
> 
> The genfscon policy statement has an argument "partial_path" which can
> be used to use specialized contexts for subpaths inside a file system.
> However, the documentation mentions that this can only be used for the
> proc filesystem. Is this really the case, and if yes, why? I'd like to
> use it for the sysfs.
> 
> The motivation for this is that both the Fedora and the Gentoo policy
> have cpu_online_t for /sys/devices/system/cpu/online, as this file is
> accessed by all applications linked to a recent glibc and therefore
> needs wider access permissions than the normal sysfs_t. Currently, the
> context is changed at startup via an init script, which is a bit of a
> hack. It would be neat if a genfscon statement could be used for that.
> 
> Is this currently possible or would it require changes to the kernel
> and/or the selinux libraries?

Setting from userspace is preferable when possible, so just do that.  In
Android, there is a recursive restorecon (equivalent of restorecon -R)
applied to /sys on boot to set up the labels of all sysfs files based on
file_contexts entries and their udev equivalent (ueventd) fixes up the
labels on any sysfs files created subsequently.

genfs_contexts path prefix matching support for a given filesystem
requires kernel code changes, and we try to avoid it.  For /proc it
makes sense since the entire proc tree is kernel generated and immutable
by userspace and since proc does not provide xattr handlers.  For sysfs
we explored use of genfs_contexts but preferred a userspace solution and
that is now supported by modern kernels.
