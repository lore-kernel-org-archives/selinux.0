Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1ERGRb006837
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:27:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1ERFqY006264
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:27:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB1ERF0o006261 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:27:15 GMT
Subject: Re: Policy error of the day
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200312010708.37773.russell@coker.com.au>
References: <20031129123120.GI18062@vnl.com>
	 <200312010708.37773.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070288825.12270.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:27:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-30 at 15:08, Russell Coker wrote:
> setfiles is supposed to operate on a non-SE machine.  The current version 
> apparently still has the code to check for validity of a context before 
> applying it, the plan is to fix this and I thought it was already fixed.  It 
> will be fixed soon.

The fix wasn't in the last public release, but is in our current tree
(and the sourceforge tree).  It checks the errno from a
security_check_context failure to see if it was just ENOENT (i.e.
/selinux/context didn't exist), and doesn't generate an error in that
case.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
