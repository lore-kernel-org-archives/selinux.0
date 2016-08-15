From: "Roberts, William C" <william.c.roberts@intel.com>
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov"
 <jwcart2@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
Subject: RE: Fix AFL Found Bugs in libsepol
Date: Mon, 15 Aug 2016 16:18:48 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601283EEE@ORSMSX103.amr.corp.intel.com>
References: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> william.c.roberts@intel.com
> Sent: Monday, August 15, 2016 8:59 AM
> To: selinux@tycho.nsa.gov; jwcart2@tycho.nsa.gov; seandroid-
> list@tycho.nsa.gov; sds@tycho.nsa.gov
> Subject: Fix AFL Found Bugs in libsepol
> 
> With the patches mentioned below, I have been able to run the AFL fuzzer for 3
> days without issue. I didn't get much feedback in v2 of the patchset, but these
> should address the issues in that series.

As well as fix a few more issues found along the way.

> 
> [PATCH v3 1/7] libsepol: fix invalid access of NULL on [PATCH v3 2/7] libsepol:
> ensure key is valid before doing search [PATCH v3 3/7] ebitmap: detect invalid
> bitmap [PATCH v3 4/7] genfs_read: fix use heap-use-after-free [PATCH v3 5/7]
> libsepol: fix overflow and 0 length allocations [PATCH v3 6/7] libsepol: bound
> attr_type_map access by nprim [PATCH v3 7/7] libsepol: fix unitialized jmp and
> invalid dereference
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
