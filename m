Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j21ChgDo000792
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 07:43:43 -0500 (EST)
Received: from mail.perevotech.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j21CeD6U012298
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 12:40:14 GMT
Received: from [192.168.0.249] (8r04b0j.pet-intranet.com [192.168.0.249])
	by mail.perevotech.com (8.13.1/8.13.1) with ESMTP id j21CeEhP014617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 13:40:14 +0100
Subject: Problem with BackupPC and selinux - FC#
From: Daniela Gradim <daniela.gradim@fortevisiomedica.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=utf-8
Message-Id: <1109680813.29522.6.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Tue, 01 Mar 2005 13:40:13 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Problem with BackupPC and selinux - FC3


I make the changes to httpd works fine but now when I try to run
BackupPC I get those messages. I tried to run chcon but still didn't
work.

Mar  1 09:42:19 backup backuppc: BackupPC shutdown failed
Mar  1 09:42:19 backup kernel: audit(1109666539.876:0): avc:  denied  {
read write } for  pid=29112 exe=/usr/bin/perl name=1 dev=devpts ino=3
scontext=root:system_r:httpd_sys_script_t
tcontext=root:object_r:devpts_t tclass=chr_file
Mar  1 09:42:19 backup kernel: audit(1109666539.876:0): avc:  denied  {
read write } for  pid=29112 exe=/usr/bin/perl path=/dev/pts/1 dev=devpts
ino=3 scontext=root:system_r:httpd_sys_script_t
tcontext=root:object_r:devpts_t tclass=chr_fileMar  1 09:42:20 backup
kernel: audit(1109666540.145:0): avc:  denied  { listen } for  pid=29138
exe=/usr/bin/perl path=/home/httpd/html/BackupPC/data/log/BackupPC.sock
scontext=root:system_r:httpd_sys_script_t
tcontext=root:system_r:httpd_sys_script_t tclass=unix_stream_socket

Can somebody help me ???

Thanks
-- 
Daniela Gradim
B.Sc.

daniela.gradim@fortevisiomedica.com
Mobile phone: +46-(0)765-48 99 95

--------------------------------------------------------------------- 
Forte Visio Medica AB
Hammarby Fabriksväg 23
S-120 33 Stockholm
Sweden

Phone: +46-(0)8-440 03 00
Fax: +46-(0)765-310 100
---------------------------------------------------------------------
THIS COMMUNICATION IS ONLY INTENDED FOR THE USE OF THE INDIVIDUAL, OR
ENTITY, TO WHICH IT IS DIRECTED AND MAY CONTAIN INFORMATION THAT IS
PRIVILIGED, CONFIDENTIAL AND EXEMPT FROM DISCLOSURE UNDER APPLICABLE
LAW. IF RECEIVED IN ERROR: PLEASE NOTIFY US IMMEDIATELY THROUGH
info@fortevisiomedica.com.
---------------------------------------------------------------------


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
