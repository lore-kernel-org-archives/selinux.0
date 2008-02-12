Subject: Re: PATCH: libsepol use correct pointer type in sizeof()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200802122059.m1CKx3ea001958@cadmus.columbia.tresys.com>
References: <200802122059.m1CKx3ea001958@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 12 Feb 2008 16:08:53 -0500
Message-Id: <1202850533.24250.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-12 at 15:59 -0500, Todd C. Miller wrote:
> This looks to be a cut & pasto from the chunk above it.  It won't change
> the code generated since sizeof(foo *) == sizeof(bar *) but it should
> probably be fixed anyway.
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
> Index: trunk/libsepol/src/users.c
> ===================================================================
> --- trunk/libsepol/src/users.c	(revision 2802)
> +++ trunk/libsepol/src/users.c	(working copy)
> @@ -237,7 +237,7 @@
>  
>  		tmp_ptr = realloc(policydb->sym_val_to_name[SYM_USERS],
>  				  (policydb->p_users.nprim +
> -				   1) * sizeof(user_datum_t *));
> +				   1) * sizeof(char *));
>  		if (!tmp_ptr)
>  			goto omem;
>  		policydb->sym_val_to_name[SYM_USERS] = tmp_ptr;
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
