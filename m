Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4S0GDG5005250
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 20:16:14 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4S0G7tn010104
	for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 00:16:08 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.195])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n4S0FmWX028611
	for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 09:15:48 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id n4S0FmS08881 for selinux@tycho.nsa.gov; Thu, 28 May 2009 09:15:48 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id n4S0Fl5q021891
	for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 09:15:47 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id A1984E48280
	for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 09:15:47 +0900 (JST)
Message-ID: <4A1DD7B3.2040603@ak.jp.nec.com>
Date: Thu, 28 May 2009 09:15:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: [ANN] Apache/SELinux plus release
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is an announcement of Apache/SELinux plus.

Now, it shall be getting available at Fedora 11, packaged as mod_selinux.
  https://admin.fedoraproject.org/pkgdb/packages/name/mod_selinux

The source tarballs are also available at:
  http://code.google.com/p/sepgsql/downloads/list

It is an extra module for apache/httpd-2.2.x series, and enables to
launch web application instance with individual security context based
on the http authentication (or other factors).
It means SELinux getting available to control accesses depending on
notion of web-users, not only os-users, in other words.
It is a part of our efforts named LAPP/SELinux which tries to improve
whole of the web-system's security using SELinux.

See the wiki article for more details:
  http://code.google.com/p/sepgsql/wiki/Apache_SELinux_plus

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
