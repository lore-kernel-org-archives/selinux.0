Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA12610
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 15:19:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA26609
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 20:16:47 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA26605
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 20:16:46 GMT
Date: Sun, 19 Jan 2003 15:19:29 -0500
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Cc: openafs-info@openafs.org
Subject: afs domain development under the selinux kernel
Message-Id: <20030119151929.747254b8.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__19_Jan_2003_15:19:29_-0500_097d11a8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart_Sun__19_Jan_2003_15:19:29_-0500_097d11a8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Summary:

The Selinux kernel provides type enforcement via data labeling for all data,
program and user objects on a server. This indludes persistent labels for 
filesystem-based data and kernel/policy derived labels for other data objects
such as /proc/*, shared memory, sockets, device files etc.

(Open)AFS provides a robust network filesystem with directory-based ACLs
authenticated against kerberos4 tickets, usually provided  by a krb5 kdc.
Many sites rely on AFS to distribute system binaries.


I've been working on OpenAFS client < selinux kernel for awhile now, and have 
got a first-draft policy working and currently under test. I'm not to sure of 
complete/correct-ness at this point but at least it seems to be working, and 
now I want to go in and make changes to either the kernel, the libafs kernel 
module or afsd to move the data in /afs/* into its own domain.

Openafs 1.2.8 introduced some structural changes in the afsd impelmentation
(which complicate the policy requirements).


General notes:

afsd (afs client) & kernel/module

tmpfs_t:* allow statements are specific because for the moment the afs
cache dir is being created in /tmp -- that's only a kludge because I 
hadn't created any other ext2fs and afsd won't run the cache on aything
else. Longterm the cachedir should probably have it's own type.

userspace client access

/afs/* is labeled of course as unlabeled_t, currently I'm using a
policy which allows user_r unrestricted access to this type. Better
solutions could involve having type enforcemnt check for valid afs
tickets and/or assigning a type to this data, however I'm not too 
sure what method might be appropriate for that.


Objective:

Presently allowing user_r access to files provided through afsd could
be extended to other limited roles such as system_u:system_r:httpd_t
with reasonable safety. Extending this to other roles would seem to be
somewhat more probelmatic.

Questions:

Where can I consider generating / enforcing an afs_t type for data
in /afs? This mostly is implemented over UDP port 7001. I think 
most things needed for the server parts are done, but I'm not certain
how much implementation could to be done mostly in the policy config,
and what things I need to modify to establish the type in either
the kernel module or the afsd process.

Next steps:

I will also be working on running the afs database and fileserver functions
under the selinux kernel. Because AFS volumes directly manipulate the inode
structures in ext2fs there may be some significant problems with hosting
an afs fileserver process under selinux.

SELinux will create a directory in every mounted filesystem named '...security' 
in the root of every filesystem which stores persistent SID:inode data.
I'm not certain whether the creation of ...security will cause problems
with a fs used as an afs partition.



Here's what I've changed so far (in /etc/security/selinux/src/policy/)



domains/program/initrc.te added:

allow run_init_t tmpfs_t:file { read write };

# however this is not sufficient to allow afsd to startup in enforcing mode
# so for now I'm starting afsd before toggling into enforcing




domains/program/mount.te added:

allow mount_t kernel_t:process { sigkill };

# when /afs is unmounted I assume VFS is providing the magic for the kill to
# be sent to afsd. Would it be better (possible?) to limit this to only killing
# the afsd_t process?



file_contexts/program/afsd.fc:

# afsd
/usr/sbin/afsd            system_u:object_r:afsd_exec_t




Most of the work is in:

domains/program/afsd.te (also attached to this email)

# Domain for afsd executable

#
# make afsd_exec_t

type afsd_exec_t, file_type, sysadmfile,exec_type;
type afsd_t, domain, privlog;

domain_auto_trans(initrc_t, afsd_exec_t, afsd_t)

allow afsd_t root_t:dir mounton;

allow kernel_t afsd_t:udp_socket { read write };

allow afsd_t afsd_t:capability { sys_admin sys_nice };
allow afsd_t afsd_t:process { fork setsched };
allow afsd_t afsd_t:udp_socket { create ioctl write };
allow afsd_t any_socket_t:udp_socket { sendto };
allow afsd_t etc_runtime_t:file { append getattr read };
allow afsd_t etc_t:dir { search };
allow afsd_t etc_t:file { getattr read write };
allow afsd_t fs_t:filesystem { getattr };
allow afsd_t ld_so_cache_t:file { getattr read };
allow afsd_t lib_t:dir { search };
allow afsd_t netif_eth0_t:netif { udp_send };
allow afsd_t netmsg_eth0_t:udp_socket { recvfrom };
allow afsd_t newrole_t:fd { use };
allow afsd_t node_t:node { udp_send };
allow afsd_t root_t:dir { search };
allow afsd_t shlib_t:file { execute getattr read };
allow afsd_t shlib_t:lnk_file { read };
allow afsd_t sysadm_tty_device_t:chr_file { getattr ioctl read write };
allow afsd_t sysadm_tmp_t:dir { create setattr getattr read search };
allow afsd_t sysadm_tmp_t:file { create };

allow afsd_t tmp_t:dir { search };
allow afsd_t unlabeled_t:filesystem { mount };
allow afsd_t usr_t:dir { search };


#
# required to give any access to users
#

allow sysadm_t afsd_t:udp_socket { write };
allow user_t afsd_t:udp_socket { write };


#
# required for full client access
#

allow kernel_t unlabeled_t:udp_socket { read write };

allow unlabeled_t any_socket_t:udp_socket { sendto };
allow unlabeled_t netif_eth0_t:netif { udp_send };
allow unlabeled_t node_t:node { udp_send };
allow unlabeled_t netmsg_eth0_t:udp_socket { recvfrom };
 
allow user_t unlabeled_t:dir { getattr search read write};
allow user_t unlabeled_t:file { read write setattr getattr execute execute_no_trans };
allow user_t unlabeled_t:lnk_file { read write setattr getattr };

allow user_t unlabeled_t:udp_socket { read write };




--Multipart_Sun__19_Jan_2003_15:19:29_-0500_097d11a8
Content-Type: application/octet-stream;
 name="afsd.te"
Content-Disposition: attachment;
 filename="afsd.te"
Content-Transfer-Encoding: base64

IyBEb21haW4gZm9yIGFmc2QgZXhlY3V0YWJsZQoKIwojIG1ha2UgYWZzZF9leGVjX3QKCnR5cGUg
YWZzZF9leGVjX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZSxleGVjX3R5cGU7CnR5cGUgYWZzZF90
LCBkb21haW4sIHByaXZsb2c7Cgpkb21haW5fYXV0b190cmFucyhpbml0cmNfdCwgYWZzZF9leGVj
X3QsIGFmc2RfdCkKCmFsbG93IGFmc2RfdCByb290X3Q6ZGlyIG1vdW50b247CgphbGxvdyBrZXJu
ZWxfdCBhZnNkX3Q6dWRwX3NvY2tldCB7IHJlYWQgd3JpdGUgfTsKCgoKYWxsb3cgYWZzZF90IGFm
c2RfdDpjYXBhYmlsaXR5IHsgc3lzX2FkbWluIHN5c19uaWNlIH07CmFsbG93IGFmc2RfdCBhZnNk
X3Q6cHJvY2VzcyB7IGZvcmsgc2V0c2NoZWQgfTsKYWxsb3cgYWZzZF90IGFmc2RfdDp1ZHBfc29j
a2V0IHsgY3JlYXRlIGlvY3RsIHdyaXRlIH07CmFsbG93IGFmc2RfdCBhbnlfc29ja2V0X3Q6dWRw
X3NvY2tldCB7IHNlbmR0byB9OwphbGxvdyBhZnNkX3QgZXRjX3J1bnRpbWVfdDpmaWxlIHsgYXBw
ZW5kIGdldGF0dHIgcmVhZCB9OwphbGxvdyBhZnNkX3QgZXRjX3Q6ZGlyIHsgc2VhcmNoIH07CmFs
bG93IGFmc2RfdCBldGNfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIHdyaXRlIH07CmFsbG93IGFmc2Rf
dCBmc190OmZpbGVzeXN0ZW0geyBnZXRhdHRyIH07CmFsbG93IGFmc2RfdCBsZF9zb19jYWNoZV90
OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKYWxsb3cgYWZzZF90IGxpYl90OmRpciB7IHNlYXJjaCB9
OwphbGxvdyBhZnNkX3QgbmV0aWZfZXRoMF90Om5ldGlmIHsgdWRwX3NlbmQgfTsKYWxsb3cgYWZz
ZF90IG5ldG1zZ19ldGgwX3Q6dWRwX3NvY2tldCB7IHJlY3Zmcm9tIH07CmFsbG93IGFmc2RfdCBu
ZXdyb2xlX3Q6ZmQgeyB1c2UgfTsKYWxsb3cgYWZzZF90IG5vZGVfdDpub2RlIHsgdWRwX3NlbmQg
fTsKYWxsb3cgYWZzZF90IHJvb3RfdDpkaXIgeyBzZWFyY2ggfTsKYWxsb3cgYWZzZF90IHNobGli
X3Q6ZmlsZSB7IGV4ZWN1dGUgZ2V0YXR0ciByZWFkIH07CmFsbG93IGFmc2RfdCBzaGxpYl90Omxu
a19maWxlIHsgcmVhZCB9OwphbGxvdyBhZnNkX3Qgc3lzYWRtX3R0eV9kZXZpY2VfdDpjaHJfZmls
ZSB7IGdldGF0dHIgaW9jdGwgcmVhZCB3cml0ZSB9OwphbGxvdyBhZnNkX3Qgc3lzYWRtX3RtcF90
OmRpciB7IGNyZWF0ZSBzZXRhdHRyIGdldGF0dHIgcmVhZCBzZWFyY2ggfTsKYWxsb3cgYWZzZF90
IHN5c2FkbV90bXBfdDpmaWxlIHsgY3JlYXRlIH07CgphbGxvdyBhZnNkX3QgdG1wX3Q6ZGlyIHsg
c2VhcmNoIH07CmFsbG93IGFmc2RfdCB1bmxhYmVsZWRfdDpmaWxlc3lzdGVtIHsgbW91bnQgfTsK
YWxsb3cgYWZzZF90IHVzcl90OmRpciB7IHNlYXJjaCB9OwoKCiMKIyByZXF1aXJlZCB0byBnaXZl
IGFueSBhY2Nlc3MgdG8gdXNlcnMKIwoKYWxsb3cgc3lzYWRtX3QgYWZzZF90OnVkcF9zb2NrZXQg
eyB3cml0ZSB9OwphbGxvdyB1c2VyX3QgYWZzZF90OnVkcF9zb2NrZXQgeyB3cml0ZSB9OwoKCiMK
IyByZXF1aXJlZCBmb3IgZnVsbCBjbGllbnQgYWNjZXNzCiMKCmFsbG93IGtlcm5lbF90IHVubGFi
ZWxlZF90OnVkcF9zb2NrZXQgeyByZWFkIHdyaXRlIH07CgphbGxvdyB1bmxhYmVsZWRfdCBhbnlf
c29ja2V0X3Q6dWRwX3NvY2tldCB7IHNlbmR0byB9OwphbGxvdyB1bmxhYmVsZWRfdCBuZXRpZl9l
dGgwX3Q6bmV0aWYgeyB1ZHBfc2VuZCB9OwphbGxvdyB1bmxhYmVsZWRfdCBub2RlX3Q6bm9kZSB7
IHVkcF9zZW5kIH07CmFsbG93IHVubGFiZWxlZF90IG5ldG1zZ19ldGgwX3Q6dWRwX3NvY2tldCB7
IHJlY3Zmcm9tIH07CiAKYWxsb3cgdXNlcl90IHVubGFiZWxlZF90OmRpciB7IGdldGF0dHIgc2Vh
cmNoIHJlYWQgd3JpdGV9OwphbGxvdyB1c2VyX3QgdW5sYWJlbGVkX3Q6ZmlsZSB7IHJlYWQgd3Jp
dGUgc2V0YXR0ciBnZXRhdHRyIGV4ZWN1dGUgZXhlY3V0ZV9ub190cmFucyB9OwphbGxvdyB1c2Vy
X3QgdW5sYWJlbGVkX3Q6bG5rX2ZpbGUgeyByZWFkIHdyaXRlIHNldGF0dHIgZ2V0YXR0ciB9OwoK
YWxsb3cgdXNlcl90IHVubGFiZWxlZF90OnVkcF9zb2NrZXQgeyByZWFkIHdyaXRlIH07Cg==

--Multipart_Sun__19_Jan_2003_15:19:29_-0500_097d11a8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
