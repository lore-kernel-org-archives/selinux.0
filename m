Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5K1WMRD019589
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 21:32:22 -0400
Received: from e38.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5K1W71L012485
	for <selinux@tycho.nsa.gov>; Sat, 20 Jun 2009 01:32:08 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5K1TFXq015065
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 19:29:15 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5K1WF5H253676
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 19:32:19 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5K1WEZj019012
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 19:32:15 -0600
Date: Fri, 19 Jun 2009 20:32:16 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Linux Containers <containers@lists.osdl.org>
Cc: linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
Message-ID: <20090620013216.GA4435@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is the next version of the patch implementing checkpoint
and restore of LSM contexts.  This is just handling IPC objects
as a proof of concept.  But actually, looking ahead and both
files and tasks, I see that selinux stores several sids in the
security structs.  For instance, for tasks there is the current
sid, exec sid, create sid, keycreate_sid, and sockcreate_sid.
So I guess I'll have to ask the LSM for how many secids it wants
to checkpoint, then checkpoint an array of contexts?
