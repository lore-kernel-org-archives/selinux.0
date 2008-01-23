Subject: Re: policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4787DC7A.9010408@redhat.com>
References: <4787DC7A.9010408@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 16:01:50 -0500
Message-Id: <1201122110.7025.331.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-11 at 16:15 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Make sepolgen-ifgen return errors.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkeH3HkACgkQrlYvE4MpobNe3ACeN095D7eEMgV1K6YlWMtXX1ck
> 6JoAniapk+chTq3cOQ3kqWZbvYhwEAAf
> =Eslh
> -----END PGP SIGNATURE-----
> plain text document attachment (policycoreutils-sepolgen.patch)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/sepolgen-ifgen policycoreutils-2.0.35/audit2allow/sepolgen-ifgen
> --- nsapolicycoreutils/audit2allow/sepolgen-ifgen	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.35/audit2allow/sepolgen-ifgen	2008-01-11 11:17:46.000000000 -0500
> @@ -80,7 +80,10 @@
>      if_set.to_file(f)
>      f.close()
>  
> -    return 0
> +    if refparser.success:
> +        return 0
> +    else:
> +        return 1
>      
>  if __name__ == "__main__":
>      sys.exit(main())

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
