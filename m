Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9OIrTDt027984
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 14:53:29 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9OIqhKQ007987
	for <selinux@tycho.nsa.gov>; Tue, 24 Oct 2006 18:52:44 GMT
Subject: ANN: SELinux Policy IDE (SLIDE)
From: Dave Sugar <dsugar@tresys.com>
To: selinux@tycho.nsa.gov
Cc: slide <slide@tresys.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 14:53:24 -0400
Message-Id: <1161716004.3279.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The third release of SELinux Policy IDE (SLIDE) from Tresys is now
available for download from the Tresys Open Source website at
http://oss.tresys.com. 

SLIDE is an Eclipse plug-in that integrates with the SELinux Reference
Policy to provide a development environment for building SELinux policy.

New features in this release:

* Ability to test policy under development on a remote machine from
within SLIDE
* Remote audit monitoring using SLIDE's Audit view, which displays audit
messages from remote machine

Bugs fixed in this release:

* Modifications to the new project wizard to make it clearer
* Rewrite of policy explorer to fix some problems it was having
* Modifications to search to include ability to search for
type_transitions
* Changes to the new project wizard to make it clearer what the various
options are

Dave Sugar
dsugar@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
