Date: Tue, 20 Sep 2005 19:10:40 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dale Amon <amon@vnl.com>, Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050920181039.GL16888@vnl.com>
References: <20050917233111.GA17916@vnl.com> <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZtAI5QFBF0GmLcW"
In-Reply-To: <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--NZtAI5QFBF0GmLcW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2005 at 08:27:50AM -0400, Stephen Smalley wrote:
> Index: libsepol/ChangeLog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/ChangeLog,v
> retrieving revision 1.59
> retrieving revision 1.60
> diff -u -p -r1.59 -r1.60
> --- libsepol/ChangeLog	6 Sep 2005 17:52:49 -0000	1.59
> +++ libsepol/ChangeLog	9 Sep 2005 14:32:32 -0000	1.60
> @@ -1,3 +1,7 @@
> +1.9.1 2005-09-09
> +	* Fixed expand_avtab and expand_cond_av_list to keep separate
> +	entries with identical keys but different enabled flags.
> +
>  1.8 2005-09-06
>  	* Updated version for release.
> =20
> Index: libsepol/VERSION
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/VERSION,v
> retrieving revision 1.54
> retrieving revision 1.55
> diff -u -p -r1.54 -r1.55
> --- libsepol/VERSION	6 Sep 2005 17:52:49 -0000	1.54
> +++ libsepol/VERSION	9 Sep 2005 14:32:32 -0000	1.55
> @@ -1 +1 @@
> -1.8
> +1.9.1
> Index: libsepol/src/expand.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
> retrieving revision 1.10
> retrieving revision 1.11
> diff -u -p -r1.10 -r1.11
> --- libsepol/src/expand.c	23 Aug 2005 13:05:18 -0000	1.10
> +++ libsepol/src/expand.c	9 Sep 2005 14:32:35 -0000	1.11
> @@ -1916,17 +1916,29 @@ int expand_module(policydb_t *base, poli
> =20
>  static int expand_avtab_insert(avtab_t *a, avtab_key_t *k, avtab_datum_t=
 *d)
>  {
> +	avtab_ptr_t node;
>  	avtab_datum_t *avd;
>  	int rc;
> -
> -	avd =3D avtab_search(a, k);
> -	if (!avd) {
> +=09
> +	node =3D avtab_search_node(a, k);
> +	if (!node) {
>  		rc =3D avtab_insert(a, k, d);
>  		if (rc)
>  			DEBUG(__FUNCTION__, "Out of memory!\n");
>  		return rc;
>  	}
> -=09
> +
> +	if ((k->specified & AVTAB_ENABLED) !=3D=20
> +	    (node->key.specified & AVTAB_ENABLED)) {
> +		node =3D avtab_insert_nonunique(a, k, d);
> +		if (!node) {
> +			DEBUG(__FUNCTION__, "Out of memory!\n");
> +			return -1;
> +		}
> +		return 0;
> +	}
> +
> +	avd =3D &node->datum;
>  	switch (k->specified & ~AVTAB_ENABLED) {
>  	case AVTAB_ALLOWED:
>  	case AVTAB_AUDITALLOW:
> @@ -2035,7 +2047,8 @@ static int expand_cond_insert(cond_av_li
>  	cond_av_list_t *nl;
> =20
>  	node =3D avtab_search_node(expa, k);
> -	if (!node) {
> +	if (!node ||
> +	    (k->specified & AVTAB_ENABLED) !=3D (node->key.specified & AVTAB_EN=
ABLED)) {
>  		node =3D avtab_insert_nonunique(expa, k, d);
>  		if (!node) {
>  			DEBUG(__FUNCTION__, "Out of memory!\n");


To save time I did this in a chroot.

The debian version is 1.8-1; your patch applied cleanly
against this. I incremented the changelog to reflect
the version change and built 1.9-1 debian packages
which installed.

However, rerunning dselect still shows the same error
messages as before.

Reading package lists... Done
Building dependency tree... Done
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
1 not fully installed or removed.
Need to get 0B of archives.
After unpacking 0B of additional disk space will be used.
Do you want to continue [Y/n]?=20
Setting up selinux-policy-default (1.18-1) ...
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
libsepol.expand_avtab_insert: Type conflict!
Out of memory - unable to check assertions
Check assertions failed.
make: *** [/etc/selinux/policy/policy.20] Error 255
dpkg: error processing selinux-policy-default (--configure):
 subprocess post-installation script returned error exit status 2
Errors were encountered while processing:
 selinux-policy-default


I could swap the drives out and try this live instead
of from chroot, but I doubt it would matter.

Suggestions?

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--NZtAI5QFBF0GmLcW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMFCeZHES7UL0zXERAojxAJ9TYaiUsbsG4x8FTUjXbWkuECMx+wCfT8hl
Ti0IKSKmvZImRtLw+0LD3vM=
=y+mj
-----END PGP SIGNATURE-----

--NZtAI5QFBF0GmLcW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
