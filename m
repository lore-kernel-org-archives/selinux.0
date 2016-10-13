Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9DIxZLW007815
 for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2016 14:59:35 -0400
From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: read_spec_entry question
Date: Thu, 13 Oct 2016 18:59:32 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD17F46@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Should read_spec_entry every return 0 and not have found in entry?

It currently only allocates the entry argument if processing the line occurred in
A way where it found a valid string. It states that on success, it returns 0 and *entry
Is allocated, but it seems that its possible that len is 0 and *entry is never allocated
But it still returns 0.

What should the behavior be?

/*
 * Read an entry from a spec file (e.g. file_contexts)
 * entry - Buffer to allocate for the entry.
 * ptr - current location of the line to be processed.
 * returns  - 0 on success and *entry is set to be a null
 *            terminated value. On Error it returns -1 and
 *            errno will be set.
 *
 */
static inline int read_spec_entry(qstr **entry, char **ptr, const char **errbuf)
