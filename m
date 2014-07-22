Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6MCChG8027063
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 08:12:43 -0400
Message-ID: <53CE5531.4020306@tresys.com>
Date: Tue, 22 Jul 2014 08:12:33 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Avijit Das <avijitnsec@live.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: File-system is not mounting when I am enabling selinux
References: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
In-Reply-To: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/21/2014 7:03 PM, Avijit Das wrote:
> Hi,
> 
> I am trying to enable SELinux in Android platform. I am getting the
> following error message:

> [   17.767028] SELinux: (dev mmcblk0p24, type ext4) has no security
> xattr handler
> [   17.830819] SELinux: (dev mmcblk0p29, type ext4) has no security
> xattr handler
> [   17.865028] EXT4-fs (mmcblk0p29): mounted filesystem with ordered
> data mode. Opts: barrier=1,noauto_da_alloc
> [   17.873877] SELinux: (dev mmcblk0p29, type ext4) has no security
> xattr handler
> [   17.934144] SELinux: (dev mmcblk0p25, type ext4) has no security
> xattr handler
> [   17.955632] SELinux: (dev mmcblk0p26, type ext4) has no security
> xattr handler

Your ext4 is missing security labels (note no security xattr handler
error), you need to turn on CONFIG_EXT4_FS_SECURITY.


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
