Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2E6iXZ005475
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:06:44 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2E6hAw019635
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:06:43 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Tue, 2 Nov 2004 09:06:34 -0500
Message-ID: <00ba01c4c0e5$29f78e70$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099403267.31739.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> TE is an access matrix, so it can represent a MLS policy, but the
> resulting representation would be huge for any significant number of
> MLS levels.  A native implementation of MLS is more efficient and
> easier to analyze.  There is benefit in a hybrid TE/MLS model.

But my instinct still says that orthogonal, rather than hybrid, TE/MLS would be
better.  I'm trying to read up on the reasons for the design decision but
perhaps you could explain further the rationale for the dependency (other than
implementation detail). 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
