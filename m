Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25531
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 11:16:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA22515
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:12:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA22507
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:12:54 GMT
Date: Tue, 25 Feb 2003 11:15:22 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Core policy
In-Reply-To: <200302251541.KAA15178@moss-shockers.ncsc.mil>
Message-ID: <Pine.LNX.4.33.0302251050030.1479-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Feb 2003, Stephen D. Smalley wrote:

>
> With regard to macros, I think that they are helpful when they provide
> a useful abstraction and are carefully limited to that abstraction
> (i.e. no granting of permissions only weakly related to that
> abstraction).  For example, domain_auto_trans and file_type_auto_trans
> provide useful abstractions of the higher level concepts of domain
> transitions and file type transitions, although we should audit them to
> ensure that they are not being overly permissive.

  I agree with the above. The macros that I was (mostly) referring to are
the ones in macros/program. The idea behind these seems to have
parameterized domain/type definitions. I'm not convinced they're a good
idea, and many have dependencies to types defined in other .te files.


 --
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
