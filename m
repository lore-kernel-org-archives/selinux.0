Message-ID: <3B0C9833.F32CAAF8@yingternet.com>
Date: Wed, 23 May 2001 22:12:19 -0700
From: Ying-Hung Chen <ying@yingternet.com>
MIME-Version: 1.0
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: problem relabel the file system
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

	I have installed SELinux on couple of my machines, it usually go
through ok at the first time, but when i try to relabel again for any
reason (i.e. change the policy/file_contexts) I always have some files
that refuse to get relabel again and cause make file to fail.

	I did remove ALL the .../security for all the partitions and did a make
initinstall in the policy (instruction 5 and 7 in the installation
guide) but no luck.

	I noticed on the installation guide, it mentioned:

"Although this invalidates any existing file labels, it does not clear
the persistent SID values in the inodes.  Consequently, some warnings
are likely when the file system is relabeled in step 12.  A program
will be provided in the future to clear the persistent SID values."

does this cause the make relabel to fail since inodes never get clean
up? are there any work arounds?

Thanks,

-Ying

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
