Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n32GFo4E010449
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 12:15:50 -0400
Received: from brmea-mail-1.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n32GFnjn016627
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 16:15:50 GMT
Received: from dm-central-01.central.sun.com ([129.147.62.4])
	by brmea-mail-1.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n32GFnvD023167
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 16:15:49 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-01.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n32GFnvf030496
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 10:15:49 -0600 (MDT)
Date: Thu, 2 Apr 2009 10:44:02 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: saag@ietf.org
Cc: nfsv4@ietf.org, labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov
Subject: Common labeled security (comment on CALIPSO, labeled NFSv4)
Message-ID: <20090402154402.GM1500@Sun.COM>
Reply-To: saag@ietf.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Over at the NFSv4 WG we've been having a discussion of a labeled NFSv4
proposal.  [Note: NFSv4 WG and others cc'ed, Reply-To: set to SAAG.]

An interop issue has arisen that we believe applies equally to CALIPSO
(draft-stjohns-sipso-11.txt)and requires input from the IETF security
area.

The issue is: how do do nodes in a labeled network/application know if
they agree on a common labeled security policy for a given DOI?

Agreeing on a DOI is accomplished easily enough -- that's not an issue.
Agreeing on what a given numeric sensitivity level or compartment bit
means in a given DOI is quite another.  Without a solution to this we're
left with out-of-band agreement, which leaves interop in a lurch.

I think we need a generic MLS and DTE labeled security policy document
format that allows a DOI to define the names and numeric assignments of
sensitivity levels, compartments, etcetera.

We also need a way for nodes to agree that they have the same policy for
a given DOI, or that they agree on a common subset of a DOI's policy.

This last problem can be solved by use of a labeled security policy URI
scheme that includes a version number (+ a requirement that changes be
in the form of additions and obsolescence of old assignments, but not
removals).

To recap: I think we need a) a common MLS and DTE labeled security
policy document format, b) a labeled security policy URI scheme to refer
to such documents by.

Given (a) and (b) NFSv4.x clients and servers would only have to
exchange {DOI #, policy URI} tuples to determine whether they agree on a
common policy.

Note that CALIPSO describes how to encode and compare MLS labels on the
wire, but it does not describe how nodes agree on the meaning of
particular sensitivity levels or compartments.  Therefore CALIPSO is
going to have much the same problem as NFSv4.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
