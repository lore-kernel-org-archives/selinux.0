Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7DCSZf6031841
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 08:28:35 -0400
Received: from mail-yx0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7DCS57J013020
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 12:28:05 GMT
Received: by yxe7 with SMTP id 7so861448yxe.32
        for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 05:28:34 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 13 Aug 2009 08:28:34 -0400
Message-ID: <2cb3b7090908130528q1c9d1c48l50f3ecc6f409fa00@mail.gmail.com>
Subject: Cron job fails to transition
From: Dan <carbonneau@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636c9356afd9c1904710512fa
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c9356afd9c1904710512fa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm working on a SELinux policy for AIDE on REHL 5.3 running in Strict
mode.  I am able to transition to aide_t fine when executed manually.  I am
having trouble transitioning to aide_t when executing from a cron job.
The cron job is trying to do the following transition:
FROM: root:sysadm_r:sysadm_crond_t:s0-s0:c0.c1023 TO:
root:system_r:aide_t:s0-s0:c0.c1023

Here's a snipplet of the important rules I have in place for the transition
in my aide.te:

# When an administrator executes a process with the type of
# $1_exec_t, the process transitions from sysadm_r to system_r.
role sysadm_r;
allow sysadm_r system_r;
role_transition sysadm_r aide_exec_t system_r;
role system_r types aide_t;
allow sysadm_crond_t aide_t:process transition;
# Allow crontab to transition to aide_t
domain_auto_trans(system_crond_t, aide_exec_t, aide_t)
When the cronjob runs, it does not transition to aide_t in enforcing mode.
Audit2Allow keeps suggesting "allow sysadm_crond_t aide_t:process
transition;" even though I already have the rule in the policy.  It looks
like its having trouble transitioning from sysadm_r to system_r (I have the
rules for that in the policy also).

Heres a few output that might be usefull:

# crontab -l
5 8 * * * /opt/security/aide_scan/bin/aide_scan.sh
/opt/security/aide_scan/cfg/aide_scan.conf > /dev/null 2>&1

# ls -lZ /opt/security/aide_scan/bin/
-rwxr-x---  root root root:object_r:aide_exec_t        aide_scan.sh
# ls -lZ /var/spool/cron/root
-rw-------  root root system_u:object_r:sysadm_cron_spool_t
/var/spool/cron/root

# ls -lZ
/etc/crontab

-rw-r--r--  root root system_u:object_r:system_cron_spool_t /etc/crontab

# cat /var/log/audit/audit.log

type=AVC msg=audit(1250165101.793:1843): avc:  denied  { transition } for
pid=16995 comm="sh" path="/opt/security/aide_scan/bin/aide_scan.sh" dev=dm-0
ino=589841 scontext=root:sysadm_r:sysadm_crond_t:s0-s0:c0.c1023
tcontext=root:system_r:aide_t:s0-s0:c0.c1023 tclass=process
type=SYSCALL msg=audit(1250165101.793:1843): arch=c000003e syscall=59
success=yes exit=0 a0=c07d0b0 a1=c07cff0 a2=c07c0d0 a3=3 items=0 ppid=16993
pid=16995 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
tty=(none) ses=239 comm="aide_scan.sh" exe="/bin/bash"
subj=root:system_r:aide_t:s0-s0:c0.c1023 key=(null)
type=CRED_DISP msg=audit(1250165101.800:1844): user pid=16990 uid=0 auid=0
subj=system_u:system_r:crond_t:s0-s0:c0.c1023 msg='PAM: setcred acct="root"
: exe="/usr/sbin/crond" (hostname=?, addr=?, terminal=cron res=success)'
type=USER_END msg=audit(1250165101.800:1845): user pid=16990 uid=0 auid=0
subj=system_u:system_r:crond_t:s0-s0:c0.c1023 msg='PAM: session close
acct="root" : exe="/usr/sbin/crond" (hostname=?, addr=?, terminal=cron
res=success)'

# ps -eafZ | grep aide

system_u:system_r:crond_t:SystemLow-SystemHigh root 17128 11042  0 08:16 ?
00:00:00 crond

root:sysadm_r:sysadm_crond_t:SystemLow-SystemHigh root 17129 17128  0 08:16
? 00:00:00 /bin/sh -c /opt/security/aide_scan/bin/aide_scan.sh
/opt/security/aide_scan/cfg/aide_scan.conf > /dev/null 2>&1

root:system_r:aide_t:SystemLow-SystemHigh root 17130 17129  0 08:16 ?
00:00:00 /bin/sh /opt/security/aide_scan/bin/aide_scan.sh
/opt/security/aide_scan/cfg/aide_scan.conf

root:system_r:aide_t:SystemLow-SystemHigh root 17155 17130 99 08:16 ?
00:01:07 /usr/sbin/aide --config=/opt/security/aide_scan/cfg/aide.conf
--check

(As you can see, the process did transition to aide_t correctly in
permissive mode.  However in enforcing mode, aide does not start at all from
the cron job.)
Anybody out there can shed some light on this problem?

Thanks,

Dan

--001636c9356afd9c1904710512fa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>I&#39;m working on a SELinux policy for AIDE on REHL 5.3 running in St=
rict mode.=A0 I am able to transition to aide_t fine when executed manually=
.=A0 I am having trouble transitioning to aide_t when executing from a cron=
 job.=A0 </div>

<div>The cron job is trying to do the following transition:</div>
<div>FROM: root:sysadm_r:sysadm_crond_t:s0-s0:c0.c1023 TO: root:system_r:ai=
de_t:s0-s0:c0.c1023</div>
<div>=A0</div>
<div>Here&#39;s a snipplet of the important rules I have in place for the t=
ransition in my aide.te:</div>
<div>=A0</div>
<div># When an administrator executes a process with the type of <br># $1_e=
xec_t, the process transitions from sysadm_r to system_r. <br>role sysadm_r=
;<br>allow sysadm_r system_r;<br>role_transition sysadm_r aide_exec_t syste=
m_r;=A0 <br>
role system_r types aide_t;<br>allow sysadm_crond_t aide_t:process transiti=
on;</div>
<div># Allow crontab to transition to aide_t<br>domain_auto_trans(system_cr=
ond_t, aide_exec_t, aide_t)<br></div>
<div>When the cronjob runs, it does not transition to aide_t in enforcing m=
ode.=A0 Audit2Allow keeps suggesting &quot;allow sysadm_crond_t aide_t:proc=
ess transition;&quot; even though I already have the rule in the policy.=A0=
 It looks like its having trouble transitioning from sysadm_r to system_r (=
I have the rules for that in the policy also).</div>

<div>=A0</div>
<div>Heres a few output that might be usefull:</div>
<div>=A0</div># crontab -l<br>5 8 * * * /opt/security/aide_scan/bin/aide_sc=
an.sh /opt/security/aide_scan/cfg/aide_scan.conf &gt; /dev/null 2&gt;&amp;1=
<br>
<div>=A0</div>
<div># ls -lZ /opt/security/aide_scan/bin/<br>-rwxr-x---=A0 root root root:=
object_r:aide_exec_t=A0=A0=A0=A0=A0=A0=A0 aide_scan.sh<br></div>
<div># ls -lZ /var/spool/cron/root <br>-rw-------=A0 root root system_u:obj=
ect_r:sysadm_cron_spool_t /var/spool/cron/root</div>
<div>=A0</div>
<div># ls -lZ /etc/crontab=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>-rw-r--r--=A0 root =
root system_u:object_r:system_cron_spool_t /etc/crontab</div>
<div>=A0</div>
<div># cat /var/log/audit/audit.log</div>
<div>=A0</div>
<div>type=3DAVC msg=3Daudit(1250165101.793:1843): avc:=A0 denied=A0 { trans=
ition } for=A0 pid=3D16995 comm=3D&quot;sh&quot; path=3D&quot;/opt/security=
/aide_scan/bin/aide_scan.sh&quot; dev=3Ddm-0 ino=3D589841 scontext=3Droot:s=
ysadm_r:sysadm_crond_t:s0-s0:c0.c1023 tcontext=3Droot:system_r:aide_t:s0-s0=
:c0.c1023 tclass=3Dprocess<br>
type=3DSYSCALL msg=3Daudit(1250165101.793:1843): arch=3Dc000003e syscall=3D=
59 success=3Dyes exit=3D0 a0=3Dc07d0b0 a1=3Dc07cff0 a2=3Dc07c0d0 a3=3D3 ite=
ms=3D0 ppid=3D16993 pid=3D16995 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 =
fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D239 comm=3D&quot;a=
ide_scan.sh&quot; exe=3D&quot;/bin/bash&quot; subj=3Droot:system_r:aide_t:s=
0-s0:c0.c1023 key=3D(null)<br>
type=3DCRED_DISP msg=3Daudit(1250165101.800:1844): user pid=3D16990 uid=3D0=
 auid=3D0 subj=3Dsystem_u:system_r:crond_t:s0-s0:c0.c1023 msg=3D&#39;PAM: s=
etcred acct=3D&quot;root&quot; : exe=3D&quot;/usr/sbin/crond&quot; (hostnam=
e=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)&#39;<br>
type=3DUSER_END msg=3Daudit(1250165101.800:1845): user pid=3D16990 uid=3D0 =
auid=3D0 subj=3Dsystem_u:system_r:crond_t:s0-s0:c0.c1023 msg=3D&#39;PAM: se=
ssion close acct=3D&quot;root&quot; : exe=3D&quot;/usr/sbin/crond&quot; (ho=
stname=3D?, addr=3D?, terminal=3Dcron res=3Dsuccess)&#39;</div>

<div>=A0</div>
<div># ps -eafZ | grep aide</div>
<div>=A0</div>
<div>system_u:system_r:crond_t:SystemLow-SystemHigh root 17128 11042=A0 0 0=
8:16 ? 00:00:00 crond</div>
<div><br>root:sysadm_r:sysadm_crond_t:SystemLow-SystemHigh root 17129 17128=
=A0 0 08:16 ? 00:00:00 /bin/sh -c /opt/security/aide_scan/bin/aide_scan.sh =
/opt/security/aide_scan/cfg/aide_scan.conf &gt; /dev/null 2&gt;&amp;1</div>

<div><br>root:system_r:aide_t:SystemLow-SystemHigh root 17130 17129=A0 0 08=
:16 ?=A0 </div>
<div>00:00:00 /bin/sh /opt/security/aide_scan/bin/aide_scan.sh /opt/securit=
y/aide_scan/cfg/aide_scan.conf</div>
<div><br>root:system_r:aide_t:SystemLow-SystemHigh root 17155 17130 99 08:1=
6 ?=A0 00:01:07 /usr/sbin/aide --config=3D/opt/security/aide_scan/cfg/aide.=
conf --check</div>
<div>=A0</div>
<div>(As you can see, the process did transition to aide_t correctly in per=
missive mode.=A0 However in enforcing mode, aide does not start at all from=
 the cron job.)<br></div>
<div>Anybody out there can shed some light on this problem?</div>
<div>=A0</div>
<div>Thanks,</div>
<div>=A0</div>
<div>Dan</div>

--001636c9356afd9c1904710512fa--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
