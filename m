Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16586
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 08:21:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA26388
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 12:19:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA26384 for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 12:19:42 GMT
Date: Wed, 26 Jun 2002 08:20:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Boyne, Patrick J" <patrick.j.boyne@lmco.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Question
In-Reply-To: <91A6D3929D6BD4119B8C0008C7E665640C565E08@emss04m03.ems.lmco.com>
Message-ID: <Pine.GSO.4.33.0206260754180.322-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 25 Jun 2002, Boyne, Patrick J wrote:

> I have a question regarding importing and exporting data from a SELinux
> system via the floppy drive. If a user brings data into the system from a
> floppy disk with (as an example) a non-ext[2|3] filesystem, am I correct in
> thinking that the files will be labeled with the security context of the
> directory they are filed under? If the data was labeled on a disk with an
> ext2 filesystem are those labels preserved when it is copied or is the label
> altered? Or is this policy-dependent?

Ordinary users aren't authorized to mount filesystems or access unlabeled
data by the example policy configuration.

>From the perspective of the kernel, there is no such operation as a file
copy; it merely sees the creation of a new file, reading from the old
file, and writing to the new file.  The label of the new file is
determined at creation time.  The copying process can specify the label of
the new file using the extended system calls in order to preserve the
label of the original if desired, as is done by the SELinux-modified cp
program if you use the -p option to preserve attributes.  Otherwise, the
kernel will apply the standard logic to determine the new label, either
inheriting the type from the parent directory or using the type specified
in a type transition rule.

> I'm curious about the reverse cases too; that is, exporting data. I
> appreciate any help.

If you copy files to a filesystem on a floppy that does not support
labels, then you would naturally lose the labeling information.  Of
course, mounting and accessing such a filesystem is controlled by the
policy.  If you copy files to a labeled filesystem on a floppy, then the
same discussion above applies for determining the label of the new file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
