Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8TIK0Ns019176
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 14:20:01 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8TIEMA9022497
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 18:14:23 GMT
Subject: apache tunable expression
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 14:13:39 -0400
Message-Id: <1128017619.12449.10.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the apache policy, there is this conditional expression:

if (httpd_enable_cgi && httpd_unified && httpd_builtin_scripting
    ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {

Why is the httpd_disable_trans boolean checked?  If the transition to
httpd_t is disabled, why does it matter if these rules are enabled or
not?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
