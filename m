Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Todd C. Miller" <tmiller@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <470120CD.5050009@redhat.com>
References: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com>
	 <470120CD.5050009@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:19:19 -0400
Message-Id: <1191593959.891.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-01 at 12:31 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This patch makes sure /root gets labeled even if it is using the default
> context.

Thanks, merged.

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFHASDNrlYvE4MpobMRAuAAAJ0edHnaWRQ/RuE8llb+RQ9Zh43j6ACg2qXK
> FsPmAB6fb4Ct9ytLVhxYijk=
> =S8km
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.11/src/genhomedircon.c
> --- nsalibsemanage/src/genhomedircon.c	2007-10-01 09:54:35.000000000 -0400
> +++ libsemanage-2.0.11/src/genhomedircon.c	2007-10-01 12:24:39.000000000 -0400
> @@ -668,12 +668,11 @@
>  
>  	for (i = 0; i < nseusers; i++) {
>  		seuname = semanage_seuser_get_sename(seuser_list[i]);
> +		name = semanage_seuser_get_name(seuser_list[i]);
>  
> -		if (strcmp(seuname, s->fallback_user) == 0)
> +		if (strcmp(name,"root") && strcmp(seuname, s->fallback_user) == 0)
>  			continue;
>  
> -		name = semanage_seuser_get_name(seuser_list[i]);
> -
>  		if (strcmp(name, DEFAULT_LOGIN) == 0)
>  			continue;
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
