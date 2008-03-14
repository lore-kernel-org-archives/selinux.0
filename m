Subject: Re: libselinux/matchpathcon has a memory leak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <47D9BBEE.5090105@redhat.com>
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com>
	 <47D9BBEE.5090105@redhat.com>
Content-Type: text/plain
Date: Fri, 14 Mar 2008 09:36:00 -0400
Message-Id: <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-13 at 19:42 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The attached patch fixes the leaks.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkfZu+0ACgkQrlYvE4MpobPbRQCeOFM6HzBGz2N3l56z+yvHEGwl
> /7sAnjiJkOYsJFZcR8yXrVCdOl3iRFT5
> =+kwB
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/label.c libselinux-2.0.59/src/label.c
> --- nsalibselinux/src/label.c	2007-07-16 14:20:46.000000000 -0400
> +++ libselinux-2.0.59/src/label.c	2008-03-13 19:40:24.000000000 -0400
> @@ -95,7 +95,7 @@
>  	if (compat_validate(rec, lr, "file_contexts", 0))
>  		return NULL;
>  
> -	if (translating &&
> +	if (translating && (! lr->ctx_trans) &&

No parentheses required there.

>  	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
>  		return NULL;
>  
> @@ -131,6 +131,7 @@
>  void selabel_close(struct selabel_handle *rec)
>  {
>  	rec->func_close(rec);
> +	free(rec->data);

Wrong layer - we don't know how rec->data was allocated here.
Needs to happen in label_file.c:close(), I think, at the end of it.

>  	free(rec);
>  }
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
