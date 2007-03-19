Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JI74cB005624
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 14:07:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JI71Rc026037
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 18:07:02 GMT
Subject: Re: gpg needs to be able to create its keys dir
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02FC3.8010501@redhat.com>
References: <45F02FC3.8010501@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 14:07:33 -0400
Message-Id: <1174327653.16707.9.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:46 -0500, Daniel J Walsh wrote:
> plain text document attachment
> (nsaserefpolicy_policy_modules_apps_gpg.if)
> --- nsaserefpolicy/policy/modules/apps/gpg.if	2007-01-02 12:57:22.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/apps/gpg.if	2007-03-08 08:42:36.000000000 -0500
> @@ -89,6 +89,7 @@
>  
>  	manage_files_pattern($1_gpg_t,$1_gpg_secret_t,$1_gpg_secret_t)
>  	manage_lnk_files_pattern($1_gpg_t,$1_gpg_secret_t,$1_gpg_secret_t)
> + 	userdom_user_home_dir_filetrans($1, $1_gpg_t, $1_gpg_secret_t, dir)
>  
>  	# transition from the userdomain to the derived domain
>  	domtrans_pattern($2,gpg_exec_t,$1_gpg_t)

Merged.  Also added perms so gpg can actually create the dir.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
