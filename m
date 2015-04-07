Message-ID: <5523E379.7060508@tycho.nsa.gov>
Date: Tue, 07 Apr 2015 10:02:33 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ravi Kumar <nxp.ravi@gmail.com>, Selinux@tycho.nsa.gov,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: Re: CONFIG_SECURITY_SELINUX_DEVELOP flag is still enabled in most
 of the AOSP based releases , Can we remove this in production builds . .
References: <CACikiw0ta3yLkbHLRVG=fScjwq9htK3s2y0VHUqWk09OysoNPA@mail.gmail.com>
 <5523CE8B.1040600@tycho.nsa.gov>
In-Reply-To: <5523CE8B.1040600@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/07/2015 08:33 AM, Stephen Smalley wrote:
> On 04/07/2015 01:30 AM, Ravi Kumar wrote:
>> Hi Team , 
>>
>> I see most of the AOSP  based release are still using
>> "CONFIG_SECURITY_SELINUX_DEVELOP "  defined and  there is still
>> possibility open for  getting or landing to permissive  can  we  remove
>> this flag  in  release  or production build  ?    and   what sort of
>> additional testing   is expected   to be run . 
> 
> First, discussion of SELinux in Android is typically done on the
> seandroid-list, not the selinux list, unless it is generic in nature for
> all of SELinux (e.g. changes to upstream SELinux).  Subscribe by sending
> email to seandroid-list-join@tycho.nsa.gov and following the
> instructions in the confirmation email.  I have added seandroid-list to
> the cc list for this reply.
> 
> CONFIG_SECURITY_SELINUX_DEVELOP aka global permissive mode is useful for
> when you are first developing device-specific policy for a board (add
> androidboot.selinux=permissive to BOARD_KERNEL_CMDLINE).  It also
> permits transient setenforce 0 in -userdebug or -eng builds, which can
> be helpful for developers.
> 
> If the bootloader is locked, then you can't modify the kernel cmdline,
> so you cannot use androidboot.selinux=permissive to defeat the security
> of a locked device.  setenforce permission is not allowed to any domain
> in policy (and this is validated by a neverallow rule, checked both at
> policy build time and by CTS) and no permissive domains are permitted in
> -user builds (checked by CTS), so you cannot use setenforce 0 to defeat
> the security of a device with a -user build that has passed CTS.
> 
> If you can directly modify the selinux_enforcing kernel variable via
> kernel exploit, then there are many other options available to you for
> disabling SELinux, escalating your own privileges, or modifying the
> policy (including making your own domain permissive, which is not
> affected by CONFIG_SECURITY_SELINUX_DEVELOP=n), so taking away
> CONFIG_SECURITY_SELINUX_DEVELOP won't help significantly.
> 
> So I don't believe that disabling CONFIG_SECURITY_SELINUX_DEVELOP would
> truly make a substantive difference to security.  Obviously you are free
> to do so if you wish, but it will require you to use slightly different
> kernel configurations for development vs production, which could have an
> impact on your QA/testing processes.
> 
> The only potential breakage from disabling
> CONFIG_SECURITY_SELINUX_DEVELOP would be if the init program treats a
> failed security_setenforce(1) call as a fatal error, since writes to
> /sys/fs/selinux/enforce will always fail in that case.  However, it
> appears that the Android init program ignores the return value of
> security_setenforce() so it would not break if you disable the option.

Also, the code in the init program for processing the
androidboot.selinux= option is only compiled in -userdebug/-eng builds,
so even aside from bootloader locking, you cannot use
androidboot.selinux=permissive on a -user build.

In upstream SELinux, the selinux_init_load_policy() libselinux function
called by various init programs (e.g. systemd) calls
security_getenforce() to check the boot-time enforcing status and only
calls security_setenforce() if the desired enforcing status differs, so
it won't bother trying to call security_setenforce(1) if the kernel has
CONFIG_SECURITY_SELINUX_DEVELOP=n.  Could do likewise in the Android
init program but it isn't a big deal.
