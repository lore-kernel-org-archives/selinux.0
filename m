Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HMo5Xf010439
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 17:50:06 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HMo3Rq024810
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 22:50:03 GMT
Message-ID: <43CD749E.4000101@redhat.com>
Date: Tue, 17 Jan 2006 17:50:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ignore repeats from previous for now.

Changes for fetchmail

sendrecv_unlabeled_association needs to be added to unconfined_t and rpcd_t

Procmail execs spamc which tries to talk to spamd_port_t

Is this done some other way, that I am missing?

+    domain_auto_trans(run_init_t,initrc_exec_t,initrc_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
