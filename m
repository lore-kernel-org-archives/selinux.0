Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA21350
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2001 20:53:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA29421
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 01:53:21 GMT
Received: from stan.ksni.net (stan.ksni.net [207.239.115.11])
	by jazzband.ncsc.mil  with ESMTP id BAA29417
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 01:53:20 GMT
Received: from ksni.net (pip-81.ksni.net [209.119.6.81])
	by stan.ksni.net (8.11.6/8.9.3) with ESMTP id fA61oaX25979
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2001 19:50:37 -0600
Message-ID: <3BE74419.46DBEAA@ksni.net>
Date: Mon, 05 Nov 2001 19:59:53 -0600
From: Ryan Senior <slax@ksni.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problem making the kernel w/ the SELinux modules added
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am running Red Hat 7.1 and am attempting to compile the SELinux
additions into the kernel,  I get the following error message when it
gets to part of the SELinux section:

make[3]: Entering directory `/usr/src/selinux/module/selinux_plug/ss'
gcc -o checkpolicy ebitmap.cp.o queue.cp.o hashtab.cp.o symtab.cp.o
sidtab.cp.o avtab.cp.o policydb.cp.o services.cp.o y.tab.cp.o
lex.yy.cp.o checkpolicy.cp.o -lfl
/usr/bin/ld: cannot find -lfl
collect2: ld returned 1 exit status
make[3]: *** [checkpolicy] Error 1
make[3]: Leaving directory `/usr/src/selinux/module/selinux_plug/ss'
make[2]: *** [_subdir_ss] Error 2
make[2]: Leaving directory `/usr/src/selinux/module/selinux_plug'
make[1]: *** [_subdir_selinux_plug] Error 2
make[1]: Leaving directory `/usr/src/lsm/security'
make: *** [_dir_security] Error 2

Thanks,
Ryan


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
