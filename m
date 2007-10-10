Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9A50FTi017328
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 01:00:15 -0400
Received: from mail9.hitachi.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9A509uW019441
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 05:00:10 GMT
Received: from mlsv13.hitachi.co.jp (unknown [133.144.234.166])
	by mail9.hitachi.co.jp (Postfix) with ESMTP id 6443C37C85
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 13:58:35 +0900 (JST)
Date: Wed, 10 Oct 2007 13:58:09 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: The current status of sebusybox project
Cc: ynakam@hitachisoft.jp, SELinux <selinux@tycho.nsa.gov>,
        busybox@kaigai.gr.jp
In-Reply-To: <470C532E.5020108@ak.jp.nec.com>
References: <470C532E.5020108@ak.jp.nec.com>
Message-Id: <20071010133958.6129.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Oct 2007 13:21:02 +0900
KaiGai Kohei wrote:
<snip>
> [policycoreutils package] ... 2 of 7 completed
>  * /sbin/setfiles
>  * /usr/sbin/load_policy
>   - They are already merged.
> 
>  * /usr/sbin/sestatus
>  * /sbin/restorecon
restorecon is merged.
When setfiles is selected, restorecon is also enabled.


>  * /usr/sbin/open_init_pty
>  * /usr/sbin/run_init
>  * /usr/bin/secon
>   - They should be ported later.
> 
>  * /usr/sbin/setsebool
>   - -P option depends on libsemanage, so a limited feature
>     version should be ported now.
> 
>  o /usr/sbin/restorecond
>  o /usr/sbin/semanage
>  o /usr/sbin/semodule
>  o /usr/bin/audit2allow
>  o /usr/bin/audit2why
>  o /usr/bin/chcat
>  o /sbin/fixfiles
>  o /usr/bin/semodule_deps
>  o /usr/bin/semodule_expand
>  o /usr/bin/semodule_link
>  o /usr/bin/semodule_package
>  o /usr/bin/sepolgen-ifgen
>   - We have no plan to port them.
> 
> [coreutils packages] ... 2 of 3 completed
>  * /usr/bin/chcon
>  * /usr/bin/runcon
>   - They are already merged.
> 
>  * /usr/bin/runuser
>   - It should be ported later.
> 
> == SELinux related extensions in the existing commands ==
> * We have 40 of SELinux related extensions in the existing commands,
>   and 19 of them should be ported into busybox. 12 of them are already
>   merged in the upstreamed busybox, and we have rest of 8 items now.
> 
> NOTE: Please tell me, if our understanding about these extension
>       was incorrect.
> 
> [SysVinit package] ... 1 of 1 completed
>  * /sbin/init (is already merged.)
>   - It enables to load the security policy, and to translate
>     its domain with itself as an entrypoint.
> 
> [util-linux package] ... 0 of 2 completed
>  o /usr/bin/chfn
>   - busybox doesn't have this applet.
>   - It enables to preserve the security context of "/etc/passwd",
>     and to check passwd:{chfn} permission.
> 
>  o /usr/bin/chsh
>   - busybox doesn't have this applet.
>   - It enables to preserve the security context of "/etc/passwd",
>     and to check passwd:{chsh} permission.
> 
>  o /usr/sbin/vipw
>   - busybox doesn't have this applet.
>   - It enables to preserve the security context of the target files.
> 
>  * /sbin/mkswap (should be ported later.)
>   - It enables to relabel the target file as "swapfile_t", when we use
>     a regular file as a swap.
> 
>  * /bin/mount (should be ported later.)
>   - It enables to parse mount options, like context="...", fscontext="..."
>     and defcontext="...". It strip quot character (") from them, and translates
>     MLS labels into raw format.
> 
> [openssh package] ... 0 of 0 completed
>  o /usr/sbin/sshd
>   - busybox doesn't have this applet.
>   - It enables to specify its role and MLS range explicitly, using
>     % ssh <username>[/<role>[/<MLS range>]]@hostname style invocation.
> 
> [vixies-cron package] ... 0 of 1 completed
>  * /usr/sbin/crond (should be ported later.)
>   - It enabled to invoke scheduled scripts with its user's security context.
> 
> [at] ... 0 of 0 completed
>  o /usr/bin/at
>   - busybox doesn't have this applet.
>   - It enables to invoke scheduled scripts with its user's security context.
> 
> [sudo] ... 0 of 0 completed
>  o /usr/bin/sudo
>  - busybox doesn't have this applet.
>  - It contained SELinux features in the past, but it is removed now.
> 
> [shadow-utils package] ... 0 of 1 completed
>  o /bin/chage
>   - busybox doesn't have this applet.
>   - It enables to preserve security context of the modified files,
>     and to check passwd:{rootok} permission.
> 
>  * /usr/sbin/useradd (should be ported later.)
>   - It enables to relabel /home/<username>/* with appropriate context came
>     from matchpathcon() when new user's home directory is set up.
>   - -Z or --selinux-user option enables to associate the newly created user
>     with SELinux user, but this feature depends on libsemanege, so we have
>     no plan now.
> 
>  o /usr/sbin/usermod
>   - busybox doesn't have this applet.
>   - It enables to relabel /home/<username>/* with appropriate context came
>     from matchpathcon() when the target user's home directory is set up.
> 
>  o /usr/sbin/userdel
>   - It enables to detach an association between the deleted user and
>     SELinux user, but it depends on libsemanage, so we have no plan now.
> 
> [libuser package] ... 0 of 0 completed
>  o /usr/sbin/lchage
>  o /usr/sbin/lgroupadd
>  o /usr/sbin/lgroupdel
>  o /usr/sbin/lgroupmod
>  o /usr/sbin/lid
>  o /usr/sbin/lnewusers
>  o /usr/sbin/lpasswd
>  o /usr/sbin/luseradd
>  o /usr/sbin/luserdel
>  o /usr/sbin/lusermod
>   - busybox doesn't have this applet.
>   - It enables to preserve the security context of "/etc/passwd",
>     when it is modified.
> 
> [passwd package] ... 0 of 1 completed
>  * /usr/bin/passwd (should be ported later.)
>   - It enables to preserve the security context of the target files,
>     and check passwd:{passwd} permission when root attempt to modify
>     other's password.
> 
> [logrotate package] ... 0 of 0 completed
>  o /usr/sbin/logrotate
>   - busybox doesn't have this applet.
>   - It enables to preserve the security context of the lotated log file,
>     so it attach the same context onto rotated .gz file and new log file.
> 
> [coreutils package] ... 9/9 completed
>  * /bin/ls (is already merged.)
>   - It enables to display the security context of files with -Z option.
> 
>  * /bin/cp (is already merged.)
>   - It enables to specify the security context with -Z option,
>     and preserve the original file's context with -c option.
> 
>  * /bin/mkdir (is already merged.)
>   - It enables to specify the security context with -Z option.
> 
>  * /bin/stat (is already merged.)
>   - It enables to display the security context of files with -Z option.
> 
>  * /bin/mkfifo (is already merged.)
>   - It enables to specify the security context with -Z option.
> 
>  * /bin/mknod (is already merged.)
>   - It enables to specify the security context with -Z option.
> 
>  * /bin/id (is already merged.)
>   - It enables to display the security context of process.
> 
>  * /bin/mv (is already merged.)
>   - It enables to preserve the original files.
> 
>  * /bin/install (is already merged.)
>   - It enables to specify the security context with -Z option,
>     or preserve the original file's context with -P option,
>     or determine the newly installed file's context based on
>     matchpathcon().
> 
> [findutils package] ... 1 of 1 completed
>  * /usr/bin/find (is already merged.)
>   - It enables to filter files with its security context, using
>     -context <security context>.
> 
> [procps package] ... 1 of 1 completed
>  * /bin/ps (is already merged.)
>   - It enables to display the security context of processes with
>     -Z option.
> 
> [psmisc package] ... 0 of 1 completed
>  * /usr/bin/killall (should be ported later.)
>   - It enables to send a signal to the processes which have specified
>     security context with -Z option. We can specify this pattern using
>     regular expression.
> 
>  o /usr/bin/pstree
>   - busybox doesn't have this applet.
>   - It enables to display the security context of the listed processes
>     with -Z option.
> 
> [net-tools package] ... 0 of 1 completed
>  * netstat (should be ported later.)
>   - It enables to display the security context of the listed sockets
>     with -Z option.
> 
> -- 
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
