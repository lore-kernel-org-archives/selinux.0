Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6ADw0EJ029269
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 09:58:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail01.circletech.net (circletech mail system) with ESMTP id 144E648A094
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 15:56:50 +0200 (CEST)
Received: from mail01.circletech.net ([127.0.0.1])
	by localhost (beatka.circletech.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fqMD9Lt7SNN for <selinux@tycho.nsa.gov>;
	Tue, 10 Jul 2012 15:56:49 +0200 (CEST)
Received: from [10.103.1.12] (rzt-nat.circletech.net [95.80.216.198])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: michal.masek@circletech.net)
	by mail01.circletech.net (circletech mail system) with ESMTPSA id B22A022622C
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 15:56:49 +0200 (CEST)
Message-ID: <4FFC34C1.7000803@circletech.net>
Date: Tue, 10 Jul 2012 15:57:21 +0200
From: =?UTF-8?B?TWljaGFsIE1hxaFlaw==?= <michal.masek@circletech.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SEAndroid: Labels of files in /data/data/APPDIR/lib directory
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am trying to make our application operational under
SEAndroid. Currently the application produces "open" and "execute"
denials when it is loading its dynamic libraries from
/data/data/APPDIR/lib directory:

<5>[ 3913.711395] type=1400 audit(1341923463.083:9): avc:  denied  {
open } for  pid=1832 comm="t.circletech.cc" name="libsdl-1.2.so"
dev=mmcblk0p12 ino=578446 scontext=u:r:untrusted_app:s0:c38
tcontext=u:object_r:system_data_file:s0 tclass=file

<5>[ 3913.711730] type=1400 audit(1341923463.083:10): avc:  denied  {
execute } for  pid=1832 comm="t.circletech.cc"
path="/data/data/net.circletech.cc/lib/libsdl-1.2.so" dev=mmcblk0p12
ino=578446 scontext=u:r:untrusted_app:s0:c38
tcontext=u:object_r:system_data_file:s0 tclass=file


My guess is that these libraries should have a different label. Such
that the application is allowed to load them. But which one? And how to
change it? I tried to change the policy (file_contexts), but it had no
effect (it seems that files in the lib directory are relabeled during
installation).

Thank you,
Michal Mašek



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
