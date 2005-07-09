Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6BD8WgA007893
	for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2005 09:08:32 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6BD5do0002694
	for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2005 13:05:39 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j6BD6BJk004383
	for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2005 09:06:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j6BD6Bxr004382
	for selinux@tycho.nsa.gov; Mon, 11 Jul 2005 09:06:11 -0400
To: SELinux@tycho.nsa.gov
Cc: ramsdell@mitre.org, sds@tycho.nsa.gov
Subject: ANN: SLAT 2.0
From: ramsdell@linus.mitre.org (John D. Ramsdell)
Date: 09 Jul 2005 18:11:41 -0400
In-Reply-To: <e8a2934d050709003658d0eda7@mail.gmail.com>
Message-ID: <ogtvf3jmxya.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SLAT is used to analyze SE Linux policy, and see if it meets policy
goals.  It does so by transforming policy and the goals into input for
a model checker.  The model checker reports the policy goal the
failures it finds.

SLAT version 2.0 is available at <http://www.mitre.org/tech/selinux>.
The current MLS format is not accepted by SLAT 1.x.x, so this version
uses APOL's permission mappings to specify the direction in which
information flows for each class-permission pair.  It also analyzes
binary policies instead of the source version of the policy.  If you
download the source version of SLAT 2.0, be sure to install
libsepol-devel.

Sorry if this is a repeat.  I thought I sent out the same message
yesterday. 

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
