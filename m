Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99HQJWt027418
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 13:26:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h99HQIUb027477
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 17:26:18 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h99HQIhX027474 for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 17:26:18 GMT
Subject: Re: autoconf/libtool for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031006201735.GA28880@suse.de>
References: <20031006201735.GA28880@suse.de>
Content-Type: text/plain
Message-Id: <1065720375.8181.311.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Oct 2003 13:26:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-06 at 16:17, Thorsten Kukuk wrote:
> Hi,
> 
> With current 2.3 glibc, setxattr and other functions from libattr
> are already included in libc.so.6. So linking against libattr is
> useless, the symbols from libc.so.6 are always prefered.
> 
> I don't know what the policy about automake/autoconf/libtool are,
> but this was the easiest solution to build libselinux against plain
> libc or add libattr.
> 
> I have attached my patch for using autoconf/libtool and patches
> building libselinux only against libc, not libattr.
> 
> Comments?

Thanks for writing this patch, but I'm not presently inclined to take
it, except possibly to change the includes to use <sys/xattr.h> rather
than <attr/xattr.h>.  autoconf/libtool seems a bit overkill for
libselinux.  It seems reasonable to require people to use a modern glibc
(>= 2.3) and to have built it against kernel headers >= 2.4.20 (where
xattr API was merged into mainline), so I'll likely just make the
transition and people who need to build with an older glibc or older
kernel headers will just need to patch it to use libattr. 
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
