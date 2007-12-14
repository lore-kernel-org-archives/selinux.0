Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEJbr1n011129
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:37:53 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBEJbr9j029049
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 19:37:53 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id lBEJaF1k010199
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:36:15 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id lBEJaFiQ010198
	for selinux@tycho.nsa.gov; Fri, 14 Dec 2007 14:36:15 -0500
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEJVQBc010064
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:31:26 -0500
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBEJVP9j026307
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 19:31:25 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lBEJTID4003999
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:29:18 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lBEJUOin026054
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:30:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: help with an avc denial
Date: Fri, 14 Dec 2007 11:31:22 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02773CB8@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running RHEL 5.1 with the mls policy.

I'm getting an avc denial that I can't get past. Here are the entries
from the audit log:

type=AVC msg=audit(1197658847.835:9499): avc:  denied  { create } for
pid=20432 comm="touch" name="tmp.log"
scontext=sysadm_u:sysadm_r:sysadm_t:s0-s4:c0.c255
tcontext=sysadm_u:object_r:audit_log_t:s0-s4:c0.c255 tclass=file
type=SYSCALL msg=audit(1197658847.835:9499): arch=c000003e syscall=2
success=no exit=-13 a0=7fff74eceb5c a1=941 a2=1b6 a3=328dd4b0ac items=0
ppid=12410 pid=20432 auid=11000 uid=11000 gid=4500 euid=11000 suid=11000
fsuid=11000 egid=4500 sgid=4500 fsgid=4500 tty=pts3 comm="touch"
exe="/bin/touch" subj=sysadm_u:sysadm_r:sysadm_t:s0-s4:c0.c255
key=(null)


Here is what audit2allow returns:
#============= sysadm_t ==============
# src="sysadm_t" tgt="audit_log_t" class="file", perms="create"
# comm="touch" exe="" path=""
allow sysadm_t audit_log_t:file create;

I have entered that exact allow rule into my policy to no effect.

Audit2why indicates that the reason for the above audit log avc denial
is a missing allow rule, as opposed to a constraint problem.

Any help would be greatly appreciated.
Thanks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
