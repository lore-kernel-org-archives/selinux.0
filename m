Message-ID: <472B8146.2060301@redhat.com>
Date: Fri, 02 Nov 2007 15:57:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to allow semanage to set boolean values and translate booleans
 via policy.xml
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Also added translations of booleans to command line.

> /usr/sbin/semanage boolean -l  | grep nfs_export
> nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
> nfs_export_all_ro              -> on    Allow nfs to be exported read only
> sh-3.2# /usr/sbin/semanage boolean -l  | grep nfs
> xen_use_nfs                    -> off   Allow xen to manage nfs files
> use_nfs_home_dirs              -> on    Support NFS home directories
> allow_ftpd_use_nfs             -> off   Allow ftp servers to use nfs used for public file transfer services.
> cdrecord_read_content          -> off   Allow cdrecord to read various content. nfs, samba, removable devices, user temp and untrusted content files
> httpd_use_nfs                  -> off   Allow httpd to read nfs files
> samba_share_nfs                -> off   Allow samba to export NFS volumes.
> mail_read_content              -> off   Allow email client to various content. nfs, samba, removable devices, user temp and untrusted content files
> allow_nfsd_anon_write          -> off   Allow nfs servers to modify public files used for public file transfer services.
> nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
> nfs_export_all_ro              -> on    Allow nfs to be exported read only
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHK4FGrlYvE4MpobMRAuCvAJ0e8yxBp8vXHBAVgOBhF4uINPKHsQCfQ7pU
q9Oau5klonoR9aUMYQw3A7k=
=DKZN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
