Subject: Re: More fixes for nscd in targeted policy
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41475DEA.90907@redhat.com>
References: <41475DEA.90907@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qTD1eo1RHraqw2748z7P"
Date: Tue, 14 Sep 2004 21:01:35 -0400
Message-Id: <1095210095.31025.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qTD1eo1RHraqw2748z7P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-14 at 17:08 -0400, Daniel J Walsh wrote:

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/macros/global_macros.te =
policy-1.17.15/macros/global_macros.te
> --- nsapolicy/macros/global_macros.te	2004-09-10 16:10:36.000000000 -0400
> +++ policy-1.17.15/macros/global_macros.te	2004-09-14 16:54:08.435636665 =
-0400
> @@ -545,6 +545,7 @@
>  # Create/access any file in a labeled filesystem;
>  allow $1 file_type:dir_file_class_set *;
>  allow $1 sysctl_t:{ dir file } *;
> +allow $1 proc_mdstat_t:file *;
>  allow $1 device_type:devfile_class_set *;
>  allow $1 mtrr_device_t:file *;

This particular one should be fixed a bit more cleanly with my proc_fs
attribute patch; that way when we give more files in /proc their own
types, we won't have to remember to update unconfined_t.


--=-qTD1eo1RHraqw2748z7P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBR5RuOIkJWWp2WGURAiBNAJ9q+hXkvuoRR1mVBDPCqih9UDcgbACeMveH
xDeLf2ca+XzuY0Dw9ByeTmg=
=QBxB
-----END PGP SIGNATURE-----

--=-qTD1eo1RHraqw2748z7P--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
