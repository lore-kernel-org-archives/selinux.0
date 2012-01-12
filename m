Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0C7KCNg013590
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 02:20:12 -0500
Received: from collab.rosalab.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0C7KBgB020181
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 07:20:11 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by collab.rosalab.ru (Postfix) with ESMTP id B386D29CF6E
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 11:20:10 +0400 (MSK)
Received: from collab.rosalab.ru ([127.0.0.1])
	by localhost (collab.rosalab.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X17jmbLBtVfk for <selinux@tycho.nsa.gov>;
	Thu, 12 Jan 2012 11:20:10 +0400 (MSK)
Received: from collab.rosalab.ru (collab.rosalab.ru [192.168.1.89])
	by collab.rosalab.ru (Postfix) with ESMTP id 69E2A29CF6B
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 11:20:10 +0400 (MSK)
Date: Thu, 12 Jan 2012 10:20:10 +0300 (MSK)
From: Eugene Budanov <eugene.budanov@rosalab.ru>
To: selinux@tycho.nsa.gov
Message-ID: <76466968.6308.1326352810378.JavaMail.root@collab.rosalab.ru>
In-Reply-To: <472823933.6304.1326352630834.JavaMail.root@collab.rosalab.ru>
Subject: SELinux for Mandriva Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

At first, I apologize for my terrible English.

I'm trying to make a port of SELinux for ROSA/Mandriva Linux from Fedora Linux.
But a have a problem. In general, the most functions and packages built and works fine but I cannot compile package for selinux policy. It crashes with this error:

 tmp/unconfineduser.mod.role
echo "')" >> tmp/unconfineduser.mod.role
m4 -D enable_mcs -D distro_redhat -D mls_num_sens=16 -D mls_num_cats=1024 -D mcs_num_cats=1024 -D hide_broken_symptoms -s support/divert.m4 policy/support/file_patterns.spt policy/support/ipc_patterns.spt policy/support/obj_perm_sets.spt policy/support/misc_patterns.spt policy/support/misc_macros.spt policy/support/mls_mcs_macros.spt policy/support/loadable_module.spt support/undivert.m4 tmp/generated_definitions.conf tmp/all_interfaces.conf policy/modules/roles/unconfineduser.te tmp/unconfineduser.mod.role > tmp/unconfineduser.tmp
/usr/bin/checkmodule -M -m tmp/unconfineduser.tmp -o tmp/unconfineduser.mod
/usr/bin/checkmodule:  loading policy configuration from tmp/unconfineduser.tmp
policy/modules/roles/unconfineduser.te":47:ERROR 'unknown role unconfined_r' at token ';' on line 3315:
#line 47
        role unconfined_r types unconfined_t;
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/unconfineduser.mod] Error 1

Version of selinux-policy package which i tried to build: 3.9.16

Researching tons of mailing lists archives, forums, asking a colleagues couldn't help for me.

Some tech info:
[root@localhost SPECS]# rpm -qa | grep selinux
lib64selinux1-2.0.78-3mdv2011.0.x86_64
python-selinux-2.0.78-3mdv2011.0.x86_64
lib64selinux-devel-2.0.78-3mdv2011.0.x86_64
libselinux-devel-2.1.5-5.2-mdv2011.0.x86_64
libselinux-2.1.5-5.2-mdv2011.0.x86_64
libselinux-python-2.1.5-5.2-mdv2011.0.x86_64
libselinux-utils-2.1.5-5.2-mdv2011.0.x86_64
selinux-policy-3.6.6-3-mdv2011.0.noarch
selinux-policy-targeted-3.6.6-3-mdv2011.0.noarch
selinux-policy-minimum-3.6.6-3-mdv2011.0.noarch
[root@localhost SPECS]# rpm -qa | grep sepol
libsepol-2.1.1-1-mdv2011.0.x86_64
libsepol-devel-2.1.1-1-mdv2011.0.x86_64
libsepol-static-2.1.1-1-mdv2011.0.x86_64
[root@localhost SPECS]# rpm -qa | grep
[root@localhost SOURCES]# rpm -qa | grep semanage
libsemanage1-2.0.43-17.1.32-mdv2011.0.x86_64
libsemanage-devel-2.0.43-17.1.32-mdv2011.0.x86_64
python-semanage-2.0.43-17.1.32-mdv2011.0.x86_64

Checkpolicy version: 2.1.3-1.3-mdv2011.0.x86_64.

Important notice. This package was build at Fedora 16 without any problems. What I am wrong?

Ask me any questions if necessary.

Thank you in advance. 

---
Best regards,
Budanov Eugene
ROSA Lab.
Russia, Moscow.
e-mail : eugene.budanov@rosalab.ru
phone +79160674716


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
