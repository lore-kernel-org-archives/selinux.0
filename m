Message-ID: <1497012308.26846.1.camel@tycho.nsa.gov>
Subject: Re: boot failure due to ambiguous SELinux config
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Cc: 864479-forwarded@bugs.debian.org
Date: Fri, 09 Jun 2017 08:45:08 -0400
In-Reply-To: <3bc76902-e183-ef43-7528-901e579d1031@debian.org>
References: <3bc76902-e183-ef43-7528-901e579d1031@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-09 at 13:25 +0200, Laurent Bigonville wrote:
> Hello,
> 
> I just got the following bugreport in debian that I've been able to 
> reproduce myself:
> 
> When booting with a kernel cmdline 'security=selinux' and a
> /etc/selinux/config setting 'SELINUX=disabled', dbus fails to start
> and thereby systemd-logind and the system is unusable:
> 
> Jun 08 16:23:43 server02 systemd[1]: Started D-Bus System Message
> Bus.
> Jun 08 16:23:43 server02 dbus-daemon[703]: Failed to set up security
> class mapping (selinux_set_mapping():Invalid argument).
> Jun 08 16:24:08 server02 systemd[1]: dbus.service: Main process
> exited, code=exited, status=1/FAILURE
> Jun 08 16:24:08 server02 systemd[1]: dbus.service: Unit entered
> failed state.
> Jun 08 16:24:08 server02 systemd[1]: dbus.service: Failed with result
> 'exit-code'.
> 
> When accessing the system using a debug shell, I can see that the 
> selinuxfs is mounted and sestatus is telling me that selinux is
> enabled. 
> I can manually unmount the selinuxfs and then sestatus is telling me 
> that selinux is disabled on the system.
> 
> Looking quickly at the code, the selinux_init_load_policy() function 
> (which is used in systemd) is supposed to unmount the selinuxfs
> itself 
> if the SELINUX parameter is set to disabled in /etc/selinux/config
> file. 
> I'm not too sure why it's not happening or maybe something else is 
> remounting it? I don't think anything else on the system is trying
> to 
> load the policy though.
> 
> An idea?
> 
> Laurent Bigonville
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=864479

Kernel version and config, particularly the CONFIG_SECURITY_SELINUX
ones?  And are you using any other SELinux-related kernel command line
options (e.g. enforcing=, selinux=)?
