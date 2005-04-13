Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EDsP7C017616
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 09:54:25 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3EDltIT014497
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 13:47:55 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j3EDpoPP007091
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 09:51:50 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j3EDpoW2007090
	for selinux@tycho.nsa.gov; Thu, 14 Apr 2005 09:51:50 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3DMWs7C013274
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 18:32:54 -0400 (EDT)
Received: from over.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3DMTHT6018372
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 22:29:18 GMT
Received: from e34.co.us.ibm.com (e34.esmtp.ibm.com [9.14.4.132])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j3DHaFo0005977
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 13:36:15 -0400
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j3DHYn5b544582
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 13:36:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j3DHXOAM248750
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 11:34:49 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j3DHXOBT016326
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 11:33:24 -0600
Received: from serge (serge.austin.ibm.com [9.53.94.132])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j3DHXOsw016313
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 11:33:24 -0600
Subject: dcache_lock deadlock due to auditing
From: Serge Hallyn <serue@us.ibm.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 13 Apr 2005 12:36:20 -0500
Message-Id: <1113413781.25428.31.camel@serge>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

a team running some tcp benchmarks on new hardware found a recursive
spinlock(dcache_lock) deadlock.  It seems to always be caused by:

 A process is doing a d_alloc() which does a spin_lock(dcache_lock).
 It is interrupted to receive a packet
 selinux_sock_rcv_skb gets called
 it calls avc_has_perm
 this calls avc_audit
 this calls audit_log_d_path
 this calls d_path which does spin_lock(dcache_lock)

Deferring the actual audit work to the audit subsystem in a manner
similar to what Stephen's recent audit_log_exit() patch did seems one
possible way to solve this problem.  Another might be to determine our
context before the audit_log_d_path( vma->vm_file->f_dentry ), and, if
we can determine that we were called from interrupt, simply print out
the f_dentry->d_name.name itself.

Are there other solutions?

Currently the team is testing Stephen's patch (from march 31) to see
whether it is sufficient.

thanks,
-serge



-- 
Serge Hallyn <serue@us.ibm.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
