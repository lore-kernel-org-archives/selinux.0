Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25859
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 11:41:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PGf3I18151
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:41:03 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h1PGf2f18147 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:41:02 GMT
Message-Id: <200302251648.LAA15220@moss-shockers.ncsc.mil>
Date: Tue, 25 Feb 2003 11:48:38 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy
To: wsalamon@tislabs.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Wayne Salamon wrote:
>   I agree with the above. The macros that I was (mostly) referring to are
> the ones in macros/program. The idea behind these seems to have
> parameterized domain/type definitions. I'm not convinced they're a good
> idea, and many have dependencies to types defined in other .te files.

Creating derived domains (and associated derived types) from the
calling domain is actually good practice, as it allows you to maintain
separation between the user domains.  Otherwise, you end up with an
initial separation between the user domains that can be easily
circumvented through shared program domains that have the same accesses
to the same types.  I'd agree that all of the macros (including the
global macros as well as the program macros) need a thorough audit and
reduction, but I don't think you truly want to eliminate the use of
program macros for instantiating program domains.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
