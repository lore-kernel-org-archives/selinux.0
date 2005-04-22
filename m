Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MMCQgA019750
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 18:12:26 -0400 (EDT)
Received: from palrel11.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MM7I3X007518
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 22:07:19 GMT
Received: from mailrelay01.cac.cpqcorp.net (mailrelay01.cac.cpqcorp.net [16.47.132.152])
	by palrel11.hp.com (Postfix) with ESMTP id E6B6A46C5
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 15:07:18 -0700 (PDT)
Received: from anw.zk3.dec.com (wasted.zk3.dec.com [16.140.32.3])
	by mailrelay01.cac.cpqcorp.net (Postfix) with ESMTP id A2D6E705
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 15:07:17 -0700 (PDT)
Message-ID: <42697589.2040506@hp.com>
Date: Fri, 22 Apr 2005 18:07:05 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: A small patch for auditd.te
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
