Subject: Re: [refpolicy] Patch: Create non_security_file_type attribute (v2)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1217361240.2932.17.camel@moss-lions.epoch.ncsc.mil>
References: <1217361240.2932.17.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 10:11:34 -0400
Message-Id: <1217513494.4114.50.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-07-29 at 15:54 -0400, James Carter wrote:
> This patch eliminates the expansion of the file_type attribute (due to
> the "-" set operation) for the *_non_security interfaces by creating a
> non_security_file_type attribute.
> 
> It also creates a files_security_mountpoint interface that is used for
> auditd_log_t so that it does not get both the security_file_type and the
> non_security_file_type attributes.
> 
> On my system the resulting binary policy is almost 20% smaller.  The
> difference is so large because there are over 1000 types labeled with
> the file_type attribute.

Merged, with one minor tweak.  I kept the
files_security_file(auditd_log_t) line just to emphasize its a file too,
in addition to a security mountpoint, despite it being redundant.

> Comparing the binary policies with sediff before and after applying this
> patch shows no differences.
> 
> kernel/files.if   |   81 +++++++++++++++++++++++++++++++++---------------------
> kernel/files.te   |    2 +
> system/logging.te |    3 --
> 3 files changed, 53 insertions(+), 33 deletions(-)
> 
> Index: policy/modules/kernel/files.if
> ===================================================================
> --- policy/modules/kernel/files.if	(revision 2767)
> +++ policy/modules/kernel/files.if	(working copy)
> @@ -32,10 +32,10 @@
>  #
>  interface(`files_type',`
>  	gen_require(`
> -		attribute file_type;
> +		attribute file_type, non_security_file_type;
>  	')
>  
> -	typeattribute $1 file_type;
> +	typeattribute $1 file_type, non_security_file_type;
>  ')
>  
>  ########################################
> @@ -217,15 +217,34 @@
>  #
>  interface(`files_security_file',`
>  	gen_require(`
> -		attribute security_file_type;
> +		attribute file_type, security_file_type;
>  	')
>  
> -	files_type($1)
> -	typeattribute $1 security_file_type;
> +	typeattribute $1 file_type, security_file_type;
>  ')
>  
>  ########################################
>  ## <summary>
> +##	Make the specified type usable for
> +##	security file filesystem mount points.
> +## </summary>
> +## <param name="type">
> +##	<summary>
> +##	Type to be used for mount points.
> +##	</summary>
> +## </param>
> +#
> +interface(`files_security_mountpoint',`
> +	gen_require(`
> +		attribute mountpoint;
> +	')
> +
> +	files_security_file($1)
> +	typeattribute $1 mountpoint;
> +')
> +
> +########################################
> +## <summary>
>  ##	Make the specified type a file
>  ##	used for temporary files.
>  ## </summary>
> @@ -316,10 +335,10 @@
>  #
>  interface(`files_list_non_security',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	list_dirs_pattern($1, { file_type -security_file_type }, { file_type -security_file_type })
> +	list_dirs_pattern($1, non_security_file_type, non_security_file_type)
>  ')
>  
>  ########################################
> @@ -335,10 +354,10 @@
>  #
>  interface(`files_dontaudit_list_non_security',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:dir list_dir_perms;
> +	dontaudit $1 non_security_file_type:dir list_dir_perms;
>  ')
>  
>  ########################################
> @@ -354,11 +373,11 @@
>  #
>  interface(`files_mounton_non_security',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	allow $1 { file_type -security_file_type }:dir mounton;
> -	allow $1 { file_type -security_file_type }:file mounton;
> +	allow $1 non_security_file_type:dir mounton;
> +	allow $1 non_security_file_type:file mounton;
>  ')
>  
>  ########################################
> @@ -373,10 +392,10 @@
>  #
>  interface(`files_write_non_security_dirs',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	allow $1 { file_type -security_file_type }:dir write;
> +	allow $1 non_security_file_type:dir write;
>  ')
>  
>  ########################################
> @@ -430,10 +449,10 @@
>  #
>  interface(`files_dontaudit_getattr_non_security_files',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:file getattr;
> +	dontaudit $1 non_security_file_type:file getattr;
>  ')
>  
>  ########################################
> @@ -498,11 +517,11 @@
>  #
>  interface(`files_read_non_security_files',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	read_files_pattern($1, { file_type -security_file_type }, { file_type -security_file_type })
> -	read_lnk_files_pattern($1, { file_type -security_file_type }, { file_type -security_file_type })
> +	read_files_pattern($1, non_security_file_type, non_security_file_type)
> +	read_lnk_files_pattern($1, non_security_file_type, non_security_file_type)
>  ')
>  
>  ########################################
> @@ -648,10 +667,10 @@
>  #
>  interface(`files_dontaudit_getattr_non_security_symlinks',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:lnk_file getattr;
> +	dontaudit $1 non_security_file_type:lnk_file getattr;
>  ')
>  
>  ########################################
> @@ -667,10 +686,10 @@
>  #
>  interface(`files_dontaudit_getattr_non_security_blk_files',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:blk_file getattr;
> +	dontaudit $1 non_security_file_type:blk_file getattr;
>  ')
>  
>  ########################################
> @@ -686,10 +705,10 @@
>  #
>  interface(`files_dontaudit_getattr_non_security_chr_files',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:chr_file getattr;
> +	dontaudit $1 non_security_file_type:chr_file getattr;
>  ')
>  
>  ########################################
> @@ -763,10 +782,10 @@
>  #
>  interface(`files_dontaudit_getattr_non_security_pipes',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:fifo_file getattr;
> +	dontaudit $1 non_security_file_type:fifo_file getattr;
>  ')
>  
>  ########################################
> @@ -820,10 +839,10 @@
>  #
>  interface(`files_dontaudit_getattr_non_security_sockets',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	dontaudit $1 { file_type -security_file_type }:sock_file getattr;
> +	dontaudit $1 non_security_file_type:sock_file getattr;
>  ')
>  
>  ########################################
> @@ -4763,8 +4782,8 @@
>  #
>  interface(`files_manage_non_security_dirs',`
>  	gen_require(`
> -		attribute file_type, security_file_type;
> +		attribute non_security_file_type;
>  	')
>  
> -	allow $1 { file_type -security_file_type }:dir manage_dir_perms;
> +	allow $1 non_security_file_type:dir manage_dir_perms;
>  ')
> Index: policy/modules/kernel/files.te
> ===================================================================
> --- policy/modules/kernel/files.te	(revision 2767)
> +++ policy/modules/kernel/files.te	(working copy)
> @@ -26,6 +26,8 @@
>  # sensitive security files whose accesses should
>  # not be dontaudited for uses
>  attribute security_file_type;
> +# and its opposite
> +attribute non_security_file_type;
>  
>  attribute tmpfile;
>  attribute tmpfsfile;
> Index: policy/modules/system/logging.te
> ===================================================================
> --- policy/modules/system/logging.te	(revision 2767)
> +++ policy/modules/system/logging.te	(working copy)
> @@ -17,8 +17,7 @@
>  files_security_file(auditd_etc_t)
>  
>  type auditd_log_t;
> -files_security_file(auditd_log_t)
> -files_mountpoint(auditd_log_t)
> +files_security_mountpoint(auditd_log_t)
>  
>  type auditd_t;
>  type auditd_exec_t;
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
