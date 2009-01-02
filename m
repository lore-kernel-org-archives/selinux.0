From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [RFC v3]Provide a method for detecting labeling support on a file system.
Date: Fri,  2 Jan 2009 11:52:23 -0500
Message-Id: <1230915146-2359-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is the third version of a patchset to allow user space programs to easily
detect if a mount supports labeling. The first patch condenses the existing
flag fields in the super block security struct into the flags field and fixes
the existing code to make use of the condensed field. The second patch adds
handling for a new mount option called supports_labeling. If this is passed in
to the mount command it is ignored by the security server, however the string
is added to the output of /proc/mounts to indicate labeling support. The last
patch makes the genfs labeling behavior behave like context mounts. Currently
instead of returning EOPNOTSUPP for attempts to set a label on a genfs
filesystem it may also fail based on permission check potentially confusing
the user.

There are two differences in the patch set between version two and three. The
first is that it has been rebased to a more recent version of Linus' tree. The
second is that a compilation error has been fixed that was introduced by a
patch that performs a check based on the proc member of the security struct
which nolonger exists. 

 security/selinux/hooks.c            |   80 +++++++++++++++++++++++------------
 security/selinux/include/objsec.h   |    2 -
 security/selinux/include/security.h |    8 ++++
 3 files changed, 61 insertions(+), 29 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
