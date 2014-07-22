Message-ID: <53CE586C.5080403@tycho.nsa.gov>
Date: Tue, 22 Jul 2014 08:26:20 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Avijit Das <avijitnsec@live.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: File-system is not mounting when I am enabling selinux
References: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
In-Reply-To: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/21/2014 07:03 PM, Avijit Das wrote:
> Hi,
> 
> I am trying to enable SELinux in Android platform. I am getting the
> following error message:
> 
> [   16.331402] init: invalid uid 'fm_radio'
> [   17.759590] EXT4-fs (mmcblk0p24): mounted filesystem with ordered
> data mode. Opts: barrier=1
> [   17.767028] SELinux: (dev mmcblk0p24, type ext4) has no security
> xattr handler

As Chris said, this indicates that your kernel configuration is missing
an option required for SELinux, CONFIG_EXT4_FS_SECURITY=y, and therefore
does not include the security xattr handlers.

Also, questions regarding the Android SELinux support are best directed
to the seandroid-list, subscribe by sending email to
seandroid-list-join@tycho.nsa.gov.
