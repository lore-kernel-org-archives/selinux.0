Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1SNk9Do028529
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2005 18:46:09 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1SNgk07024219
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2005 23:42:46 GMT
Message-Id: <200502282342.j1SNgW8R008814@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>,
   "Fedora-Selinux-List" <fedora-selinux-list@redhat.com>
Cc: <selinux-dev@tresys.com>
Subject: [ANN] Setools 2.0 released
Date: Mon, 28 Feb 2005 18:42:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of Setools is available from http://www.tresys.com/selinux. This
release contains major new features including:

- Sediff: a new tool that allows a user to take two policies and find the
differences including added or removed types, users, roles, booleans and most
importantly type enforcement rules. The semantic difference of a policy is
different from the syntactic difference in that it shows the cumulative effect
of rules rather than doing a line-by-line comparison.

- File contexts database: major improvements were made to the file context
indexing and searching tools including conversion to an on-disk database for
reduced memory usage and integration into Apol.

- Direct file relabel analysis: a new analysis module was added to Apol for
analyzing direct object relabeling.

- Type relationship analysis: a new analysis module was added to Apol for to
facilitate understanding the relationship between two types. This analysis
builds on the rule searching and other analysis in Apol to give the user
convenient access to many queries and anlyses at once.

- Seaudit report: generation of reports was integrated into seaudit. Previously
this was only available as a commandline tool.

More details on the new features can be found at
http://www.tresys.com/selinux/setools_new_noteworthy.html.

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
