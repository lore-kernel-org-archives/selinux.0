Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09LrQ3N023549
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 16:53:26 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
 (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s09LrOD1024917
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 16:53:24 -0500
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com
 [10.19.60.53])
 by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
 s09LrNYI029621
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 16:53:23 -0500
Message-ID: <52CF1A53.9080501@redhat.com>
Date: Thu, 09 Jan 2014 16:53:23 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Changing unlabeled_t on files to invalid_label_t.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We would like to change

sid file_labels         gen_context(system_u:object_r:unlabeled_t,s0)

to something like

sid file_labels         gen_context(system_u:object_r:invalid_label_t,s0)

Since explaining to someone that a file without a label is file_t, but if it
has a label that the kernel does not understand it is labeled as unlabeled_t.
A file with a label is unlabeled_t????  While a file without a label is file_t.


#
# unlabeled_t is the type of unlabeled objects.
# Objects that have no known labeling information or that
# have labels that are no longer valid are treated as having this type.
#

#
# file_t is the default type of a file that has not yet been
# assigned an extended attribute (EA) value (when using a filesystem
# that supports EAs).
#

These two type definitions seem to conflict, with file_t winning at least on
systems that support XAttrs.

I would guess a better fix would be to change the kernel to handle the case
where an object is unlabeled_t one way and if it is labeled and the kernel
does not understand the label differently.

sid invalid_file_labels gen_context(system_u:object_r:invalid_label_t,s0)

Opinions....

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLPGlMACgkQrlYvE4MpobOrDwCgwSduQpyqjGFni/0dksiv0I2j
uEAAn181YTHYYRj0XSern/+CPtuUp7Vu
=3HJ3
-----END PGP SIGNATURE-----
