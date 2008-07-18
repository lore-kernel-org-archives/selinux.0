Subject: Re: [refpolicy] Patch: Create non_security_file_type attribute
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1216390554.21191.147.camel@gorn>
References: <1214592935.2888.11.camel@moss-lions.epoch.ncsc.mil>
	 <1216390554.21191.147.camel@gorn>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 11:42:18 -0400
Message-Id: <1216395738.26625.45.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-18 at 10:15 -0400, Christopher J. PeBenito wrote:
> On Fri, 2008-06-27 at 14:55 -0400, James Carter wrote:
> > This patch eliminates the expansion of the file_type attribute (due to
> > the "-" set operation) for the *_non_security interfaces by creating a
> > non_security_file_type attribute.
> > 
> > On my system the resulting binary policy is almost 20% smaller.  The
> > difference is so large because there are over 1000 types labeled with
> > the file_type attribute.
> 
> I'm hesitant to attach non_security_file_type to the files_type
> attribute, since its not clear to me that it makes conceptual sense.

The primary goal here is a smaller binary policy.  But it still makes
sense conceptually to me because the security_file_type attribute is
never used by itself as far as I can tell.  It is always used as
{file_type-security_file_type}.

>   In
> fact a sediff of the policy reveals that auidtd_log_t gains
> non_security_file_type while it already has security_file_type, which
> results in rule additions with this patch added.
That's not good.  There are only a handful of types labeled with
security_file_type, I don't know how I missed that.  Sorry.

The following line is the problem: files_mountpoint(auditd_log_t).
So, a files_mountpoint_security interface would have to be created.

It's not a big deal to me.  If there is no interest in creating a
non_security_file_type attribute, I won't pursue this any farther.

Jim


> 
> >  files.if |   61 ++++++++++++++++++++++++++++++-------------------------------
> >  files.te |    2 ++
> >  2 files changed, 32 insertions(+), 31 deletions(-)
> > 
> > Index: policy/modules/kernel/files.if
> > ===================================================================
> > --- policy/modules/kernel/files.if	(revision 2739)
> > +++ policy/modules/kernel/files.if	(working copy)
> > @@ -32,10 +32,10 @@
> >  #
> >  interface(`files_type',`
> >  	gen_require(`
> > -		attribute file_type;
> > +		attribute file_type, non_security_file_type;
> >  	')
> >  
> > -	typeattribute $1 file_type;
> > +	typeattribute $1 file_type, non_security_file_type;
> >  ')
> >  
> >  ########################################
> > @@ -217,11 +217,10 @@
> >  #
> >  interface(`files_security_file',`
> >  	gen_require(`
> > -		attribute security_file_type;
> > +		attribute file_type, security_file_type;
> >  	')
> >  
> > -	files_type($1)
> > -	typeattribute $1 security_file_type;
> > +	typeattribute $1 file_type, security_file_type;
> >  ')
> >  
> >  ########################################
> > @@ -316,10 +315,10 @@
> >  #
> >  interface(`files_list_non_security',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	list_dirs_pattern($1,{ file_type -security_file_type },{ file_type -security_file_type })
> > +	list_dirs_pattern($1,non_security_file_type,non_security_file_type)
> >  ')
> >  
> >  ########################################
> > @@ -335,10 +334,10 @@
> >  #
> >  interface(`files_dontaudit_list_non_security',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:dir list_dir_perms;
> > +	dontaudit $1 non_security_file_type:dir list_dir_perms;
> >  ')
> >  
> >  ########################################
> > @@ -354,11 +353,11 @@
> >  #
> >  interface(`files_mounton_non_security',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	allow $1 { file_type -security_file_type }:dir mounton;
> > -	allow $1 { file_type -security_file_type }:file mounton;
> > +	allow $1 non_security_file_type:dir mounton;
> > +	allow $1 non_security_file_type:file mounton;
> >  ')
> >  
> >  ########################################
> > @@ -373,10 +372,10 @@
> >  #
> >  interface(`files_write_non_security_dirs',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	allow $1 { file_type -security_file_type }:dir write;
> > +	allow $1 non_security_file_type:dir write;
> >  ')
> >  
> >  ########################################
> > @@ -430,10 +429,10 @@
> >  #
> >  interface(`files_dontaudit_getattr_non_security_files',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:file getattr;
> > +	dontaudit $1 non_security_file_type:file getattr;
> >  ')
> >  
> >  ########################################
> > @@ -498,11 +497,11 @@
> >  #
> >  interface(`files_read_non_security_files',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	read_files_pattern($1,{ file_type -security_file_type },{ file_type -security_file_type })
> > -	read_lnk_files_pattern($1,{ file_type -security_file_type },{ file_type -security_file_type })
> > +	read_files_pattern($1,non_security_file_type,non_security_file_type)
> > +	read_lnk_files_pattern($1,non_security_file_type,non_security_file_type)
> >  ')
> >  
> >  ########################################
> > @@ -648,10 +647,10 @@
> >  #
> >  interface(`files_dontaudit_getattr_non_security_symlinks',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:lnk_file getattr;
> > +	dontaudit $1 non_security_file_type:lnk_file getattr;
> >  ')
> >  
> >  ########################################
> > @@ -667,10 +666,10 @@
> >  #
> >  interface(`files_dontaudit_getattr_non_security_blk_files',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:blk_file getattr;
> > +	dontaudit $1 non_security_file_type:blk_file getattr;
> >  ')
> >  
> >  ########################################
> > @@ -686,10 +685,10 @@
> >  #
> >  interface(`files_dontaudit_getattr_non_security_chr_files',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:chr_file getattr;
> > +	dontaudit $1 non_security_file_type:chr_file getattr;
> >  ')
> >  
> >  ########################################
> > @@ -763,10 +762,10 @@
> >  #
> >  interface(`files_dontaudit_getattr_non_security_pipes',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:fifo_file getattr;
> > +	dontaudit $1 non_security_file_type:fifo_file getattr;
> >  ')
> >  
> >  ########################################
> > @@ -820,10 +819,10 @@
> >  #
> >  interface(`files_dontaudit_getattr_non_security_sockets',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	dontaudit $1 { file_type -security_file_type }:sock_file getattr;
> > +	dontaudit $1 non_security_file_type:sock_file getattr;
> >  ')
> >  
> >  ########################################
> > @@ -4763,8 +4762,8 @@
> >  #
> >  interface(`files_manage_non_security_dirs',`
> >  	gen_require(`
> > -		attribute file_type, security_file_type;
> > +		attribute non_security_file_type;
> >  	')
> >  
> > -	allow $1 { file_type -security_file_type }:dir manage_dir_perms;
> > +	allow $1 non_security_file_type:dir manage_dir_perms;
> >  ')
> > Index: policy/modules/kernel/files.te
> > ===================================================================
> > --- policy/modules/kernel/files.te	(revision 2739)
> > +++ policy/modules/kernel/files.te	(working copy)
> > @@ -26,6 +26,8 @@
> >  # sensitive security files whose accesses should
> >  # not be dontaudited for uses
> >  attribute security_file_type;
> > +# and its opposite
> > +attribute non_security_file_type;
> >  
> >  attribute tmpfile;
> >  attribute tmpfsfile;
> > 
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
