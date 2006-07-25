Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PJPQPM030157
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:25:26 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6PJPOJ2013577
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 19:25:25 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k6PJPOKf011331
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:25:24 -0400 (EDT)
Date: Tue, 25 Jul 2006 14:25:13 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: Context mounts and unsupported context strings
Message-Id: <20060725142513.9ee1efc3.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I recently ran into a problem with mounting file systems for particular
context strings.  At this point we are still in the analysis phase so any
information or ideas would be appreciated.

The problem:

Attempt to mount a cdrom with the context option of
context=system_u:object_r:iso9660_t:s1:c0,c2,c4

The context will get interpreted as only
system_u:object_r:iso9660_t:s1:c0.  The reason is that the field separator
for the option field is ',', which is the same as that for categories. As a
result the rest of the context ends up being interpreted as additional
mount options that get passed on to the file system.

We've considered translation, escape characters, and quoting the entire
context string.  So far the most feasible appear to be either escaping or
quoting the entire context string.


-- 
Cory Olmo
Trusted Computer Solutions
www.TrustedCS.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
