Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9HLBUbc011439
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 17:11:30 -0400
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9HLA7sW007237
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 21:10:07 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9HLBU9N015075
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 17:11:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9HLBT1n296104
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 15:11:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9HLBS2Y030112
	for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2006 15:11:29 -0600
Message-ID: <453546FC.2050109@us.ibm.com>
Date: Tue, 17 Oct 2006 16:11:24 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: lspp-list <redhat-lspp@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: policy issues in 2.3.18-10 - sshd & polyinstantiation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So polyinstantiation is broken, it used to work at one point. The 
following is the log of what seems to be causing the failure. I'm 
looking into this, but it would be nice to have someone more adept at 
policy wrangling to jump in and save the day.

Thanks,
Mike


type=USER_AUTH msg=audit(1161119055.423:230): user pid=2095 uid=0 
auid=4294967295 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 msg='PAM: 
authentication acct=ealuser : exe="/usr/sbin/sshd" 
(hostname=pendarric.austin.ibm.com, addr=9.41.46.108, terminal=ssh 
res=success)'
type=USER_ACCT msg=audit(1161119055.443:231): user pid=2095 uid=0 
auid=4294967295 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 msg='PAM: 
accounting acct=ealuser : exe="/usr/sbin/sshd" 
(hostname=pendarric.austin.ibm.com, addr=9.41.46.108, terminal=ssh 
res=success)'
type=LOGIN msg=audit(1161119055.455:232): login pid=2098 uid=0 old 
auid=4294967295 new auid=500

type=AVC msg=audit(1161119055.475:233): avc:  denied  { relabelfrom } 
for  pid=2098 comm="sshd" name="ealuser" dev=hda3 ino=356226 
scontext=system_u:system_r:sshd_t:s0-s15:c0.c1023 
tcontext=system_u:object_r:sshd_tmp_t:s0 tclass=dir
type=SYSCALL msg=audit(1161119055.475:233): arch=14 syscall=211 
success=no exit=-13 a0=6 a1=7f2607c a2=8084e18 a3=28 items=0 ppid=2093 
pid=2098 auid=500 uid=0 gid=500 euid=0 suid=0 fsuid=0 egid=500 sgid=500 
fsgid=500 tty=(none) comm="sshd" exe="/usr/sbin/sshd" 
subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 key=(null)

type=USER_START msg=audit(1161119055.483:234): user pid=2098 uid=0
auid=500 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 msg='PAM: session 
open acct=ealuser : exe="/usr/sbin/sshd" 
(hostname=pendarric.austin.ibm.com, addr=9.41.46.108, terminal=ssh 
res=failed)'
type=CRED_REFR msg=audit(1161119055.487:235): user pid=2098 uid=0 
auid=500 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 msg='PAM: setcred 
acct=ealuser : exe="/usr/sbin/sshd" (hostname=pendarric.austin.ibm.com, 
addr=9.41.46.108, terminal=ssh res=success)'
type=USER_LOGIN msg=audit(1161119055.527:236): user pid=2093 uid=0 
auid=4294967295 subj=system_u:system_r:sshd_t:s0-s15:c0.c1023 
msg='uid=500: exe="/usr/sbin/sshd" (hostname=pendarric.austin.ibm.com, 
addr=9.41.46.108, terminal=/dev/pts/5 res=success)'


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
