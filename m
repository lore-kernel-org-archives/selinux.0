Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q443X6Rv030121
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2012 23:33:06 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casinee app <appcasinee@gmail.com>, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: Can't login the embedded linux with seliux support
Date: Fri, 4 May 2012 13:32:59 +1000
References: <CAO-AVB4KaNM=V97rPjgTDr_x5QuXvyAZnoBv8WJWZDG+2a6RpA@mail.gmail.com> <201205032130.23611.russell@coker.com.au> <CAO-AVB6cO6ZaN9e40oo4uVL2HfU55=N1wOyVOs92qEfop6zpDA@mail.gmail.com>
In-Reply-To: <CAO-AVB6cO6ZaN9e40oo4uVL2HfU55=N1wOyVOs92qEfop6zpDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201205041333.00008.russell@coker.com.au>
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

On Fri, 4 May 2012, casinee app <appcasinee@gmail.com> wrote:
> 2012/5/3, Russell Coker <russell@coker.com.au>:
> > On Thu, 3 May 2012, casinee app <appcasinee@gmail.com> wrote:
> >> i build a linux system with selinux support for my embedded device. It
> >> now can login as the root user automatically when it is powered on.
> > 
> > What distribution is the embedded system most similar to?  Using Busybox
> > makes
> > things a bit more difficult as some of the programs won't end up in the
> > correct domains unless you do some work.  But it would be good to know
> > more about the distro so we can identify other potential problems.
> 
> Yes, i build the busybox to get the shell tools for the root
> filesystem. The lib needed are libselinux and libsepol. What's the
> "unless you do some work" you said means?

The purpose of Busybox is to save disk space by having code shared among 
multiple applications.  So for example /bin/login and /bin/init will be hard 
links or sym-links to the same executable.  SE Linux has labels based on 
Inodes so we can't have init labelled as init_exec_t and login labelled as 
login_exec_t if they are both the same program.

http://doc.coker.com.au/papers/porting-se-linux-hand-held-devices/

The above URL explains how I solved this problem on ARM in 2003.  Since 2003 
RAM has become bigger (even in embedded systems) so the down-sides of this are 
diminished.

> > With this automatic login, what is the context of the shell?  "id -Z"
> > should tell you.
> 
> 2)some information in and after boot process.
> ……
> Please press Enter to activate this console.
> [root@MrExcalibur=/]#dmesg
[no AVC messages in the dmesg output]
> [root@MrExcalibur=/]#restorecon -R /

The -v option to restorecon is good in these cases to show whether it's doing 
something.

> [root@MrExcalibur=/]#id -Z
> id: can't get process context

That's strange, please run "strace id -Z".

> [root@MrExcalibur=/]#ps -Z
>   PID CONTEXT                          STAT COMMAND
[snip]
>   881 system_u:system_r:kernel_t       S    -/bin/sh
>   884 system_u:system_r:kernel_t       R    ps -Z

OK, you have no domain transition happening.  /sbin/init is not labelled 
correctly or it doesn't exec itself.

> [root@MrExcalibur=/]#ls -Z
> drwxr-xr-x system_u:object_r:dir_bin_t      bin
> drwxr-xr-x system_u:object_r:dir_childdir__t boot
> drwxr-xr-x system_u:object_r:dir_dev_t      dev
> drwxr-xr-x system_u:object_r:dir_etc_t      etc
> drwxr-xr-x system_u:object_r:dir_homedir_rootdir_t home
> drwxr-xr-x system_u:object_r:dir_lib_t      lib
> lrwxrwxrwx system_u:object_r:rootdir_t      linuxrc
> drwxr-xr-x system_u:object_r:dir_childdir__t mnt
> dr-xr-xr-x system_u:object_r:proc_t         proc
> drwxr-xr-x system_u:object_r:dir_childdir__t root
> drwxr-xr-x system_u:object_r:dir_sbin_t     sbin
> drwxr-xr-x system_u:object_r:security_t     selinux
> drwxr-xr-x system_u:object_r:sysfs_t        sys
> drwxr-xr-x system_u:object_r:tmp_t          tmp
> drwxr-xr-x system_u:object_r:dir_childdir__t tst
> drwxr-xr-x system_u:object_r:dir_usr_t      usr
> drwxr-xr-x system_u:object_r:dir_var_t      var
> [root@MrExcalibur=/]#

What are all these dir_X_t types?  You've got a very different policy to the 
refernce policy.

> >> Then i copy the fiels( shadow ,group and passwd) in my PC linux system
> >> to the embedded system, and add the login to it. But after i input the
> > 
> >> username and pass word, it output like this :
> > So you had a working system but then after copying those three files it
> > didn't
> > work?  If so then it probably got the wrong type for one of them.  If so
> > then
> > "restorecon -R -v /etc" will probably fix it.
> 
> I change the file /etc/inittab to this to add the login program to the
> system: #etc/inittab
> 
> ::respawn:-/bin/login
> ::sysinit:/etc/init.d/rcS
> ::ctrlaltdel:/sbin/reboot
> ::shutdown:/bin/umount -a -r
> 
> Then, when the system start up be required to input the username and
> password. login:root
> password:
> login:Can’t get SID for root
> The error comes out.
> 
> >> login:root
> >> password:
> >> login:Can’t get SID for root
> >> 
> >> The output comes from the file  login.c in busybox, how can i sovle
> >> this problem?
> >> Does this problem comes from the error in my policy? or the lib
> >> related to the selinux?
> > 
> > When there's a problem that prevents logging in then it's often best to
> > boot
> > 
> > the system with "enforcing=0" on the kernel command line.
> 
> How to set  "enforcing=0"?  Do you mean the configuration option of the
> kernel? [*] NSA SELinux Support
>      [* ]   NSA SELinux boot parameter
> and set the NSA SELinux boot parameter as 0?

No, a parameter on the kernel command line.  It's something you do through the 
boot loader.

> > Then you can login
> > and view the contexts of the processes and files in question and also
> > look at
> > the audit log (or kernel log for a system without auditd) to see what
> > would
> > 
> > have been denied.  All login programs should have special-case code to
> > allow
> > 
> > launching a shell in an invalid context when the system is in permissive
> > mode.
> 
> The fiel /etc/selinux/config of the system :
> [root@MrExcalibur=selinux]#cat config
> # This file controls the state of SELinux on the system.
> # SELINUX= can take one of these three values:
> #       enforcing - SELinux security policy is enforced.
> #       permissive - SELinux prints warnings instead of enforcing.
> #       disabled - SELinux is fully disabled.
> SELINUX=permissive
> # SELINUXTYPE= type of policy in use. Possible values are:
> #       targeted - Only targeted network daemons are protected.
> #       strict - Full SELinux protection.
> SELINUXTYPE=seedit

OK, it's already in permissive mode.

What is the "seedit" type?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
