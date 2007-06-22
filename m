Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5MFVUi3011844
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 11:31:30 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5MFVTIG008175
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 15:31:29 GMT
Subject: Re: backups in fedora
From: James Antill <jantill@redhat.com>
To: david carvalho <david@di.ubi.pt>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <078701c7b4dd$009d7640$fd01000a@ubi.pt>
References: <078701c7b4dd$009d7640$fd01000a@ubi.pt>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WADzqAmssW9SxkQlaV4j"
Date: Fri, 22 Jun 2007 11:31:02 -0400
Message-Id: <1182526262.31779.64.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WADzqAmssW9SxkQlaV4j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-22 at 15:52 +0100, david carvalho wrote:
> Hi !
> after I run a few tests, I've verified that "dump" can backup/restore
> files
> with selinu attributes. Later "tar" versions seem to do this also, but
> when I extract
> a tar archive with "--xattr" or "--selinux", the attributes aren't
> there.
> So there are 2 options. Or they aren't been created whith these
> attributes, or it's
> on the extraction stage.
> Could you please provide me a simple example of tar creation and
> extraction for=20
> selinux/extended attributes ?

 From man tar:

       --acls this option causes tar to store each file=E2=80=99s ACLs in t=
he archive.

       --selinux
              this option causes tar to store  each  file=E2=80=99s  SELinu=
x  security
              context information in the archive.

       --xattrs
              this  option causes tar to store each file=E2=80=99s extended=
 attributes
              in the archive. This option also enables --acls and--selinux =
 if
              they haven=E2=80=99t been set already, due to the fact that t=
he data for
              those are stored in special xattrs.

 As the above implies tar doesn't automatically create archives with any
xattrs in them. However if the information is there it will
automatically use it on extraction.
 The simple create example is:

 tar --xattrs -cvf my-backup.tar ./path/to/backup

=E2=80=A6at which point extracting as normal will use that information (usi=
ng
--no-xattrs etc. will tell tar to ignore the information in an
extracting archive).

--=20
James Antill <jantill@redhat.com>

--=-WADzqAmssW9SxkQlaV4j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGe+s211eXTEMrxtQRAgT4AKCNQgresy7GLRtlac5SxZjfWi+8wwCeJzCq
3BpujJdEjGZkjkYOt3W5JV8=
=UkjW
-----END PGP SIGNATURE-----

--=-WADzqAmssW9SxkQlaV4j--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
