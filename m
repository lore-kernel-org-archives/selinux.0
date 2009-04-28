Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3S5t7MR031670
	for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2009 01:55:07 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3S5t526021985
	for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2009 05:55:06 GMT
Message-ID: <49F69A33.2070601@ak.jp.nec.com>
Date: Tue, 28 Apr 2009 14:54:59 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Refpolicy <refpolicy@oss.tresys.com>
Subject: [RFC] mod_selinux security policy
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Folks,

Nowadays, I'm also under development for a loadable module on apache/httpd,
named as mod_selinux.so. It enables to launch web-applications with an
individual security context based on http-authenticated users.
It internally uses a one-time worker thread for each connections to perform
as a restrictive domain bounded to httpd_t due to the hard-wired rule for
multi-threading process.

In the LCA2009 demonstration, all we can show was individual MCS category
per http-users because of lack of TE policy.
The following ugly policy is an example of TE policy for mod_selinux.so.

 http://code.google.com/p/sepgsql/source/browse/misc/mod_selinux/mod_selinux.te
 http://code.google.com/p/sepgsql/source/browse/misc/mod_selinux/mod_selinux.if

We needed to remain a minimum set of privileges on the bounded domains because
they also perform as a part of the daemon process, although they are restricted
to access to the web contents or database objects.
(Thus, it allows webapp_type to write on log files, for example.)

In my hope, if we can have a interface to assign the minimum set of privileges
on the bounded domain, it will be helpfull for authors of web applications
which provide its own security policy. It will enables them to focus on writing
their policy for web contents.

Could you tell me your opinions?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
