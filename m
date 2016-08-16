From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: Fix AFL Found Bugs in libsepol v4
Date: Tue, 16 Aug 2016 10:28:30 -0700
Message-Id: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So the delta between v3 and v4 is addressing the comments
on "fix overflow and 0 length allocations", and also move that
patch to the end of the series. Take up to where you have
issues as each patch can stand on its own.

[PATCH v4 1/7] libsepol: fix invalid access of NULL on

[PATCH v4 2/7] libsepol: ensure key is valid before doing search

[PATCH v4 3/7] ebitmap: detect invalid bitmap

[PATCH v4 4/7] genfs_read: fix use heap-use-after-free

[PATCH v4 5/7] libsepol: bound attr_type_map access by nprim

[PATCH v4 6/7] libsepol: fix unitialized jmp and invalid dereference

[PATCH v4 7/7] libsepol: fix overflow and 0 length allocations
