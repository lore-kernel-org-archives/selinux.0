Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UEGwI4004579
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 10:16:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UEGv7R010715
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 14:16:57 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3UEGqKP010705 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 14:16:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: truncate(2) and setattr
Date: Thu, 1 May 2003 00:16:04 +1000
Cc: selinux@tycho.nsa.gov
References: <200304301034.38073.russell@coker.com.au> <200304302231.13209.russell@coker.com.au> <1051708617.1118.173.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1051708617.1118.173.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305010016.04155.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Apr 2003 23:16, Stephen Smalley wrote:
> So you want something like the below patch, which omits the file setattr
> permission check in the truncate case.

Yes.  I believe that using write permission checks for this is the appropriate 
thing to do.  I think that a CTIME change does not deserve much attention, 
and size is a direct function of write/append.

> Index: lsm-2.4/security/selinux/hooks.c
> ===================================================================
> RCS file: /home/pal/CVS/lsm-2.4/security/selinux/hooks.c,v
> retrieving revision 1.89
> diff -u -r1.89 hooks.c
> --- lsm-2.4/security/selinux/hooks.c    27 Mar 2003 20:05:18
> -0000      1.89 +++ lsm-2.4/security/selinux/hooks.c    30 Apr 2003
> 13:09:39 -0000 @@ -2034,6 +2034,10 @@
>  
>  static int selinux_inode_setattr(struct dentry *dentry, struct iattr
> *iattr) {
> +       if (iattr->ia_valid == (ATTR_SIZE | ATTR_CTIME)) {
> +               /* truncate covered by write permission check */
> +               return 0;
> +       }
>         return dentry_has_perm(current, dentry, FILE__SETATTR, NULL);
>  }

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
