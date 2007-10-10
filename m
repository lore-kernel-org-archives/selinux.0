Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9A4Mln6015947
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 00:22:48 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9A4MjuW013183
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 04:22:46 GMT
Message-ID: <470C532E.5020108@ak.jp.nec.com>
Date: Wed, 10 Oct 2007 13:21:02 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: busybox@kaigai.gr.jp
Subject: The current status of sebusybox project
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following summary is the current status of our sebusybox project.
It shows already ported items and rest of works.
Please tell us, if you know any other extension which should be ported
into busybox.

NOTE: This list is made based on the following description:
      http://selinux.sourceforge.net/devel/userland.php3

NOTE: We don't have a plan to cover libsemanage now, so the related
      commands and features, like setsebool -P option, are not listed
      to be ported.

== SELinux specific commands ==

* We have 32 of SELinux specific commands, and 15 of them should be
  ported into busybox. 9 of them are already merged in the upstreamed
  busybox, and we have rest of 6 items now.

[checkpolicy package] ... 0 of 0 completed
 o /usr/bin/checkmodule
 o /usr/bin/checkpolicy
  - They should be run on the host environment,
    so we have no plan to port them.

[libselinux package] ... 5 of 5 completed
 * /usr/sbin/getenforce
 * /usr/sbin/getsebool
 * /usr/sbin/matchpathcon
 * /usr/sbin/selinuxenabled
 * /usr/sbin/setenforce
  - They are already merged.

 o /usr/sbin/avcstat
 o /usr/sbin/togglesebool
  - We have no plan to port them.

[policycoreutils package] ... 2 of 7 completed
 * /sbin/setfiles
 * /usr/sbin/load_policy
  - They are already merged.

 * /usr/sbin/sestatus
 * /sbin/restorecon
 * /usr/sbin/open_init_pty
 * /usr/sbin/run_init
 * /usr/bin/secon
  - They should be ported later.

 * /usr/sbin/setsebool
  - -P option depends on libsemanage, so a limited feature
    version should be ported now.

 o /usr/sbin/restorecond
 o /usr/sbin/semanage
 o /usr/sbin/semodule
 o /usr/bin/audit2allow
 o /usr/bin/audit2why
 o /usr/bin/chcat
 o /sbin/fixfiles
 o /usr/bin/semodule_deps
 o /usr/bin/semodule_expand
 o /usr/bin/semodule_link
 o /usr/bin/semodule_package
 o /usr/bin/sepolgen-ifgen
  - We have no plan to port them.

[coreutils packages] ... 2 of 3 completed
 * /usr/bin/chcon
 * /usr/bin/runcon
  - They are already merged.

 * /usr/bin/runuser
  - It should be ported later.

== SELinux related extensions in the existing commands ==
* We have 40 of SELinux related extensions in the existing commands,
  and 19 of them should be ported into busybox. 12 of them are already
  merged in the upstreamed busybox, and we have rest of 8 items now.

NOTE: Please tell me, if our understanding about these extension
      was incorrect.

[SysVinit package] ... 1 of 1 completed
 * /sbin/init (is already merged.)
  - It enables to load the security policy, and to translate
    its domain with itself as an entrypoint.

[util-linux package] ... 0 of 2 completed
 o /usr/bin/chfn
  - busybox doesn't have this applet.
  - It enables to preserve the security context of "/etc/passwd",
    and to check passwd:{chfn} permission.

 o /usr/bin/chsh
  - busybox doesn't have this applet.
  - It enables to preserve the security context of "/etc/passwd",
    and to check passwd:{chsh} permission.

 o /usr/sbin/vipw
  - busybox doesn't have this applet.
  - It enables to preserve the security context of the target files.

 * /sbin/mkswap (should be ported later.)
  - It enables to relabel the target file as "swapfile_t", when we use
    a regular file as a swap.

 * /bin/mount (should be ported later.)
  - It enables to parse mount options, like context="...", fscontext="..."
    and defcontext="...". It strip quot character (") from them, and translates
    MLS labels into raw format.

[openssh package] ... 0 of 0 completed
 o /usr/sbin/sshd
  - busybox doesn't have this applet.
  - It enables to specify its role and MLS range explicitly, using
    % ssh <username>[/<role>[/<MLS range>]]@hostname style invocation.

[vixies-cron package] ... 0 of 1 completed
 * /usr/sbin/crond (should be ported later.)
  - It enabled to invoke scheduled scripts with its user's security context.

[at] ... 0 of 0 completed
 o /usr/bin/at
  - busybox doesn't have this applet.
  - It enables to invoke scheduled scripts with its user's security context.

[sudo] ... 0 of 0 completed
 o /usr/bin/sudo
 - busybox doesn't have this applet.
 - It contained SELinux features in the past, but it is removed now.

[shadow-utils package] ... 0 of 1 completed
 o /bin/chage
  - busybox doesn't have this applet.
  - It enables to preserve security context of the modified files,
    and to check passwd:{rootok} permission.

 * /usr/sbin/useradd (should be ported later.)
  - It enables to relabel /home/<username>/* with appropriate context came
    from matchpathcon() when new user's home directory is set up.
  - -Z or --selinux-user option enables to associate the newly created user
    with SELinux user, but this feature depends on libsemanege, so we have
    no plan now.

 o /usr/sbin/usermod
  - busybox doesn't have this applet.
  - It enables to relabel /home/<username>/* with appropriate context came
    from matchpathcon() when the target user's home directory is set up.

 o /usr/sbin/userdel
  - It enables to detach an association between the deleted user and
    SELinux user, but it depends on libsemanage, so we have no plan now.

[libuser package] ... 0 of 0 completed
 o /usr/sbin/lchage
 o /usr/sbin/lgroupadd
 o /usr/sbin/lgroupdel
 o /usr/sbin/lgroupmod
 o /usr/sbin/lid
 o /usr/sbin/lnewusers
 o /usr/sbin/lpasswd
 o /usr/sbin/luseradd
 o /usr/sbin/luserdel
 o /usr/sbin/lusermod
  - busybox doesn't have this applet.
  - It enables to preserve the security context of "/etc/passwd",
    when it is modified.

[passwd package] ... 0 of 1 completed
 * /usr/bin/passwd (should be ported later.)
  - It enables to preserve the security context of the target files,
    and check passwd:{passwd} permission when root attempt to modify
    other's password.

[logrotate package] ... 0 of 0 completed
 o /usr/sbin/logrotate
  - busybox doesn't have this applet.
  - It enables to preserve the security context of the lotated log file,
    so it attach the same context onto rotated .gz file and new log file.

[coreutils package] ... 9/9 completed
 * /bin/ls (is already merged.)
  - It enables to display the security context of files with -Z option.

 * /bin/cp (is already merged.)
  - It enables to specify the security context with -Z option,
    and preserve the original file's context with -c option.

 * /bin/mkdir (is already merged.)
  - It enables to specify the security context with -Z option.

 * /bin/stat (is already merged.)
  - It enables to display the security context of files with -Z option.

 * /bin/mkfifo (is already merged.)
  - It enables to specify the security context with -Z option.

 * /bin/mknod (is already merged.)
  - It enables to specify the security context with -Z option.

 * /bin/id (is already merged.)
  - It enables to display the security context of process.

 * /bin/mv (is already merged.)
  - It enables to preserve the original files.

 * /bin/install (is already merged.)
  - It enables to specify the security context with -Z option,
    or preserve the original file's context with -P option,
    or determine the newly installed file's context based on
    matchpathcon().

[findutils package] ... 1 of 1 completed
 * /usr/bin/find (is already merged.)
  - It enables to filter files with its security context, using
    -context <security context>.

[procps package] ... 1 of 1 completed
 * /bin/ps (is already merged.)
  - It enables to display the security context of processes with
    -Z option.

[psmisc package] ... 0 of 1 completed
 * /usr/bin/killall (should be ported later.)
  - It enables to send a signal to the processes which have specified
    security context with -Z option. We can specify this pattern using
    regular expression.

 o /usr/bin/pstree
  - busybox doesn't have this applet.
  - It enables to display the security context of the listed processes
    with -Z option.

[net-tools package] ... 0 of 1 completed
 * netstat (should be ported later.)
  - It enables to display the security context of the listed sockets
    with -Z option.

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
