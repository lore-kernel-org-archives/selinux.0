Content-Type: text/plain;
  charset="windows-1252"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: azeredo@qmc.ufsc.br, SELinux@tycho.nsa.gov
Subject: Re: Still problems with RedHat8.0
Date: Wed, 20 Nov 2002 00:33:35 +0100
References: <1037722529.3dda63a114991@qmc.ufsc.br>
In-Reply-To: <1037722529.3dda63a114991@qmc.ufsc.br>
MIME-Version: 1.0
Message-Id: <200211200033.35017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Nov 2002 17:15, azeredo@qmc.ufsc.br wrote:
> avc:  denied  { read } for  pid=666 exe=/usr/local/selinux/bin/checkpolicy
> path=/usr/src/selinux/policy/Makefile dev=03:05 ino=882701
> scontext=root:sysadm_r:checkpolicy_t tcontext=system_u:object_r:src_t
> tclass=file /usr/local/selinux/bin/setfiles file_contexts/file_contexts

/etc/selinux(/.*)?              system_u:object_r:policy_src_t
/etc/security/selinux/src(/.*)? system_u:object_r:policy_src_t
/usr/lib/selinux(/.*)?          system_u:object_r:policy_src_t
/usr/share/selinux(/.*)?        system_u:object_r:policy_src_t

file_contexts/file_context in the default policy has the above entries for 
policy source.  Move your policy source into one of those four directories 
and do a "make relabel" and things will be fine.

> avc:  denied  { write } for  pid=109 exe=/bin/rm path=/halt dev=03:05
> ino=571 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:file_t tclass=file

Why is the rm program trying to write to the file?

> avc:  denied  { read } for  pid=129 exe=/sbin/pam_console_apply
> path=/dev/video dev=03:05 ino=65803 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:v4l_device_t tclass=dir

If you want to chown device nodes for local users then that would require some 
changes to the policy.  If done right they shouldn't be that significant, 
just allow login_t to chown the device nodes and then either create a new 
domain for pam_console_apply when run from initrc_t or grant initrc_t setattr 
access (dangerous).

Also the entry for /dev/(radio|video|vbi|vtx).* in file_contexts/types.fc 
should have "-c" to specify that it's for character devices only so that the 
directory /dev/video doesn't get assigned that type.

I'm not sure that v4l_device_t is appropriate for /dev/video/* entries anyway, 
but that's a separate issue.

> avc:  denied  { write } for  pid=577 exe=/bin/rm
> path=/tmp/.font-unix/fs7100 dev=03:05 ino=180181
> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:xfs_tmp_t
> tclass=sock_file

This rm process should be in the tmpreaper_t domain, then it would be able to 
do that rm.

> avc:  denied  { mknod } for  pid=692 comm=X capability=27
> scontext=root:sysadm_r:sysadm_xserver_t
> tcontext=root:sysadm_r:sysadm_xserver_t tclass=capability

Why does the X server want to create a device node?

> avc:  denied  { write } for  pid=695 exe=/sbin/insmod
> path=/sys/kernel/tainted dev=00:02 ino=4144
> scontext=root:sysadm_r:sysadm_xserver_t
> tcontext=system_u:object_r:sysctl_kernel_t tclass=file

Why does the X server want to run insmod/modprobe?

> avc:  denied  { read write } for  pid=692 exe=/usr/X11R6/bin/XFree86
> path=/dev/input/mice dev=03:05 ino=799982
> scontext=root:sysadm_r:sysadm_xserver_t tcontext=system_u:object_r:device_t
> tclass=chr_file

Add the following line to file_contexts/types.fc:
/dev/input/mice                 system_u:object_r:mouse_device_t

> avc:  denied  { search } for  pid=692 exe=/usr/X11R6/bin/XFree86
> path=/root/.gnome2 dev=03:05 ino=426603
> scontext=root:sysadm_r:sysadm_xserver_t
> tcontext=system_u:object_r:sysadm_home_t tclass=dir

That's the X server trying to search for custom fonts under the .gnome2 
directory, don't worry about it.

> avc:  denied  { read } for  pid=745 exe=/usr/X11R6/bin/xscreensaver
> path=/etc/shadow dev=03:05 ino=230216 scontext=root:sysadm_r:sysadm_t
> tcontext=system_u:object_r:shadow_t tclass=file

I created a separate domain for the KDE screen saver, kcheckpass.  Please try 
configuring xscreensaver to use that and see what happens.

> avc:  denied  { read } for  pid=751 exe=/usr/bin/magicdev path=/dev/hdd
> dev=03:05 ino=33539 scontext=root:sysadm_r:sysadm_t
> tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file

What is magicdev?

> avc:  denied  { execute } for  pid=755 exe=/usr/bin/gnome-session
> path=/usr/share/rhn/rhn_applet/applet.py dev=03:05 ino=833120
> scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:usr_t
> tclass=file

What is rhn?

Maybe all files under rhn_applet should be labeled bin_t?

> avc:  denied  { read write } for  pid=767 exe=/usr/bin/gnome-terminal
> path=/dev/ptyp0 dev=03:05 ino=34775 scontext=root:sysadm_r:sysadm_t
> tcontext=system_u:object_r:device_t tclass=chr_file

Compile your kernel for unix98 PTY's and make sure that /dev/pts is mounted.  
Then make sure that the application tries unix98 first.  Unix98 works well 
and lots of people use it, I'm not sure that the old style pty's work at all.

One thing to be certain of, the pseudo-tty device node should NOT be labelled 
as device_t at the time the terminal program tries to access it.


PS  Why use SE Linux if you are going to run Gnome as sysadm_r?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
