Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01479
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:15:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA02579
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:14:05 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id LAA02574
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:14:04 GMT
Date: Tue, 1 Oct 2002 13:15:36 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: policy version
Message-ID: <20021001131535.A21503@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm a little upset right now, so apologies up front if I get across a
little too aggressive:

I have a totally unusable SELinux system right now, because of policy
version conflicts. For reasons I don't understand, checkpolicy creates
a binary representation version 12, which load_policy refuses to load
because it's version 11.

I have removed and reinstalled all available policies from both
Russell's and Brian's site, all available selinux packages from both
sites, and both .deb and .tgz versions where I could.

Unless I am horribly stupid, there is a major fuckup somewhere. Add to
this the fact that your system is fubar'ed when the policy doesn't work
and I second Brian's call that we require a lot more checking and
information when it comes to the policy versions.

I just find it unacceptable that a standard update (all my troubles
started when I ran nothing more than "se_apt-get upgrade" this morning)
can take the system out completely, with no path back.

That, or I'm a total idiot.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
