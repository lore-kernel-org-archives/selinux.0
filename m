Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27KRlB6004157
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 15:27:47 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l27KTD7g013801
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 20:29:13 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: pyzor/spam changes in policy
Date: Wed, 7 Mar 2007 15:29:16 -0500
Message-ID: <1173299356.10747.25.camel@sgc.columbia.tresys.com>
In-Reply-To: <200702261735.l1QHZrjX030675@localhost.localdomain>
References: <200702261735.l1QHZrjX030675@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:35 -0500, dwalsh@localhost.localdomain wrote:
> New directory for spamassin /var/lib/
> spam needs to send signals to pyzor
> pyzor uses tmp files

Merged most,  exceptions:

> +interface(`spamassassin_manage_lib_files',`
> +	gen_require(`
> +		type spamd_var_lib_t;
> +	')
> +
> +	files_search_var_lib($1)
> +	manage_dirs_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
> +	manage_files_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
> +')

Removed the dirs part.  If there is an interface needed that has both,
then there should be a more abstract interface.

> @@ -139,6 +148,7 @@
>  
>  	tunable_policy(`spamd_enable_home_dirs',`
>  		userdom_home_filetrans_generic_user_home_dir(spamd_t)
> +		userdom_manage_generic_user_home_dirs(spamd_t)
>  		userdom_manage_generic_user_home_content_dirs(spamd_t)
>  		userdom_manage_generic_user_home_content_files(spamd_t)
>  		userdom_manage_generic_user_home_content_symlinks(spamd_t)

I don't understand why spamd_t would be creating new top level home
diretories, for example the /home/myuser dir.

> @@ -184,6 +194,7 @@
>  
>  optional_policy(`
>  	pyzor_domtrans(spamd_t)
> +	pyzor_signal(spamd_t)
>  ')

Dropped this and the following, because the interface looks wrong ($1 is
the object).

> +########################################
> +## <summary>
> +##	Send generic signals to pyzor
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`pyzor_signal',`
> +	gen_require(`
> +		type pyzor_t;
> +	')
> +
> +	allow pyzor_t $1:process signal;
> +')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
