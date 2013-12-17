MIME-Version: 1.0
Date: Tue, 17 Dec 2013 08:23:38 -0800
Message-ID: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
Subject: /bin/bash: Bad interpreter: Permission denied.
From: Jay Corrales <jscorrales1122@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7bfcf1e2cdc41604edbd5908
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7bfcf1e2cdc41604edbd5908
Content-Type: text/plain; charset=ISO-8859-1

Folks,

We're running RedHat Enterprise Linux 5 (rhel5) with selinux strict and
enforcing mode, and finding that something in our configuration prevents a
simple shell script from domain transitioning from user_t to awips_t
context. If we run a test virtual machine with a new install of rhel5, it
does run OK, but something in our current configuration prevents this
result. Wondering if it makes sense to run a tool like apol to find any
clues as to why? The audit log (/var/log/audit/audit.log) shows an AVC
requiring execute_no_trans for user_t (no listed here). I can send as a
follow up along with strace outputs if desired.

Thanks

[jay@localhost ~]$ /awips/fxa/bin/test.sh
/bin/bash: Bad interpreter: Permission denied.

[root@localhost ~]# ps faxZ



LABEL                             PID TTY      STAT   TIME COMMAND

system_u:system_r:sshd_t:SystemLow-SystemHigh 3953 ? Ss   0:00  \_ sshd:
jay [priv]

system_u:system_r:sshd_t:SystemLow-SystemHigh 3958 ? S   0:00  |   \_ sshd:
jay@pts/1

user_u:user_r:user_t             3959 pts/1    Ss     0:00  |       \_ -bash

...


[jay@localhost ~]$ cat /awips/fxa/bin/test.sh
#!/bin/bash
while /bin/true; do
 id -Z sleep 10
done
[root@localhost ~]# sesearch -a -s user_t -t awips_exec_t -c file -p
execute



Found 1 av rules:

   allow user_t awips_exec_t : file { ioctl read getattr lock execute };





Found 9 role allow rules:

   allow staff_r sysadm_r ;

   allow sysadm_r staff_r ;

   allow sysadm_r user_r ;

   allow system_r user_r ;

   allow system_r staff_r ;

   allow system_r sysadm_r ;

   allow system_r gadmin_r ;

   allow system_r guest_r ;

   allow sysadm_r system_r ;



[root@localhost ~]# sesearch -a -s awips_t -t awips_exec_t -c file -p
entrypoint Found 1 av rules:
   allow awips_t awips_exec_t : file { ioctl read getattr lock execute
entrypoint };
...

[root@localhost ~]# sesearch -a -s user_t -t awips_t -c process -p
transition Found 1 av rules:
   allow user_t awips_t : process { transition sigkill signal };
...



File: awips.te

      1 policy_module(awips,1.0.0)

      2

      3 require {

      4   type user_t;

      5   type initrc_devpts_t;

      6   type devpts_t;

      7   type user_devpts_t;

      8 }

      9

     10 type awips_t;

     11 type awips_exec_t;

     12

     13 domain_type(awips_t)

     14 domain_entry_file(awips_t,awips_exec_t)

     15

     16 role user_r types awips_t;

     17

     18 domain_auto_trans(user_t,awips_exec_t,awips_t)

     19

     20 allow awips_t user_t:fd use;

     21 allow awips_t user_t:fifo_file rw_file_perms;

     22 allow awips_t user_t:process sigchld;

     23

     24 # AWIPS scripts run shell scripts

     25 corecmd_exec_bin(awips_t)

     26 corecmd_exec_shell(awips_t)

     27

     28 # must have execute rights on shell script

     29 allow user_t awips_exec_t:file rx_file_perms;

     30

     31 # output to terminal

     32 allow awips_t initrc_devpts_t:chr_file { read write };

     33 allow awips_t devpts_t:dir { getattr search };

     34 allow awips_t user_devpts_t:chr_file { read write getattr };

     35

     36 # load shared libs

     37 libs_use_ld_so(awips_t);

     38 libs_use_shared_libs(awips_t);

     39

     40 # respond to ctrl-c

     41 allow user_t awips_t:process { signal sigkill };

     42 allow awips_t self:process signal;





File: awips.fc

      1 # default to read-only access

      2 /awips(/.*)?    gen_context(system_u:object_r:bin_t,s0)

      3

      4 # script files and app that calls a script

      5 /awips/fxa/bin -d gen_context(system_u:object_r:bin_t,s0)

      6 /awips/fxa/bin/test.sh --
gen_context(system_u:object_r:awips_exec_t,s0)

--047d7bfcf1e2cdc41604edbd5908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">Folks,</font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" f=
ace=3D"Calibri"></font>=A0</div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" f=
ace=3D"Calibri">We&#39;re running RedHat Enterprise Linux 5 (rhel5) with se=
linux strict and enforcing mode, and finding that something in our configur=
ation prevents a simple shell script from domain transitioning from user_t =
to awips_t context. If we run a test virtual machine with a new install of =
rhel5, it does run OK, but something in our current configuration prevents =
this result. Wondering if it makes sense to run a tool like apol to find an=
y clues as to why? The audit log (/var/log/audit/audit.log) shows an AVC re=
quiring execute_no_trans for user_t (no listed here). I can send as a follo=
w up along with strace outputs if desired.</font></div>

<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" f=
ace=3D"Calibri"></font>=A0</div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" f=
ace=3D"Calibri">Thanks</font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri"></font></font>=A0</div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">[jay@localhost ~]$ /awips/fxa/bin/test.sh </font></fo=
nt></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">/bin/bash: Bad interpreter: Permission denied.</font>=
</font></div>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">[root@localhost ~]# ps faxZ </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">LABEL<span style>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>PID TTY<span style>=
=A0=A0=A0=A0=A0 </span>STAT<span style>=A0=A0 </span>TIME COMMAND</font></f=
ont></p>

<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">system_u:system_r:sshd_t:SystemLow-SystemHigh 3953 ? Ss=
<span style>=A0=A0 </span>0:00<span style>=A0 </span>\_ sshd: jay [priv] </=
font></font></p>

<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">system_u:system_r:sshd_t:SystemLow-SystemHigh 3958 ? S<=
span style>=A0=A0 </span>0:00<span style>=A0 </span>|<span style>=A0=A0 </s=
pan>\_ sshd: jay@pts/1<span style>=A0 </span></font></font></p>

<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">user_u:user_r:user_t<span style>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 </span>3959 pts/1<span style>=A0=A0=A0 </span>Ss<span style=
>=A0=A0=A0=A0 </span>0:00<span style>=A0 </span>|<span style>=A0=A0=A0=A0=
=A0=A0 </span>\_ -bash</font></font></p>

<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">...=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">[jay@localhost ~]$ cat /awips/fxa/bin/test.sh </font>=
</font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">#!/bin/bash </font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">while /bin/true; do </font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">=A0id -Z sleep 10 </font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">done </font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">[root@localhost ~]# sesearch -a -s user_t -t awips_ex=
ec_t -c file -p execute </font></font></div>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">Found 1 av rules:</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow user_t awips_exec_t : f=
ile { ioctl read getattr lock execute }; </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">Found 9 role allow rules:</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow staff_r sysadm_r ;</fon=
t></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow sysadm_r staff_r ;</fon=
t></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow sysadm_r user_r ;</font=
></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow system_r user_r ;</font=
></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow system_r staff_r ;</fon=
t></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow system_r sysadm_r ;</fo=
nt></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow system_r gadmin_r ;</fo=
nt></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow system_r guest_r ;</fon=
t></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0 </span>allow sysadm_r system_r ;</fo=
nt></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">[root@localhost ~]# sesearch -a -s awips_t -t awips_exe=
c_t -c file -p entrypoint Found 1 av rules:</font></font></p>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri"><span style>=A0=A0 </span>allow awips_t awips_exec_t =
: file { ioctl read getattr lock execute entrypoint }; </font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">...</font></font></div>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">[root@localhost ~]# sesearch -a -s user_t -t awips_t -c=
 process -p transition Found 1 av rules:</font></font></p>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri"><span style>=A0=A0 </span>allow user_t awips_t : proc=
ess { transition sigkill signal }; </font></font></div>
<div style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><=
font face=3D"Calibri">...</font></font></div>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">File: awips.te</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>1 policy_module(awip=
s,1.0.0)</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>2 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>3 require {</font></=
font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>4<span style>=A0=A0 =
</span>type user_t;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>5<span style>=A0=A0 =
</span>type initrc_devpts_t;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>6<span style>=A0=A0 =
</span>type devpts_t;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>7<span style>=A0=A0 =
</span>type user_devpts_t;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>8 }</font></font></p=
>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>9 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>10 type awips_t;</font>=
</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>11 type awips_exec_t;</=
font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>12 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>13 domain_type(awips_t)=
</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>14 domain_entry_file(aw=
ips_t,awips_exec_t)</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>15 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>16 role user_r types aw=
ips_t;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>17 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>18 domain_auto_trans(us=
er_t,awips_exec_t,awips_t)</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>19 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>20 allow awips_t user_t=
:fd use;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>21 allow awips_t user_t=
:fifo_file rw_file_perms;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>22 allow awips_t user_t=
:process sigchld;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>23 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>24 # AWIPS scripts run =
shell scripts</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>25 corecmd_exec_bin(awi=
ps_t)</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>26 corecmd_exec_shell(a=
wips_t)</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>27 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>28 # must have execute =
rights on shell script</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>29 allow user_t awips_e=
xec_t:file rx_file_perms;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>30 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>31 # output to terminal=
</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>32 allow awips_t initrc=
_devpts_t:chr_file { read write };</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>33 allow awips_t devpts=
_t:dir { getattr search };</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>34 allow awips_t user_d=
evpts_t:chr_file { read write getattr };</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>35 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>36 # load shared libs</=
font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>37 libs_use_ld_so(awips=
_t);</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>38 libs_use_shared_libs=
(awips_t);</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>39 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>40 # respond to ctrl-c<=
/font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>41 allow user_t awips_t=
:process { signal sigkill };</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0 </span>42 allow awips_t self:p=
rocess signal;</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3" fac=
e=3D"Calibri">=A0</font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri">File: awips.fc</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>1 # default to read-=
only access</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>2 /awips(/.*)?<span =
style>=A0=A0=A0 </span>gen_context(system_u:object_r:bin_t,s0)</font></font=
></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>3 </font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>4 # script files and=
 app that calls a script</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>5 /awips/fxa/bin -d =
gen_context(system_u:object_r:bin_t,s0)</font></font></p>
<p style=3D"MARGIN:0in 0in 0pt" class=3D"MsoPlainText"><font size=3D"3"><fo=
nt face=3D"Calibri"><span style>=A0=A0=A0=A0=A0 </span>6 /awips/fxa/bin/tes=
t.sh -- gen_context(system_u:object_r:awips_exec_t,s0)</font></font></p>

--047d7bfcf1e2cdc41604edbd5908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
