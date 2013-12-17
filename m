MIME-Version: 1.0
In-Reply-To: <52B07D69.70209@tycho.nsa.gov>
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
	<52B07D69.70209@tycho.nsa.gov>
Date: Tue, 17 Dec 2013 10:03:02 -0800
Message-ID: <CACVacMvNNP3HLAEW_RhzuHxqUvq77nmApstS5V_xKoEG1zbZkA@mail.gmail.com>
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
From: Jay Corrales <jscorrales1122@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c347e049bc5e04edbebdf5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001a11c347e049bc5e04edbebdf5
Content-Type: text/plain; charset=ISO-8859-1

bash-3.2$ /awips/fxa/bin/test.sh

bash: /awips/fxa/bin/test.sh: /bin/bash: bad interpreter: Permission denied

bash-3.2$

bash-3.2$ /tmp/strace /awips/fxa/bin/test.sh

execve("/awips/fxa/bin/test.sh", ["/awips/fxa/bin/test.sh"], [/* 38 vars
*/]) = -1 EACCES (Permission denied)

dup(2) = 3

fcntl64(3, F_GETFL) = 0x2 (flags O_RDWR)

fstat64(3, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 4), ...}) = 0

mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0xb7f64000

_llseek(3, 0, 0xbfe66ce4, SEEK_CUR) = -1 ESPIPE (Illegal seek)

write(3, "strace: exec: Permission denied\n", 32strace: exec: Permission
denied

) = 32

close(3) = 0

munmap(0xb7f64000, 4096) = 0

exit_group(1) = ?

bash-3.2$



type=AVC msg=audit(1387301151.195:82549): avc: denied { execute_no_trans }
for pid=24492 comm="bash" path="/awips/fxa/bin/test.sh" dev=sda2 ino=800003
scontext=user_u:user_r:user_t:s0
tcontext=system_u:object_r:lx_apps_script_exec_t:s0 tclass=file

type=SYSCALL msg=audit(1387301151.195:82549): arch=40000003 syscall=11
success=no exit=-13 a0=8d0d228 a1=8d0d2d0 a2=8cfd1f0 a3=0 items=1
ppid=24476 pid=24492 auid=10037 uid=10037 gid=210 euid=10037 suid=10037
fsuid=10037 egid=210 sgid=210 fsgid=210 tty=pts4 ses=778 comm="bash"
exe="/bin/bash" subj=user_u:user_r:user_t:s0
key="KEY_failed_execute_program"

type=CWD msg=audit(1387301151.195:82549): cwd="/home/awips_jay"

type=PATH msg=audit(1387301151.195:82549): item=0
name="/awips/fxa/bin/test.sh" inode=800003 dev=08:02 mode=0100755 ouid=206
ogid=210 rdev=00:00 obj=system_u:object_r:lx_apps_script_exec_t:s0

type=SYSCALL msg=audit(1387301151.199:82550): arch=40000003 syscall=5
success=no exit=-2 a0=8d01928 a1=0 a2=1 a3=0 items=1 ppid=24476 pid=24492
auid=10037 uid=10037 gid=210 euid=10037 suid=10037 fsuid=10037 egid=210
sgid=210 fsgid=210 tty=pts4 ses=778 comm="bash" exe="/bin/bash"
subj=user_u:user_r:user_t:s0 key=(null)

type=CWD msg=audit(1387301151.199:82550): cwd="/home/awips_jay"

type=PATH msg=audit(1387301151.199:82550): item=0
name="/usr/share/locale/en_US/LC_MESSAGES/bash.mo"

type=SYSCALL msg=audit(1387301151.199:82551): arch=40000003 syscall=5
success=no exit=-2 a0=8d0d310 a1=0 a2=1 a3=8d0d2f0 items=1 ppid=24476
pid=24492 auid=10037 uid=10037 gid=210 euid=10037 suid=10037 fsuid=10037
egid=210 sgid=210 fsgid=210 tty=pts4 ses=778 comm="bash" exe="/bin/bash"
subj=user_u:user_r:user_t:s0 key=(null)

type=CWD msg=audit(1387301151.199:82551): cwd="/home/awips_jay"

type=PATH msg=audit(1387301151.199:82551): item=0
name="/usr/share/locale/en/LC_MESSAGES/bash.mo"

type=SYSCALL msg=audit(1387301151.199:82552): arch=40000003 syscall=5
success=no exit=-2 a0=8d0d360 a1=0 a2=1 a3=0 items=1 ppid=24476 pid=24492
auid=10037 uid=10037 gid=210 euid=10037 suid=10037 fsuid=10037 egid=210
sgid=210 fsgid=210 tty=pts4 ses=778 comm="bash" exe="/bin/bash"
subj=user_u:user_r:user_t:s0 key=(null)

type=CWD msg=audit(1387301151.199:82552): cwd="/home/awips_jay"

type=PATH msg=audit(1387301151.199:82552): item=0
name="/usr/share/locale/en_US/LC_MESSAGES/libc.mo"

type=SYSCALL msg=audit(1387301151.199:82553): arch=40000003 syscall=5
success=no exit=-2 a0=8d0d3b0 a1=0 a2=1 a3=8d0d390 items=1 ppid=24476
pid=24492 auid=10037 uid=10037 gid=210 euid=10037 suid=10037 fsuid=10037
egid=210 sgid=210 fsgid=210 tty=pts4 ses=778 comm="bash" exe="/bin/bash"
subj=user_u:user_r:user_t:s0 key=(null)

type=CWD msg=audit(1387301151.199:82553): cwd="/home/awips_jay"

type=PATH msg=audit(1387301151.199:82553): item=0
name="/usr/share/locale/en/LC_MESSAGES/libc.mo"


On Tue, Dec 17, 2013 at 8:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 12/17/2013 11:23 AM, Jay Corrales wrote:
> > Folks,
> >
> > We're running RedHat Enterprise Linux 5 (rhel5) with selinux strict and
> > enforcing mode, and finding that something in our configuration prevents
> a
> > simple shell script from domain transitioning from user_t to awips_t
> > context. If we run a test virtual machine with a new install of rhel5, it
> > does run OK, but something in our current configuration prevents this
> > result. Wondering if it makes sense to run a tool like apol to find any
> > clues as to why? The audit log (/var/log/audit/audit.log) shows an AVC
> > requiring execute_no_trans for user_t (no listed here). I can send as a
> > follow up along with strace outputs if desired.
>
> Yes, send the avc message.
>
> >
> > Thanks
> >
> > [jay@localhost ~]$ /awips/fxa/bin/test.sh
> > /bin/bash: Bad interpreter: Permission denied.
> >
> > [root@localhost ~]# ps faxZ
> >
> >
> >
> > LABEL                             PID TTY      STAT   TIME COMMAND
> >
> > system_u:system_r:sshd_t:SystemLow-SystemHigh 3953 ? Ss   0:00  \_ sshd:
> > jay [priv]
> >
> > system_u:system_r:sshd_t:SystemLow-SystemHigh 3958 ? S   0:00  |   \_
> sshd:
> > jay@pts/1
> >
> > user_u:user_r:user_t             3959 pts/1    Ss     0:00  |       \_
> -bash
> >
> > ...
> >
> >
> > [jay@localhost ~]$ cat /awips/fxa/bin/test.sh
> > #!/bin/bash
> > while /bin/true; do
> >  id -Z sleep 10
> > done
> > [root@localhost ~]# sesearch -a -s user_t -t awips_exec_t -c file -p
> > execute
> >
> >
> >
> > Found 1 av rules:
> >
> >    allow user_t awips_exec_t : file { ioctl read getattr lock execute };
> >
> >
> >
> >
> >
> > Found 9 role allow rules:
> >
> >    allow staff_r sysadm_r ;
> >
> >    allow sysadm_r staff_r ;
> >
> >    allow sysadm_r user_r ;
> >
> >    allow system_r user_r ;
> >
> >    allow system_r staff_r ;
> >
> >    allow system_r sysadm_r ;
> >
> >    allow system_r gadmin_r ;
> >
> >    allow system_r guest_r ;
> >
> >    allow sysadm_r system_r ;
> >
> >
> >
> > [root@localhost ~]# sesearch -a -s awips_t -t awips_exec_t -c file -p
> > entrypoint Found 1 av rules:
> >    allow awips_t awips_exec_t : file { ioctl read getattr lock execute
> > entrypoint };
> > ...
> >
> > [root@localhost ~]# sesearch -a -s user_t -t awips_t -c process -p
> > transition Found 1 av rules:
> >    allow user_t awips_t : process { transition sigkill signal };
> > ...
> >
> >
> >
> > File: awips.te
> >
> >       1 policy_module(awips,1.0.0)
> >
> >       2
> >
> >       3 require {
> >
> >       4   type user_t;
> >
> >       5   type initrc_devpts_t;
> >
> >       6   type devpts_t;
> >
> >       7   type user_devpts_t;
> >
> >       8 }
> >
> >       9
> >
> >      10 type awips_t;
> >
> >      11 type awips_exec_t;
> >
> >      12
> >
> >      13 domain_type(awips_t)
> >
> >      14 domain_entry_file(awips_t,awips_exec_t)
> >
> >      15
> >
> >      16 role user_r types awips_t;
> >
> >      17
> >
> >      18 domain_auto_trans(user_t,awips_exec_t,awips_t)
> >
> >      19
> >
> >      20 allow awips_t user_t:fd use;
> >
> >      21 allow awips_t user_t:fifo_file rw_file_perms;
> >
> >      22 allow awips_t user_t:process sigchld;
> >
> >      23
> >
> >      24 # AWIPS scripts run shell scripts
> >
> >      25 corecmd_exec_bin(awips_t)
> >
> >      26 corecmd_exec_shell(awips_t)
> >
> >      27
> >
> >      28 # must have execute rights on shell script
> >
> >      29 allow user_t awips_exec_t:file rx_file_perms;
> >
> >      30
> >
> >      31 # output to terminal
> >
> >      32 allow awips_t initrc_devpts_t:chr_file { read write };
> >
> >      33 allow awips_t devpts_t:dir { getattr search };
> >
> >      34 allow awips_t user_devpts_t:chr_file { read write getattr };
> >
> >      35
> >
> >      36 # load shared libs
> >
> >      37 libs_use_ld_so(awips_t);
> >
> >      38 libs_use_shared_libs(awips_t);
> >
> >      39
> >
> >      40 # respond to ctrl-c
> >
> >      41 allow user_t awips_t:process { signal sigkill };
> >
> >      42 allow awips_t self:process signal;
> >
> >
> >
> >
> >
> > File: awips.fc
> >
> >       1 # default to read-only access
> >
> >       2 /awips(/.*)?    gen_context(system_u:object_r:bin_t,s0)
> >
> >       3
> >
> >       4 # script files and app that calls a script
> >
> >       5 /awips/fxa/bin -d gen_context(system_u:object_r:bin_t,s0)
> >
> >       6 /awips/fxa/bin/test.sh --
> > gen_context(system_u:object_r:awips_exec_t,s0)
> >
>
>

--001a11c347e049bc5e04edbebdf5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<span lang=3D"EN">
<div><span lang=3D"EN">
<p>bash-3.2$ /awips/fxa/bin/test.sh </p>
<p>bash: /awips/fxa/bin/test.sh: /bin/bash: bad interpreter: Permission den=
ied</p>
<p>bash-3.2$</p>
<p>bash-3.2$ /tmp/strace /awips/fxa/bin/test.sh </p>
<p>execve(&quot;/awips/fxa/bin/test.sh&quot;, [&quot;/awips/fxa/bin/test.sh=
&quot;], [/* 38 vars */]) =3D -1 EACCES (Permission denied)</p>
<p>dup(2) =3D 3</p>
<p>fcntl64(3, F_GETFL) =3D 0x2 (flags O_RDWR)</p>
<p>fstat64(3, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 4), ...}) =3D=
 0</p>
<p>mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0xb7f64000</p>
<p>_llseek(3, 0, 0xbfe66ce4, SEEK_CUR) =3D -1 ESPIPE (Illegal seek)</p>
<p>write(3, &quot;strace: exec: Permission denied\n&quot;, 32strace: exec: =
Permission denied</p>
<p>) =3D 32</p>
<p>close(3) =3D 0</p>
<p>munmap(0xb7f64000, 4096) =3D 0</p>
<p>exit_group(1) =3D ?</p>
<p>bash-3.2$ </p>
<p></p>
<p>=E3=80=80</p>
<p>=E3=80=80</p></span></div>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div>type=3DAVC msg=3Daudit(1387301151.195:82549): avc: denied { execute_no=
_trans } for pid=3D24492 comm=3D&quot;bash&quot; path=3D&quot;/awips/fxa/bi=
n/test.sh&quot; dev=3Dsda2 ino=3D800003 scontext=3Duser_u:user_r:user_t:s0 =
tcontext=3Dsystem_u:object_r:lx_apps_script_exec_t:s0 tclass=3Dfile</div>

<p>type=3DSYSCALL msg=3Daudit(1387301151.195:82549): arch=3D40000003 syscal=
l=3D11 success=3Dno exit=3D-13 a0=3D8d0d228 a1=3D8d0d2d0 a2=3D8cfd1f0 a3=3D=
0 items=3D1 ppid=3D24476 pid=3D24492 auid=3D10037 uid=3D10037 gid=3D210 eui=
d=3D10037 suid=3D10037 fsuid=3D10037 egid=3D210 sgid=3D210 fsgid=3D210 tty=
=3Dpts4 ses=3D778 comm=3D&quot;bash&quot; exe=3D&quot;/bin/bash&quot; subj=
=3Duser_u:user_r:user_t:s0 key=3D&quot;KEY_failed_execute_program&quot;</p>

<p>type=3DCWD msg=3Daudit(1387301151.195:82549): cwd=3D&quot;/home/awips_ja=
y&quot;</p>
<p>type=3DPATH msg=3Daudit(1387301151.195:82549): item=3D0 name=3D&quot;/aw=
ips/fxa/bin/test.sh&quot; inode=3D800003 dev=3D08:02 mode=3D0100755 ouid=3D=
206 ogid=3D210 rdev=3D00:00 obj=3Dsystem_u:object_r:lx_apps_script_exec_t:s=
0</p>
<p>type=3DSYSCALL msg=3Daudit(1387301151.199:82550): arch=3D40000003 syscal=
l=3D5 success=3Dno exit=3D-2 a0=3D8d01928 a1=3D0 a2=3D1 a3=3D0 items=3D1 pp=
id=3D24476 pid=3D24492 auid=3D10037 uid=3D10037 gid=3D210 euid=3D10037 suid=
=3D10037 fsuid=3D10037 egid=3D210 sgid=3D210 fsgid=3D210 tty=3Dpts4 ses=3D7=
78 comm=3D&quot;bash&quot; exe=3D&quot;/bin/bash&quot; subj=3Duser_u:user_r=
:user_t:s0 key=3D(null)</p>

<p>type=3DCWD msg=3Daudit(1387301151.199:82550): cwd=3D&quot;/home/awips_ja=
y&quot;</p>
<p>type=3DPATH msg=3Daudit(1387301151.199:82550): item=3D0 name=3D&quot;/us=
r/share/locale/en_US/LC_MESSAGES/bash.mo&quot;</p>
<p>type=3DSYSCALL msg=3Daudit(1387301151.199:82551): arch=3D40000003 syscal=
l=3D5 success=3Dno exit=3D-2 a0=3D8d0d310 a1=3D0 a2=3D1 a3=3D8d0d2f0 items=
=3D1 ppid=3D24476 pid=3D24492 auid=3D10037 uid=3D10037 gid=3D210 euid=3D100=
37 suid=3D10037 fsuid=3D10037 egid=3D210 sgid=3D210 fsgid=3D210 tty=3Dpts4 =
ses=3D778 comm=3D&quot;bash&quot; exe=3D&quot;/bin/bash&quot; subj=3Duser_u=
:user_r:user_t:s0 key=3D(null)</p>

<p>type=3DCWD msg=3Daudit(1387301151.199:82551): cwd=3D&quot;/home/awips_ja=
y&quot;</p>
<p>type=3DPATH msg=3Daudit(1387301151.199:82551): item=3D0 name=3D&quot;/us=
r/share/locale/en/LC_MESSAGES/bash.mo&quot;</p>
<p>type=3DSYSCALL msg=3Daudit(1387301151.199:82552): arch=3D40000003 syscal=
l=3D5 success=3Dno exit=3D-2 a0=3D8d0d360 a1=3D0 a2=3D1 a3=3D0 items=3D1 pp=
id=3D24476 pid=3D24492 auid=3D10037 uid=3D10037 gid=3D210 euid=3D10037 suid=
=3D10037 fsuid=3D10037 egid=3D210 sgid=3D210 fsgid=3D210 tty=3Dpts4 ses=3D7=
78 comm=3D&quot;bash&quot; exe=3D&quot;/bin/bash&quot; subj=3Duser_u:user_r=
:user_t:s0 key=3D(null)</p>

<p>type=3DCWD msg=3Daudit(1387301151.199:82552): cwd=3D&quot;/home/awips_ja=
y&quot;</p>
<p>type=3DPATH msg=3Daudit(1387301151.199:82552): item=3D0 name=3D&quot;/us=
r/share/locale/en_US/LC_MESSAGES/libc.mo&quot;</p>
<p>type=3DSYSCALL msg=3Daudit(1387301151.199:82553): arch=3D40000003 syscal=
l=3D5 success=3Dno exit=3D-2 a0=3D8d0d3b0 a1=3D0 a2=3D1 a3=3D8d0d390 items=
=3D1 ppid=3D24476 pid=3D24492 auid=3D10037 uid=3D10037 gid=3D210 euid=3D100=
37 suid=3D10037 fsuid=3D10037 egid=3D210 sgid=3D210 fsgid=3D210 tty=3Dpts4 =
ses=3D778 comm=3D&quot;bash&quot; exe=3D&quot;/bin/bash&quot; subj=3Duser_u=
:user_r:user_t:s0 key=3D(null)</p>

<p>type=3DCWD msg=3Daudit(1387301151.199:82553): cwd=3D&quot;/home/awips_ja=
y&quot;</p>
<p>type=3DPATH msg=3Daudit(1387301151.199:82553): item=3D0 name=3D&quot;/us=
r/share/locale/en/LC_MESSAGES/libc.mo&quot;</p></span><br><br>
<div class=3D"gmail_quote">On Tue, Dec 17, 2013 at 8:35 AM, Stephen Smalley=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blan=
k">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div class=3D"im">On 12/17/2013 11:23 AM, Jay Corrales wrote:<br>&gt; Folks=
,<br>&gt;<br>&gt; We&#39;re running RedHat Enterprise Linux 5 (rhel5) with =
selinux strict and<br>&gt; enforcing mode, and finding that something in ou=
r configuration prevents a<br>
&gt; simple shell script from domain transitioning from user_t to awips_t<b=
r>&gt; context. If we run a test virtual machine with a new install of rhel=
5, it<br>&gt; does run OK, but something in our current configuration preve=
nts this<br>
&gt; result. Wondering if it makes sense to run a tool like apol to find an=
y<br>&gt; clues as to why? The audit log (/var/log/audit/audit.log) shows a=
n AVC<br>&gt; requiring execute_no_trans for user_t (no listed here). I can=
 send as a<br>
&gt; follow up along with strace outputs if desired.<br><br></div>Yes, send=
 the avc message.<br>
<div class=3D"HOEnZb">
<div class=3D"h5"><br>&gt;<br>&gt; Thanks<br>&gt;<br>&gt; [jay@localhost ~]=
$ /awips/fxa/bin/test.sh<br>&gt; /bin/bash: Bad interpreter: Permission den=
ied.<br>&gt;<br>&gt; [root@localhost ~]# ps faxZ<br>&gt;<br>&gt;<br>&gt;<br=
>
&gt; LABEL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PID TTY =C2=A0 =C2=A0 =C2=A0STAT =C2=A0 =
TIME COMMAND<br>&gt;<br>&gt; system_u:system_r:sshd_t:SystemLow-SystemHigh =
3953 ? Ss =C2=A0 0:00 =C2=A0\_ sshd:<br>&gt; jay [priv]<br>&gt;<br>&gt; sys=
tem_u:system_r:sshd_t:SystemLow-SystemHigh 3958 ? S =C2=A0 0:00 =C2=A0| =C2=
=A0 \_ sshd:<br>
&gt; jay@pts/1<br>&gt;<br>&gt; user_u:user_r:user_t =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 3959 pts/1 =C2=A0 =C2=A0Ss =C2=A0 =C2=A0 0:00 =C2=A0| =
=C2=A0 =C2=A0 =C2=A0 \_ -bash<br>&gt;<br>&gt; ...<br>&gt;<br>&gt;<br>&gt; [=
jay@localhost ~]$ cat /awips/fxa/bin/test.sh<br>&gt; #!/bin/bash<br>
&gt; while /bin/true; do<br>&gt; =C2=A0id -Z sleep 10<br>&gt; done<br>&gt; =
[root@localhost ~]# sesearch -a -s user_t -t awips_exec_t -c file -p<br>&gt=
; execute<br>&gt;<br>&gt;<br>&gt;<br>&gt; Found 1 av rules:<br>&gt;<br>&gt;=
 =C2=A0 =C2=A0allow user_t awips_exec_t : file { ioctl read getattr lock ex=
ecute };<br>
&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; Found 9 role allow rules:<br>&=
gt;<br>&gt; =C2=A0 =C2=A0allow staff_r sysadm_r ;<br>&gt;<br>&gt; =C2=A0 =
=C2=A0allow sysadm_r staff_r ;<br>&gt;<br>&gt; =C2=A0 =C2=A0allow sysadm_r =
user_r ;<br>&gt;<br>&gt; =C2=A0 =C2=A0allow system_r user_r ;<br>
&gt;<br>&gt; =C2=A0 =C2=A0allow system_r staff_r ;<br>&gt;<br>&gt; =C2=A0 =
=C2=A0allow system_r sysadm_r ;<br>&gt;<br>&gt; =C2=A0 =C2=A0allow system_r=
 gadmin_r ;<br>&gt;<br>&gt; =C2=A0 =C2=A0allow system_r guest_r ;<br>&gt;<b=
r>&gt; =C2=A0 =C2=A0allow sysadm_r system_r ;<br>
&gt;<br>&gt;<br>&gt;<br>&gt; [root@localhost ~]# sesearch -a -s awips_t -t =
awips_exec_t -c file -p<br>&gt; entrypoint Found 1 av rules:<br>&gt; =C2=A0=
 =C2=A0allow awips_t awips_exec_t : file { ioctl read getattr lock execute<=
br>&gt; entrypoint };<br>
&gt; ...<br>&gt;<br>&gt; [root@localhost ~]# sesearch -a -s user_t -t awips=
_t -c process -p<br>&gt; transition Found 1 av rules:<br>&gt; =C2=A0 =C2=A0=
allow user_t awips_t : process { transition sigkill signal };<br>&gt; ...<b=
r>&gt;<br>
&gt;<br>&gt;<br>&gt; File: awips.te<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 1 =
policy_module(awips,1.0.0)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 2<br>&gt;<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 3 require {<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 4 =C2=A0 type user_t;<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 5 =C2=A0 typ=
e initrc_devpts_t;<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 6 =C2=A0 type devpts_t;<br>&gt;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 7 =C2=A0 type user_devpts_t;<br>&gt;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 8 }<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 9<br>&gt;<br>&gt; =
=C2=A0 =C2=A0 =C2=A010 type awips_t;<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A011=
 type awips_exec_t;<br>&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A012<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A013 domain_t=
ype(awips_t)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A014 domain_entry_file(awips=
_t,awips_exec_t)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A015<br>&gt;<br>&gt; =C2=
=A0 =C2=A0 =C2=A016 role user_r types awips_t;<br>&gt;<br>&gt; =C2=A0 =C2=
=A0 =C2=A017<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A018 domain_auto_trans(user_t,awips_exec_t,a=
wips_t)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A019<br>&gt;<br>&gt; =C2=A0 =C2=
=A0 =C2=A020 allow awips_t user_t:fd use;<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=
=A021 allow awips_t user_t:fifo_file rw_file_perms;<br>&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A022 allow awips_t user_t:process sigchld;<br>&gt;<b=
r>&gt; =C2=A0 =C2=A0 =C2=A023<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A024 # AWIP=
S scripts run shell scripts<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A025 corecmd_=
exec_bin(awips_t)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A026 corecmd_exec_shell=
(awips_t)<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A027<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A028 =
# must have execute rights on shell script<br>&gt;<br>&gt; =C2=A0 =C2=A0 =
=C2=A029 allow user_t awips_exec_t:file rx_file_perms;<br>&gt;<br>&gt; =C2=
=A0 =C2=A0 =C2=A030<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A031 # output to term=
inal<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A032 allow awips_t initrc_devpts_t:chr_file =
{ read write };<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A033 allow awips_t devpts=
_t:dir { getattr search };<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A034 allow awi=
ps_t user_devpts_t:chr_file { read write getattr };<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A035<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A036 =
# load shared libs<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A037 libs_use_ld_so(aw=
ips_t);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A038 libs_use_shared_libs(awips_t=
);<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A039<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=
=A040 # respond to ctrl-c<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A041 allow user_t awips_t:process { signal s=
igkill };<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A042 allow awips_t self:process=
 signal;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; File: awips.fc<br>=
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 1 # default to read-only access<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 2 /awips(/.*)? =C2=A0 =C2=A0gen_context(s=
ystem_u:object_r:bin_t,s0)<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 3<br>&gt;<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0 4 # script files and app that calls a script<br=
>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 5 /awips/fxa/bin -d gen_context(system_u=
:object_r:bin_t,s0)<br>
&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0 6 /awips/fxa/bin/test.sh --<br>&gt; gen_c=
ontext(system_u:object_r:awips_exec_t,s0)<br>&gt;<br><br></div></div></bloc=
kquote></div><br>

--001a11c347e049bc5e04edbebdf5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
