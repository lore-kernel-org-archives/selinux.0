Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5H9PmgA007484
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 05:25:49 -0400 (EDT)
Received: from ms1.nttdata.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5H9GWoA017005
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 09:16:33 GMT
Received: from ms1.nttdata.co.jp (localhost [127.0.0.1])
	by ms1.nttdata.co.jp (8.12.11/3.7W-NTTDATA-TOP-11/02/04) with ESMTP id j5H9H2kp000570
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 18:17:02 +0900 (JST)
Received: from mail1.nttdata.co.jp ([163.135.10.21])
	by ms1.nttdata.co.jp (8.12.11/3.7W-NTTDATA-TOP-11/18/04) with ESMTP id j5H9Gm2K000420
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 18:16:48 +0900 (JST)
Received: from mail1.nttdata.co.jp (localhost [127.0.0.1])
	by mail1.nttdata.co.jp (8.12.11/3.7W-NTTDATA-TOP-01/18/05) with ESMTP id j5H9GmHC006963
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 18:16:48 +0900 (JST)
Received: from msggw-r02.msg.nttdata.co.jp ([10.10.1.56])
	by mail1.nttdata.co.jp (8.12.11/3.7W-NTTDATA-TOP-11/02/04) with ESMTP id j5H9Gl2Q006960
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 18:16:47 +0900 (JST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: [RFC]Kernel Built-in IDS extension
Date: Fri, 17 Jun 2005 18:16:47 +0900
Message-ID: <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
From: <horietk@nttdata.co.jp>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm glad to announce the release of experimental kernel extensions to 
SELinux access control, which enables intrusion detection and system 
protection functionalities.

The extensions have following features.
1. Detecting the access violation and can log that trial.
2. Operating booleans of 'Conditional Policy' when the access violation 
is detected.
3. Kernel built-in implementation. All the detections and the operations 
are performed within kernel.
4. To specify access contexts to be detected and boolean variables to be 
turned on, extended policy notation was introduced, which resembles the 
'allow' statement.

   trap <subject> <object>:<class> <permissions> <booleans> ;

Also, the AVC 'detected' log is recorded. (see below)

"Jun 13 10:05:47 molder kernel: audit(1118624747.611:0): avc:  detected  
{ execute } for  pid=4126 exe=/usr/sbin/in.ftpd name=sh dev=dm-0 
ino=3572008 scontext=scontext=system_u:system_r:ftpd_t 
tcontext=system_u:object_r:shell_exec_t tclass=file"

I believe that these features are useful in some cases.
For examaple, it is possible to detect harzardous access context which 
appears only when malicious operation is tried and to apply more 
restricted policy by means of turning on booleans automatically.

example) buffer overflow detection and system protection.
  bool etc_locked false ;
  bool bool_locked false ;
  trap ftpd_t shell_exec_t:file { execute } { etc_locked bool_locked } ;
  if (etc_locked) {
     /* read only, no one can change /etc files  */
     allow sysadm_t etc_t:file { r_file_perms }; 
  } else {
     /* sysadm can edit /etc files */
     allow sysadm_t etc_t:file { rw_file_perms }; 
  }
  if (!bool_locked) {
     /* sysadm can operate booleans */
     allow sysadm_t security_t:security setbool;
  }

If an unauthorized shell execution tried by ftpd is detected, kernel 
itself performs policy modification.

Of course, not only 'unconditional trap' but also 'conditional trap' can 
be used too.
  bool bool_a false ;
  bool bool_b false ;
  bool bool_c false ;
  if (bool_a) {
     trap xxx_t yyy_t:file { perms } { bool_b } ;
  } else {
     trap xxx_t yyy_t:file { perms } { bool_a bool_c } ;
  }
So, rather complicated boolean operations can be determined.

The patches and the documents are available at SourceForge site.
  http://sourceforge.net/projects/lk-ids

There are three patches.
[1] kernel patch (to version 2.6.11)
 - Member correspoding to 'trap' vector is added to avtab and policydb 
structures. (Mainly avc.h and avtab.h modifications)
 - Requested permission is compared with 'trap' vector, separate from 
SELinux's permission check. (Mainly avc.c modifications)
 - Internal boolean operation by kernel itself. (Mainly conditional.c 
and selinuxfs.c)
[2] checkpolicy patch (to version 1.22)
[3] libsetools patch (to version 1.4)
 - Policy parser, compiler and related library are extended to meet 
'trap' notation.

I hope I could have a lot of comments, suggestions and feedbacks.

Best regards,

-----
NTT DATA CORPORATION
Open Source Software Development Center
Takashi Horie
E-Mail: horie-t@users.sourceforge.net
E-Mail: horietk@nttdata.co.jp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
