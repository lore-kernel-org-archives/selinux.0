Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0R57BRb028137
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 00:07:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0R55txr015023
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 05:05:55 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id i0R55tYc015020
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 05:05:55 GMT
Message-ID: <4015F1FB.4000902@diyab.net>
Date: Tue, 27 Jan 2004 00:07:07 -0500
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: login roles
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I set the pam_selinux module to multiple and now I'm seeing three roles 
instead of the two defined in policy/users.  The third context is 
<username>:staff_r:system_chkpwd_t, is this normal? I diffed my current 
policy against the 1.4 tarball from the NSA site and the only 
differences are a couple of changes I've made for slackware.  Of those 
few changes none of them have anything to do with system_chkpwd_t.

Timothy,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
