Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02917
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 17:57:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA23277
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:55:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA23273 for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:55:36 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: the new default_contexts file
Date: Wed, 30 Oct 2002 23:57:20 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210301745000.25777-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210301745000.25777-100000@raven>
MIME-Version: 1.0
Message-Id: <200210302357.20168.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Oct 2002 23:45, Stephen Smalley wrote:
> On Wed, 30 Oct 2002, Russell Coker wrote:
> > The idea of having key-value pairs where the key is the partial context
> > of the daemon is good.
> >
> > However only being able to specify an order is not good.
> >
> > I would like to be able to have two users, user "a" gets user_r:user_t by
> > default while user "b" gets second_r:second_t by default even though both
> > users are authorised for both roles.
>
> This can be customized on a per-user basis by the user via a
> $HOME/.default_contexts file.  Same syntax as the main configuration file,
> and it takes precedence.

OK.  Should we define a new type for the default_contexts file then and allow 
the various login programs read access?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
