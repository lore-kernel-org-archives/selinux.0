Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA23659
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 15:27:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA15831
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 19:27:07 GMT
Received: from hidrogeno.cti (cti015035.prima.com.ar [200.42.15.35])
	by jazzswing.ncsc.mil  with ESMTP id TAA15819
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 19:27:01 GMT
Received: from cti.com.ar (radon.cti [170.51.191.71])
	by hidrogeno.cti (8.8.6 (PHNE_17190)/8.8.6) with ESMTP id QAA16442
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2001 16:28:13 -0300 (SAT)
Message-ID: <3B0AF61B.BC396C0F@cti.com.ar>
Date: Tue, 22 May 2001 16:28:27 -0700
From: "Hugo F. Martinez" <hmartinez@cti.com.ar>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: policy
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi:
Im  trying to relabel my file system but im getting this kind of errors

....
./set files: invalid context system_u:object_r:cron_log_ti on line
number 368
make: *** [relabel] Error 1

I check the file_contexts but i cant see any clue of where the problem

Thanks in advance.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
