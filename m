Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA27051
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 13:12:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA00086
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 18:09:10 GMT
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.102])
	by jazzswing.ncsc.mil  with ESMTP id SAA00082
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 18:09:08 GMT
In-Reply-To: <200302251648.LAA15220@moss-shockers.ncsc.mil>
Subject: Re: Core policy and TCB
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Message-ID: <OF4A38669D.D36073FC-ON85256CD8.0061512D-85256CD8.0063FC56@us.ibm.com>
From: Trent Jaeger <jaegert@us.ibm.com>
Date: Tue, 25 Feb 2003 13:12:06 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov





Hi,

I am interested in this notion of a core policy as well.

My take is slightly different, I think (although correct me if I am wrong).
Rather than identifying a set of core subject types, I want to identify the
subject types that form the trusted computing base of a SELinux policy.
Because a core subject type need not be in the system TCB, the TCB subject
types would be a subset of the core policy types.

I would like to prove that the TCB subject types are protected from the
rest of the system (i.e., the integrity of these TCB subject types should
only be dependent on input from other TCB subject types) .  As a first
step, I have used Biba integrity as the basis to see where integrity issues
are.  I have used my policy analysis prototype to collect the Biba
integrity violations in the policy.  I could provide a table of such
violations to those that are interested or to the list if enough interest.

As a summary, there are some ad hoc issues (like dpkg discussed earlier --
I included it in the TCB because I assumed that it was a fundamental system
update tool) and broad assignments of rights issues (like the use of the
attribute file_type to assign rights to files, as Stephen mentioned).  The
latter case can be fixed by decomposing attributes, but I would rather find
another approach.  I like the general specification of attributes, but
where they conflict with higher-level goals, I would like to be able to
dictate a resolution strategy (deny, audit, etc.).  For example, sys admins
have access to all files, but they should probably audited upon access to
low integrity files (and denied altogether on some).  This could be
relative to the integrity spec rather than changing the attribute
relationships...

I am looking into this, but I am curious what your thoughts are on the
matter.

Regards,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
