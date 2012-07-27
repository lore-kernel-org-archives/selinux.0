Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RBFveT018993
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 07:15:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail01.circletech.net (circletech mail system) with ESMTP id 39A4848A003
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 13:14:51 +0200 (CEST)
Received: from mail01.circletech.net ([127.0.0.1])
	by localhost (beatka.circletech.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1W8r-lBE36JT for <selinux@tycho.nsa.gov>;
	Fri, 27 Jul 2012 13:14:51 +0200 (CEST)
Received: from [10.103.1.12] (rzt-nat.circletech.net [95.80.216.198])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: michal.masek@circletech.net)
	by mail01.circletech.net (circletech mail system) with ESMTPSA id 0C33E226229
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 13:14:51 +0200 (CEST)
Message-ID: <50127869.4070605@circletech.net>
Date: Fri, 27 Jul 2012 13:15:53 +0200
From: =?UTF-8?B?TWljaGFsIE1hxaFlaw==?= <michal.masek@circletech.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Issue with setting booleans in SEManager app
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am unable to set or unset 'app_ndk' boolean using the SEManager app in
seandroid-4.1.1 branch (in the master branch everything works fine).
However I can still set it from command line:
  adb shell su 0 setsebool app_ndk=1

The same applies for 'in_qemu' boolean. All other booleans can be set
just fine. I am running SEAndroid on Galaxy Nexus. Does anyone else have
this issue?

--
Michal Mašek



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
