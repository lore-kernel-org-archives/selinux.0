Message-ID: <a5e2b64d0812301805m706463b7o3aae6ab45502d32f@mail.gmail.com>
Date: Wed, 31 Dec 2008 11:05:25 +0900
From: Tim <timasyk@gmail.com>
To: "SELinux mailing list" <SELinux@tycho.nsa.gov>
Subject: Reference policy: fc_sort bug (or feature?)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While crafting reference policy to adjust it to my needs, I've
discovered a bug (or feature?) in fc_sort executable used to sort file
with files contexts.

Discovered behaviour (refpolicy 20080702):
1) If input file to fc_sort contains no files contexts definitions,
e.g. only comments starting with #, the fc_sort terminates with
Segmentation fault, core is dumped.
2) If input file to fc_sort contains only one files context
definition, the fc_sort terminates with Segmentation fault, core is
dumped.
3) fc_sort is working file if input file contains at least two files
contexts definitions.

Is there any patch available to fix that bug (or feature)?

Tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
