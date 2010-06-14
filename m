Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5EKb6LY017489
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 16:37:06 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o5EKcW0B015917
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 20:38:32 GMT
Date: Mon, 14 Jun 2010 16:36:57 -0400
Subject: Re: Minor fixup of checkmodule man page.
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <C83C0B29.B9022%csellers@tresys.com>
In-Reply-To: <4BDF0BBA.1040307@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/3/10 1:45 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Quality Engineering is going through all commands on the system looking
> for mismatches between man page/usage and actual code.
> 
> It found that checkmodule had a -d option that is unused and undocumented -h
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkvfC7oACgkQrlYvE4MpobNPrACg0uP02CWYPs9YcdU87jts9YqT
> hMAAn2QA1UWZpGLvvU4yxStmhUU1Kg1+
> =topF
> -----END PGP SIGNATURE-----

Acked-by: Chad Sellers <csellers@tresys.com>

Merged as of checkpolicy 2.0.22


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
