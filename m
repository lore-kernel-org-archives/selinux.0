Subject: Re: [PATCH 2/2] RFC: selinux: sysctl: fix selinux labeling broken
 by last patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lucian Adrian Grijincu <lucian.grijincu@gmail.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Dave
 Chinner <dchinner@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <AANLkTimt5sxmgUmn-i-WcgMN4d0X00YVMujsA4QgS8nX@mail.gmail.com>
References: <AANLkTi=4CH2zFrDp6DAnSj3pa28MtymfG+NrtQ3iW5k-@mail.gmail.com>
	 <1296482354.26427.21.camel@moss-pluto>
	 <AANLkTimt5sxmgUmn-i-WcgMN4d0X00YVMujsA4QgS8nX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 11:59:35 -0500
Message-ID: <1296493175.26427.37.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-01-31 at 18:27 +0200, Lucian Adrian Grijincu wrote:
> There are now fewer differences than before, but I'd like to point
> something out: *without* the patches files in /proc/sys/* get labeled
> like this.
> -r--r--r-- unknown                          /proc/sys/fs/file-nr
> -rw-r--r-- unknown                          /proc/sys/debug/exception-trace
> -rw-r--r-- unknown                          /proc/sys/dev/cdrom/autoclose
> -rw-r--r-- unknown                          /proc/sys/kernel/sem
> -rw-r--r-- unknown
> /proc/sys/net/ipv4/conf/all/accept_local
> 
> but with the patches:
> -r--r--r-- system_u:object_r:sysctl_fs_t:s0 /proc/sys/fs/file-nr
> -rw-r--r-- system_u:object_r:sysctl_t:s0    /proc/sys/debug/exception-trace
> -rw-r--r-- system_u:object_r:sysctl_dev_t:s0 /proc/sys/dev/cdrom/autoclose
> -rw-r--r-- system_u:object_r:sysctl_kernel_t:s0 /proc/sys/kernel/sem
> -rw-r--r-- system_u:object_r:sysctl_net_t:s0
> /proc/sys/net/ipv4/conf/all/accept_local
> 
> 
> There seem to be no labeling mismatches elsewhere. So either sysctl
> labeling is broken in 2.6.37 or my test setup is broken.

/proc/sys inode labeling was disabled earlier (hence marked S_PRIVATE)
when /proc/sys was reimplemented by Eric, so all access control
on /proc/sys was switched to using the sysctl hook rather than the
inode-based checking.  That's why you don't get a result from ls -Z
on /proc/sys on current kernels.  Getting actual labeling working again
for those inodes would be a win, so your patch is an improvement in that
regard for selinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
