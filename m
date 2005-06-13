Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5DL8IgA009590
	for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2005 17:08:18 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5DKxent020913
	for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2005 20:59:40 GMT
Message-ID: <42ADF43D.9080002@trustedcs.com>
Date: Mon, 13 Jun 2005 16:01:49 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: James Morris <jmorris@redhat.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>,
   =?ISO-8859-1?Q?Lorenzo_Hern=E1nde?=
 =?ISO-8859-1?Q?z_Garc=EDa-Hierro?= <lorenzo@gnu.org>
Subject: Re: [PATCH] devpts xattr support
References: <Xine.LNX.4.44.0410271428590.10702-100000@thoron.boston.redhat.com> <1118691161.24565.147.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1118691161.24565.147.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Below is a simple patch that does this for getxattr.  ls -Z then works
> for e.g. /proc /dev/pts /selinux.
> 
> Index: linux-2.6/fs/xattr.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/linux-2.6/fs/xattr.c,v
> retrieving revision 1.9
> diff -u -p -r1.9 xattr.c
> --- linux-2.6/fs/xattr.c	27 Dec 2004 15:09:17 -0000	1.9
> +++ linux-2.6/fs/xattr.c	31 May 2005 12:56:27 -0000
> @@ -142,15 +142,19 @@ getxattr(struct dentry *d, char __user *
>  		if (error)
>  			goto out;
>  		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
> -		if (error > 0) {
> -			if (size && copy_to_user(value, kvalue, error))
> -				error = -EFAULT;
> -		} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
> -			/* The file system tried to returned a value bigger
> -			   than XATTR_SIZE_MAX bytes. Not possible. */
> -			error = -E2BIG;
> -		}
> +	} else if (!strncmp(kname, XATTR_SECURITY_PREFIX, sizeof XATTR_SECURITY_PREFIX - 1)) {

What about the case of an xattr handle being present that does not support security
attributes?  Or the case where an appropriate handler exists but there is no data stored
on the filesystem (I think this still happens for directories that are mounted over at
install time on Fedora Core).  Changing the above to:

	}
	if ((error == -EOPNOTSUPP || error == -ENODATA) &&
	    !strncmp(kname, XATTR_SECURITY_PREFIX, sizeof XATTR_SECURITY_PREFIX - 1)) {

would handle those cases as well (I think that gets em all).

> +		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
> +		error = security_inode_getsecurity(d->d_inode, suffix, kvalue, size);

Shouldn't we also check security_inode_getxattr before going ahead with the
security_ionde_getxattr_checkin the "fallback" case?  

>  	}
> +	if (error > 0) {
> +		if (size && copy_to_user(value, kvalue, error))
> +			error = -EFAULT;
> +	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
> +		/* The file system tried to returned a value bigger
> +		   than XATTR_SIZE_MAX bytes. Not possible. */
> +		error = -E2BIG;
> +	} 
> +
>  out:
>  	if (kvalue)
>  		kfree(kvalue);
> 
> 

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
