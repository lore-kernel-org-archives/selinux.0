Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9LDAoNs013028
	for <selinux@tycho.nsa.gov>; Fri, 21 Oct 2005 09:10:50 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9LD7jC7017272
	for <selinux@tycho.nsa.gov>; Fri, 21 Oct 2005 13:07:45 GMT
Date: Fri, 21 Oct 2005 09:07:25 -0400
Subject: [RFC} sectioned package format
From: Chad Sellers <csellers@tresys.com>
To: <selinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Message-ID: <BF7E604D.7836%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, module package files store policy modules and their corresponding
file_contexts in a format that is not extensible.  Eventually, we would like
to be able to add other components to the package (e.g. default_contexts),
or modify the package file format.  This was discussed on
fedora-selinux-list a few days ago.  To accomplish this, we are proposing
the following simple module package file format.

Policy Package Header
The package begins with the package header.  This contains the following
fields:

uint32_t magic_number;
uint32_t package_file_version;
uint32_t num_sections;
uint32_t section_offset;
... 

uint32_t is a 4-byte datum stored in little-endian format.  magic_number
identifies the file as a module package, and has a value of 0xf97c668f.
package_file_version identifies the version of the package file, and this
first version will be 1.  num_sections gives the total number of sections in
this file, which is also the number of section_offset entries that follow.
section_offset identifies the offset in bytes from the beginning of the file
to the beginning of the section.  These sections are always listed in
sequence, so the length of a given section is the difference between its
offset and the following offset, except the final section which ends with
the end of the file.

Sections
Sections are generic areas for data from the package perspective.  They are
identified by a magic number at the beginning of the section, just as
current policy modules begin with a magic number.  We will add a magic
number to the top of the file_contexts section as well to identify it.
Different kinds of sections can be added later simply by assigning them a
new magic number.

Please let us know what you think of this format, and if you see any
problems with it.

Thanks,
Chad Sellers

----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
