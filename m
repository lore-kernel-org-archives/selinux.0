Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TKfTXZ011732
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 16:41:29 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TKfOsx025948
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 20:41:25 GMT
Subject: Re: make policy complains on file_contexts
From: Colin Walters <walters@verbum.org>
To: Valdis.Kletnieks@vt.edu
Cc: Alex Ackerman <alex@darkhonor.com>, selinux@tycho.nsa.gov
In-Reply-To: <200410291706.i9TH6Fxx031799@turing-police.cc.vt.edu>
References: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
	 <200410291706.i9TH6Fxx031799@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 16:41:17 -0400
Message-Id: <1099082477.17521.25.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-29 at 13:06 -0400, Valdis.Kletnieks@vt.edu wrote:

> Does a 'make reload' fix this?  A common cause of this is a "new" type that's
> in the on-disk policy, but not in the in-memory version.  So the
> new policy.18 is made, but when you run setfiles, user_eclipse_rw_t isn't
> active yet....

?  setfiles is validating against the new on-disk policy (policy.18),
not against the running one.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
