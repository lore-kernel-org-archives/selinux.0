From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [RFC v4]Provide a method for detecting labeling support on a file system
Date: Fri, 16 Jan 2009 09:22:01 -0500
Message-Id: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
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

There are two differences between this patch set and version three. The first
is the string supports_labeling has been replaced with seclabel as labeling is
to generic of a term with respect to file systems. The second change is that the
string has been added to the appropriate function in the selinux code such that
it gets stripped out of the mount options that are eventually handed to the
file system to parse.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
