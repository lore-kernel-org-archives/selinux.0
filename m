Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA18862
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 12:03:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA02558
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 17:03:44 GMT
Received: from hotmail.com (f153.law10.hotmail.com [64.4.15.153])
	by jazzswing.ncsc.mil  with ESMTP id RAA02554
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2001 17:03:44 GMT
From: "Femitha Majeed" <m_femitha@hotmail.com>
To: sds@tislabs.com, selinux@tycho.nsa.gov
Subject: RedHat 7.2
Date: Tue, 30 Oct 2001 17:03:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F153sB53WU1VOmmuoqf00017b23@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Is SELinux easily configurable on RedHat 7.2?

>From: Stephen Smalley <sds@tislabs.com>
>To: <selinux@tycho.nsa.gov>
>Subject: [PATCH] Bug fix for load_policy
>Date: Tue, 30 Oct 2001 10:20:33 -0500 (EST)
>
>
>When the SELinux module is in permissive mode, a bug in the
>convert_contexts function used by the load_policy function can leave the
>SID table in an inconsistent state when users, roles, or types are
>removed from the policy on a running system.  The attached patch fixes
>this bug.  To apply, save the attached patch to ~/services.patch, cd
>selinux, and run 'patch -p1 < services.patch'.  Then, rebuild the
>LSM-patched kernel with the built-in SELinux security module.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
><< services.patch >>


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
