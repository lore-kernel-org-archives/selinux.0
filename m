Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01222
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2001 09:56:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA06679
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2001 13:54:57 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA06675
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2001 13:54:56 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id JAA02068
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2001 09:55:09 -0400 (EDT)
Date: Fri, 31 Aug 2001 09:55:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Performance fix for inode-to-PSID mapping
Message-ID: <Pine.SOL.3.95.1010831092717.28272I-200000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-33463914-999266109=:28272"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-33463914-999266109=:28272
Content-Type: TEXT/PLAIN; charset=US-ASCII


I've attached a patch for selinux/module/selinux_plug/psid.c that fixes an
oversight that was causing significant performance degradation on file
creation and file relabeling operations.  To apply this patch, save it to
psid.patch, change to the selinux directory and run 'patch -p1 <
psid.patch'.  This patch will be included in the next release.

If you're not interested in the explanation for the patch, you can stop
reading this message now and just apply the patch.

First, some background for the patch, starting with some information
already provided in the selinux/CHANGES file.  Since LSM provides all of
its file-related hooks in the VFS layer and does not provide any
low-level filesystem-specific hooks, the SELinux persistent label mapping
was changed to maintain the inode-to-PSID mapping in a regular file rather
than using a spare field in the ext2 on-disk inode.  This change should
allow SELinux to support other file system types more easily, but has 
disadvantages in terms of performance and consistency.  This was 
the approach used in the Flask prototype, and it is also used by 
some other systems in order to avoid any dependency on the
particular file system type.  Naturally,  if support for extended
attributes becomes integrated into the mainstream Linux kernel, SELinux
will be modified to take advantage of it when possible.

The original SELinux persistent label mapping already maintained two
mapping files in each file system: the first file is indexed by PSID and
stores a (offset, length) pair into the second file, which stores
the actual security contexts.  Synchronous writes are used to update
these two files and the writes are ordered to ensure that there
are no dangling references to a context or to a PSID.  But these two files
are only updated when a new security context is first used for a file in a
file system, so such writes are rare after the initial labeling of the
file system.  Since the PSID was originally stored in the on-disk ext2
inode, updating the PSID in the on-disk inode was handled asynchronously
like any other update to the inode.

When the inode-to-PSID mapping file was added for the LSM-based prototype,
it also happened to be opened with O_SYNC like the other mapping files.
Consequently, updating the PSID for an inode suddenly required a
synchronous write.  Naturally, this makes the file creation and file
relabeling operations much more expensive.  The attached patch
simply changes the persistent labeling implementation to _not_ use 
O_SYNC for the inode-to-PSID mapping file.  Thus, updating the PSID
for an inode is once again asynchronous, although it is unfortunately
no longer coupled with updating the rest of the inode state.  Hopefully,
this will all be made moot once support for extended attributes becomes
mainstream.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-33463914-999266109=:28272
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="psid.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.95.1010831095509.28272J@clipper.gw.tislabs.com>
Content-Description: 

SW5kZXg6IHNlbGludXgvbW9kdWxlL3NlbGludXhfcGx1Zy9wc2lkLmMNCmRp
ZmYgLXUgc2VsaW51eC9tb2R1bGUvc2VsaW51eF9wbHVnL3BzaWQuYzoxLjcg
c2VsaW51eC9tb2R1bGUvc2VsaW51eF9wbHVnL3BzaWQuYzoxLjgNCi0tLSBz
ZWxpbnV4L21vZHVsZS9zZWxpbnV4X3BsdWcvcHNpZC5jOjEuNwlUdWUgQXVn
ICA3IDA5OjE3OjM0IDIwMDENCisrKyBzZWxpbnV4L21vZHVsZS9zZWxpbnV4
X3BsdWcvcHNpZC5jCUZyaSBBdWcgMzEgMDk6MDY6MzggMjAwMQ0KQEAgLTUw
Nyw3ICs1MDcsOSBAQA0KIA0KIAkJLyogIk9wZW4iIHRoZSBmaWxlIGFuZCBz
ZXQgaXQgZm9yIHN5bmNocm9ub3VzIHdyaXRlcyAqLw0KIAkJcmMgPSBpbml0
X3ByaXZhdGVfZmlsZSgmdC0+ZmlsZXNbaW5kZXhdLCBmaWxlLCAzKTsgDQot
CQl0LT5maWxlc1tpbmRleF0uZl9mbGFncyA9IE9fUkRXUiB8IE9fU1lOQzsN
CisJCXQtPmZpbGVzW2luZGV4XS5mX2ZsYWdzID0gT19SRFdSOw0KKwkJaWYg
KGluZGV4ID09IFBTRUNfQ09OVEVYVFMgfHwgaW5kZXggPT0gUFNFQ19JTkRF
WCkNCisJCQl0LT5maWxlc1tpbmRleF0uZl9mbGFncyB8PSBPX1NZTkM7DQog
CQlpZiAocmMpIHsJDQogCQkJcHJpbnRrKCJwc2lkZmlsZXNfaW5pdDogIGlu
aXRfcHJpdmF0ZV9maWxlIHJldHVybmVkICVkXG4iLCAtcmMpOw0KIAkJCWdv
dG8gYmFkX2ZpbGU7DQo=
---559023410-33463914-999266109=:28272--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
