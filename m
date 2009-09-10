Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AKMTSM028374
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:22:29 -0400
Received: from e34.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AKLnB2025173
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 20:21:49 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8AKICHf025671
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:18:12 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n8AKMJRI216172
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:22:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n8AKMI7C026344
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:22:19 -0600
Date: Thu, 10 Sep 2009 15:22:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 0/4] LSM checkpoint/restart: introduction
Message-ID: <20090910202219.GA6778@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Following is a respin of the LSM checkpoint/restart patchset,
hopefully addressing most of the feedback I've gotten.

The patchset includes one (1/4) patch which is not directly
LSM-related, one (2/4) which implements the generic LSM c/r
support, one (3/4) implementing support for Smack, one
(4/4) implementing support for SELinux, and one (1/1)
updating the userspace program which initiates restart.

At this point I'm hoping to get some acks and get them pushed
to the c/r kernel tree, which is branch ckpt-v17-dev in
git://git.ncl.cs.columbia.edu/pub/git/linux-cr.git/.  Comments
are of course appreciated.  Once they sit in the tree for a bit,
I'll tackle the socket related LSM c/r.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
