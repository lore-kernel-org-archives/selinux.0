Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SIcDrT009689
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 14:38:13 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SIcCPw013004
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:38:12 GMT
Subject: Re: [patch] types.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Chris PeBenito <pebenito@gentoo.org>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1095987749.7142.6.camel@gorn.pebenito.net>
References: <1095987749.7142.6.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1096396626.30810.80.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Sep 2004 14:37:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Also, I don't see anything that matches /usr/.*redhat-linux/lib(64)? on
FC2 or FC3 test2 (or RH8 for that matter).  What version of Fedora or
Red Hat Linux are they for?  Are they for something that maybe I don't
have installed?  Or are they now obsolete and can be removed?  
Dan or Russell, do you know?

Index: file_contexts/types.fc
> ===================================================================
> RCS file:
> /cvsroot/selinux/nsa/selinux-usr/policy/file_contexts/types.fc,v
> retrieving revision 1.40
> diff -u -r1.40 types.fc
> --- file_contexts/types.fc      23 Sep 2004 19:08:59 -0000      1.40
> +++ file_contexts/types.fc      24 Sep 2004 01:00:59 -0000


> @@ -352,11 +362,14 @@
>  /usr/.*glibc.*-linux/lib(64)?/ld[^/]*\.so(\.[^/]*)*    --      system_u:object_r:ld_so_t
>  /usr/.*glibc.*-linux/lib(64)?/lib[^/]*\.so(\.[^/]*)*   --      system_u:object_r:shlib_t
>  
> +#
>  # /usr/.*redhat-linux/lib(64)?
>  #
> +ifdef(`distro_redhat', `
>  /usr/.*redhat-linux/lib(64)?(/.*)?     system_u:object_r:lib_t
>  /usr/.*redhat-linux/lib(64)?/ld[^/]*\.so(\.[^/]*)*     --      system_u:object_r:ld_so_t
>  /usr/.*redhat-linux/lib(64)?/lib[^/]*\.so(\.[^/]*)*    --      system_u:object_r:shlib_t
> +')
>  
>  #
> # /usr/.*linux-libc.*/lib(64)?

On Thu, 2004-09-23 at 21:02, Chris PeBenito wrote:
> Here's an update of types.fc with a some Gentoo-specific entries,
> against CVS.  Also enclose a few entries with other distro tunables.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
