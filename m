Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m76IokC2027859
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2008 14:50:46 -0400
Received: from mail.rowdy.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m76Ioj3k013155
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2008 18:50:45 GMT
Received: from spacetime.nextelcup.rowdy.com ([208.81.230.219])
        by mail.helixsystems.com (HXS1 mail server) with ASMTP (SSL) id MAE20245
        for <selinux@tycho.nsa.gov>; Wed, 06 Aug 2008 14:50:45 -0400
Date: Wed, 6 Aug 2008 14:49:49 -0400 (EDT)
From: Lucas Emery <lucas@rowdy.com>
To: selinux@tycho.nsa.gov
Message-ID: <20657148.261218048588328.JavaMail.SYSTEM@Spacetime>
In-Reply-To: <32753706.241218048327109.JavaMail.SYSTEM@Spacetime>
Subject: selinux freaking out about cifs share
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Someone on #selinux suggested I post this issue I'm having to the list, so here goes.

I've got pages and pages of the following error in /var/log/messages:

SELinux is preventing httpd (httpd_t) "0x100000" to 'somefile' (httpd_sys_content_t).

The files in question are on a remote cifs share.  SELinux context on all files is httpd_sys_content_t.

Output of sealert follows:

Summary:

SELinux is preventing httpd (httpd_t) "0x100000" to 'somefile'
(httpd_sys_content_t).

Additional Information:

Source Context                root:system_r:httpd_t
Target Context                system_u:object_r:httpd_sys_content_t
Target Objects                'blah' [ file ]
Source                        httpd
Source Path                   /usr/sbin/httpd
Port                          <Unknown>
Host                          localhost
Source RPM Packages           httpd-2.2.3-11.el5_1.centos.3
Target RPM Packages
Policy RPM                    selinux-policy-2.4.6-137.1.el5
Selinux Enabled               True
Policy Type                   targeted
MLS Enabled                   True
Enforcing Mode                Enforcing
Plugin Name                   catchall_file
Host Name                     localhost
Platform                      Linux localhost 2.6.18-92.1.6.el5 #1 SMP Wed
Jun 25
                             13:49:24 EDT 2008 i686 i686
Alert Count                   43
First Seen                    Mon Aug  4 11:10:09 2008
Last Seen                     Wed Aug  6 11:25:14 2008
Local ID                      4f544c6a-2eb9-4025-8bcf-f4c4383f26d2
Line Numbers

Raw Audit Messages

host=localhost type=AVC msg=audit(1218036314.997:95776): avc:  denied  {
0x100000 } for  pid=10564 comm="httpd" name="241" dev=cifs ino=7278187
scontext=root:system_r:httpd_t:s0
tcontext=system_u:object_r:httpd_sys_content_t:s0 tclass=file

host=localhost type=SYSCALL msg=audit(1218036314.997:95776): arch=40000003
syscall=195 success=no exit=-13 a0=9bc1a10 a1=bfa580bc a2=333ff4 a3=8170
items=0 ppid=10496 pid=10564 auid=0 uid=48 gid=48 euid=48 suid=48 fsuid=48
egid=48 sgid=48 fsgid=48 tty=(none) ses=511 comm="httpd"
exe="/usr/sbin/httpd" subj=root:system_r:httpd_t:s0 key=(null)

I'm running CIFS module version 1.50cRH

Red Hat thinks this is a kernel bug and I have filed a bug report with them.

I can temporarily fix the problem with a reboot, but that's  treating the symptom and not the cause, and this is a production box so random reboots are not really a workable solution.

Thanks,

Lucas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
