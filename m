Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12849
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 10:33:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA17625
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 15:32:10 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id PAA17621 for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 15:32:09 GMT
Date: Sun, 24 Mar 2002 15:45:41 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Mix and Match 2: relabel problems
Message-ID: <20020324154541.GA31389@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, getting close. I rebooted into selinux after remembering to
do the make relable this time. Then I did Russell's policy make install,
and it works under an selinux kernel as I surmised it would.

However I'm still missing something in his policy, because when
I relabel after the boot:

> make verbose
./setfiles -v file_contexts `mount | awk '/ext[23]/{print $3}'`
./setfiles:  Running on a SELinux kernel, using new system calls
./setfiles:  read 352 specifications
./setfiles:  invalid context system_u:object_r:slapd_db_t on line number 65
./setfiles:  invalid context system_u:object_r:slapd_replog_t on line number 66
./setfiles:  invalid context system_u:object_r:slapd_exec_t on line number 401
make: *** [verbose] Error 1

I'm using the policy/ from Russell's selinux_2002031409-2_i386.deb dist in
the lsm-2.4-selinux-2002031409.tgz base release. With minor twiddles of
my own to make things work together.

Any suggestions?



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
