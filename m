Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BEZ6w9016400
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 10:35:06 -0400
Received: from mx.meyering.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BEYP4H014481
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 14:34:25 GMT
From: Jim Meyering <jim@meyering.net>
To: bug-coreutils@gnu.org
Cc: Ulrich Drepper <drepper@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH] id: don't print context if POSIXLY_CORRECT is set
Date: Fri, 11 Sep 2009 16:35:04 +0200
Message-ID: <87pr9x5z3b.fsf@meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a small change to make id's output (when invoked with no options)
conform, when POSIXLY_CORRECT is set:
