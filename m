Message-Id: <200606220735.k5M7ZOUI016994@turing-police.cc.vt.edu>
To: janak@us.ibm.com
Cc: dwalsh@redhat.com, sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        sds@tycho.nsa.gov, russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [PATCH] pam_namespace : allow use of X while polyinstantiating /tmp - v3
In-Reply-To: Your message of "Tue, 20 Jun 2006 12:23:12 EDT."
             <1150820592.31280.2.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <1150820592.31280.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1150961724_21543P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 22 Jun 2006 03:35:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1150961724_21543P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Jun 2006 12:23:12 EDT, Janak Desai said:
> This patch updates pam_namespace to allow the use of graphical display
> manager while polyinstantiating /tmp. It applies on top of the 06/18/06
> version of pam_namespace (pam-0.99.4.0-5.src.rpm) in rawhide. 

I hit another bug...

> diff -Naurp pam_namespace0620/modules/pam_namespace/pam_namespace.c pam_namespace0620+patch/modules/pam_namespace/pam_namespace.c
> --- pam_namespace0620/modules/pam_namespace/pam_namespace.c	2006-06-20 14:49:34.000000000 +0000
> +++ pam_namespace0620+patch/modules/pam_namespace/pam_namespace.c	2006-06-20 14:49:44.000000000 +0000
....

> @@ -776,12 +778,19 @@ static int create_dirs(const struct poly
>       * directory as arguments.
>       */
>  
> +inst_init:
> +    osighand = signal(SIGCHLD, SIG_DFL);
> +    if (osighand == NULL) {
> +        pam_syslog(idata->pamh, LOG_ERR, "Cannot set signal value");
> +        return PAM_SESSION_ERR;
> +    }
> +

Of course, SIG_DFL and NULL are both zero - which means this throws an
error if we try to set it to SIG_DFL and it already *was*.  I suspect
the 'if' condition should be:

	if (osighand == SIG_ERR) {

instead. (Unless somebody can point me at code that guarantees that the
signal handler *will* be set to a non-SIG_DFL value when we get here? I
don't see anyplace in pam_namespace.c where we would have set it before...)

--==_Exmh_1150961724_21543P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEmkg8cC3lWbTT17ARAhGKAJ9igJMjFQlpJywTViaDhrtjqBdkdgCbBOAb
2Zok48jgZtBg0OFyyu5xTvs=
=kasg
-----END PGP SIGNATURE-----

--==_Exmh_1150961724_21543P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
