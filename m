Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA22575
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 20:07:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0L17LI07566
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 01:07:21 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
        by jazzband.ncsc.mil  with ESMTP id h0L17Kf07562 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 01:07:20 GMT
Date: Mon, 20 Jan 2003 20:07:18 -0500
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Cc: openafs-info@openafs.org
Subject: selinux afs domain v 0.2
Message-Id: <20030120200718.57f30b5f.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__20_Jan_2003_20:07:18_-0500_08b01b78"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart_Mon__20_Jan_2003_20:07:18_-0500_08b01b78
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


With thanks to Russell Coker, I've got an improved - doubtless still far
from perfect - policy for afs client operation.

I've attached from /etc/security/selinux/src/policy

domains/program/afsd.te          # the bulk of the policy
file_contexts/program/afsd.fc    # define the /usr/sbin/afsd type
types/afs.te                     # provide policy distinctions for /afs
                                 # and local / non-local domains

Additionally, note the following changes:

genfs_contexts                  # provides labeling to non-PSID filesystems

# afs
genfscon afs /                                   system_u:object_r:afs_t

# local afs files (httpd_t is not allowed outside this)
genfscon afs /afsdomain.org.dom                  system_u:object_r:afs_loc_t

# (e.g.) a place where trusted binaries might reside
genfscon afs /afsdomain.org.dom/usr/local/bin    system_u:object_r:afs_loc_tbin_t

-----

domains/program/mount.te                    #added:

allow mount_t kernel_t:process { sigkill };

# when /afs is unmounted I assume VFS is providing the magic for the kill to
# be sent to afsd. Would it be better (possible?) to limit this to only killing
# the afsd_t process?

-----


types/file.te:                              #afsd needs to write /usr/etc/openafs/AFSLog

# usr_etc_log_t is created primarily for afsd which
# wants to keep a log in /usr/etc/openafs

type usr_etc_log_t, file_type, sysadmfile;

------

Fixes vs. prior email.

usr_etc_log_t type removes error allowing afsd write-permission to most of /etc

Having corrected the policy (using every_domain() macro) the incorrect initrc.te 
hack is now fixed. 

Added exemplar site-specific types and policy enforcements for local and remote
afs data.


Next steps:

1.  Running volume location and fileserver under the selinux kernel.

The creation of the .../security directory and the included inode index files 
has a fairly high chance of breaking the fileserver volume operation.

Afs volume partitions on linux are in ext2fs but must never be treated
as regular filesystems, and fsck will destroy the volume data.

2.  Possible generation of a policy for AFS tokens stored in kernel memory.

Currently all selinux roles will have the same access to the afs tokens. This
is workable but providing a TE policy might be useful.

--Multipart_Mon__20_Jan_2003_20:07:18_-0500_08b01b78
Content-Type: application/octet-stream;
 name="afsd.te"
Content-Disposition: attachment;
 filename="afsd.te"
Content-Transfer-Encoding: base64

IyBEb21haW4gZm9yIGFmc2QgZXhlY3V0YWJsZQojCiMgQXV0aG9yOiAgRm9ycmVzdCBXaGl0Y2hl
ciA8ZndAZndzeXN0ZW1zLmNvbT4KIwojIENvcHlyaWdodCAyMDAyLCAyMDAzIEZXIFN5c3RlbXMg
bGxjCiMgQWxsIFJpZ2h0cyBSZXNlcnZlZC4KIwoKdHlwZSBhZnNkX3QsIGRvbWFpbiwgcHJpdmxv
ZzsKCnJvbGUgc3lzdGVtX3IgdHlwZXMgYWZzZF90OwpldmVyeV9kb21haW4oYWZzZF90KQoKdHlw
ZSBhZnNkX2V4ZWNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLGV4ZWNfdHlwZTsKCmRvbWFpbl9h
dXRvX3RyYW5zKGluaXRyY190LCBhZnNkX2V4ZWNfdCwgYWZzZF90KQoKYWxsb3cgYWZzZF90IHJv
b3RfdDpkaXIgbW91bnRvbjsKYWxsb3cgYWZzZF90IGFmc190OmZpbGVzeXN0ZW0geyBtb3VudCB9
OwphbGxvdyBhZnNkX3Qga2VybmVsX3Q6cHJvY2VzcyB7IHNpZ2tpbGwgfTsKCmFsbG93IGtlcm5l
bF90IGFmc2RfdDp1ZHBfc29ja2V0IHsgcmVhZCB3cml0ZSB9OwoKYWxsb3cgYWZzZF90IGFmc2Rf
dDpjYXBhYmlsaXR5IHsgc3lzX2FkbWluIHN5c19uaWNlIH07CmFsbG93IGFmc2RfdCBhZnNkX3Q6
cHJvY2VzcyB7IGZvcmsgc2V0c2NoZWQgfTsKYWxsb3cgYWZzZF90IGFmc2RfdDp1ZHBfc29ja2V0
IHsgY3JlYXRlIGlvY3RsIHdyaXRlIH07CmFsbG93IGFmc2RfdCBhbnlfc29ja2V0X3Q6dWRwX3Nv
Y2tldCB7IHNlbmR0byB9OwphbGxvdyBhZnNkX3QgZXRjX3J1bnRpbWVfdDpmaWxlIHsgYXBwZW5k
IGdldGF0dHIgcmVhZCB9OwphbGxvdyBhZnNkX3QgZXRjX3Q6ZGlyIHsgc2VhcmNoIH07CgphbGxv
dyBhZnNkX3QgZXRjX3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9OwphbGxvdyBhZnNkX3QgdXNyX2V0
Y19sb2dfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIHdyaXRlIH07CgphbGxvdyBhZnNkX3QgZnNfdDpm
aWxlc3lzdGVtIHsgZ2V0YXR0ciB9OwphbGxvdyBhZnNkX3QgbGRfc29fY2FjaGVfdDpmaWxlIHsg
Z2V0YXR0ciByZWFkIH07CmFsbG93IGFmc2RfdCBsaWJfdDpkaXIgeyBzZWFyY2ggfTsKYWxsb3cg
YWZzZF90IG5ldGlmX2V0aDBfdDpuZXRpZiB7IHVkcF9zZW5kIH07CmFsbG93IGFmc2RfdCBuZXRt
c2dfZXRoMF90OnVkcF9zb2NrZXQgeyByZWN2ZnJvbSB9OwoKYWxsb3cgYWZzZF90IG5ld3JvbGVf
dDpmZCB7IHVzZSB9OwoKYWxsb3cgYWZzZF90IG5vZGVfdDpub2RlIHsgdWRwX3NlbmQgfTsKYWxs
b3cgYWZzZF90IHJvb3RfdDpkaXIgeyBzZWFyY2ggfTsKYWxsb3cgYWZzZF90IHNobGliX3Q6Zmls
ZSB7IGV4ZWN1dGUgZ2V0YXR0ciByZWFkIH07CmFsbG93IGFmc2RfdCBzaGxpYl90Omxua19maWxl
IHsgcmVhZCB9OwphbGxvdyBhZnNkX3Qgc3lzYWRtX3R0eV9kZXZpY2VfdDpjaHJfZmlsZSB7IGdl
dGF0dHIgaW9jdGwgcmVhZCB3cml0ZSB9OwphbGxvdyBhZnNkX3Qgc3lzYWRtX3RtcF90OmRpciB7
IGNyZWF0ZSBzZXRhdHRyIGdldGF0dHIgcmVhZCBzZWFyY2ggfTsKYWxsb3cgYWZzZF90IHN5c2Fk
bV90bXBfdDpmaWxlIHsgY3JlYXRlIH07CgphbGxvdyBhZnNkX3QgdG1wX3Q6ZGlyIHsgc2VhcmNo
IH07CmFsbG93IGFmc2RfdCB1c3JfdDpkaXIgeyBzZWFyY2ggfTsKCgojCiMgcmVxdWlyZWQgdG8g
Z2l2ZSBhbnkgYWNjZXNzIHRvIHVzZXJzCiMKCmFsbG93IHN5c2FkbV90IGFmc2RfdDp1ZHBfc29j
a2V0IHsgd3JpdGUgfTsKYWxsb3cgdXNlcl90IGFmc2RfdDp1ZHBfc29ja2V0IHsgd3JpdGUgfTsK
YWxsb3cgaHR0cGRfdCBhZnNkX3Q6dWRwX3NvY2tldCB7IHdyaXRlIH07CgojCiMgcmVxdWlyZWQg
Zm9yIGZ1bGwgY2xpZW50IGFjY2VzcwojCgphbGxvdyB1c2VyX3QgYWZzX3Q6ZGlyIHsgZ2V0YXR0
ciBzZWFyY2ggcmVhZCB3cml0ZX07CmFsbG93IHVzZXJfdCBhZnNfdDpmaWxlIHsgcmVhZCB3cml0
ZSBzZXRhdHRyIGdldGF0dHIgZXhlY3V0ZSBleGVjdXRlX25vX3RyYW5zIH07CmFsbG93IHVzZXJf
dCBhZnNfdDpsbmtfZmlsZSB7IHJlYWQgd3JpdGUgc2V0YXR0ciBnZXRhdHRyIH07CmFsbG93IHVz
ZXJfdCBhZnNfdDp1ZHBfc29ja2V0IHsgcmVhZCB3cml0ZSB9OwogCmFsbG93IHVzZXJfdCBhZnNf
bG9jX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggcmVhZCB3cml0ZX07CmFsbG93IHVzZXJfdCBhZnNf
bG9jX3Q6ZmlsZSB7IHJlYWQgd3JpdGUgc2V0YXR0ciBnZXRhdHRyIGV4ZWN1dGUgZXhlY3V0ZV9u
b190cmFucyB9OwphbGxvdyB1c2VyX3QgYWZzX2xvY190Omxua19maWxlIHsgcmVhZCB3cml0ZSBz
ZXRhdHRyIGdldGF0dHIgfTsKYWxsb3cgdXNlcl90IGFmc19sb2NfdDp1ZHBfc29ja2V0IHsgcmVh
ZCB3cml0ZSB9OwoKYWxsb3cgdXNlcl90IGFmc19sb2NfdGJpbl90OmRpciB7IGdldGF0dHIgc2Vh
cmNoIHJlYWQgd3JpdGV9OwphbGxvdyB1c2VyX3QgYWZzX2xvY190YmluX3Q6ZmlsZSB7IHJlYWQg
d3JpdGUgc2V0YXR0ciBnZXRhdHRyIGV4ZWN1dGUgZXhlY3V0ZV9ub190cmFucyB9OwphbGxvdyB1
c2VyX3QgYWZzX2xvY190YmluX3Q6bG5rX2ZpbGUgeyByZWFkIHdyaXRlIHNldGF0dHIgZ2V0YXR0
ciB9OwphbGxvdyB1c2VyX3QgYWZzX2xvY190YmluX3Q6dWRwX3NvY2tldCB7IHJlYWQgd3JpdGUg
fTsKCmFsbG93IGh0dHBkX3QgYWZzX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggcmVhZCB9OwphbGxv
dyBodHRwZF90IGFmc190Omxua19maWxlIHsgcmVhZCB3cml0ZSBzZXRhdHRyIGdldGF0dHIgfTsK
YWxsb3cgaHR0cGRfdCBhZnNfdDp1ZHBfc29ja2V0IHsgcmVhZCB3cml0ZSB9OwoKYWxsb3cgaHR0
cGRfdCBhZnNfbG9jX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggcmVhZCB3cml0ZX07CmFsbG93IGh0
dHBkX3QgYWZzX2xvY190OmZpbGUgeyByZWFkIHdyaXRlIHNldGF0dHIgZ2V0YXR0ciBleGVjdXRl
IGV4ZWN1dGVfbm9fdHJhbnMgfTsKYWxsb3cgaHR0cGRfdCBhZnNfbG9jX3Q6bG5rX2ZpbGUgeyBy
ZWFkIHdyaXRlIHNldGF0dHIgZ2V0YXR0ciB9OwphbGxvdyBodHRwZF90IGFmc19sb2NfdDp1ZHBf
c29ja2V0IHsgcmVhZCB3cml0ZSB9OwoKYWxsb3cgc3lzYWRtX3QgYWZzX3Q6ZGlyIHsgZ2V0YXR0
ciBzZWFyY2ggcmVhZCB9OwphbGxvdyBzeXNhZG1fdCBhZnNfdDpsbmtfZmlsZSB7IHJlYWQgd3Jp
dGUgc2V0YXR0ciBnZXRhdHRyIH07CmFsbG93IHN5c2FkbV90IGFmc190OnVkcF9zb2NrZXQgeyBy
ZWFkIHdyaXRlIH07CgphbGxvdyBzeXNhZG1fdCBhZnNfbG9jX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFy
Y2ggcmVhZCB3cml0ZX07CmFsbG93IHN5c2FkbV90IGFmc19sb2NfdDpmaWxlIHsgcmVhZCB3cml0
ZSBzZXRhdHRyIGdldGF0dHIgfTsKYWxsb3cgc3lzYWRtX3QgYWZzX2xvY190Omxua19maWxlIHsg
cmVhZCB3cml0ZSBzZXRhdHRyIGdldGF0dHIgfTsKYWxsb3cgc3lzYWRtX3QgYWZzX2xvY190OnVk
cF9zb2NrZXQgeyByZWFkIHdyaXRlIH07CmFsbG93IHN5c2FkbV90IGFmc19sb2NfdGJpbl90OmZp
bGUgeyBleGVjdXRlIGV4ZWN1dGVfbm9fdHJhbnMgfTsKCg==

--Multipart_Mon__20_Jan_2003_20:07:18_-0500_08b01b78
Content-Type: application/octet-stream;
 name="afsd.fc"
Content-Disposition: attachment;
 filename="afsd.fc"
Content-Transfer-Encoding: base64

IyBhZnNkCi91c3Ivc2Jpbi9hZnNkICAgICAgICAgICAgc3lzdGVtX3U6b2JqZWN0X3I6YWZzZF9l
eGVjX3QK

--Multipart_Mon__20_Jan_2003_20:07:18_-0500_08b01b78
Content-Type: application/octet-stream;
 name="afs.te"
Content-Disposition: attachment;
 filename="afs.te"
Content-Transfer-Encoding: base64

IwojIEF1dGhvcjogIEZvcnJlc3QgV2hpdGNoZXIgPGZ3QGZ3c3lzdGVtcy5jb20+CiMKCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIGFmcyB0eXBlcwojIGNv
cGllZCBzbGF2aXNobHkgZnJvbSBuZnMudGUKIwp0eXBlIGFmc190LCBmc190eXBlLCByb290X2Rp
cl90eXBlOwp0eXBlIGFmc19sb2NfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwp0eXBlIGFmc19s
b2NfdGJpbl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CgojCiMgQWxsb3cgQUZTIGZpbGVzIHRv
IGJlIGFzc29jaWF0ZWQgd2l0aCBhbiBBRlMgZmlsZSBzeXN0ZW0uCiMKCmFsbG93IGFmc190IGFm
c190OmZpbGVzeXN0ZW0gYXNzb2NpYXRlOwphbGxvdyBhZnNfbG9jX3QgYWZzX3Q6ZmlsZXN5c3Rl
bSBhc3NvY2lhdGU7CmFsbG93IGFmc19sb2NfdGJpbl90IGFmc190OmZpbGVzeXN0ZW0gYXNzb2Np
YXRlOwoK

--Multipart_Mon__20_Jan_2003_20:07:18_-0500_08b01b78--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
