Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JLB5Xf007791
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 16:11:06 -0500 (EST)
Received: from e3.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JL9ugR000768
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 21:09:56 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0JLB5Fs022831
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 16:11:05 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0JLB4iA132428
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 16:11:04 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0JLB4C0012845
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 16:11:04 -0500
Received: from sergelap.hallyn.com ([9.49.204.186])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k0JLB43U012832
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 16:11:04 -0500
Date: Thu, 19 Jan 2006 15:11:03 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: next try at refpolicy-gentoo patches
Message-ID: <20060119211103.GA8117@sergelap.austin.ibm.com>
References: <20060119203317.GA27395@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060119203317.GA27395@sergelap.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oops, I forgot one piece which was thrown in with a site-private
patch.

Under gentoo, syslog-ng is under /usr/sbin.

Index: refpolicy/policy/modules/system/logging.fc
===================================================================
--- refpolicy.orig/policy/modules/system/logging.fc
+++ refpolicy/policy/modules/system/logging.fc
@@ -10,6 +10,9 @@
 /sbin/minilogd		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 /sbin/syslogd		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 /sbin/syslog-ng		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
+ifdef(`distro_gentoo', `
+/usr/sbin/syslog-ng		--	gen_context(system_u:object_r:syslogd_exec_t,s0)
+')
 
 /usr/sbin/klogd		--	gen_context(system_u:object_r:klogd_exec_t,s0)
 /usr/sbin/metalog	--	gen_context(system_u:object_r:syslogd_exec_t,s0)

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
