Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2SHNI58014576
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 13:23:18 -0400
Message-ID: <4F734903.3000605@redhat.com>
Date: Wed, 28 Mar 2012 13:23:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 41/73] policycoreutils: mcstransd: write a pid file FIXME
References: <4F71E181.80300@redhat.com> <1332863630.15547.22.camel@lenny>  <4F7200C7.4060008@redhat.com> <1332951864.15547.29.camel@lenny>
In-Reply-To: <1332951864.15547.29.camel@lenny>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/28/2012 12:24 PM, Colin Walters wrote:
> The naming here is confusing...the C variable should be called "daemonize" or "do_fork" or something.
> 
> +       if (foreground && daemon(0, 0)) {
> 
> Would then be:
> 
> if (!foreground && daemon(0, 0))
> 
> Right?
> 
> 
Ok using do_fork.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9zSQIACgkQrlYvE4MpobNJeQCeMJJLClSc7KgtNxtEp9SRRgrm
gscAoJGil/oYdK+agV3OSDF/eUm8nixW
=0jm0
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
