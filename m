Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9JJCIi015202
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 14:19:12 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9JJEEj005843
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 19:19:14 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <20041209190701.GF8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <20041209190701.GF8179@jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 06:19:11 +1100
Message-Id: <1102619951.4509.70.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 20:07 +0100, Thomas Bleher wrote:
> A while ago we had this discussion on the lsm-list. Colin suggested
> using the following patch to prevent symlinks attacks:
> 
> --- orig/constraints
> +++ mod/constraints
> @@ -67,3 +67,7 @@
>  constrain socket_class_set { create relabelto relabelfrom } 
>  	( u1 == u2 or t1 == privowner );
>  
> +# read symlinks under /tmp only if owners match
> +constrain lnk_file read
> +	( t2 != tmpfile or u1 == u2 );
> + 

That will be fine AFTER we have a follow operation as in the sample
patch Steve just posted.

For some particular environments with clueful administrators it might
not be a big deal to deny the administrator the ability to run
"ls -l /tmp" and see everything that they would see without SE Linux.
In most cases I believe that they will demand that they can have a fully
functional ls.  Also even for skilled administrators, it's just really
handy to be able to see what the users are doing.  Being forced to login
as a user (or su to the user in Fedora) just to see what sym-links they
have in /tmp is unweildy.

Also the constraints entry would have to apply to home_type for correct
operation on systems where /tmp and /home are on the same file system
which is the result of "autopartitioning" in Fedora Core and a common
practice by many (most?) administrators of small systems.

constrain lnk_file read
	( (t2 != tmpfile and t2 != home_type) or u1 == u2 );

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
