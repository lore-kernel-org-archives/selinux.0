Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BJiVW0011886
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 15:44:31 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BJiTGQ004262
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 19:44:30 GMT
Subject: Re: selinux_getattr patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460426EA.6050801@redhat.com>
References: <460426EA.6050801@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 19:45:16 +0000
Message-Id: <1176320717.9840.55.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:13 -0400, Daniel J Walsh wrote:
> Some apps doing a getattr of all files in / generate avc messages on
> /selinux
> 
> This patch removes those avc's.

This looks more like something to do with the libselinux constructor.
Perhaps we should have interfaces for selinux aware programs, for
allowing and dontauditing the constructor, at least.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (selinux_getattr.patch), "selinux_getattr.patch"
> 
> --- nsaserefpolicy/policy/modules/kernel/selinux.if     2007-02-27 14:37:10.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/kernel/selinux.if 2007-03-22 15:06:58.000000000 -0400
> @@ -51,6 +51,44 @@
>  
>  ########################################
>  ## <summary>
> +##     Do not audit attempts to get the
> +##     attributes of the selinuxfs filesystem
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain to not audit.
> +##     </summary>
> +## </param>
> +#
> +interface(`selinux_dontaudit_getattr_fs',`
> +       gen_require(`
> +               type security_t;
> +       ')
> +
> +       dontaudit $1 security_t:filesystem getattr;
> +')
> +
> +########################################
> +## <summary>
> +##     Allow domain to get the
> +##     attributes of the selinuxfs filesystem
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain to not audit.
> +##     </summary>
> +## </param>
> +#
> +interface(`selinux_getattr_fs',`
> +       gen_require(`
> +               type security_t;
> +       ')
> +
> +       allow $1 security_t:filesystem getattr;
> +')
> +
> +########################################
> +## <summary>
>  ##     Search selinuxfs.
>  ## </summary>
>  ## <param name="domain">
> --- nsaserefpolicy/policy/modules/system/selinuxutil.if 2007-01-02 12:57:49.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/system/selinuxutil.if     2007-03-22 15:06:59.000000000 -0400
> @@ -616,7 +616,7 @@
>         gen_require(`
>                 type selinux_config_t;
>         ')
> -
> +       selinux_dontaudit_getattr_fs($1)
>         dontaudit $1 selinux_config_t:dir search;
>         dontaudit $1 selinux_config_t:file { getattr read };
>  ')
> @@ -637,6 +637,8 @@
>                 type selinux_config_t;
>         ')
>  
> +       selinux_getattr_fs($1)
> +
>         files_search_etc($1)
>         allow $1 selinux_config_t:dir list_dir_perms;
>         read_files_pattern($1,selinux_config_t,selinux_config_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
