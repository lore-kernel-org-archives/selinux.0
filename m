Date: Thu, 28 Sep 2006 08:20:18 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com, jmorris@namei.org,
        chanson@TrustedCS.com, dgoeddel@TrustedCS.com, kzak@redhat.com
Subject: [Patch 0/3] Support context mount options that contain commas
Message-Id: <20060928082018.67dc0473.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set corrects the collision which is occurring between commas 
in contexts and the comma delimiter between option values for mount.

If the context option specified to mount contains a comma then the 
value of the context option will be improperly broken up.

Example:

Using an MCS translation setup with these entries.

s0:c1=PatientRecord
s0:c2=Unclassified
s0:c3=Secret
s0:c4=TopSecret
s0:c1,c3,c4=CompanySecrets

With translations turned off:
mount -t iso9660 /dev/cdrom /media/cdrom -o \
ro,context=system_u:object_r:iso9660_t:s0:c1,c3,c4,exec

The context option that will be interpreted by SELinux is
context=system_u:object_r:iso9660_t:s0:c1

The options that will be passed on to the file system will be 
ro,c3,c4,exec.

If translations are turned on the context that will be interpreted for
system_u:object_r:iso9660_t:CompanySecrets, will be
system_u:object_r:iso9660_t:PatientRecord.

The proposed solution is to allow/require the SELinux context option 
specified to mount to use quotes when the context contains a comma.  The 
patches that are included are for the kernel, util-linux, and nfs-utils.  
They were generated against the Fedora rawhide rpms util-linux-2.13-0.42,
nfs-utils-1.0.9-7, and kernel-2.6.18-1.2693.

Testing was performed on FC6 test3 system.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
