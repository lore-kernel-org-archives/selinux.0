Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJhxOA023327
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:43:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QJhuRM022735
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:43:56 GMT
Subject: Re: Fix dosfs handling in the interface
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02E3D.2070503@redhat.com>
References: <45F02E3D.2070503@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 15:44:24 -0400
Message-Id: <1174938265.28830.78.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:39 -0500, Daniel J Walsh wrote:
> Allow xend to use dosfs for ia64 boot.
> 
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (dosfs.patch)
> 
> --- nsaserefpolicy/policy/modules/kernel/filesystem.if  2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/filesystem.if       2007-03-08 08:42:37.000000000 -0500
> @@ -1110,11 +1110,31 @@
>                 type dosfs_t;
>         ')
>  
> +       manage_dirs_pattern($1,dosfs_t,dosfs_t)
>         manage_files_pattern($1,dosfs_t,dosfs_t)
>  ')

Dropped this as it breaks the meaning of the interface.

>  ########################################
>  ## <summary>
> +##     read files
> +##     on a DOS filesystem.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`fs_read_dos_files',`
> +       gen_require(`
> +               type dosfs_t;
> +       ')
> +
> +       read_files_pattern($1,dosfs_t,dosfs_t)
> +')

Moved this up.

> --- nsaserefpolicy/policy/modules/system/xen.te 2007-01-02 12:57:49.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/xen.te      2007-03-08 08:42:37.000000000 -0500
> @@ -357,3 +373,11 @@
>  xen_append_log(xm_t)
>  xen_stream_connect(xm_t)
>  xen_stream_connect_xenstore(xm_t)
> +
> +#Should have a boolean wrapping these
> +fs_list_auto_mountpoints(xend_t)
> +files_search_mnt(xend_t)
> +fs_write_nfs_files(xend_t)
> +fs_read_nfs_files(xend_t)
> +fs_getattr_all_fs(xend_t)
> +fs_read_dos_files(xend_t)
> 

If these should be conditional, why aren't they?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
