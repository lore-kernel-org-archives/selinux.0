Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06732
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 14:39:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA04520
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 19:39:26 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA04516
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 19:39:24 GMT
Received: from avsrv1.mitre.org (avsrv1.mitre.org [129.83.20.58])
	by smtpproxy1.mitre.org (8.9.3/8.9.3) with ESMTP id OAA11298
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 14:39:36 -0500 (EST)
Received: from mailsrv1.mitre.org (mailsrv1.mitre.org [129.83.20.6])
	by smtpsrv1.mitre.org (8.9.3/8.9.3) with ESMTP id OAA21045
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 14:39:35 -0500 (EST)
Message-ID: <3AC38FB1.FA2E8109@mitre.org>
Date: Thu, 29 Mar 2001 14:40:33 -0500
From: Jon Crowley <jonathan@mitre.org>
MIME-Version: 1.0
To: "McFarland David M." <DMMcFa2@missi.ncsc.mil>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Context switches
References: <200103291918.OAA25148@stingray.missi.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Have you changed your path to have /usr/flask/bin before /usr/bin?  If
not, you may not be using the new versions of the utilities.

Jon


> "McFarland, David M." wrote:
> 
> Hello,
> 
>         I was able to install the 2.2.12 kernel fine but when I try to
> use the --context switches it gives me an error. Any idea what might
> be wrong? I'm following the install instructions from the website.
> 
> Dave

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
