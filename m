Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19908
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:38:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA08283
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:38:12 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id PAA08279
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:38:12 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: Proposal: install policy.conf
Date: Fri, 24 May 2002 11:41:52 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIIENMKDAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that we've completed a version of seuser, and somewhat of a follow on to
the comments in
http://marc.theaimsgroup.com/?l=selinux&m=102192722227366&w=2, I have a
specific proposal for operationally managing policies.

I suggest that policy.conf be installed in /etc/security as the "official
installed" policy (rather than /ss_policy), that load_policy or equivalent
commands effectively do a "checkpolicy -o /etc/security/policy.conf;
install -m 644 -o root -g root policy /ss_policy; load_policy /ss_policy" as
the only accepted means of installing a new policy.

What we'd like to see is /etc/security/policy.conf treated as the definitive
policy for a system, allowing all sorts of tools to change, create, or
otherwise manage all or portions of the installed policy.

Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
