Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3RGVVI4020918
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 12:31:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3RGVU7R023858
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 16:31:30 GMT
Received: from hoss.orcus.priv.at (chello080110242202.117.11.tuwien.teleweb.at [80.110.242.202])
        by jazzband.ncsc.mil  with ESMTP id h3RGVSKP023855 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 16:31:29 GMT
To: selinux@tycho.nsa.gov
Subject: Re: broad domains
References: <87n0ilej7x.fsf@orcus.priv.at>
	<200304251321.07207.russell@coker.com.au>
From: Robert Bihlmeyer <robbe@orcus.priv.at>
Date: 27 Apr 2003 18:17:20 +0200
In-Reply-To: <200304251321.07207.russell@coker.com.au>
Message-ID: <87of2r9apb.fsf@orcus.priv.at>
MIME-Version: 1.0
content-Type: multipart/signed; boundary="----------=_1051460297-1046-0"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
It has been signed conforming to RFC3156.
You need GPG or PGP to check the signature.

------------=_1051460297-1046-0
Content-Type: text/plain; charset=us-ascii

Russell Coker <russell@coker.com.au> writes:

> On Sun, 20 Apr 2003 17:11, Robert Bihlmeyer wrote:
> > [...] Maybe these generic domains are a mistake?
> 
> Which generic domains are you referring to?

My X client domain, the games domain from the default policy.

> Why do you want to add a special domain for X clients?

I wanted to avoid giving user_t direct access to the X server or the
DRI devices. But since I now think that this was mistaken, I now grant
normal Xlib-style access to user_t, and open special domains for the
programs that need DRI.

> For good X security we need something like Cluster Mode Workstation 
> http://www.ornl.gov/~jar/cmw4me.pdf .




> > A have the same problem with the games domain provided in the default
> > policy (or at least in Russell's package). As is, it doesn't fit half
> > the stuff in my /usr/games.
> 
> How does it not fit them?

I simply don't think it makes sense to put a class as diverse as games
into one domain. Some games, need X access (provided by the default
policy), some none. Some need direct video access, or want to output
(in rare cases input) sound. Some need read access to game data, or
r/w access to state (hiscore, save games), that may be located in a
shared area or in a fixed or variable location below the user's home. 
Sometimes even the game data or the game itself is in a user-specified
location (think: Doom WADs or Infocom zcode).

Basically, I think most games should just run under user_t, and the
blanket specification putting everything in /usr/games into this
domain is wrong.

> > On the other hand, having a domain for every teensy toy out there
> > seems a bit excessive.
> 
> Yes, it becomes a management nightmare which isn't good for security.

If we had a stronger inheritance model (maybe just through m4 macros)
I'm not so sure it's too hard to handle.

> > BTW, can't setfiles assume some default user & role if none is given?
> > Repeating system_u:object_r: a million times is superflous.
> 
> I did that once and Steve convinced me to stop doing it.

Any subject keywords or URL so I can find the arguments?

-- 
Robbe

------------=_1051460297-1046-0
Content-Type: application/pgp-signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+rAXe8g21h7wYWrMRAllsAJ0S1FGt850aHWontZ1nrbsnMLaR5ACfSSPe
2kNzHazw4PlvDI/EFI0dt64=
=BTE+
-----END PGP SIGNATURE-----

------------=_1051460297-1046-0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
