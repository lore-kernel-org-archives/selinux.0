Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IDKPRb001153
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:20:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IDI0B2011841
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:18:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4IDI0wi011838
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:18:00 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040518130244.GB24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net>
	 <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518130244.GB24917@lkcl.net>
Content-Type: text/plain
Message-Id: <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 09:20:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 09:02, Luke Kenneth Casson Leighton wrote:
>  given the number of errors i am seeing, and given that they won't
>  go away, perhaps there is some breakdown in communication between
>  the rules being in the policy.conf file and their application to
>  packages.

They aren't applied until you compile that policy.conf via checkpolicy
and load the resulting binary policy into the kernel.  make load in the
policy directory will do that for you.

>  for example, should i be doing a make relabel every time i add
>  some new rules?

No.  You only have to relabel if you have altered the file contexts
configuration in some manner (but note that this is true if you enable
additional .te files, as that automatically requires their .fc files).

>  ah.  then i will try.... xdm, and see what happens.
> 
>  (wdm is the patched one from daniel walsh).

Are you sure?  I'm not aware of any patched wdm from Dan Walsh, just one
by Tom Vogt that was upstreamed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
