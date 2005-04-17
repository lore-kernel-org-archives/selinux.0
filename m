Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3HMVi7C008227
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2005 18:31:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3HMRPPp013036
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2005 22:27:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: [ PATCH ] Cumulative patch - various fixes, untrusted_content_t, mozilla, gnome types
Date: Sun, 17 Apr 2005 23:46:34 +1000
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
References: <1113445869.6139.52.camel@cobra.ivg2.net>
In-Reply-To: <1113445869.6139.52.camel@cobra.ivg2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504172346.39313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 14 April 2005 12:31, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> Parts of this patch are rather controversial and might break things.
> Please comment if anything needs to be changed.
>
> Changelog:
> ==========
>
> 1) Introduces new type - ROLE_untrusted_content_t.
> This will be the "downloads" folder type that I proposed earlier.
> I started a discussion on the Gnome Usability list about further
> separation, but so far it doesn't seem to be making progress.

This is a difficult area that requires a lot of thought and work if we are to 
have a chance to get it right.  Let's leave this until after we get some of 
the base stuff done.

> 2) Introduce new types for gnome - ROLE_gnome_settings_t, and
> ROLE_gnome_data_t. This looks to me like too low level of granularity
> for labeling, but I didn't know what would be appropriate - at
> least it seems better than the existing types (ROLE_home_t, and
> ROLE_mozilla_home_t (why mozilla for .gconf?))

Mozilla wants read/write access to .gconf as well as processes in ROLE_t, 
using a mozilla type grants such access.  It's an ugly hack and doesn't 
really work well (think ROLE_games_t and GNOME games).

> Those types are used
> for .gnome, .gnome2, .gnome_private, .gnome2_private, .gconf,
> .local, .thumbnails, .themes, .icons,
>
> and are fully accessible from ROLE_t. However, now applications
> can be granted access to this particular type, rather than
> ROLE_home_t, or ROLE_mozilla_home_t.

I think that first we should get a separate domain for gconf.  If gconf is to 
become a trusted object manager as I recall Colin has suggested then it will 
address some of the issues related to this.  You have:
create_dir_file(ROLE_t, ROLE_gnome_settings_t)
allow ROLE_mozilla_t ROLE_gnome_settings_t:dir { search getattr };

Mozilla will desire read/write access to the .gconf directory and it's files 
so the only solution is something like:
domain_auto_trans({ ROLE_t ROLE_mozilla_t }, gconfd_exec_t, ROLE_gconfd_t)

This assumes that gconf will do the right things.

> 3) Introduce new type for .fonts.cache-1 - ROLE_font_cache_t.
> Change dontaudit for gift and mozilla to allow reading this file.

It's my observation that the common practice for font cache files is to often 
create new files and unlink the old one - thus losing a specific type 
assigned to it.  Maybe we could put SE Linux code into the programs that use 
this file, but it's ugly.

> 4) Miscellaneous fix: Allow load_policy to read /proc/filesystems,
> or else it just refuses to load in enforcing mode.

Best to put it in can_loadpol().

> 6) Grant the user the ability to relabel to/from directories of type
> ROLE_home_t. Why not?

It's already in macros/base_user_macros.te .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
