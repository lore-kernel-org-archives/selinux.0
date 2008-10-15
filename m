Date: Wed, 15 Oct 2008 01:50:36 +0000 (GMT)
From: korkishko Tymur <k.tymur@samsung.com>
Subject: Genfscon and cramfs issue
To: SELinux@tycho.nsa.gov, k.tymur@samsung.com
Reply-to: k.tymur@samsung.com
Message-id: <26901264.215431224035436346.JavaMail.weblogic@epml03>
MIME-version: 1.0
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have discovered an issue with using genfscon for labeling cramfs filesystem.

I have Linux kernel 2.6.26 with a patch from NSA that allows genfscon support of security contexts for directories/files (others than/ ). 
I use genfscon to label files/directories on cramfsfilesystem(read-only filesystem) that does not support xattr.  

Cramfs filesystem has following behavior: for two files with different names but with the same file content it assigns single inode.  
Example:
genfscon cramfs /usr/file_one       user_u:system_r:file_one_t
genfscon cramfs /usr/file_two       user_u:system_r:file_two_t 

file-one and file-two have the same content (e.g. Hello world).
file-one and file-two share the same inode on cramfs. 

As a result, two files might have the _same_ security context  - either ...:file_one_t or ...:file_two_t.
If file  /usr/file_one is accessed first, user_u:system_r:file_one_t is used for both files.
If file  /usr/file_two is accessed first, user_u:system_r:file_two_t is used for both files. 

Any ideas how to fix/deal with that issue are welcomed. 

---
Tymur Korkishko
Samsung Electronics


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
