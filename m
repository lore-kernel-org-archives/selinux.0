Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3G70b7C002245
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 03:00:38 -0400 (EDT)
Received: from mail-old.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3G6rjOQ028849
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 06:53:49 GMT
Received: from mailr2.asahi-net.or.jp (mailr2.asahi-net.or.jp [202.224.39.212])
	by mail-old.asahi-net.or.jp (Postfix) with ESMTP id DF3E45CDB
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 15:56:23 +0900 (JST)
Received: from ayu.kaigai.gr.jp (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by mailr2.asahi-net.or.jp (8.11.7/3.7W) with ESMTP id j3G6uNu07217
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 15:56:23 +0900 (JST)
Received: from [127.0.0.1] (sake.kaigai.gr.jp [192.168.1.32])
	by ayu.kaigai.gr.jp (Postfix) with ESMTP id 2DFAFCD01AE
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 16:19:41 -0400 (EDT)
Message-ID: <4260B74B.3000002@kaigai.gr.jp>
Date: Sat, 16 Apr 2005 15:57:15 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>
Subject: [POLICY/PATCH] IA-64 Boot Partition
Content-Type: multipart/mixed;
 boundary="------------080808040001010602030406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080808040001010602030406
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

This attached patch modifies genfs_contexts.
When arch_ia64 is defined in tunable/tunable.tun,
vfat is labeled as boot_t, not dosfs_t.

Currently, vfat-fs is recognized as dosfs_t.
But, vfat is often used as bootable partition
which should be labeled as boot_t.

In IA-64 Linux, any files related to booting process such as
vmlinuz and initrd.img are placed under /boot/efi/.
We must mount a vfat partition contains such files on /boot/efi,
because EFI can't recognize the contents of Ext2/3 partitions.
(EFI is a firmware similar to PC's BIOS.)
# The kernel provided by RedHat is placed in /boot/efi/efi/redhat.

Thanks,
--
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------080808040001010602030406
Content-Type: text/plain;
 name="policy-1.22_IA64_BootPartition.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="policy-1.22_IA64_BootPartition.patch"

LS0tIHBvbGljeS0xLjIyL2dlbmZzX2NvbnRleHRzCTIwMDUtMDEtMjQgMTQ6MDA6NDEuMDAw
MDAwMDAwIC0wNTAwCisrKyBwb2xpY3ktMS4yMi1pYTY0L2dlbmZzX2NvbnRleHRzCTIwMDUt
MDQtMTYgMTU6NTU6NTEuMDAwMDAwMDAwIC0wNDAwCkBAIC03Nyw3ICs3Nyw5IEBACiBnZW5m
c2NvbiByYW1mcyAvCQkJc3lzdGVtX3U6b2JqZWN0X3I6cmFtZnNfdAogCiAjIHZmYXQsIG1z
ZG9zCi1nZW5mc2NvbiB2ZmF0IC8JCQkJc3lzdGVtX3U6b2JqZWN0X3I6ZG9zZnNfdAoraWZk
ZWYoYGFyY2hfaWE2NCcsCitgZ2VuZnNjb24gdmZhdCAvCQkJCXN5c3RlbV91Om9iamVjdF9y
OmJvb3RfdCcsCitgZ2VuZnNjb24gdmZhdCAvCQkJCXN5c3RlbV91Om9iamVjdF9yOmRvc2Zz
X3QnKQogZ2VuZnNjb24gbXNkb3MgLwkJCXN5c3RlbV91Om9iamVjdF9yOmRvc2ZzX3QKIGdl
bmZzY29uIGZhdCAvCQkJCXN5c3RlbV91Om9iamVjdF9yOmRvc2ZzX3QKIGdlbmZzY29uIG50
ZnMgLwkJCQlzeXN0ZW1fdTpvYmplY3Rfcjpkb3Nmc190Ci0tLSBwb2xpY3ktMS4yMi90dW5h
Ymxlcy90dW5hYmxlLnR1bgkyMDA0LTEyLTEwIDE0OjU3OjM2LjAwMDAwMDAwMCAtMDUwMAor
KysgcG9saWN5LTEuMjItaWE2NC90dW5hYmxlcy90dW5hYmxlLnR1bgkyMDA1LTA0LTE2IDE1
OjU1OjE2LjAwMDAwMDAwMCAtMDQwMApAQCAtMjksMyArMjksNiBAQAogCiAjIGZvciBuZGNf
dCB0byBiZSB1c2VkIGZvciByZXN0YXJ0IHNoZWxsIHNjcmlwdHMKIGRubCBkZWZpbmUoYG5k
Y19zaGVsbF9zY3JpcHQnKQorCisjIGZvciBJQS02NCBhcmNodGVjdHVyZQorZG5sIGRlZmlu
ZShgYXJjaF9pYTY0JykK
--------------080808040001010602030406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
