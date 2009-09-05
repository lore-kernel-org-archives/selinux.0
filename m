Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n855UlGA004843
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 01:30:47 -0400
Received: from mail-yw0-f204.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n855W4W2006748
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 05:32:04 GMT
Received: by ywh42 with SMTP id 42so2245520ywh.30
        for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2009 22:30:46 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 4 Sep 2009 22:30:46 -0700
Message-ID: <dd18b0c30909042230r3da58c1ay996b7f0fbac361d0@mail.gmail.com>
Subject: can't login in enforcing mode for some reason.
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

any ideas on why I'm hitting this:

 type=1106 audit(1252128138.800:242): user pid=5022 uid=0 auid=1000
ses=12 subj=system_u:system_r:sysadm_t msg='op=PAM:session_close
acct="name" exe="/bin/login" hostname=? addr=? terminal=/dev/tty1
res=success'
[ 4110.457610] type=1100 audit(1252128145.452:243): user pid=5468
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:sysadm_t
msg='op=PAM:authentication acct="name" exe="/bin/login" hostname=?
addr=? terminal=/dev/tty1 res=success'
[ 4110.460426] type=1101 audit(1252128145.452:244): user pid=5468
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:sysadm_t
msg='op=PAM:accounting acct="name" exe="/bin/login" hostname=? addr=?
terminal=/dev/tty1 res=success'
[ 4110.461260] type=1006 audit(1252128145.452:245): login pid=5468
uid=0 old auid=4294967295 new auid=1000 old ses=4294967295 new ses=13
[ 4110.473666] type=2300 audit(1252128145.472:246): user pid=5468
uid=0 auid=1000 ses=13 subj=system_u:system_r:sysadm_t msg='pam:
default-context=name:sysadm_r:sysadm_t
selected-context=name:sysadm_r:sysadm_t: exe="/bin/login" hostname=?
addr=? terminal=tty1 res=success'
[ 4110.473824] type=1105 audit(1252128145.472:247): user pid=5468
uid=0 auid=1000 ses=13 subj=system_u:system_r:sysadm_t
msg='op=PAM:session_open acct="name" exe="/bin/login" hostname=?
addr=? terminal=/dev/tty1 res=success'
[ 4110.474729] type=1103 audit(1252128145.472:248): user pid=5468
uid=0 auid=1000 ses=13 subj=system_u:system_r:sysadm_t
msg='op=PAM:setcred acct="name" exe="/bin/login" hostname=? addr=?
terminal=/dev/tty1 res=success'
[ 4110.474792] type=1112 audit(1252128145.472:249): user pid=5468
uid=0 auid=1000 ses=13 subj=system_u:system_r:sysadm_t msg='op=login
acct="name" exe="/bin/login" hostname=? addr=? terminal=/dev/tty1
res=success'
[ 4110.475448] type=1400 audit(1252128145.472:250): avc:  denied  {
transition } for  pid=5475 comm="login" path="/bin/bash" dev=sda3
ino=204858 scontext=system_u:system_r:sysadm_t
tcontext=name:sysadm_r:sysadm_t tclass=process
[ 4110.476010] type=1400 audit(1252128145.472:250): avc:  denied  {
rlimitinh } for  pid=5475 comm="bash"
scontext=system_u:system_r:sysadm_t tcontext=name:sysadm_r:sysadm_t
tclass=process
[ 4110.476026] type=1400 audit(1252128145.472:250): avc:  denied  {
siginh } for  pid=5475 comm="bash" scontext=system_u:system_r:sysadm_t
tcontext=name:sysadm_r:sysadm_t tclass=process
[ 4110.476048] type=1400 audit(1252128145.472:250): avc:  denied  {
noatsecure } for  pid=5475 comm="bash"
scontext=system_u:system_r:sysadm_t tcontext=name:sysadm_r:sysadm_t
tclass=process
[ 4110.476096] type=1300 audit(1252128145.472:250): arch=c000003e
syscall=59 success=yes exit=0 a0=616760 a1=7fffce1af800 a2=60a060 a3=0
items=0 ppid=5468 pid=5475 auid=1000 uid=1000 gid=1000 euid=1000
suid=1000 fsuid=1000 egid=1000 sgid=1000 fsgid=1000 tty=tty1 ses=13
comm="bash" exe="/bin/bash" subj=name:sysadm_r:sysadm_t key=(null)


audit2allow shows this:
allow sysadm_t self:process { siginh rlimitinh transition noatsecure };

seems I had these three avc's fixed by removing securetty
but for some reason these appeared again.

any ideas would be helpful.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
