Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8G5bpc2010764
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 01:37:51 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8G5b099026549
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 05:37:02 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.193])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m8G5bc2R006450
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 14:37:38 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id m8G5bcw26506 for selinux@tycho.nsa.gov; Tue, 16 Sep 2008 14:37:38 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id m8G5bbxm024631
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 14:37:37 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id A4AFEE48276
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 14:37:37 +0900 (JST)
Message-ID: <48CF4621.20808@ak.jp.nec.com>
Date: Tue, 16 Sep 2008 14:37:37 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [RFC] Apache/SELinux : Enables to prevent web application flaws.
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is a RFC for httpd-selinux package.

It enables to invoke its contents handler with an individual security
context based on HTTP authentication.
Apache has a feature to handle various kind of file format like *.html,
*.php, *.cgi and so on. These are well moduled and we call it as contents
handler.

The idea is simple. The httpd-selinux assignes a proper security context
using setcon() API just before contents handler invocation. The context
is identified based on HTTP authentication.
When the httpd-selinux accepts a HTTP request from a client, it creates
a one-time thread and wait for its exit. The child thread invokes setcon()
as I noted above, and execute contents handler to generate HTTP response.

In the result, it enables to kick web application under restricted domain
and prevent web application flaws.

Steps to build/install
----------------------
 $ vi ~/.rpmmacros	# set a proper '%_topdir' macro
 $ wget http://<somewhere Fedora mirrors>/path/to/httpd-2.2.9-4.src.rpm
 $ svn checkout http://sepgsql.googlecode.com/svn/misc/httpd-selinux
 $ ./httpd-selinux/build-httpd-selinux.sh ./httpd-2.2.9-4.src.rpm
 $ su -
 # rpm -ivh /path/to/rpms/i386/httpd-selinux-2.2.9-4.i386.rpm
 Preparing...                ########################################### [100%]
    1:httpd-selinux          ########################################### [100%]
 # vi /etc/sysconfig/httpd      # add a line: "HTTPD=/usr/sbin/httpd.selinux"
 # /etc/init.d/httpd restart

 (NOTE) The kernel has to support type boundary feature.
 (NOTE) If you feel the source code is complex, get a diff between prefork.c
        and selinux.c. :)

Configuration
-------------
The "/etc/httpd/conf.d/httpd-selinux.conf" is a template of configuration.
It defined three directives which can be enclosed by <Directory> tag.
 - selinuxAuthConfigFile
   It specifies a path to configuration file which describes pairs of
   authenticated user and its domain/range.
 - selinuxAuthDefaultDomain
   It specifies the default domain.
 - selinuxAuthDefaultRange
   It specifies the default range.

Future plans
------------
* Proposing it to the upstream Apache developers and Fedora community
* Proposing PHP/SELinux binding to PHP developers
* Similar enhancement on application server, like Tomcat
* Full SELinux coverage on LAPP software stack:
  http://kaigai.sakura.ne.jp/sblo_files/kaigai/image/080719_lapp.png

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
