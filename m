Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA02743
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 11:16:45 -0400 (EDT)
From: azeredo@qmc.ufsc.br
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA06673
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 15:15:16 GMT
Received: from quark.qmc.ufsc.br (bohr-gw.qmc.ufsc.br [150.162.31.223])
	by jazzswing.ncsc.mil  with ESMTP id PAA06669
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 15:15:15 GMT
Received: (from wwwrun@localhost)
	by quark.qmc.ufsc.br (8.11.3/8.11.3/SuSE Linux 8.11.1-0.5) id g8OFZXn22828
	for selinux@tycho.nsa.gov; Tue, 24 Sep 2002 12:35:33 -0300
Message-ID: <1032881732.3d908644afb3b@qmc.ufsc.br>
Date: Tue, 24 Sep 2002 12:35:32 -0300
To: selinux@tycho.nsa.gov
Subject: Problems compiling selinux in Mandrake 8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



  Hi,

  After giving up compiling selinux on SuSe 7.2  cause LIDS didn't work I am now
trying to compile selinux on Mandrake 8.1, and got the following mesage:


 /usr/src/lsm-2.4/arch/i386/lib/lib.a /usr/src/lsm-2.4/lib/lib.a
/usr/src/lsm-2.4/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
security/vmlinux-obj.o: In function `selopt_init':
security/vmlinux-obj.o(.text.init+0x1af): undefined reference to `selopt_queue_exit'
security/vmlinux-obj.o(.text.init+0x1b4): undefined reference to `selopt_cache_exit'
security/vmlinux-obj.o(.text.init+0x1b9): undefined reference to
`selopt_perimtab_exit'
security/vmlinux-obj.o(.text.init+0x1be): undefined reference to `flnetlink_exit'
make: *** [vmlinux] Error 1


   Any idea about the problem?

                                     Thanks,

                                           azeredo

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
