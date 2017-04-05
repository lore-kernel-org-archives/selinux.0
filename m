Message-ID: <1491405087.15479.16.camel@tycho.nsa.gov>
Subject: Re: newrole: pam_systemd fails after dbus message rejection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cgzones <cgzones@googlemail.com>, selinux <selinux@tycho.nsa.gov>
Date: Wed, 05 Apr 2017 11:11:27 -0400
In-Reply-To: <CAJ2a_DdWUN98=F6dL0X22xSOd7bu1bvXQHaKha0+EyLE2X=UXQ@mail.gmail.com>
References: <CAJ2a_DdWUN98=F6dL0X22xSOd7bu1bvXQHaKha0+EyLE2X=UXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-05 at 15:11 +0200, cgzones wrote:
> Hi list,
> when switching context with `newrole` I am getting the following
> error
> message, although the session is succesffully created and works fine:
> 
> Apr 05 14:59:25 debianserver dbus[357]: [system] Rejected send
> message, 2 matched rules; type="method_call", sender=":1.7" (uid=1000
> pid=2428 comm="newrole -r sysadm_r ")
> interface="org.freedesktop.login1.Manager" member="CreateSession"
> Apr 05 14:59:25 debianserver newrole[2428]:
> pam_systemd(newrole:session): Failed to create session: Access denied
> 
> Is this a dbus or pam_systemd problem?
> 
> The issue is present with and without the dbus-send_policynote
> patch[1].

I see the same in Fedora. It isn't a SELinux denial, but rather a dbus
denial based on a file provided by systemd.  /etc/dbus-
1/system.d/org.freedesktop.login1.conf only allows user=root to send
any call other than the ones whitelisted under the default context, and
CreateSession is not whitelisted there.  I assume this is because any
other program that creates a session is setuid-root, and newrole is
instead using file capabilities these days? I am not sure what the
correct fix is for this issue, although it does not seem to be fatal as
you say.  It appears that newrole only opens a session to support use
of pam_namespace, and this is not the default pam configuration for
newrole.

> 
> Best regards,
>       Christian Göttsche
> 
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=857660
> 
> 
> Verbose output without dontaudit rules active:
> 
> Apr 05 14:59:21 debianserver audit[2424]: AVC avc:  denied  {
> rlimitinh } for  pid=2424 comm="newrole"
> scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:21 debianserver audit[2424]: AVC avc:  denied  { siginh
> }
> for  pid=2424 comm="newrole"
> scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:21 debianserver audit[2424]: SYSCALL arch=c000003e
> syscall=59 success=yes exit=0 a0=92c1a8 a1=91d108 a2=a01008 a3=59a
> items=2 ppid=2415 pid=2424 auid=1000 uid=1000 gid=1000 euid=1000
> suid=1000 fsuid=1000 egid=1000 sgid=1000
> Apr 05 14:59:21 debianserver audit: BPRM_FCAPS fver=2
> fp=000000002020010f fi=0000000000000000 fe=1 old_pp=0000000000000000
> old_pi=0000000000000000 old_pe=0000000000000000
> new_pp=000000002020010f new_pi=0000000000000000 new_pe=00000000202
> Apr 05 14:59:21 debianserver audit: EXECVE argc=3 a0="newrole" a1="-
> r"
> a2="sysadm_r"
> Apr 05 14:59:21 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:21 debianserver audit: PATH item=0
> name="/usr/bin/newrole" inode=155812 dev=08:01 mode=0100755 ouid=0
> ogid=0 rdev=00:00 obj=system_u:object_r:newrole_exec_t:s0
> nametype=NORMAL cap_fp=000000002020010f cap_fe=1 cap_fver=2
> Apr 05 14:59:21 debianserver audit: PATH item=1
> name="/lib64/ld-linux-x86-64.so.2" inode=132140 dev=08:01
> mode=0100755
> ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL
> Apr 05 14:59:21 debianserver audit: PROCTITLE
> proctitle=6E6577726F6C65002D720073797361646D5F72
> Apr 05 14:59:21 debianserver audit[2424]: AVC avc:  denied  { read }
> for  pid=2424 comm="newrole" name="shadow" dev="sda1" ino=152257
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file pe
> Apr 05 14:59:21 debianserver audit[2424]: SYSCALL arch=c000003e
> syscall=2 success=no exit=-13 a0=7f9037b667f1 a1=80000 a2=1b6
> a3=80000
> items=1 ppid=2415 pid=2424 auid=1000 uid=1000 gid=1000 euid=1000
> suid=1000 fsuid=1000 egid=1000 sgid=1
> Apr 05 14:59:21 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:21 debianserver audit: PATH item=0 name="/etc/shadow"
> inode=152257 dev=08:01 mode=0100640 ouid=0 ogid=42 rdev=00:00
> obj=system_u:object_r:shadow_t:s0 nametype=NORMAL
> Apr 05 14:59:21 debianserver audit: PROCTITLE
> proctitle=6E6577726F6C65002D720073797361646D5F72
> Apr 05 14:59:21 debianserver audit[2425]: AVC avc:  denied  {
> rlimitinh } for  pid=2425 comm="unix_chkpwd"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:chkpwd_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:21 debianserver audit[2425]: AVC avc:  denied  { siginh
> }
> for  pid=2425 comm="unix_chkpwd"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:chkpwd_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:21 debianserver audit[2425]: SYSCALL arch=c000003e
> syscall=59 success=yes exit=0 a0=7f903731ac0d a1=7ffffabf2000
> a2=7f90375223c0 a3=7f903941bfc0 items=2 ppid=2424 pid=2425 auid=1000
> uid=1000 gid=1000 euid=1000 suid=1000 fsui
> Apr 05 14:59:21 debianserver audit: EXECVE argc=3
> a0="/sbin/unix_chkpwd" a1="debianuser" a2="nullok"
> Apr 05 14:59:21 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:21 debianserver audit: PATH item=0
> name="/sbin/unix_chkpwd" inode=627 dev=08:01 mode=0102755 ouid=0
> ogid=42 rdev=00:00 obj=system_u:object_r:chkpwd_exec_t:s0
> nametype=NORMAL
> Apr 05 14:59:21 debianserver audit: PATH item=1
> name="/lib64/ld-linux-x86-64.so.2" inode=132140 dev=08:01
> mode=0100755
> ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL
> Apr 05 14:59:21 debianserver audit: PROCTITLE
> proctitle=2F7362696E2F756E69785F63686B7077640064656269616E75736572006
> E756C6C6F6B
> Apr 05 14:59:25 debianserver audit[2424]: AVC avc:  denied  { read }
> for  pid=2424 comm="newrole" name="shadow" dev="sda1" ino=152257
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file pe
> Apr 05 14:59:25 debianserver audit[2424]: SYSCALL arch=c000003e
> syscall=2 success=no exit=-13 a0=7f9037b667f1 a1=80000 a2=1b6
> a3=80000
> items=1 ppid=2415 pid=2424 auid=1000 uid=1000 gid=1000 euid=1000
> suid=1000 fsuid=1000 egid=1000 sgid=1
> Apr 05 14:59:25 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:25 debianserver audit: PATH item=0 name="/etc/shadow"
> inode=152257 dev=08:01 mode=0100640 ouid=0 ogid=42 rdev=00:00
> obj=system_u:object_r:shadow_t:s0 nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PROCTITLE
> proctitle=6E6577726F6C65002D720073797361646D5F72
> Apr 05 14:59:25 debianserver audit[2426]: AVC avc:  denied  {
> rlimitinh } for  pid=2426 comm="unix_chkpwd"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:chkpwd_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2426]: AVC avc:  denied  { siginh
> }
> for  pid=2426 comm="unix_chkpwd"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:chkpwd_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2426]: SYSCALL arch=c000003e
> syscall=59 success=yes exit=0 a0=7f903731ac0d a1=7ffffabf1fc0
> a2=7f90375223c0 a3=7f903941bfc0 items=2 ppid=2424 pid=2426 auid=1000
> uid=1000 gid=1000 euid=1000 suid=1000 fsui
> Apr 05 14:59:25 debianserver audit: EXECVE argc=3
> a0="/sbin/unix_chkpwd" a1="debianuser" a2="nullok"
> Apr 05 14:59:25 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:25 debianserver audit: PATH item=0
> name="/sbin/unix_chkpwd" inode=627 dev=08:01 mode=0102755 ouid=0
> ogid=42 rdev=00:00 obj=system_u:object_r:chkpwd_exec_t:s0
> nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PATH item=1
> name="/lib64/ld-linux-x86-64.so.2" inode=132140 dev=08:01
> mode=0100755
> ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PROCTITLE
> proctitle=2F7362696E2F756E69785F63686B7077640064656269616E75736572006
> E756C6C6F6B
> Apr 05 14:59:25 debianserver audit[2424]: USER_AUTH pid=2424 uid=1000
> auid=1000 ses=5 subj=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> msg='op=PAM:authentication acct="debianuser" exe="/usr/bin/newrole"
> hostname=? addr=? terminal=pts/1 res=
> Apr 05 14:59:25 debianserver audit[2424]: AVC avc:  denied  { read }
> for  pid=2424 comm="newrole" name="shadow" dev="sda1" ino=152257
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:shadow_t:s0 tclass=file pe
> Apr 05 14:59:25 debianserver audit[2424]: SYSCALL arch=c000003e
> syscall=2 success=no exit=-13 a0=7f9037b667f1 a1=80000 a2=1b6
> a3=80000
> items=1 ppid=2415 pid=2424 auid=1000 uid=1000 gid=1000 euid=1000
> suid=1000 fsuid=1000 egid=1000 sgid=1
> Apr 05 14:59:25 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:25 debianserver audit: PATH item=0 name="/etc/shadow"
> inode=152257 dev=08:01 mode=0100640 ouid=0 ogid=42 rdev=00:00
> obj=system_u:object_r:shadow_t:s0 nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PROCTITLE
> proctitle=6E6577726F6C65002D720073797361646D5F72
> Apr 05 14:59:25 debianserver audit[2427]: AVC avc:  denied  {
> rlimitinh } for  pid=2427 comm="unix_chkpwd"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:chkpwd_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2427]: AVC avc:  denied  { siginh
> }
> for  pid=2427 comm="unix_chkpwd"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:staff_r:chkpwd_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2427]: SYSCALL arch=c000003e
> syscall=59 success=yes exit=0 a0=7f903731ac0d a1=7ffffabf1f10
> a2=7f903751e388 a3=7f9037f81260 items=2 ppid=2424 pid=2427 auid=1000
> uid=1000 gid=1000 euid=1000 suid=1000 fsui
> Apr 05 14:59:25 debianserver audit: EXECVE argc=3
> a0="/sbin/unix_chkpwd" a1="debianuser" a2="chkexpiry"
> Apr 05 14:59:25 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:25 debianserver audit: PATH item=0
> name="/sbin/unix_chkpwd" inode=627 dev=08:01 mode=0102755 ouid=0
> ogid=42 rdev=00:00 obj=system_u:object_r:chkpwd_exec_t:s0
> nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PATH item=1
> name="/lib64/ld-linux-x86-64.so.2" inode=132140 dev=08:01
> mode=0100755
> ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PROCTITLE
> proctitle=2F7362696E2F756E69785F63686B7077640064656269616E75736572006
> 3686B657870697279
> Apr 05 14:59:25 debianserver audit[2424]: USER_ACCT pid=2424 uid=1000
> auid=1000 ses=5 subj=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> msg='op=PAM:accounting acct="debianuser" exe="/usr/bin/newrole"
> hostname=? addr=? terminal=pts/1 res=succ
> Apr 05 14:59:25 debianserver newrole[2428]:
> pam_unix(newrole:session):
> session opened for user debianuser by debianuser(uid=1000)
> Apr 05 14:59:25 debianserver audit[2428]: USER_START pid=2428
> uid=1000
> auid=1000 ses=5 subj=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> msg='op=PAM:session_open acct="debianuser" exe="/usr/bin/newrole"
> hostname=? addr=? terminal=pts/1 res=s
> Apr 05 14:59:25 debianserver audit[2428]: USER_ROLE_CHANGE pid=2428
> uid=1000 auid=1000 ses=5 subj=staff_u:staff_r:newrole_t:s0-
> s0:c0.c1023
> msg='newrole: old-context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> new-context=staff_u:sysadm_r:sysa
> Apr 05 14:59:25 debianserver dbus[357]: [system] Rejected send
> message, 2 matched rules; type="method_call", sender=":1.7" (uid=1000
> pid=2428 comm="newrole -r sysadm_r ")
> interface="org.freedesktop.login1.Manager" member="CreateSession"
> Apr 05 14:59:25 debianserver newrole[2428]:
> pam_systemd(newrole:session): Failed to create session: Access denied
> Apr 05 14:59:25 debianserver audit[2428]: AVC avc:  denied  {
> rlimitinh } for  pid=2428 comm="bash"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2428]: AVC avc:  denied  { siginh
> }
> for  pid=2428 comm="bash"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2428]: AVC avc:  denied  {
> noatsecure } for  pid=2428 comm="bash"
> scontext=staff_u:staff_r:newrole_t:s0-s0:c0.c1023
> tcontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 tclass=process
> permissive=0
> Apr 05 14:59:25 debianserver audit[2428]: SYSCALL arch=c000003e
> syscall=59 success=yes exit=0 a0=55aa5e4bca00 a1=7ffffabf2588
> a2=55aa5e4ba300 a3=7f903847db01 items=2 ppid=2424 pid=2428 auid=1000
> uid=1000 gid=1000 euid=1000 suid=1000 fsui
> Apr 05 14:59:25 debianserver audit: EXECVE argc=1 a0="-/bin/bash"
> Apr 05 14:59:25 debianserver audit: CWD cwd="/home/debianuser"
> Apr 05 14:59:25 debianserver audit: PATH item=0 name="/bin/bash"
> inode=4205 dev=08:01 mode=0100755 ouid=0 ogid=0 rdev=00:00
> obj=system_u:object_r:shell_exec_t:s0 nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PATH item=1
> name="/lib64/ld-linux-x86-64.so.2" inode=132140 dev=08:01
> mode=0100755
> ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:ld_so_t:s0
> nametype=NORMAL
> Apr 05 14:59:25 debianserver audit: PROCTITLE proctitle="-/bin/bash"
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
