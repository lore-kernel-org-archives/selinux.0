Subject: Re: Audit2allow/audit2why patch for policycoreutils.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47DFDF4A.8090006@redhat.com>
References: <47DFDF4A.8090006@redhat.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 16:38:13 -0400
Message-Id: <1205872693.6466.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-18 at 11:27 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Reveals dontaudit rules in policy.

Thanks, merged.

It would help if we could make the output more user-friendly, e.g.
giving the user more help on how to resolve or further investigate such
cases, although that is difficult in this situation where we have a
mismatch.

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkff30kACgkQrlYvE4MpobP0IgCfTxNojL6yGB6t26Nl+aERmQc4
> pJUAoNlJHmee/Q++U18HG2ty5UcECkte
> =qpCx
> -----END PGP SIGNATURE-----
> plain text document attachment (audit2why.patch)
> --- nsapolicycoreutils/audit2allow/audit2allow	2008-01-28 16:52:25.000000000 -0500
> +++ policycoreutils-2.0.44/audit2allow/audit2allow	2008-03-18 11:22:52.000000000 -0400
> @@ -247,6 +247,11 @@
>                      print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
>                      print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
>                      continue
> +                if rc == audit2why.DONTAUDIT:
> +                    print "\t\tUnknown - should be dontaudit'd by active policy\n",
> +                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
> +                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
> +                    continue
>                  if rc == audit2why.BOOLEAN:
>                      if len(bools) > 1:
>                          print "\tOne of the following booleans was set incorrectly."
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
