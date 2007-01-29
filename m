Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TJ3cpX025969
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 14:03:38 -0500
Received: from ultra1.univ-paris12.fr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TJ4dF5001236
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 19:04:40 GMT
Received: from [193.51.149.46] (localhost [127.0.0.1])
	by ultra1.univ-paris12.fr (8.13.8/8.13.8) with ESMTP id l0TJ4aLv029308
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 20:04:36 +0100 (MET)
Message-ID: <45BE44FC.8080303@univ-paris12.fr>
Date: Mon, 29 Jan 2007 20:03:24 +0100
From: Catalin DIMA <dima@univ-paris12.fr>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problems installing current version of refpolicy with FC6
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to install different versions of refpolicy on Dell X1 
machines with FC6, for teaching purposes, but no choice of build.conf 
parameters can make it. I get outcomes from "kernel panic" (when trying 
to install the "strict monolithic" version of refpolicy) to system stall 
(when trying to install "targeted monolithic" version), or outputs like 
below (when trying to install "targeted modular" version -- this 
installation ends in stack problems which also cause system halt). Every 
time the kernel does not panic, there's a whole list of booleans that 
are unknown to libsepol.load_booleans, though generated from refpolicy 
via the "install" target of the Makefile.

I have tried on two different laptops but the outcome is the same. I 
have also tried with the latest or older versions and the output is the 
same. Did anyone observe similar behaviors with laptops/FC6/refpolicy ?...

Output :
libsepol.load_booleans: unknown boolean user_ttyfile_stat (and others)
libsepol.sepol_genbools: error while reading /etc/selinux/refpolicy/booleans
bash: initialize_job_control : setpgid: Permission denied
bash: /sbin/consoletype: Permission denied
No devices found
Setting up Logival Volume Management: No volume groups found
ext2fs_check_if_mount: Permission denied while determining whether 
/dev/hda7 is mounted
/etc/selinux/refpolicy/contexts/files/file_contexts: Multiple different 
specifications for /usr/bin/mplayer 
(system_u:object_r:unconfined_execmem_exec_t and 
system_u:object_r:mplayer_exec_t)
....

-- 
Catalin Dima, 
Paris 12 University




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
