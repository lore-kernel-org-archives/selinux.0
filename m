Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA04948
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 11:52:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA15221
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 15:52:10 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id PAA15217
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 15:52:10 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: default context files
Date: Fri, 19 Jul 2002 11:56:34 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIKENIKEAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a reason why the cron_context file has a specific type
(cron_context_t) and the default_context file has the generic etc_t type?
We're trying to give a domain the ability to write both context files, and
it seems excessive for it to have the ability to modify all files with etc_t
type.  Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
