Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA29394
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 17:07:20 -0500 (EST)
From: azeredo@qmc.ufsc.br
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA07323
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 22:05:21 GMT
Received: from quark.qmc.ufsc.br (bohr-gw.qmc.ufsc.br [150.162.31.223])
	by jazzswing.ncsc.mil  with ESMTP id WAA07319
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 22:05:19 GMT
Received: (from wwwrun@localhost)
	by quark.qmc.ufsc.br (8.11.3/8.11.3/SuSE Linux 8.11.1-0.5) id gA7MT4Y06467
	for selinux@tycho.nsa.gov; Thu, 7 Nov 2002 20:29:04 -0200
Message-ID: <1036708144.3dcae930a8fe4@qmc.ufsc.br>
Date: Thu,  7 Nov 2002 20:29:04 -0200
To: selinux@tycho.nsa.gov
Subject: selinux in RH8
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




  I found the problems with the kernel and re-install all selinux from the
beginning. Everything went fine, no compilations problems at all. All utils were
built correctly. ....

make reset


reboot and got only one error.

avc: denied {write} for pid=396 exe=/bin/bash path=/etc/passwd dev=03:05 ino=231078
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:etc_t tclass=file

System booted ok and I logged as root and changed to system_r context and did a

make relabel

and got the following


avc:  denied  { read } for  pid=686 exe=/usr/local/selinux/bin/checkpolicy
path=/usr/src/selinux/policy/Makefile dev=03:05 ino=882701
scontext=root:sysadm_r:checkpolicy_t tcontext=system_u:object_r:src_t tclass=file
/usr/local/selinux/bin/setfiles file_contexts/file_contexts `mount | awk
'/(ext[23]|reiserfs)/{print $3}'`
/usr/local/selinux/bin/setfiles:  Running on a SELinux kernel, using new system
calls

avc:  denied  { read } for  pid=687 exe=/usr/local/selinux/bin/setfiles
path=/usr/src/selinux/policy/file_contexts/file_contexts dev=03:05 ino=883914
scontext=root:sysadm_r:setfiles_t tcontext=system_u:object_r:src_t tclass=file
/usr/local/selinux/bin/setfiles:  read 846 specifications
/usr/local/selinux/bin/setfiles:  labeling files under /


avc:  denied  { write } for  pid=687 exe=/usr/local/selinux/bin/setfiles
path=/dev/tty1 dev=03:05 ino=39346 scontext=root:sysadm_r:setfiles_t
tcontext=system_u:object_r:tty_device_t tclass=chr_file
/usr/local/selinux/bin/setfiles:  conflicting specifications for /sbin/mkfs.ext3
and /sbin/mkfs.ext2, using system_u:object_r:fsadm_exec_t.
/usr/local/selinux/bin/setfiles:  hash table stats: 159697 elements, 30356/65536
buckets used, longest chain length 14
/usr/local/selinux/bin/setfiles:  labeling files under /home
/usr/local/selinux/bin/setfiles:  hash table stats: 1182 elements, 1182/65536
buckets used, longest chain length 1
/usr/local/selinux/bin/setfiles:  Done.

 Finally I started mysqld daemon that went  ok but when started apache got:

Starting httpd:
avc:  denied  { name_bind } for  pid=802 exe=/usr/sbin/httpd port=80
scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:http_port_t
tclass=tcp_socket

ps -e --context

execute as expected.

      I believe I am almost there. What is missing?
       I read about OSDgroup and the SElinux distribution available as a beta
version. Why there is no comment  in the list about?

                                    Thanks a lot for  the help.

                             Aldrovando Azeredo.
                             Mathematics Department
                             UFSC- Santa Catarina
                             Brazil  
                              

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
