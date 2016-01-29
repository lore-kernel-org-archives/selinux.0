Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0THNekT012471
 for <selinux@tycho.nsa.gov>; Fri, 29 Jan 2016 12:23:49 -0500
From: Thomas Downing <tdowning@bomgar.com>
To: <selinux@tycho.nsa.gov>
Subject: Newbie question on fixfiles
Date: Fri, 29 Jan 2016 11:25:21 -0600
Message-ID: <1464190.SZXTM0cE5o@juss>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I need to get SELinux running on an appliance we are building, not based on a 
distro that already supports SELinux.

I've got all the userspace stuff built, (including setools3) without any 
warnings or errors. I followed instructions for installing and loading 
refpolicy, no warnings or errors.  (Except the python tools, which all import 
selinux.py, which does not seem to be included in the source tree.)

I'm booting with kernel options "security=selinux selinux=1", and dmesg shows 
SELinux initializing, and no errors or warnings.

sestatus output:

SELinux status:				enabled
SELinuxfs mount:			/sys/fs/selinux
SELinux root directory:		/etc/selinux
Loaded policy name:		refpolicy
Current mode:				permissive
Mode from config file:		permissive
Policy MLS status:			disabled
Policy deny_unknown status:	denied
Max kernel policy version:		30

Problem is: fixfiles does not actually label anything, and the underlying reason 
is that none of the mounted disk filesystems (all ext4) have option 'seclabel'.

Any pointers?

Also, given the absence of the seclabel option, I question if the kernel part 
of SELinux is in fact really happy...and if it isn't, I'm dead in the water 
anyway.

Thanks much,

Thomas Downing
