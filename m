Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24FJQUH027643
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 10:19:26 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m24FJNKP021328
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 15:19:23 GMT
Date: Tue, 4 Mar 2008 16:19:11 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Martin Orr <martin@martinorr.name>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7, new patch
Message-ID: <20080304151911.GA22571@bobek.pm.i.cz>
References: <1204302749.32061.241.camel@gorn> <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn> <20080229072116.GA13364@bobek.pm.i.cz> <1204292761.32061.230.camel@gorn> <47C824BE.5040001@martinorr.name> <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn> <20080229072116.GA13364@bobek.pm.i.cz> <1204292761.32061.230.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204302749.32061.241.camel@gorn> <47C824BE.5040001@martinorr.name> <1204292761.32061.230.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 29, 2008 at 08:46:01AM -0500, Christopher J. PeBenito wrote:
>...
> The apt rules are fine, but there shouldn't be any more generic pty
> usage anymore.  Are you using an older policy that doesn't have strict
> and targeted merged (and unconfined_r)?

Policy is HEAD. I did a bad work. When I got the denial, I simply grep
policy files for macro that best fits :(.  I assume, that context for pty
was interited from parent directory (devpts_t). Martin did fine analyse.

I tried to install small shlib, insert `ls -laZ /dev/pts' into its
postrm script and remove it:

sid:~# se_apt-get remove libcdb1
Authenticating root.
Password: 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be REMOVED:
  libcdb1
0 upgraded, 0 newly installed, 1 to remove and 0 not upgraded.
After this operation, 36.9kB disk space will be freed.
(Reading database ... 68022 files and directories currently installed.)
Removing libcdb1 ...
total 0
drwxr-xr-x+  2 root root system_u:object_r:devpts_t:s0             0 Feb 29 16:17 .
drwxr-xr-x+ 11 root root system_u:object_r:device_t:s0          2440 Feb 29 16:17 ..
crw-------+  1 zito tty  staff_u:object_r:sysadm_devpts_t:s0  136, 0 Feb 29 16:26 0
crw--w----+  1 root tty  system_u:object_r:initrc_devpts_t:s0 136, 1 Feb 29 16:26 1
crw--w----+  1 root tty  system_u:object_r:devpts_t:s0        136, 2 Feb 29 16:26 2
sid:~# 

and denial (I commented out `term_use_generic_ptys(ldconfig_t)':

audit(1204298770.142:5): avc:  denied  { read write } for  pid=1762 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:devpts_t:s0 tclass=chr_file


On Fri, Feb 29, 2008 at 03:29:02PM +0000, Martin Orr wrote:
>...
> It's because apt creates a pty of its own to run dpkg on, so it can log the
> output.  (This is fairly recent - it has been in apt trunk since October.)
> 
> The attached patch is what I am using to deal with this.  (I'm not sure if
> it should be apt_dontaudit_use_fds(ldconfig_t) or apt_use_fds(ldconfig_t)
> but dontaudit is what the Debian policy package uses.)
>...

Fine, I took your changes. Thanks.


On Fri, Feb 29, 2008 at 11:32:29AM -0500, Christopher J. PeBenito wrote:
>...
> > The attached patch is what I am using to deal with this.  (I'm not sure if
> > it should be apt_dontaudit_use_fds(ldconfig_t) or apt_use_fds(ldconfig_t)
> > but dontaudit is what the Debian policy package uses.)
> 
> You probably want to allow it otherwise ldconfig won't inherit the fds
> that point to the apt pty.  By denying the inheritance on an enforcing
> system, fd 0,1,2 will be closed and reopened to /dev/null, so you lose
> any ldconfig output.

Ok. I did a similar experiment with the patch from Martin but without
`apt_dontaudit_use_fds(ldconfig_t)'.  I added option -v to ldconfig, so
it could create some output and `ls -laZ /dev/pts'.
In permissive mode:

total 0
drwxr-xr-x+  2 root root system_u:object_r:devpts_t:s0             0 Mar  4 15:29 .
drwxr-xr-x+ 11 root root system_u:object_r:device_t:s0          2440 Mar  4 15:31 ..
crw-------+  1 zito tty  staff_u:object_r:sysadm_devpts_t:s0  136, 0 Mar  4 15:41 0
crw--w----+  1 root tty  system_u:object_r:initrc_devpts_t:s0 136, 1 Mar  4 15:41 1
crw--w----+  1 root tty  system_u:object_r:apt_devpts_t:s0    136, 2 Mar  4 15:41 2
ldconfig: Can't stat /lib64: No such file or directory
/lib/i486-linux-gnu:
/usr/lib/i486-linux-gnu:
/usr/local/lib:
/lib:
        libsemanage.so.1 -> libsemanage.so.1
        libnss_mdns6_minimal.so.2 -> libnss_mdns6_minimal.so.2
        libwrap.so.0 -> libwrap.so.0.7.6
        libusb-0.1.so.4 -> libusb-0.1.so.4.4.4
        libreadline.so.5 -> libreadline.so.5.2
...

and denial:

sid login: audit(1204641693.561:8): avc:  denied  { use } for  pid=1983 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd

I restart machine in enforced mode and did the same, but no output from
ldconfig was visible and denials like the above appeared. Listing of
directory /dev/pts was disallowed too (some dontaudit rules probably).

Then I added `apt_use_fds(ldconfig_t)', rebuild the policy and try in
permissive mode:

sid:~# se_apt-get install libcdb1
Authenticating root.
Password: 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  libcdb1
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 0B/11.9kB of archives.
After this operation, 36.9kB of additional disk space will be used.
Selecting previously deselected package libcdb1.
(Reading database ... 68018 files and directories currently installed.)
Unpacking libcdb1 (from .../archives/libcdb1_0.76_i386.deb) ...
Setting up libcdb1 (0.76) ...
sid:~# vim /var/lib/dpkg/info/libcdb1.postrm 
sid:~# cat /var/lib/dpkg/info/libcdb1.postrm
#!/bin/sh
set -e
# Automatically added by dh_makeshlibs
if [ "$1" = "remove" ]; then
        ldconfig -v
fi
# End automatically added section
sid:~# load_policy 
sid:~# se_apt-get remove libcdb1
Authenticating root.
Password: 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be REMOVED:
  libcdb1
0 upgraded, 0 newly installed, 1 to remove and 0 not upgraded.
After this operation, 36.9kB disk space will be freed.
(Reading database ... 68022 files and directories currently installed.)
Removing libcdb1 ...
ldconfig: Can't stat /lib64: No such file or directory
/lib/i486-linux-gnu:
/usr/lib/i486-linux-gnu:
/usr/local/lib:
/lib:
        libsemanage.so.1 -> libsemanage.so.1
        libnss_mdns6_minimal.so.2 -> libnss_mdns6_minimal.so.2
        libwrap.so.0 -> libwrap.so.0.7.6
        libusb-0.1.so.4 -> libusb-0.1.so.4.4.4
...

no denials

I think, that Martin Orr patch is usable fine, but using of apt file
descriptors by ldconfig should be allowed. Martin please review this.

I'm going to learn GNU Arch as penalty for my hasty patch last time. :)
Just kiding, knowing GNU Arch will be worth!

Best Regards
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
