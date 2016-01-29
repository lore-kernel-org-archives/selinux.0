Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0TIOTUL017962
 for <selinux@tycho.nsa.gov>; Fri, 29 Jan 2016 13:24:34 -0500
From: Thomas Downing <tdowning@bomgar.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: Newbie question on fixfiles
Date: Fri, 29 Jan 2016 12:26:09 -0600
Message-ID: <7201270.lcs2eakWRV@juss>
In-Reply-To: <2033239564.1859278.1454089035658.JavaMail.yahoo@mail.yahoo.com>
References: <1464190.SZXTM0cE5o@juss>
 <2033239564.1859278.1454089035658.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 29, 2016 17:37:15 Joe Wulf wrote:
> What filesystem is applied to your disk and its various partitions?For this
> to work, that FS has to be one that supports SELinux labeling
> (seclabel).You are right---if what you are using doesn't support that, you
> are dead in the water (currently).What options do you have to change to an
> SELinux-compliant FS?

The disk partitions are all ext4.

cat /proc/config.gz | gunzip - | grep CONFIG_EXT4 yeilds:

CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y

as root, cat /proc/self/mounts | grep ext4 yeids:

/dev/root / ext4 rw,relatime,data=ordered 0 0
/dev/sda5 /home ext4 rw,relatime,data=ordered 0 0
/dev/sda6 /var ext4 rw,relatime,data=ordered 0 0
/dev/sda1 /boot ext4 rw,relatime,data=ordered 0 0


Thanks

Thomas Downing.


> 
>       From: Thomas Downing <tdowning@bomgar.com>
>  To: selinux@tycho.nsa.gov
>  Sent: Friday, January 29, 2016 12:25 PM
>  Subject: Newbie question on fixfiles
> 
> Hi,
> 
> I need to get SELinux running on an appliance we are building, not based on
> a distro that already supports SELinux.
> 
> I've got all the userspace stuff built, (including setools3) without any
> warnings or errors. I followed instructions for installing and loading
> refpolicy, no warnings or errors.  (Except the python tools, which all
> import selinux.py, which does not seem to be included in the source tree.)
> 
> I'm booting with kernel options "security=selinux selinux=1", and dmesg
> shows SELinux initializing, and no errors or warnings.
> 
> sestatus output:
> 
> SELinux status:                enabled
> SELinuxfs mount:            /sys/fs/selinux
> SELinux root directory:        /etc/selinux
> Loaded policy name:        refpolicy
> Current mode:                permissive
> Mode from config file:        permissive
> Policy MLS status:            disabled
> Policy deny_unknown status:    denied
> Max kernel policy version:        30
> 
> Problem is: fixfiles does not actually label anything, and the underlying
> reason is that none of the mounted disk filesystems (all ext4) have option
> 'seclabel'.
> 
> Any pointers?
> 
> Also, given the absence of the seclabel option, I question if the kernel
> part of SELinux is in fact really happy...and if it isn't, I'm dead in the
> water anyway.
> 
> Thanks much,
> 
> Thomas Downing
