Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA22910
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 15:31:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA08693
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 20:29:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA08689
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 20:29:35 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: font paths
Date: Tue, 29 Oct 2002 21:31:16 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210291417080.29605-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210291417080.29605-100000@raven>
MIME-Version: 1.0
Message-Id: <200210292131.16040.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Oct 2002 20:17, Stephen Smalley wrote:
> On Mon, 28 Oct 2002, Russell Coker wrote:
> > http://lists.debian.org/debian-kde/2002/debian-kde-200210/msg00605.html
> >
> > Please read the above discussion about font paths used by KDE.  I imagine
> > that GNOME is likely to do the same (if they don't already).
> >
> > Would it make sense to have a user_home_xfont_t for the fonts so the X
> > server can read them but not the rest of the user's files?
>
> Does the same issue arise for other user-configurable data that X needs to
> read?  If so, you might want a more general type for this purpose.

I don't know.

Maybe it should be user_home_x_ro_t?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
