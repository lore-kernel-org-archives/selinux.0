Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2EDOXZ005540
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:13:24 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2EC34G007724
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:12:03 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Tue, 2 Nov 2004 09:13:23 -0500
Message-ID: <00bb01c4c0e6$1d5a3a40$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099403267.31739.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> TE is an access matrix, so it can represent a MLS policy, but the
> resulting representation would be huge for any significant number of
> MLS levels.  A native implementation of MLS is more efficient and
> easier to analyze.  There is benefit in a hybrid TE/MLS model.

Actually, we have been struggling with this a bit, and the only MLS-like issues
we seem not to be able to handle efficiently in TE is compartments.  So it seems
a combination of TE and categories/compartments is most efficient (though this
still doesn't seem to necessitate making the mechanisms non-orthogonal).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
