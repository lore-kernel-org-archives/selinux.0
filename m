Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAC1o8uN020562
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 20:50:08 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAC1mNo2000106
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2008 01:48:23 GMT
Message-ID: <491A3631.8080806@redhat.com>
Date: Wed, 12 Nov 2008 11:49:37 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: user guide drafts: "Linux Permissions" and "Manual Pages for Services"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following are drafts for the "Fixing Problems"[1] section. Any 
comments and corrections are appreciated.

Linux Permissions

When access is denied, check standard Linux permissions. As mentioned in 
Chapter 2, Introduction, most operating systems use a Discretionary 
Access Control (DAC) system to control access, allowing users to control 
the permissions of files that they own. SELinux policy rules are checked 
after DAC rules. SELinux policy rules are not used if DAC rules deny 
access first.

If access is denied and no SELinux denials are logged, use the ls -l 
command to view the standard Linux permissions:

[example output]

In this example, index.html is owned by the root user and group. The 
root user has read and write permissions (-rw), and members of the root 
group have read permissions (-r-). Everyone else has no access (---). By 
default, such permissions do not allow httpd to read this file. To 
resolve this issue, use the chown command to change the owner and group. 
This command must be run as the Linux root user:

# chown apache:apache /var/www/html/index.html

This assumes the default configuration, in which httpd runs as the Linux 
apache user. If you run httpd with a different user, replace 
apache:apache with that user.

Refer to the Fedora Documentation Project "Permissions"[2] draft for 
information about managing Linux permissions.

Manual Pages for Services

Manual pages for services contain valuable information, such as what 
file type to use for a given situation, and Booleans to change the 
access a service has (such as httpd accessing NFS file systems). This 
information may be in the standard manual page, or a manual page with 
selinux prepended or appended.

For example, the httpd_selinux(8) manual page has information about what 
file type to use for a given situation, as well as Booleans to allow 
scripts, sharing files, accessing directories inside user home 
directories, and so on. Other manual pages with SELinux information for 
services include:

* Samba: the samba_selinux(8) manual page describes that files and 
directories to be exported via Samba must be labeled with the 
samba_share_t type, as well as Booleans to allow files labeled with 
types other than samba_share_t to be exported via Samba.

* NFS: the nfs_selinux(8) manual page describes that, by default, file 
systems can not be exported via NFS, and that to allow file systems to 
be exported, Booleans such as nfs_export_all_ro or nfs_export_all_rw 
must be turned on.

* Berkeley Internet Name Domain (BIND): the named(8) manual page 
describes what file type to use for a given situation (see the Red Hat 
SELinux BIND Security Profile section). The named_selinux(8) manual page 
describes that, by default, named can not write to master zone files, 
and to allow such access, the named_write_master_zones Boolean must be 
turned on.

The information in manual pages helps you configure the correct file 
types and Booleans, helping to prevent SELinux from denying access.

Cheers.

[1] 7.3. Fixing Problems

     7.3.1. Linux Permissions
     7.3.2. Manual Pages for Services
     7.3.3. Permissive Domains
     7.3.4. Searching For and Viewing Denials
     7.3.5. Raw Audit Messages
     7.3.6. sealert Messages
     7.3.7. audit2allow
(I have not sent Permissive Domains or audit2allow to the list yet)

[2] 
<http://fedoraproject.org/wiki/Docs/Drafts/AdministrationGuide/Permissions>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
