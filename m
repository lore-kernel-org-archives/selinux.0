Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF92C7EE24
	for <selinux@archiver.kernel.org>; Tue,  6 Jun 2023 08:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjFFIK2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jun 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjFFIK1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jun 2023 04:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C456A7
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686038988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5li/dTtvAQICDstlPPc6U67XS41kldX6FZI7HVJZPT8=;
        b=fxSG0kwXGn19slMOMVt1LYkokNKfkAE16wdPS3W0S9tu/0/wUeq4Z6eIOumw001YiqtJBR
        tFogloz2KgMLhg6pWIpxN+7ZqlEk2krWhEabrCD1TOWSowNG3hY3KTOgXid/osMVuFUVp3
        +gtHBuBQGO0Wj+AESf6LXOb1s8khEKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-TiF_qdAnNFmIKSK6nCpQAg-1; Tue, 06 Jun 2023 04:09:46 -0400
X-MC-Unique: TiF_qdAnNFmIKSK6nCpQAg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52BF2101A52C
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 08:09:46 +0000 (UTC)
Received: from localhost (unknown [10.45.224.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3073400F4E;
        Tue,  6 Jun 2023 08:09:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/5] policycoreutils: Add examples to man pages
In-Reply-To: <20230601143915.2051922-1-vmojzis@redhat.com>
References: <87ttvsk0qx.fsf@redhat.com>
 <20230601143915.2051922-1-vmojzis@redhat.com>
Date:   Tue, 06 Jun 2023 10:09:45 +0200
Message-ID: <87sfb5hv06.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> While at it, remove trailing whitespaces.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>

For these five patches:
Acked-by: Petr Lautrbach <lautrbach@redhat.com>



> ---
>  policycoreutils/scripts/fixfiles.8          | 34 +++++++++++++--------
>  policycoreutils/secon/secon.1               | 12 ++++++--
>  policycoreutils/semodule/semodule.8         | 14 ++++-----
>  policycoreutils/setfiles/restorecon.8       |  9 ++++++
>  policycoreutils/setfiles/restorecon_xattr.8 |  7 +++++
>  policycoreutils/setfiles/setfiles.8         |  9 ++++++
>  policycoreutils/setsebool/setsebool.8       | 16 +++++++---
>  7 files changed, 74 insertions(+), 27 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
> index 9a317d91..928b8200 100644
> --- a/policycoreutils/scripts/fixfiles.8
> +++ b/policycoreutils/scripts/fixfiles.8
> @@ -14,7 +14,7 @@ fixfiles \- fix file SELinux security contexts.
>  .B fixfiles
>  .I [\-v] [\-F] [\-B | \-N time ] [\-T nthreads] { check | restore | verify }
>  
> -.B fixfiles 
> +.B fixfiles
>  .I [\-v] [\-F] [\-T nthreads] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
>  
>  .B fixfiles
> @@ -31,7 +31,7 @@ This manual page describes the
>  script.
>  .P
>  This script is primarily used to correct the security context
> -database (extended attributes) on filesystems.  
> +database (extended attributes) on filesystems.
>  .P
>  It can also be run at any time to relabel when adding support for
>  new policy, or  just check whether the file contexts are all
> @@ -41,29 +41,29 @@ option.  You can use the \-R flag to use rpmpackages as an alternative.
>  The file /etc/selinux/fixfiles_exclude_dirs can contain a list of directories
>  excluded from relabeling.
>  .P
> -.B fixfiles onboot 
> +.B fixfiles onboot
>  will setup the machine to relabel on the next reboot.
>  
>  .SH "OPTIONS"
> -.TP 
> +.TP
>  .B \-B
>  If specified with onboot, this fixfiles will record the current date in the /.autorelabel file, so that it can be used later to speed up labeling. If used with restore, the restore will only affect files that were modified today.
>  .TP
>  .B \-F
>  Force reset of context to match file_context for customizable files
>  
> -.TP 
> +.TP
>  .B \-f
>  Clear /tmp directory with out prompt for removal.
>  
> -.TP 
> +.TP
>  .B \-R rpmpackagename[,rpmpackagename...]
>  Use the rpm database to discover all files within the specified packages and restore the file contexts.
>  .TP
>  .B \-C PREVIOUS_FILECONTEXT
>  Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installed one, and restore the context of all affected files.
>  
> -.TP 
> +.TP
>  .B \-N time
>  Only act on files created after the specified date.  Date must be specified in
>  "YYYY\-MM\-DD HH:MM" format.  Date field will be passed to find \-\-newermt command.
> @@ -83,19 +83,28 @@ Use parallel relabeling, see
>  
>  .SH "ARGUMENTS"
>  One of:
> -.TP 
> +.TP
>  .B check | verify
>  print any incorrect file context labels, showing old and new context, but do not change them.
> -.TP 
> +.TP
>  .B restore
>  change any incorrect file context labels.
> -.TP 
> +.TP
>  .B relabel
>  Prompt for removal of contents of /tmp directory and then change any incorrect file context labels to match the install file_contexts file.
> -.TP 
> -.B [[dir/file] ... ] 
> +.TP
> +.B [[dir/file] ... ]
>  List of files or directories trees that you wish to check file context on.
>  
> +.SH EXAMPLE
> +.nf
> +Relabel the whole filesystem, except paths listed in /etc/selinux/fixfiles_exclude_dirs
> +# fixfiles relabel
> +Schedule the machine to relabel on the next boot and force relabeling of customizable types
> +# fixfiles -F onboot
> +Check labeling of all files from the samba package (while not changing any labels)
> +# fixfiles -R samba check
> +
>  .SH "AUTHOR"
>  This man page was written by Richard Hally <rhally@mindspring.com>.
>  The script  was written by Dan Walsh <dwalsh@redhat.com>
> @@ -103,4 +112,3 @@ The script  was written by Dan Walsh <dwalsh@redhat.com>
>  .SH "SEE ALSO"
>  .BR setfiles (8),
>  .BR restorecon (8)
> -
> diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
> index 501b5cb8..c0e8b05a 100644
> --- a/policycoreutils/secon/secon.1
> +++ b/policycoreutils/secon/secon.1
> @@ -107,16 +107,24 @@ then the context will be read from stdin.
>  .br
>  If there is no argument,
>  .B secon
> -will try reading a context from stdin, if that is not a tty, otherwise 
> +will try reading a context from stdin, if that is not a tty, otherwise
>  .B secon
>  will act as though \fB\-\-self\fR had been passed.
>  .PP
>  If none of \fB\-\-user\fR, \fB\-\-role\fR, \fB\-\-type\fR, \fB\-\-level\fR or
>  \fB\-\-mls\-range\fR is passed.
>  Then all of them will be output.
> +
> +.SH EXAMPLE
> +.nf
> +Show SElinux context of the init process
> +# secon --pid 1
> +Parse the type portion of given security context
> +# secon -t system_u:object_r:httpd_sys_rw_content_t:s0
> +
>  .PP
>  .SH SEE ALSO
>  .BR chcon (1)
>  .SH AUTHORS
>  .nf
> -James Antill (james.antill@redhat.com) 
> +James Antill (james.antill@redhat.com)
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
> index c56e580f..01757b00 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -1,5 +1,5 @@
>  .TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux" NSA
> -.SH NAME 
> +.SH NAME
>  semodule \- Manage SELinux policy modules.
>  
>  .SH SYNOPSIS
> @@ -8,7 +8,7 @@ semodule \- Manage SELinux policy modules.
>  .SH DESCRIPTION
>  .PP
>  semodule is the tool used to manage SELinux policy modules,
> -including installing, upgrading, listing and removing modules.  
> +including installing, upgrading, listing and removing modules.
>  semodule may also be used to force a rebuild of policy from the
>  module store and/or to force a reload of policy without performing
>  any other transaction.  semodule acts on module packages created
> @@ -39,7 +39,7 @@ install/replace a module package
>  .B  \-u,\-\-upgrade=MODULE_PKG
>  deprecated, alias for --install
>  .TP
> -.B  \-b,\-\-base=MODULE_PKG   
> +.B  \-b,\-\-base=MODULE_PKG
>  deprecated, alias for --install
>  .TP
>  .B  \-r,\-\-remove=MODULE_NAME
> @@ -77,7 +77,7 @@ name of the store to operate on
>  .B  \-n,\-\-noreload,\-N
>  do not reload policy after commit
>  .TP
> -.B  \-h,\-\-help        
> +.B  \-h,\-\-help
>  prints help message and quit
>  .TP
>  .B \-P,\-\-preserve_tunables
> @@ -92,7 +92,7 @@ Use an alternate path for the policy root
>  .B \-S,\-\-store-path
>  Use an alternate path for the policy store root
>  .TP
> -.B  \-v,\-\-verbose     
> +.B  \-v,\-\-verbose
>  be verbose
>  .TP
>  .B  \-c,\-\-cil
> @@ -131,8 +131,6 @@ $ semodule \-B
>  $ semodule \-d alsa
>  # Install a module at a specific priority.
>  $ semodule \-X 100 \-i alsa.pp
> -# List all modules.
> -$ semodule \-\-list=full
>  # Set an alternate path for the policy root
>  $ semodule \-B \-p "/tmp"
>  # Set an alternate path for the policy store root
> @@ -143,6 +141,8 @@ $ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E wireshark
>  # Check whether a module in "localmodule.pp" file is same as installed module "localmodule"
>  $ /usr/libexec/selinux/hll/pp localmodule.pp | sha256sum
>  $ semodule -l -m | grep localmodule
> +# Translate binary module file into CIL (useful for debugging installation errors)
> +$ /usr/libexec/selinux/hll/pp alsa.pp > alsa.cil
>  .fi
>  
>  .SH SEE ALSO
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
> index e07db2c8..c3cc5c9b 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -224,6 +224,15 @@ and provided the
>  option is NOT set and recursive mode is set, files will be relabeled as
>  required with the digests then being updated provided there are no errors.
>  
> +.SH EXAMPLE
> +.nf
> +Fix labeling of /var/www/ including all sub-directories and list all context changes
> +# restorecon -rv /var/www/
> +List mislabeled files in user home directory and what the correct label should be
> +# restorecon -nvr ~
> +Fix labeling of files listed in file_list file, ignoring any that do not exist
> +# restorecon -vif file_list
> +
>  .SH "AUTHOR"
>  This man page was written by Dan Walsh <dwalsh@redhat.com>.
>  Some of the content of this man page was taken from the setfiles
> diff --git a/policycoreutils/setfiles/restorecon_xattr.8 b/policycoreutils/setfiles/restorecon_xattr.8
> index e04528e6..51d12a4d 100644
> --- a/policycoreutils/setfiles/restorecon_xattr.8
> +++ b/policycoreutils/setfiles/restorecon_xattr.8
> @@ -112,6 +112,13 @@ If the option is not specified, then the default file_contexts will be used.
>  .br
>  the pathname of the directory tree to be searched.
>  
> +.SH EXAMPLE
> +.nf
> +List all paths that where assigned a checksum by "restorecon/setfiles -D"
> +# restorecon_xattr -r /
> +Remove all non-matching checksums
> +# restorecon_xattr -rd /
> +
>  .SH "SEE ALSO"
>  .BR restorecon (8),
>  .BR setfiles (8)
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
> index bf26e161..892a5062 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -289,6 +289,15 @@ and provided the
>  option is NOT set, files will be relabeled as required with the digests then
>  being updated provided there are no errors.
>  
> +.SH EXAMPLE
> +.nf
> +Fix labeling of /var/www/ including all sub-directories, using targeted policy file context definitions and list all context changes
> +# setfiles -v /etc/selinux/targeted/contexts/files/file_contexts /var/www/
> +List mislabeled files in user home directory and what the label should be based on targeted policy file context definitions
> +# setfiles -nv /etc/selinux/targeted/contexts/files/file_contexts ~
> +Fix labeling of files listed in file_list file, ignoring any that do not exist
> +# setfiles -vif file_list /etc/selinux/targeted/contexts/files/file_contexts
> +
>  .SH "AUTHOR"
>  This man page was written by Russell Coker <russell@coker.com.au>.
>  The program was written by Stephen Smalley <sds@tycho.nsa.gov>
> diff --git a/policycoreutils/setsebool/setsebool.8 b/policycoreutils/setsebool/setsebool.8
> index 52936f5a..f54664fb 100644
> --- a/policycoreutils/setsebool/setsebool.8
> +++ b/policycoreutils/setsebool/setsebool.8
> @@ -7,13 +7,13 @@ setsebool \- set SELinux boolean value
>  .I "[ \-PNV ] boolean value | bool1=val1 bool2=val2 ..."
>  
>  .SH "DESCRIPTION"
> -.B setsebool 
> -sets the current state of a particular SELinux boolean or a list of booleans 
> -to a given value. The value may be 1 or true or on to enable the boolean, or 0 or false or off to disable it. 
> +.B setsebool
> +sets the current state of a particular SELinux boolean or a list of booleans
> +to a given value. The value may be 1 or true or on to enable the boolean, or 0 or false or off to disable it.
>  
>  Without the \-P option, only the current boolean value is
> -affected; the boot-time default settings 
> -are not changed. 
> +affected; the boot-time default settings
> +are not changed.
>  
>  If the \-P option is given, all pending values are written to
>  the policy file on disk. So they will be persistent across reboots.
> @@ -22,6 +22,12 @@ If the \-N option is given, the policy on disk is not reloaded into the kernel.
>  
>  If the \-V option is given, verbose error messages will be printed from semanage libraries.
>  
> +.SH EXAMPLE
> +.nf
> +Enable container_use_devices boolean (will return to persistent value after reboot)
> +# setsebool container_use_devices 1
> +Persistently enable samba_create_home_dirs and samba_enable_home_dirs booleans
> +# setsebool -P samba_create_home_dirs=on samba_enable_home_dirs=on
>  
>  .SH AUTHOR
>  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
> -- 
> 2.40.0

