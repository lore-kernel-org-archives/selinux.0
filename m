Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3PEwTgA001321
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 10:58:30 -0400 (EDT)
Received: from palrel10.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3PEqrYj023085
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 14:52:54 GMT
Received: from mailrelay01.cac.cpqcorp.net (mailrelay01.cac.cpqcorp.net [16.47.132.152])
	by palrel10.hp.com (Postfix) with ESMTP id E1E8E2197
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 07:52:55 -0700 (PDT)
Received: from anw.zk3.dec.com (and.zk3.dec.com [16.140.64.3])
	by mailrelay01.cac.cpqcorp.net (Postfix) with ESMTP id 75CE552F
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 07:52:54 -0700 (PDT)
Message-ID: <426D0440.501@hp.com>
Date: Mon, 25 Apr 2005 10:52:48 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: A small patch for auditd.te
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* My apologies if this is a duplicate, my first message seems to have
   been lost.

Below is my attempt at fixing the audit policy so that the auditd and
auditctl work correctly at boot time.  I tested this on the latest FC4
bits augmented with Dan's MLS policy RPM and the latest audit RPMs from
David Woodhouse's repository.

Index: auditd.te
===================================================================
RCS file:
/cvsroot/selinux/nsa/selinux-usr/policy/domains/program/unused/auditd.te,v
retrieving revision 1.6
diff -r1.6 auditd.te
4a5,6
> # Some fixes by Paul Moore <paul.moore@hp.com>
> #
15a18
> allow auditd_t self:process setsched;
34a38
> allow auditctl_t init_t:fd use;
38a43
> role system_r types auditctl_t;
42a48,51
> allow initrc_t auditctl_exec_t:file rx_file_perms;
> allow initrc_t auditd_etc_t:file r_file_perms;
> domain_auto_trans(initrc_t, auditctl_exec_t, auditctl_t)

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
