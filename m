Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FFuFOe030013
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:56:15 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FFtqhu028623
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 15:55:53 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k7FFuERh017199
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:56:14 -0400 (EDT)
Date: Tue, 15 Aug 2006 10:55:58 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: [RFC Patch 0/3] Context Mounts and Unsupported Contexts
Message-Id: <20060815105558.0b44a54a.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a potential patch set to correct the collision which is occurring
between commas in contexts and the comma delimiter between option values for
mount.

The Problem:

If the context option specified to mount contains a comma then the value of 
the context option will be improperly broken up.

Example:

Using an MCS translation setup with these entries.

s0:c1=PatientRecord
s0:c2=Unclassified
s0:c3=Secret
s0:c4=TopSecret
s0:c1,c3,c4=CompanySecrets

With translations turned off:
mount -t iso9660 /dev/cdrom /media/cdrom -o \
ro,context=system_u:object_r:iso9660_t:s0:c2,c3,c4,exec

The context option that will be interpreted by SeLinux is
context=system_u:object_r:iso9660_t:s0:c2

The options that will be passed on to the file system will be ro,c3,c4,exec.

If translations are turned on the context that will be interpreted for the
context, system_u:object_r:iso9660_t:Unclassified,Secret,TopSecret, will be
system_u:object_r:iso9660_t:Unclassified.

Proposed Solution:

The proposed solution is to allow/require the SeLinux context option specified
to mount to use escaped quotes when the context contains a comma.  The patches
that are included are for the kernel, util-linux, and nfs-utils.  They were
generated against the following Fedora rawhide rpms util-linux-2.13-0.36,
nfs-utils-1.0.9-3, and kernel-2.6.17-1.2528.

-- 
Cory Olmo

Trusted Computer Solutions
www.TrustedCS.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
