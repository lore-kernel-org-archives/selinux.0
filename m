Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25155
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 10:43:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PFhNI14837
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 15:43:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h1PFhNf14833 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 15:43:23 GMT
Message-Id: <200302251550.KAA15183@moss-shockers.ncsc.mil>
Date: Tue, 25 Feb 2003 10:50:58 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy
To: ragnor@mitre.org, wsalamon@tislabs.com, russell@coker.com.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Russell Coker wrote:
> I suggest that we make the second line of each .te file contain a comment 
> stating which category it is in, with the possibility of policy being in 
> multiple categories.

While this seems reasonable to me, I'd suggest that we first identify
the core policy components, cleanly separate out the non-core
components, and perform a thorough audit and reduction of the core
macros and domains.  Then, we can incrementally work on a similar audit
and reduction of each of the non-core policy components, including
categorizing them and determining their interdependencies.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
