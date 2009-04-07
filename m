Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n37JHh2H000544
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 15:17:43 -0400
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n37JHgbv020911
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 19:17:42 GMT
Received: by qw-out-1920.google.com with SMTP id 5so2656967qwf.30
        for <selinux@tycho.nsa.gov>; Tue, 07 Apr 2009 12:17:42 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Apr 2009 12:17:42 -0700
Message-ID: <dd18b0c30904071217x740a809fve1ad3f9fbba140e5@mail.gmail.com>
Subject: SELinux userpace compile errors
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

compiling the userspace tools
I'm receiving some errors:
(the first is just a simple "make" instead of "sudo make")


make[1]: Entering directory `/home/name/LFS/SELinux/selinux/libsepol'
make -C include install
make[2]: Entering directory `/home/name/LFS/SELinux/selinux/libsepol/include'
test -d /usr/include/sepol || install -m 755 -d /usr/include/sepol
test -d /usr/include/sepol/policydb || install -m 755 -d
/usr/include/sepol/policydb
install -m 644 sepol/boolean_record.h sepol/booleans.h sepol/context.h
sepol/context_record.h sepol/debug.h sepol/errcodes.h sepol/handle.h
sepol/iface_record.h sepol/interfaces.h sepol/module.h
sepol/node_record.h sepol/nodes.h sepol/policydb.h sepol/port_record.h
sepol/ports.h sepol/roles.h sepol/sepol.h sepol/user_record.h
sepol/users.h /usr/include/sepol
install: cannot remove `/usr/include/sepol/boolean_record.h': Permission denied
install: cannot remove `/usr/include/sepol/booleans.h': Permission denied
install: cannot remove `/usr/include/sepol/context.h': Permission denied
install: cannot remove `/usr/include/sepol/context_record.h': Permission denied
install: cannot remove `/usr/include/sepol/debug.h': Permission denied
install: cannot remove `/usr/include/sepol/errcodes.h': Permission denied
install: cannot remove `/usr/include/sepol/handle.h': Permission denied
install: cannot remove `/usr/include/sepol/iface_record.h': Permission denied
install: cannot remove `/usr/include/sepol/interfaces.h': Permission denied
install: cannot remove `/usr/include/sepol/module.h': Permission denied
install: cannot remove `/usr/include/sepol/node_record.h': Permission denied
install: cannot remove `/usr/include/sepol/nodes.h': Permission denied
install: cannot remove `/usr/include/sepol/policydb.h': Permission denied
install: cannot remove `/usr/include/sepol/port_record.h': Permission denied
install: cannot remove `/usr/include/sepol/ports.h': Permission denied
install: cannot remove `/usr/include/sepol/roles.h': Permission denied
install: cannot remove `/usr/include/sepol/sepol.h': Permission denied
install: cannot remove `/usr/include/sepol/user_record.h': Permission denied
install: cannot remove `/usr/include/sepol/users.h': Permission denied
make[2]: *** [install] Error 1
make[2]: Leaving directory `/home/name/LFS/SELinux/selinux/libsepol/include'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/name/LFS/SELinux/selinux/libsepol'
make: *** [install] Error 1

the second seems to maybe be with the gcc
(which is 4.5.0)



policy_define.c: In function 'set_types':
policy_define.c:1304: error: offset '3' outside bounds of constant string
policy_define.c:1316: error: offset '3' outside bounds of constant string
policy_define.c:1328: error: offset '3' outside bounds of constant string
policy_define.c: In function 'define_te_avtab_helper':
policy_define.c:1679: error: offset '3' outside bounds of constant string
policy_define.c:1685: error: offset '3' outside bounds of constant string
policy_define.c: In function 'set_roles':
policy_define.c:2024: error: offset '3' outside bounds of constant string
policy_define.c:2030: error: offset '3' outside bounds of constant string
policy_define.c: In function 'set_user_roles':
policy_define.c:2854: error: offset '3' outside bounds of constant string
policy_define.c:2860: error: offset '3' outside bounds of constant string
make[1]: *** [policy_define.o] Error 1
make[1]: Leaving directory `/home/name/LFS/SELinux/selinux/checkpolicy'
make: *** [install] Error 1


I've seen this offset 3 message with different
apps.
(maybe I just need to set the "warnings treated as error"
flag somewhere).

regards,

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
