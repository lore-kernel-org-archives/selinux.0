Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18281
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 15:09:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OK9mI07469
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 20:09:48 GMT
Received: from smtpproxy2.mitre.org (smtpproxy2.mitre.org [192.80.55.70])
        by jazzband.ncsc.mil  with ESMTP id h1OK9jf07464 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 20:09:45 GMT
Message-ID: <3E5A7BBC.63AF1F96@mitre.org>
Date: Mon, 24 Feb 2003 15:08:28 -0500
From: Clem Skorupka <ragnor@mitre.org>
MIME-Version: 1.0
To: Wayne Salamon <wsalamon@tislabs.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe a number of groups have taken this tact, and it's understood that the
example policy is just that: examples to be trimmed down or modified to suit your
particular security goals.
I also agree that a cleaner way to manage dependencies and untangle macros would be
useful.

My inclination is to define core policy along the lines of  "minimum needed so
system can boot/identify common devices, and be administrated" and not much more
than that.  And then add "core network" capabilities after that.

Basically think of core as the minimum services/policy that any stripped-down
"specialty" server would want.
So if I was building a hardened dns server, I would have no need of printing, or an
apache web server.  Or inetd/xinetd.
I wouldn't need sound.  Or dhcp client.

After that I'd create some category of "server" policy, to cover the webservers,
ftp servers, dns, et al.
Some might want to slice this up into internal servers (e.g. printing, databases)
vs. external servers (e.g. web).  I'd follow common industry practices such as
keeping servers "headless".

Another category would be "user-workstation/gui", which would include dhcp client,
x-windows, sound, web browsers.

Regards,

Clem Skorupka
The MITRE Corporation


Wayne Salamon wrote:

>   I would like some feedback from the list in order to begin paring back
> the SELinux example policy for a smaller 'core'. The idea is that other
> portions of the policy considered non-core will be in a directory whose
> files are not built into the core by default.
>
> Here is a list of policy files that may considered the core policy.
> However, this policy needs some work in order to build, but I'm trying to
> get a feel for what users typically run on their systems.
>
> The inclusion of a file should be determined by the needs of the system
> and what programs are expected to be run, and other needs of the system
> software (network interfaces, for example). The base platform is assumed
> to be a capable Linux workstation with few optional services.
>
> The X Windows related domains have been listed separately.
>
> domains/program (with corresponding file_contexts/program)
> ==========================================================
> apache.te       Apache Web server; may need to be simplified to allow only
>                 serving Web pages without CGI, etc.
> apmd.te         Automatic Power Management daemon
> atd.te          Atd server
> automount.te    Automount daemon
> bootloader.te   Lilo boot loader/manager
> cardmgr.te      PCMCIA control programs
> checkpolicy.te  SELinux policy compliler
> chkpwd.te       PAM password checking programs
> crond.te        Crond daemon
> crontab.te      Crontab manipulation programs
> cups.te         Common Unix Printing System
> devfsd.te       Control daemon for devfs device file system
> dhcpc.te        DHCP client
> fsadm           Disk and file system administration
> getty.te        Manage ttys
> gpm.te          General Purpose Mouse driver
> hotplug.te      Hardware event manager
> hwclock.te      Hardware clock manager
> ifconfig.te     Configure network interfaces
> inetd.te        Internet services daemon
> init.te         Process initialization
> initrc.te       System initialization scripts
> ipchains.te     IP packet filter administration
> klogd.te        Kernel log daemon
> ldconfig.te     Configure dynamic linker bindings
> load_policy.te  Policy loading utilities
> login.te        Local/remote login utilities
> logrotate.te    Rotate log files
> lpr.te          Print client
> modutil.te      Dynamic module utilities
> mount.te        Filesystem mount utilities
> netscape.te     Web browser (most of the policy is in a macros file)
> netutils.te     Network utilities (could be removed)
> newrole.te      SELinux utility to run a shell with a new role
> pamconsole.te   PAM console
> passwd.te       Password utilities
> ping.te         Send ICMP messages to network hosts
> portmap.te      Maintain RPC program number map
> portslave.te    Terminal server software (not sure about this one)
> pppd.te         PPP daemon
> procmail.te     Mail delivery agent for mail servers (may be removed)
> pump.te         DHCP client
> rlogind.te      Remote login daemon (can remove; shouldn't run rlogin anyway)
> rpcd.te         RPC daemon (not sure; how often do client workstations export
>                 RPC services)
> rpm.te          Red Hat package management
> rshd.te         RSH daemon (can remove; shouldn't run rsh anyway)
> selopt.te       SELinux ip labeling utilities (can be removed; should only
>                 be installed when experimenting with labeled packets)
> setfiles.te     SELinux filesystem labeling utilities
> sound.te        Sound utilities
> ssh.te          SSH daemon and ssh command
> su.te           Run shells with substitute user and group (most of the policy
>                 is contained in su_macros.te
> sxid.te         SUID/SGID program monitoring
> syslogd.te      System log daemon
> tmpreaper.te    Monitor and maintain temporary files
> usbmodules.te   List kernel modules for USB devices
> useradd.te      Manage system user accounts
> utempter.te     Privileged helper for utmp/wtmp updates
>
> X Windows potential core domains
> ==================================================
> xauth.te        X authority file utility
> xdm.te          X Display Manager
> xfs.te          X font server
> xserver.te      X Server
>
> Macros
> ======
> The use of macros has grown to be a large problem. The current policy makes use
> of macros that call other macros which call macros. Some macros should be
> eliminated; every_domain, every_test_domain for example. Others should be
> pared down to least privilege; the xx_file_perms and xx_dir_perms for example.
> The use of parameterized macros makes it very difficult to analyze the policy
> source files. Also, there are several instances of rules being duplicated
> in the generated policy due to macro usage.
>
> --
> Wayne Salamon
> wsalamon@tislabs.com
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
