Message-ID: <490F780E.4020806@redhat.com>
Date: Mon, 03 Nov 2008 17:15:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dave Quigley <dpquigl@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: SELinux on NFS.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We really want to get SELinux labeled files on NFS into Fedora 11.  But
it seems to be getting bogged down in the standards process.  I think we
need to simplify.

All Fedora  needs for SELinux on NFS is the ability to store and enforce
file labels from the client side on the server.  This has to work with
full Unix authentication model (Trusted Host) as well as the full
kerberos authentication model.

I think we can treat the server side as a dumb server.  NFS servers
tends to fully trust the client to do the "right thing" on disk
partitions that the server shares.  Our first version of SELinux NFS
should do the same.  Getting bogged down in the server worrying about
which process on the client created a file/file_label is not something
that is necessary for the first version.  And probably not something
that is required for the vast majority of situations for the next few
years.  The servers will/should not have a requirement to run SELinux.

But labelled NFS on the client side has potential great benefits for us.
 Especially with work in svirt where we want to be able to share virtual
image files via NFS and have them isolated by SELinux.

How close are we to getting this functionality working and do you think
the upstream kernel would accept your changes to allow this?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkPeA4ACgkQrlYvE4MpobPo0gCeIRWkQ4BNwN5qGkekCL4bTpeX
6g0AoJ9wDiM46Rd/Yz96AyyaNBRL4Qbu
=SuLv
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
