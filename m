Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA04787
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 11:37:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA14429
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 15:36:25 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id PAA14425
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2002 15:36:25 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: policy_src_t
Date: Fri, 19 Jul 2002 11:40:38 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIAENIKEAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is the type policy_src_t being used?  It doesn't appear so.  We're trying to
update our tools to work with the recent policy syntax changes, as well as
create a policy for our tools themselves.  We need to read, modify, and
re-install a policy in an operational system.  As previously indicated, that
requires an installed policy.conf (we'll submit a proposed patch to the
makefile to do this next week).

In addition, for now we also need a known location for the policy source
make directory.  It seems logical that this directory would also have
policy_src_t.  If there are no specific plans to use this type, then we'll
be glad to submit a proposed use.  If there are plans, we'd like to hear
what they are so we can make our tools work within those plans. Thanks

Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
